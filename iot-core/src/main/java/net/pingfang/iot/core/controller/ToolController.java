package net.pingfang.iot.core.controller;

import static net.pingfang.iot.common.utils.file.FileUploadUtils.getExtension;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.pingfang.iot.common.annotation.Log;
import net.pingfang.iot.common.config.RuoYiConfig;
import net.pingfang.iot.common.constant.Constants;
import net.pingfang.iot.common.core.controller.BaseController;
import net.pingfang.iot.common.core.domain.AjaxResult;
import net.pingfang.iot.common.core.redis.RedisCache;
import net.pingfang.iot.common.enums.BusinessType;
import net.pingfang.iot.common.exception.file.FileNameLengthLimitExceededException;
import net.pingfang.iot.common.utils.StringUtils;
import net.pingfang.iot.common.utils.file.FileUploadUtils;
import net.pingfang.iot.common.utils.file.FileUtils;
import net.pingfang.iot.core.domain.Device;
import net.pingfang.iot.core.domain.ProductAuthorize;
import net.pingfang.iot.core.model.AuthenticateInputModel;
import net.pingfang.iot.core.model.DeviceAuthenticateModel;
import net.pingfang.iot.core.model.MqttClientConnectModel;
import net.pingfang.iot.core.model.RegisterUserInput;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelShadow;
import net.pingfang.iot.core.mqtt.EmqxService;
import net.pingfang.iot.core.mqtt.MqttConfig;
import net.pingfang.iot.core.service.IDeviceService;
import net.pingfang.iot.core.service.IProductAuthorizeService;
import net.pingfang.iot.core.service.IToolService;
import net.pingfang.iot.core.service.impl.ThingsModelServiceImpl;
import net.pingfang.iot.core.util.AESUtils;
import net.pingfang.iot.core.util.VelocityInitializer;
import net.pingfang.iot.core.util.VelocityUtils;

