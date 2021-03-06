package net.pingfang.iot.core.service.impl;

import static net.pingfang.iot.common.utils.SecurityUtils.getLoginUser;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import net.pingfang.iot.common.constant.Constants;
import net.pingfang.iot.common.core.domain.entity.SysUser;
import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.common.utils.StringUtils;
import net.pingfang.iot.common.utils.http.HttpUtils;
import net.pingfang.iot.common.utils.ip.IpUtils;
import net.pingfang.iot.core.domain.Device;
import net.pingfang.iot.core.domain.DeviceLog;
import net.pingfang.iot.core.domain.Product;
import net.pingfang.iot.core.mapper.DeviceLogMapper;
import net.pingfang.iot.core.mapper.DeviceMapper;
import net.pingfang.iot.core.mapper.DeviceUserMapper;
import net.pingfang.iot.core.model.AuthenticateInputModel;
import net.pingfang.iot.core.model.DeviceAllShortOutput;
import net.pingfang.iot.core.model.DeviceAuthenticateModel;
import net.pingfang.iot.core.model.DeviceShortOutput;
import net.pingfang.iot.core.model.ThingsModelItem.ArrayModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.BoolModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.DecimalModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.EnumItemOutput;
import net.pingfang.iot.core.model.ThingsModelItem.EnumModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.IntegerModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.ReadOnlyModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.StringModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.ThingsModelItemBase;
import net.pingfang.iot.core.model.ThingsModels.IdentityAndName;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelShadow;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValueItem;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValueItemDto;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValuesInput;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValuesOutput;
import net.pingfang.iot.core.service.IDeviceLogService;
import net.pingfang.iot.core.service.IDeviceService;
import net.pingfang.iot.core.service.IProductService;
import net.pingfang.iot.core.service.IToolService;
import net.pingfang.iot.system.service.ISysUserService;

