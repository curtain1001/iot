package com.ruoyi.iot.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.file.FileNameLengthLimitExceededException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.domain.ProductAuthorize;
import com.ruoyi.iot.model.AuthenticateInputModel;
import com.ruoyi.iot.model.DeviceAuthenticateModel;
import com.ruoyi.iot.model.MqttClientConnectModel;
import com.ruoyi.iot.model.RegisterUserInput;
import com.ruoyi.iot.model.ThingsModels.IdentityAndName;
import com.ruoyi.iot.model.ThingsModels.ThingsModelValueItem;
import com.ruoyi.iot.model.ThingsModels.ThingsModelShadow;
import com.ruoyi.iot.mqtt.EmqxService;
import com.ruoyi.iot.mqtt.MqttConfig;
import com.ruoyi.iot.service.IDeviceService;
import com.ruoyi.iot.service.IProductAuthorizeService;
import com.ruoyi.iot.service.IToolService;
import com.ruoyi.iot.service.impl.ThingsModelServiceImpl;
import com.ruoyi.iot.util.AESUtils;
import com.ruoyi.iot.util.VelocityInitializer;
import com.ruoyi.iot.util.VelocityUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.io.IOUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import static com.ruoyi.common.utils.file.FileUploadUtils.getExtension;

/**
 * 产品分类Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "工具相关")
@RestController
@RequestMapping("/iot/tool")
public class ToolController extends BaseController {
    private static final Logger log = LoggerFactory.getLogger(ToolController.class);

    @Autowired
    private IDeviceService deviceService;

    private IProductAuthorizeService authorizeService;

    @Autowired
    private ThingsModelServiceImpl thingsModelService;

    @Lazy
    @Autowired
    private EmqxService emqxService;

    @Autowired
    private MqttConfig mqttConfig;

    @Autowired
    private IToolService toolService;

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    @Autowired
    private RedisCache redisCache;

    /**
     * 用户注册
     */
    @ApiOperation("用户注册")
    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterUserInput user) {
        String msg = toolService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }

    @ApiOperation("mqtt认证")
    @PostMapping("/mqtt/auth")
    public ResponseEntity mqttAuth(@RequestParam String clientid, @RequestParam String username, @RequestParam String password) throws Exception {
        try {
            if (clientid.startsWith("server")) {
                // 服务端配置账号认证
                if (mqttConfig.getusername().equals(username) && mqttConfig.getpassword().equals(password)) {
                    System.out.println("-----------认证成功,clientId:" + clientid + "---------------");
                    return ResponseEntity.ok().body("ok");
                }
            } else if (clientid.startsWith("web") || clientid.startsWith("phone")) {
                // web端和手机端token认证
                String token = password;
                if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
                    token = token.replace(Constants.TOKEN_PREFIX, "");
                }
                try {
                    Claims claims = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
                    System.out.println("-----------认证成功,clientId:" + clientid + "---------------");
                    return ResponseEntity.ok().body("ok");
                } catch (Exception ex) {
                    return returnUnauthorized(clientid, username, password, ex.getMessage());
                }
            } else {
                // 设备端
                String[] clientInfo = clientid.split("&");
                if (clientInfo.length != 2) {
                    // 设备未加密认证
                    String deviceNum = clientInfo[0];
                    Device device = deviceService.selectShortDeviceBySerialNumber(deviceNum);
                    if (device !=null && mqttConfig.getusername().equals(username) && mqttConfig.getpassword().equals(password)) {
                        System.out.println("-----------认证成功,clientId:" + clientid + "---------------");
                        ProductAuthorize authorize = new ProductAuthorize(null, device.getProductId(), device.getDeviceId(), device.getSerialNumber(), 1L, "admin");
                        authorizeService.boundProductAuthorize(authorize);
                        return ResponseEntity.ok().body("ok");
                    }
                    return returnUnauthorized(clientid, username, password, "认证信息有误");
                }
                // 设备加密认证
                String deviceNum = clientInfo[0];
                Long productId = Long.valueOf(clientInfo[1]);
                AuthenticateInputModel authenticateInputModel = new AuthenticateInputModel(deviceNum, productId);
                DeviceAuthenticateModel model = deviceService.selectDeviceAuthenticate(authenticateInputModel);
                if (model == null) {
                    return returnUnauthorized(clientid, username, password, "认证信息有误");
                }
                // 密码解密，密码加密格式 password & productId & userId & expireTime
                String decryptPassword = AESUtils.decrypt(password, model.getMqttSecret());
                if (decryptPassword == null || decryptPassword == "") {
                    return returnUnauthorized(clientid, username, password, "认证信息有误");
                }
                String[] infos = decryptPassword.split("&");
                if (infos.length != 3) {
                    return returnUnauthorized(clientid, username, password, "认证信息有误");
                }
                String mqttPassword = infos[0];
                Long userId = Long.valueOf(infos[1]);
                Long expireTime = Long.valueOf(infos[2]);
                // 账号密码验证，产品必须为发布状态：1-未发布，2-已发布
                if (mqttPassword.equals(model.getMqttPassword())
                        && username.equals(model.getMqttAccount())
                        && expireTime > System.currentTimeMillis()
                        && model.getProductStatus() == 2) {

                    // 设备状态验证 （1-未激活，2-禁用，3-在线，4-离线）
                    if (model.getDeviceId() != null && model.getDeviceId() != 0 && model.getStatus() != 2) {
                        System.out.println("-----------认证成功,clientId:" + clientid + "---------------");
                        ProductAuthorize authorize = new ProductAuthorize(null, model.getProductId(), model.getDeviceId(), model.getSerialNumber(), 1L, "admin");
                        authorizeService.boundProductAuthorize(authorize);
                        return ResponseEntity.ok().body("ok");
                    } else {
                        // 自动添加设备
                        int result = deviceService.insertDeviceAuto(deviceNum, userId, productId);
                        if (result == 1) {
                            System.out.println("-----------认证成功,clientId:" + clientid + "---------------");
                            ProductAuthorize authorize = new ProductAuthorize(null, model.getProductId(), model.getDeviceId(), model.getSerialNumber(), 1L, "admin");
                            authorizeService.boundProductAuthorize(authorize);
                            return ResponseEntity.ok().body("ok");
                        }
                    }
                }
            }
        } catch (Exception ex) {
            // ex.printStackTrace();
            return returnUnauthorized(clientid, username, password, ex.getMessage());
        }
        return returnUnauthorized(clientid, username, password, "认证信息有误");
    }

    /**
     * 返回认证信息
     */
    private ResponseEntity returnUnauthorized(String clientid, String username, String password, String message) {
        System.out.println("认证失败：" + message
                + "\nclientid:" + clientid
                + "\nusername:" + username
                + "\npassword:" + password);
        log.error("认证失败：" + message
                + "\nclientid:" + clientid
                + "\nusername:" + username
                + "\npassword:" + password);
        return ResponseEntity.status(401).body("Unauthorized");
    }


    @ApiOperation("mqtt钩子处理")
    @PostMapping("/mqtt/webhook")
    public void webHookProcess(@RequestBody MqttClientConnectModel model) {
        try {
            System.out.println("webhook:" + model.getAction());
            // 过滤服务端、web端和手机端
            if (model.getClientid().startsWith("server") || model.getClientid().startsWith("web") || model.getClientid().startsWith("phone")) {
                return;
            }
            String[] clientInfo = model.getClientid().split("&");
            String deviceNum = clientInfo[0];
            Device device = deviceService.selectShortDeviceBySerialNumber(deviceNum);
            // 设备状态（1-未激活，2-禁用，3-在线，4-离线）
            if (model.getAction().equals("client_disconnected")) {
                device.setStatus(4);
                deviceService.updateDeviceStatusAndLocation(device, "");
                // 发布设备状态
                emqxService.publishStatus(device.getProductId(), device.getSerialNumber(), 4, device.getIsShadow());
                // 清空保留消息，上线后发布新的属性功能保留消息
                emqxService.publishProperty(device.getProductId(), device.getSerialNumber(), null);
                emqxService.publishFunction(device.getProductId(), device.getSerialNumber(), null);
            } else if (model.getAction().equals("client_connected")) {
                device.setStatus(3);
                deviceService.updateDeviceStatusAndLocation(device, model.getIpaddress());
                // 发布设备状态
                emqxService.publishStatus(device.getProductId(), device.getSerialNumber(), 3, device.getIsShadow());
                // 影子模式，发布属性和功能
                if (device.getIsShadow() == 1) {
                    ThingsModelShadow shadow = deviceService.getDeviceShadowThingsModel(device);
                    if (shadow.getProperties().size() > 0) {
                        emqxService.publishProperty(device.getProductId(), device.getSerialNumber(), shadow.getProperties());
                    }
                    if (shadow.getFunctions().size() > 0) {
                        emqxService.publishFunction(device.getProductId(), device.getSerialNumber(), shadow.getFunctions());
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            log.error("发生错误：" + ex.getMessage());
        }
    }


    @ApiOperation("获取NTP时间")
    @GetMapping("/ntp")
    public JSONObject ntp(@RequestParam Long deviceSendTime) {
        JSONObject ntpJson = new JSONObject();
        ntpJson.put("deviceSendTime", deviceSendTime);
        ntpJson.put("serverRecvTime", System.currentTimeMillis());
        ntpJson.put("serverSendTime", System.currentTimeMillis());
        return ntpJson;
    }

    /**
     * 文件上传
     */
    @PostMapping("/upload")
    @ApiOperation("文件上传")
    public AjaxResult uploadFile(MultipartFile file) throws Exception {
        try {
            String filePath = RuoYiConfig.getProfile();
            // 文件名长度限制
            int fileNamelength = file.getOriginalFilename().length();
            if (fileNamelength > FileUploadUtils.DEFAULT_FILE_NAME_LENGTH) {
                throw new FileNameLengthLimitExceededException(FileUploadUtils.DEFAULT_FILE_NAME_LENGTH);
            }
            // 文件类型限制
            // assertAllowed(file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);

            // 获取文件名和文件类型
            String fileName = file.getOriginalFilename();
            String extension = getExtension(file);
            //设置日期格式
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MMdd-HHmmss");
            fileName = "/iot/" + getLoginUser().getUserId().toString() + "/" + df.format(new Date()) + "." + extension;
            //创建目录
            File desc = new File(filePath + File.separator + fileName);
            if (!desc.exists()) {
                if (!desc.getParentFile().exists()) {
                    desc.getParentFile().mkdirs();
                }
            }
            // 存储文件
            file.transferTo(desc);

            String url = "/profile" + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("fileName", url);
            ajax.put("url", url);
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 下载文件
     */
    @ApiOperation("文件下载")
    @GetMapping("/download")
    public void download(String fileName, HttpServletResponse response, HttpServletRequest request) {
        try {
//            if (!FileUtils.checkAllowDownload(fileName)) {
//                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载。 ", fileName));
//            }
            String filePath = RuoYiConfig.getProfile();
            // 资源地址
            String downloadPath = filePath + fileName.replace("/profile", "");
            // 下载名称
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, downloadName);
            FileUtils.writeBytes(downloadPath, response.getOutputStream());
        } catch (Exception e) {
            log.error("下载文件失败", e);
        }
    }

    /**
     * 批量生成代码
     */
    @Log(title = "SDK生成", businessType = BusinessType.GENCODE)
    @GetMapping("/genSdk")
    @ApiOperation("生成SDK")
    public void genSdk(HttpServletResponse response, int deviceChip) throws IOException {
        byte[] data = downloadCode(deviceChip);
        genSdk(response, data);
    }

    /**
     * 生成zip文件
     */
    private void genSdk(HttpServletResponse response, byte[] data) throws IOException {
        response.reset();
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Expose-Headers", "Content-Disposition");
        response.setHeader("Content-Disposition", "attachment; filename=\"ruoyi.zip\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IOUtils.write(data, response.getOutputStream());
    }

    /**
     * 批量生成代码（下载方式）
     *
     * @param deviceChip
     * @return 数据
     */
    public byte[] downloadCode(int deviceChip) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(outputStream);
//        generatorCode(deviceChip, zip);
        IOUtils.closeQuietly(zip);
        return outputStream.toByteArray();
    }

    /**
     * 查询表信息并生成代码
     */
    private void generatorCode(int deviceChip, ZipOutputStream zip) {
        VelocityInitializer.initVelocity();

        VelocityContext context = VelocityUtils.prepareContext(deviceChip);

        // 获取模板列表
        List<String> templates = VelocityUtils.getTemplateList("");
        for (String template : templates) {
            // 渲染模板
            StringWriter sw = new StringWriter();
            Template tpl = Velocity.getTemplate(template, Constants.UTF8);
            tpl.merge(context, sw);
            try {
                // 添加到zip
                zip.putNextEntry(new ZipEntry(VelocityUtils.getFileName(template)));
                IOUtils.write(sw.toString(), zip, Constants.UTF8);
                IOUtils.closeQuietly(sw);
                zip.flush();
                zip.closeEntry();
            } catch (IOException e) {
                System.out.println("渲染模板失败");
            }
        }
    }

}