/**
 * ????????????Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "????????????")
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

	// ????????????
	@Value("${token.secret}")
	private String secret;

	@Autowired
	private RedisCache redisCache;

	/**
	 * ????????????
	 */
	@ApiOperation("????????????")
	@PostMapping("/register")
	public AjaxResult register(@RequestBody RegisterUserInput user) {
		String msg = toolService.register(user);
		return StringUtils.isEmpty(msg) ? success() : error(msg);
	}

	@ApiOperation("mqtt??????")
	@PostMapping("/mqtt/auth")
	public ResponseEntity mqttAuth(@RequestParam String clientid, @RequestParam String username,
			@RequestParam String password) throws Exception {
		try {
			if (clientid.startsWith("server")) {
				// ???????????????????????????
				if (mqttConfig.getusername().equals(username) && mqttConfig.getpassword().equals(password)) {
					System.out.println("-----------????????????,clientId:" + clientid + "---------------");
					return ResponseEntity.ok().body("ok");
				}
			} else if (clientid.startsWith("web") || clientid.startsWith("phone")) {
				// web???????????????token??????
				String token = password;
				if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
					token = token.replace(Constants.TOKEN_PREFIX, "");
				}
				try {
					Claims claims = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
					System.out.println("-----------????????????,clientId:" + clientid + "---------------");
					return ResponseEntity.ok().body("ok");
				} catch (Exception ex) {
					return returnUnauthorized(clientid, username, password, ex.getMessage());
				}
			} else {
				// ?????????
				String[] clientInfo = clientid.split("&");
				if (clientInfo.length != 2) {
					// ?????????????????????
					String deviceNum = clientInfo[0];
					Device device = deviceService.selectShortDeviceBySerialNumber(deviceNum);
					if (device != null && mqttConfig.getusername().equals(username)
							&& mqttConfig.getpassword().equals(password)) {
						System.out.println("-----------????????????,clientId:" + clientid + "---------------");
						ProductAuthorize authorize = new ProductAuthorize(null, device.getProductId(),
								device.getDeviceId(), device.getSerialNumber(), 1L, "admin");
						authorizeService.boundProductAuthorize(authorize);
						return ResponseEntity.ok().body("ok");
					}
					return returnUnauthorized(clientid, username, password, "??????????????????");
				}
				// ??????????????????
				String deviceNum = clientInfo[0];
				Long productId = Long.valueOf(clientInfo[1]);
				AuthenticateInputModel authenticateInputModel = new AuthenticateInputModel(deviceNum, productId);
				DeviceAuthenticateModel model = deviceService.selectDeviceAuthenticate(authenticateInputModel);
				if (model == null) {
					return returnUnauthorized(clientid, username, password, "??????????????????");
				}
				// ????????????????????????????????? password & productId & userId & expireTime
				String decryptPassword = AESUtils.decrypt(password, model.getMqttSecret());
				if (decryptPassword == null || decryptPassword == "") {
					return returnUnauthorized(clientid, username, password, "??????????????????");
				}
				String[] infos = decryptPassword.split("&");
				if (infos.length != 3) {
					return returnUnauthorized(clientid, username, password, "??????????????????");
				}
				String mqttPassword = infos[0];
				Long userId = Long.valueOf(infos[1]);
				Long expireTime = Long.valueOf(infos[2]);
				// ???????????????????????????????????????????????????1-????????????2-?????????
				if (mqttPassword.equals(model.getMqttPassword()) && username.equals(model.getMqttAccount())
						&& expireTime > System.currentTimeMillis() && model.getProductStatus() == 2) {

					// ?????????????????? ???1-????????????2-?????????3-?????????4-?????????
					if (model.getDeviceId() != null && model.getDeviceId() != 0 && model.getStatus() != 2) {
						System.out.println("-----------????????????,clientId:" + clientid + "---------------");
						ProductAuthorize authorize = new ProductAuthorize(null, model.getProductId(),
								model.getDeviceId(), model.getSerialNumber(), 1L, "admin");
						authorizeService.boundProductAuthorize(authorize);
						return ResponseEntity.ok().body("ok");
					} else {
						// ??????????????????
						int result = deviceService.insertDeviceAuto(deviceNum, userId, productId);
						if (result == 1) {
							System.out.println("-----------????????????,clientId:" + clientid + "---------------");
							ProductAuthorize authorize = new ProductAuthorize(null, model.getProductId(),
									model.getDeviceId(), model.getSerialNumber(), 1L, "admin");
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
		return returnUnauthorized(clientid, username, password, "??????????????????");
	}

	/**
	 * ??????????????????
	 */
	private ResponseEntity returnUnauthorized(String clientid, String username, String password, String message) {
		System.out.println(
				"???????????????" + message + "\nclientid:" + clientid + "\nusername:" + username + "\npassword:" + password);
		log.error("???????????????" + message + "\nclientid:" + clientid + "\nusername:" + username + "\npassword:" + password);
		return ResponseEntity.status(401).body("Unauthorized");
	}

	@ApiOperation("mqtt????????????")
	@PostMapping("/mqtt/webhook")
	public void webHookProcess(@RequestBody MqttClientConnectModel model) {
		try {
			System.out.println("webhook:" + model.getAction());
			// ??????????????????web???????????????
			if (model.getClientid().startsWith("server") || model.getClientid().startsWith("web")
					|| model.getClientid().startsWith("phone")) {
				return;
			}
			String[] clientInfo = model.getClientid().split("&");
			String deviceNum = clientInfo[0];
			Device device = deviceService.selectShortDeviceBySerialNumber(deviceNum);
			// ???????????????1-????????????2-?????????3-?????????4-?????????
			if (model.getAction().equals("client_disconnected")) {
				device.setStatus(4);
				deviceService.updateDeviceStatusAndLocation(device, "");
				// ??????????????????
				emqxService.publishStatus(device.getProductId(), device.getSerialNumber(), 4, device.getIsShadow());
				// ??????????????????????????????????????????????????????????????????
				emqxService.publishProperty(device.getProductId(), device.getSerialNumber(), null);
				emqxService.publishFunction(device.getProductId(), device.getSerialNumber(), null);
			} else if (model.getAction().equals("client_connected")) {
				device.setStatus(3);
				deviceService.updateDeviceStatusAndLocation(device, model.getIpaddress());
				// ??????????????????
				emqxService.publishStatus(device.getProductId(), device.getSerialNumber(), 3, device.getIsShadow());
				// ????????????????????????????????????
				if (device.getIsShadow() == 1) {
					ThingsModelShadow shadow = deviceService.getDeviceShadowThingsModel(device);
					if (shadow.getProperties().size() > 0) {
						emqxService.publishProperty(device.getProductId(), device.getSerialNumber(),
								shadow.getProperties());
					}
					if (shadow.getFunctions().size() > 0) {
						emqxService.publishFunction(device.getProductId(), device.getSerialNumber(),
								shadow.getFunctions());
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			log.error("???????????????" + ex.getMessage());
		}
	}

	@ApiOperation("??????NTP??????")
	@GetMapping("/ntp")
	public JSONObject ntp(@RequestParam Long deviceSendTime) {
		JSONObject ntpJson = new JSONObject();
		ntpJson.put("deviceSendTime", deviceSendTime);
		ntpJson.put("serverRecvTime", System.currentTimeMillis());
		ntpJson.put("serverSendTime", System.currentTimeMillis());
		return ntpJson;
	}

	/**
	 * ????????????
	 */
	@PostMapping("/upload")
	@ApiOperation("????????????")
	public AjaxResult uploadFile(MultipartFile file) throws Exception {
		try {
			String filePath = RuoYiConfig.getProfile();
			// ?????????????????????
			int fileNamelength = file.getOriginalFilename().length();
			if (fileNamelength > FileUploadUtils.DEFAULT_FILE_NAME_LENGTH) {
				throw new FileNameLengthLimitExceededException(FileUploadUtils.DEFAULT_FILE_NAME_LENGTH);
			}
			// ??????????????????
			// assertAllowed(file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);

			// ??????????????????????????????
			String fileName = file.getOriginalFilename();
			String extension = getExtension(file);
			// ??????????????????
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MMdd-HHmmss");
			fileName = "/iot/" + getLoginUser().getUserId().toString() + "/" + df.format(new Date()) + "." + extension;
			// ????????????
			File desc = new File(filePath + File.separator + fileName);
			if (!desc.exists()) {
				if (!desc.getParentFile().exists()) {
					desc.getParentFile().mkdirs();
				}
			}
			// ????????????
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
	 * ????????????
	 */
	@ApiOperation("????????????")
	@GetMapping("/download")
	public void download(String fileName, HttpServletResponse response, HttpServletRequest request) {
		try {
//            if (!FileUtils.checkAllowDownload(fileName)) {
//                throw new Exception(StringUtils.format("????????????({})??????????????????????????? ", fileName));
//            }
			String filePath = RuoYiConfig.getProfile();
			// ????????????
			String downloadPath = filePath + fileName.replace("/profile", "");
			// ????????????
			String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
			response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
			FileUtils.setAttachmentResponseHeader(response, downloadName);
			FileUtils.writeBytes(downloadPath, response.getOutputStream());
		} catch (Exception e) {
			log.error("??????????????????", e);
		}
	}

	/**
	 * ??????????????????
	 */
	@Log(title = "SDK??????", businessType = BusinessType.GENCODE)
	@GetMapping("/genSdk")
	@ApiOperation("??????SDK")
	public void genSdk(HttpServletResponse response, int deviceChip) throws IOException {
		byte[] data = downloadCode(deviceChip);
		genSdk(response, data);
	}

	/**
	 * ??????zip??????
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
	 * ????????????????????????????????????
	 *
	 * @param deviceChip
	 * @return ??????
	 */
	public byte[] downloadCode(int deviceChip) {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(outputStream);
//        generatorCode(deviceChip, zip);
		IOUtils.closeQuietly(zip);
		return outputStream.toByteArray();
	}

	/**
	 * ??????????????????????????????
	 */
	private void generatorCode(int deviceChip, ZipOutputStream zip) {
		VelocityInitializer.initVelocity();

		VelocityContext context = VelocityUtils.prepareContext(deviceChip);

		// ??????????????????
		List<String> templates = VelocityUtils.getTemplateList("");
		for (String template : templates) {
			// ????????????
			StringWriter sw = new StringWriter();
			Template tpl = Velocity.getTemplate(template, Constants.UTF8);
			tpl.merge(context, sw);
			try {
				// ?????????zip
				zip.putNextEntry(new ZipEntry(VelocityUtils.getFileName(template)));
				IOUtils.write(sw.toString(), zip, Constants.UTF8);
				IOUtils.closeQuietly(sw);
				zip.flush();
				zip.closeEntry();
			} catch (IOException e) {
				System.out.println("??????????????????");
			}
		}
	}

}