/**
 * ??????Service???????????????
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class DeviceServiceImpl implements IDeviceService {
	private static final Logger log = LoggerFactory.getLogger(DeviceServiceImpl.class);

	@Autowired
	private DeviceMapper deviceMapper;

	@Autowired
	private DeviceUserMapper deviceUserMapper;

	@Autowired
	private ThingsModelServiceImpl thingsModelService;

	@Autowired
	private DeviceJobServiceImpl deviceJobService;

	@Autowired
	private DeviceLogMapper deviceLogMapper;

	@Autowired
	private IToolService toolService;

	@Autowired
	private IProductService productService;

	@Autowired
	private ISysUserService userService;

	@Autowired
	private IDeviceLogService deviceLogService;

	/**
	 * ????????????
	 *
	 * @param deviceId ????????????
	 * @return ??????
	 */
	@Override
	public Device selectDeviceByDeviceId(Long deviceId) {
		return deviceMapper.selectDeviceByDeviceId(deviceId);
	}

	/**
	 * ??????????????????????????????
	 *
	 * @param serialNumber ????????????
	 * @return ??????
	 */
	@Override
	public Device selectDeviceBySerialNumber(String serialNumber) {
		return deviceMapper.selectDeviceBySerialNumber(serialNumber);
	}

	/**
	 * ????????????????????????????????????
	 *
	 * @param serialNumber ????????????
	 * @return ??????
	 */
	@Override
	public Device selectShortDeviceBySerialNumber(String serialNumber) {
		return deviceMapper.selectShortDeviceBySerialNumber(serialNumber);
	}

	/**
	 * ??????????????????????????????????????????
	 *
	 * @param model ?????????????????????ID
	 * @return ??????
	 */
	@Override
	public DeviceAuthenticateModel selectDeviceAuthenticate(AuthenticateInputModel model) {
		return deviceMapper.selectDeviceAuthenticate(model);
	}

	/**
	 * ????????????
	 *
	 * @param deviceId ????????????
	 * @return ??????
	 */
	@Override
	public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId) {
		DeviceShortOutput device = deviceMapper.selectDeviceRunningStatusByDeviceId(deviceId);
		JSONObject thingsModelObject = JSONObject
				.parseObject(thingsModelService.getCacheThingsModelByProductId(device.getProductId()));
		JSONArray properties = thingsModelObject.getJSONArray("properties");
		JSONArray functions = thingsModelObject.getJSONArray("functions");
		// ????????????????????????????????????????????????
		convertJsonToCategoryList(properties, device, false, false);
		convertJsonToCategoryList(functions, device, false, false);
		device.setThingsModelValue("");
		return device;
	}

	/**
	 * ????????????????????????
	 *
	 * @param input ??????ID???????????????
	 * @param type  1=?????? 2=??????
	 * @return ??????
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int reportDeviceThingsModelValue(ThingsModelValuesInput input, int type, boolean isShadow) {
		// ???????????????
		String thingsModels = thingsModelService.getCacheThingsModelByProductId(input.getProductId());
		JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
		List<ThingsModelValueItemDto> valueList = null;
		if (type == 1) {
			JSONArray properties = thingsModelObject.getJSONArray("properties");
			valueList = properties.toJavaList(ThingsModelValueItemDto.class);
		} else if (type == 2) {
			JSONArray functions = thingsModelObject.getJSONArray("functions");
			valueList = functions.toJavaList(ThingsModelValueItemDto.class);
		}

		// ??????????????????
		ThingsModelValuesOutput deviceThings = deviceMapper
				.selectDeviceThingsModelValueBySerialNumber(input.getDeviceNumber());
		List<ThingsModelValueItem> thingsModelValues = JSONObject.parseArray(deviceThings.getThingsModelValue(),
				ThingsModelValueItem.class);

		for (int i = 0; i < input.getThingsModelValueRemarkItem().size(); i++) {
			// ??????
			for (int j = 0; j < thingsModelValues.size(); j++) {
				if (input.getThingsModelValueRemarkItem().get(i).getId().equals(thingsModelValues.get(j).getId())) {
					// ??????????????????????????????
					if (!isShadow) {
						thingsModelValues.get(j)
								.setValue(String.valueOf(input.getThingsModelValueRemarkItem().get(i).getValue()));
					}
					thingsModelValues.get(j)
							.setShadow(String.valueOf(input.getThingsModelValueRemarkItem().get(i).getValue()));
					break;
				}
			}

			// ??????
			for (int k = 0; k < valueList.size(); k++) {
				if (valueList.get(k).getId().equals(input.getThingsModelValueRemarkItem().get(i).getId())) {
					valueList.get(k).setValue(input.getThingsModelValueRemarkItem().get(i).getValue());
					// TODO ???????????????????????????????????????

					// ?????????????????????
					DeviceLog deviceLog = new DeviceLog();
					deviceLog.setDeviceId(deviceThings.getDeviceId());
					deviceLog.setSerialNumber(deviceThings.getSerialNumber());
					deviceLog.setDeviceName(deviceThings.getDeviceName());
					deviceLog.setLogValue(input.getThingsModelValueRemarkItem().get(i).getValue());
					deviceLog.setRemark(input.getThingsModelValueRemarkItem().get(i).getRemark());
					deviceLog.setIdentity(input.getThingsModelValueRemarkItem().get(i).getId());
					deviceLog.setCreateTime(DateUtils.getNowDate());
					deviceLog.setIsMonitor(valueList.get(k).getIsMonitor());
					deviceLog.setLogType(type);
					deviceLogMapper.insertDeviceLog(deviceLog);
					break;
				}
			}
		}
		input.setStringValue(JSONObject.toJSONString(thingsModelValues));
		input.setDeviceId(deviceThings.getDeviceId());
		return deviceMapper.updateDeviceThingsModelValue(input);
	}

	/**
	 * ??????????????????
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	public List<Device> selectDeviceList(Device device) {
		return deviceMapper.selectDeviceList(device);
	}

	/**
	 * ??????????????????????????????
	 *
	 * @return ??????
	 */
	@Override
	public List<DeviceAllShortOutput> selectAllDeviceShortList() {
		// TODO redis??????
		return deviceMapper.selectAllDeviceShortList();
	}

	/**
	 * ????????????????????????
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	public List<DeviceShortOutput> selectDeviceShortList(Device device) {
		// TODO ?????????????????????
		List<DeviceShortOutput> deviceList = deviceMapper.selectDeviceShortList(device);
		for (int i = 0; i < deviceList.size(); i++) {
			JSONObject thingsModelObject = JSONObject
					.parseObject(thingsModelService.getCacheThingsModelByProductId(deviceList.get(i).getProductId()));
			JSONArray properties = thingsModelObject.getJSONArray("properties");
			JSONArray functions = thingsModelObject.getJSONArray("functions");
			// ????????????????????????????????????????????????,isOnlyRead????????????????????????????????????
			convertJsonToCategoryList(properties, deviceList.get(i), true, false);
			convertJsonToCategoryList(functions, deviceList.get(i), true, false);
			deviceList.get(i).setThingsModelValue("");
		}
		return deviceList;
	}

	// ?????????????????????????????????
	@Override
	public List<DeviceShortOutput> selectDeviceShortListAccurate(Device device) {
		return deviceMapper.selectDeviceShortListAccurate(device);
	}

	/**
	 * Json????????????????????????????????????????????????
	 *
	 * @param jsonArray  ???????????????
	 * @param isOnlyTop  ???????????????????????????
	 * @param isOnlyRead ?????????????????????
	 * @param device     ??????
	 */
	@Async
	public void convertJsonToCategoryList(JSONArray jsonArray, DeviceShortOutput device, boolean isOnlyTop,
			boolean isOnlyRead) {
		// ??????????????????
		JSONArray thingsValueArray = JSONObject.parseArray(device.getThingsModelValue());
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject thingsJson = jsonArray.getJSONObject(i);
			JSONObject datatypeJson = thingsJson.getJSONObject("datatype");
			ThingsModelItemBase thingsModel = new ThingsModelItemBase();
			thingsModel.setIsTop(thingsJson.getInteger("isTop"));
			// ?????????isTop??????
			if (thingsModel.getIsTop() == 0 && isOnlyTop == true) {
				continue;
			}

			thingsModel.setId(thingsJson.getString("id"));
			thingsModel.setName(thingsJson.getString("name"));
			thingsModel
					.setIsMonitor(thingsJson.getInteger("isMonitor") == null ? 0 : thingsJson.getInteger("isMonitor"));
			thingsModel.setType(datatypeJson.getString("type"));
			thingsModel.setValue("");
			// ??????value
			for (int j = 0; j < thingsValueArray.size(); j++) {
				if (thingsValueArray.getJSONObject(j).getString("id").equals(thingsModel.getId())) {
					thingsModel.setValue(thingsValueArray.getJSONObject(j).getString("value"));
					thingsModel.setShadow(thingsValueArray.getJSONObject(j).getString("shadow"));
					break;
				}
			}
			// ??????????????????????????????????????????
			if (datatypeJson.getString("type").equals("decimal")) {
				DecimalModelOutput model = new DecimalModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				model.setMax(datatypeJson.getBigDecimal("max"));
				model.setMin(datatypeJson.getBigDecimal("min"));
				model.setStep(datatypeJson.getBigDecimal("step"));
				model.setUnit(datatypeJson.getString("unit"));
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getDecimalList().add(model);
				}
			} else if (datatypeJson.getString("type").equals("integer")) {
				IntegerModelOutput model = new IntegerModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				model.setMax(datatypeJson.getBigDecimal("max"));
				model.setMin(datatypeJson.getBigDecimal("min"));
				model.setStep(datatypeJson.getBigDecimal("step"));
				model.setUnit(datatypeJson.getString("unit"));
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getIntegerList().add(model);
				}
			} else if (datatypeJson.getString("type").equals("bool")) {
				BoolModelOutput model = new BoolModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				model.setFalseText(datatypeJson.getString("falseText"));
				model.setTrueText(datatypeJson.getString("trueText"));
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getBoolList().add(model);
				}
			} else if (datatypeJson.getString("type").equals("string")) {
				StringModelOutput model = new StringModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				model.setMaxLength(datatypeJson.getInteger("maxLength"));
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getStringList().add(model);
				}
			} else if (datatypeJson.getString("type").equals("array")) {
				ArrayModelOutput model = new ArrayModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				model.setArrayType(datatypeJson.getString("arrayType"));
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getArrayList().add(model);
				}
			} else if (datatypeJson.getString("type").equals("enum")) {
				EnumModelOutput model = new EnumModelOutput();
				BeanUtils.copyProperties(thingsModel, model);
				List<EnumItemOutput> enumItemList = JSONObject.parseArray(datatypeJson.getString("enumList"),
						EnumItemOutput.class);
				model.setEnumList(enumItemList);
				if (model.getIsMonitor() == 1 || isOnlyRead == true) {
					ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
					BeanUtils.copyProperties(model, readonlyModel);
					device.getReadOnlyList().add(readonlyModel);
				} else {
					device.getEnumList().add(model);
				}
			}
		}
		// ??????
		device.setReadOnlyList(device.getReadOnlyList().stream()
				.sorted(Comparator.comparing(ThingsModelItemBase::getIsMonitor).reversed())
				.collect(Collectors.toList()));
	}

	/**
	 * ????????????
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Device insertDevice(Device device) {
		SysUser sysUser = getLoginUser().getUser();
		// ????????????
		device.setCreateTime(DateUtils.getNowDate());
		device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(device.getProductId())));
		device.setUserId(sysUser.getUserId());
		device.setUserName(sysUser.getUserName());
		device.setTenantId(sysUser.getUserId());
		device.setTenantName(sysUser.getUserName());
		device.setRssi(0);
		deviceMapper.insertDevice(device);
		// ??????????????????
//        DeviceUser deviceUser = new DeviceUser();
//        deviceUser.setUserId(sysUser.getUserId());
//        deviceUser.setUserName(sysUser.getUserName());
//        deviceUser.setPhonenumber(sysUser.getPhonenumber());
//        deviceUser.setDeviceId(device.getDeviceId());
//        deviceUser.setDeviceName(device.getDeviceName());
//        deviceUser.setTenantId(device.getDeviceId());
//        deviceUser.setTenantName(device.getTenantName());
//        deviceUser.setIsOwner(1);
//        deviceUserMapper.insertDeviceUser(deviceUser);
		return device;
	}

	/**
	 * ?????????????????????????????????
	 *
	 * @return ??????
	 */
	@Override
	public int insertDeviceAuto(String serialNumber, Long userId, Long productId) {
		Device device = new Device();
		int random = (int) (Math.random() * (9000)) + 1000;
		device.setDeviceName("??????" + random);
		device.setSerialNumber(serialNumber);
		SysUser user = userService.selectUserById(userId);
		device.setUserId(userId);
		device.setUserName(user.getUserName());
		Product product = productService.selectProductByProductId(productId);
		device.setProductId(productId);
		device.setProductName(product.getProductName());
		device.setTenantId(userId);
		device.setTenantName(user.getUserName());
		device.setFirmwareVersion(BigDecimal.valueOf(1.0));
		device.setStatus(3);
		device.setActiveTime(DateUtils.getNowDate());
		device.setIsShadow(0);
		device.setRssi(0);
		device.setIsCustomLocation(0);
		device.setCreateTime(DateUtils.getNowDate());
		device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(device.getProductId())));
		return deviceMapper.insertDevice(device);
	}

	/**
	 * ??????????????????
	 *
	 * @param productId
	 * @return
	 */
	private List<ThingsModelValueItem> getThingsModelDefaultValue(Long productId) {
		// ???????????????,???????????????
		String thingsModels = thingsModelService.getCacheThingsModelByProductId(productId);
		JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
		JSONArray properties = thingsModelObject.getJSONArray("properties");
		JSONArray functions = thingsModelObject.getJSONArray("functions");
		List<ThingsModelValueItem> valueList = properties.toJavaList(ThingsModelValueItem.class);
		valueList.addAll(functions.toJavaList(ThingsModelValueItem.class));
		valueList.forEach(x -> {
			x.setValue("");
			x.setShadow("");
		});
		return valueList;
	}

	/**
	 * ???????????????????????????
	 *
	 * @param device
	 * @return
	 */
	@Override
	public ThingsModelShadow getDeviceShadowThingsModel(Device device) {
		// ?????????
		String thingsModels = thingsModelService.getCacheThingsModelByProductId(device.getProductId());
		JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
		JSONArray properties = thingsModelObject.getJSONArray("properties");
		JSONArray functions = thingsModelObject.getJSONArray("functions");

		// ????????????
		List<ThingsModelValueItem> thingsModelValueItems = JSONObject.parseArray(device.getThingsModelValue(),
				ThingsModelValueItem.class);

		// ???????????????????????????
		List<ThingsModelValueItem> shadowList = new ArrayList<>();
		for (int i = 0; i < thingsModelValueItems.size(); i++) {
			if (!thingsModelValueItems.get(i).getValue().equals(thingsModelValueItems.get(i).getShadow())) {
				shadowList.add(thingsModelValueItems.get(i));
				System.out.println("???????????????" + thingsModelValueItems.get(i).getId());
			}
		}
		ThingsModelShadow shadow = new ThingsModelShadow();
		for (int i = 0; i < shadowList.size(); i++) {
			boolean isGetValue = false;
			for (int j = 0; j < properties.size(); j++) {
				if (properties.getJSONObject(j).getInteger("isMonitor") == 0
						&& properties.getJSONObject(j).getString("id").equals(shadowList.get(i).getId())) {
					IdentityAndName item = new IdentityAndName(shadowList.get(i).getId(),
							shadowList.get(i).getShadow());
					shadow.getProperties().add(item);
					System.out.println("?????????????????????" + item.getId());
					isGetValue = true;
					break;
				}
			}
			if (!isGetValue) {
				for (int k = 0; k < functions.size(); k++) {
					if (functions.getJSONObject(k).getString("id").equals(shadowList.get(i).getId())) {
						IdentityAndName item = new IdentityAndName(shadowList.get(i).getId(),
								shadowList.get(i).getShadow());
						shadow.getFunctions().add(item);
						System.out.println("?????????????????????" + item.getId());
						break;
					}
				}
			}
		}
		return shadow;
	}

	/**
	 * ????????????
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	public int updateDevice(Device device) {
		device.setUpdateTime(DateUtils.getNowDate());
		// ???????????????,????????????????????????????????????
		if (device.getStatus() == 1) {
			device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(device.getProductId())));
		} else {
			device.setProductId(null);
			device.setProductName(null);
		}
		return deviceMapper.updateDevice(device);
	}

	/**
	 * ????????????????????????
	 *
	 * @return ??????
	 */
	@Override
	public String generationDeviceNum() {
		String number = "D" + toolService.getStringRandom(15);
		int count = deviceMapper.getDeviceNumCount(number);
		if (count == 0) {
			return number;
		} else {
			generationDeviceNum();
		}
		return "";
	}

	@Override
	public List<DeviceAllShortOutput> selectAllDeviceShortListAccurate(String userName) {
		return deviceMapper.selectAllDeviceShortListAccurate(userName);
	}

	// ???????????? ????????????????????????????????????
	@Override
	public List<Device> selectDeviceListAccurate(Device device) {
		return deviceMapper.selectDeviceListAccurate(device);
	}

	/**
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateDeviceStatusAndLocation(Device device, String ipAddress) {
		// ?????????????????????
		if (ipAddress != "") {
			if (device.getActiveTime() == null) {
				device.setActiveTime(DateUtils.getNowDate());
			}
			if (device.getIsCustomLocation() == 0) {
				device.setNetworkIp(ipAddress);
				setLocation(ipAddress, device);
			}
		}
		int result = deviceMapper.updateDeviceStatus(device);

		// ?????????????????????
		DeviceLog deviceLog = new DeviceLog();
		deviceLog.setDeviceId(device.getDeviceId());
		deviceLog.setDeviceName(device.getDeviceName());
		deviceLog.setSerialNumber(device.getSerialNumber());
		deviceLog.setIsMonitor(0);
		if (device.getStatus() == 3) {
			deviceLog.setLogValue("1");
			deviceLog.setRemark("????????????");
			deviceLog.setIdentity("online");
			deviceLog.setLogType(5);
		} else if (device.getStatus() == 4) {
			deviceLog.setLogValue("0");
			deviceLog.setRemark("????????????");
			deviceLog.setIdentity("offline");
			deviceLog.setLogType(6);
		}
		deviceLogService.insertDeviceLog(deviceLog);
		return result;
	}

	/**
	 * ??????IP????????????
	 *
	 * @param ip
	 * @return
	 */
	private void setLocation(String ip, Device device) {
		String IP_URL = "http://whois.pconline.com.cn/ipJson.jsp";
		String address = "????????????";
		// ???????????????
		if (IpUtils.internalIp(ip)) {
			device.setNetworkAddress("??????IP");
		}
		try {
			String rspStr = HttpUtils.sendGet(IP_URL, "ip=" + ip + "&json=true", Constants.GBK);
			if (!StringUtils.isEmpty(rspStr)) {
				JSONObject obj = JSONObject.parseObject(rspStr);
				device.setNetworkAddress(obj.getString("addr"));
				System.out.println(device.getSerialNumber() + "- ???????????????" + obj.getString("addr"));
				// ???????????????
				setLatitudeAndLongitude(obj.getString("city"), device);
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	/**
	 * ???????????????
	 *
	 * @param city
	 */
	private void setLatitudeAndLongitude(String city, Device device) {
		String BAIDU_URL = "https://api.map.baidu.com/geocoder";
		String baiduResponse = HttpUtils.sendGet(BAIDU_URL, "address=" + city + "&output=json", Constants.GBK);
		if (!StringUtils.isEmpty(baiduResponse)) {
			JSONObject baiduObject = JSONObject.parseObject(baiduResponse);
			JSONObject location = baiduObject.getJSONObject("result").getJSONObject("location");
			device.setLongitude(location.getBigDecimal("lng"));
			device.setLatitude(location.getBigDecimal("lat"));
			System.out.println(device.getSerialNumber() + "- ???????????????" + location.getBigDecimal("lng") + "??????????????????"
					+ location.getBigDecimal("lat"));
		}
	}

	/**
	 * ??????????????????
	 *
	 * @param device ??????
	 * @return ??????
	 */
	@Override
	public int reportDevice(Device device) {
		Device deviceEntity = deviceMapper.selectDeviceBySerialNumber(device.getSerialNumber());
		int result = 0;
		if (deviceEntity != null) {
			// ??????????????????
			device.setUpdateTime(DateUtils.getNowDate());
			if (deviceEntity.getActiveTime() == null || deviceEntity.getActiveTime().equals("")) {
				device.setActiveTime(DateUtils.getNowDate());
			}
			device.setThingsModelValue(null);
			result = deviceMapper.updateDeviceBySerialNumber(device);
		}
		return result;
	}

	/**
	 * ??????????????????
	 *
	 * @return ??????
	 */
	@Override
	public int resetDeviceStatus(String deviceNum) {
		int result = deviceMapper.resetDeviceStatus(deviceNum);
		return result;
	}

	/**
	 * ??????????????????
	 *
	 * @param deviceIds ???????????????????????????
	 * @return ??????
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteDeviceByDeviceIds(Long[] deviceIds) throws SchedulerException {
		// ??????????????????
		deviceMapper.deleteDeviceGroupByDeviceIds(deviceIds);
		// ??????????????????
		deviceLogMapper.deleteDeviceLogByDeviceIds(deviceIds);
		// ??????????????????
		deviceJobService.deleteJobByDeviceIds(deviceIds);

		// TODO ??????????????????
		return deviceMapper.deleteDeviceByDeviceIds(deviceIds);
	}

	/**
	 * ??????????????????
	 *
	 * @param deviceId ????????????
	 * @return ??????
	 */
	@Override
	public int deleteDeviceByDeviceId(Long deviceId) {
		return deviceMapper.deleteDeviceByDeviceId(deviceId);
	}
}
