package net.pingfang.iot.core.mqtt;

import java.util.List;

import org.eclipse.paho.client.mqttv3.MqttAsyncClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import net.pingfang.iot.core.domain.Device;
import net.pingfang.iot.core.domain.DeviceLog;
import net.pingfang.iot.core.model.NtpModel;
import net.pingfang.iot.core.model.ThingsModels.IdentityAndName;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValueRemarkItem;
import net.pingfang.iot.core.model.ThingsModels.ThingsModelValuesInput;
import net.pingfang.iot.core.service.IDeviceLogService;
import net.pingfang.iot.core.service.IDeviceService;

@Service
public class EmqxService {
	private static final Logger logger = LoggerFactory.getLogger(EmqxService.class);
	/**
	 * 订阅的主题
	 */
	private static final String prefix = "/+/+/";
	String sInfoTopic = prefix + "info/post";
	String sNtpTopic = prefix + "ntp/post";
	String sPropertyTopic = prefix + "property/post";
	String sFunctionTopic = prefix + "function/post";
	String sEventTopic = prefix + "event/post";
	String sShadowPropertyTopic = prefix + "property-offline/post";
	String sShadowFunctionTopic = prefix + "function-offline/post";
	/**
	 * 发布的主题
	 */
	String pStatusTopic = "/status/post";
	String pNtpTopic = "/ntp/get";
	String pPropertyTopic = "/property/get";
	String pFunctionTopic = "/function/get";
	@Autowired
	private EmqxClient emqxClient;
	@Autowired
	private IDeviceService deviceService;
	@Autowired
	private IDeviceLogService deviceLogService;

	public void subscribe(MqttAsyncClient client) throws MqttException {
		// 订阅设备信息
		client.subscribe(sInfoTopic, 1);
		// 订阅时钟同步
		client.subscribe(sNtpTopic, 1);
		// 订阅设备属性
		client.subscribe(sPropertyTopic, 1);
		// 订阅设备功能
		client.subscribe(sFunctionTopic, 1);
		// 订阅设备事件
		client.subscribe(sEventTopic, 1);
		// 订阅属性（影子模式）
		client.subscribe(sShadowPropertyTopic, 1);
		// 订阅功能（影子模式）
		client.subscribe(sShadowFunctionTopic, 1);
		logger.info("mqtt订阅了设备信息和物模型主题");
	}

	/**
	 * 消息回调方法
	 *
	 * @param topic       主题
	 * @param mqttMessage 消息体
	 */
	@Async
	public void subscribeCallback(String topic, MqttMessage mqttMessage) throws InterruptedException {

		/** 测试线程池使用 */
		logger.info("====>>>>线程名--{}", Thread.currentThread().getName());
		/** 模拟耗时操作 */
		// Thread.sleep(1000);
		// subscribe后得到的消息会执行到这里面
		String message = new String(mqttMessage.getPayload());
		logger.info("接收消息主题 : " + topic);
		logger.info("接收消息Qos : " + mqttMessage.getQos());
		logger.info("接收消息内容 : " + message);

		String[] topicItem = topic.substring(1).split("/");
		Long productId = Long.valueOf(topicItem[0]);
		String deviceNum = topicItem[1];
		String name = topicItem[2];
		switch (name) {
		case "info":
			reportDevice(productId, deviceNum, message);
			break;
		case "ntp":
			publishNtp(productId, deviceNum, message);
			break;
		case "property":
			reportProperty(productId, deviceNum, message, false);
			break;
		case "function":
			reportFunction(productId, deviceNum, message, false);
			break;
		case "event":
			reportEvent(productId, deviceNum, message);
			break;
		case "property-offline":
			reportProperty(productId, deviceNum, message, true);
			break;
		case "function-offline":
			reportFunction(productId, deviceNum, message, true);
			break;
		}
	}

	/**
	 * 上报设备信息
	 */
	private void reportDevice(Long productId, String deviceNum, String message) {
		try {
			Device device = JSON.parseObject(message, Device.class);
			device.setProductId(productId);
			device.setSerialNumber(deviceNum);
			deviceService.reportDevice(device);
		} catch (Exception e) {
			logger.error("接收设备信息，解析数据时异常 message={}", e.getMessage());
		}
	}

	/**
	 * 上报属性
	 *
	 * @param message
	 */
	private void reportProperty(Long productId, String deviceNum, String message, boolean isShadow) {
		try {
			List<ThingsModelValueRemarkItem> thingsModelValueRemarkItems = JSON.parseArray(message,
					ThingsModelValueRemarkItem.class);
			ThingsModelValuesInput input = new ThingsModelValuesInput();
			input.setProductId(productId);
			input.setDeviceNumber(deviceNum);
			input.setThingsModelValueRemarkItem(thingsModelValueRemarkItems);
			deviceService.reportDeviceThingsModelValue(input, 1, isShadow);
		} catch (Exception e) {
			logger.error("接收属性数据，解析数据时异常 message={}", e.getMessage());
		}
	}

	/**
	 * 上报功能
	 *
	 * @param message
	 */
	private void reportFunction(Long productId, String deviceNum, String message, boolean isShadow) {
		try {
			List<ThingsModelValueRemarkItem> thingsModelValueRemarkItems = JSON.parseArray(message,
					ThingsModelValueRemarkItem.class);
			ThingsModelValuesInput input = new ThingsModelValuesInput();
			input.setProductId(productId);
			input.setDeviceNumber(deviceNum);
			input.setThingsModelValueRemarkItem(thingsModelValueRemarkItems);
			deviceService.reportDeviceThingsModelValue(input, 2, isShadow);
		} catch (Exception e) {
			logger.error("接收功能，解析数据时异常 message={}", e.getMessage());
		}
	}

	/**
	 * 上报事件
	 *
	 * @param message
	 */
	private void reportEvent(Long productId, String deviceNum, String message) {
		try {
			List<ThingsModelValueRemarkItem> thingsModelValueRemarkItems = JSON.parseArray(message,
					ThingsModelValueRemarkItem.class);
			Device device = deviceService.selectDeviceBySerialNumber(deviceNum);
			for (int i = 0; i < thingsModelValueRemarkItems.size(); i++) {
				// 添加到设备日志
				DeviceLog deviceLog = new DeviceLog();
				deviceLog.setDeviceId(device.getDeviceId());
				deviceLog.setDeviceName(device.getDeviceName());
				deviceLog.setLogValue(thingsModelValueRemarkItems.get(i).getValue());
				deviceLog.setRemark(thingsModelValueRemarkItems.get(i).getRemark());
				deviceLog.setSerialNumber(device.getSerialNumber());
				deviceLog.setIdentity(thingsModelValueRemarkItems.get(i).getId());
				deviceLog.setLogType(3);
				deviceLog.setIsMonitor(0);
				deviceLogService.insertDeviceLog(deviceLog);
			}
		} catch (Exception e) {
			logger.error("接收事件，解析数据时异常 message={}", e.getMessage());
		}
	}

	/**
	 * 1.发布设备状态
	 */
	public void publishStatus(Long productId, String deviceNum, int deviceStatus, int isShadow) {
		String message = "{\"status\":" + deviceStatus + ",\"isShadow\":" + isShadow + "}";
		emqxClient.publish(1, false, "/" + productId + "/" + deviceNum + pStatusTopic, message);
	}

	/**
	 * 2.发布时钟同步信息
	 *
	 * @param message
	 */
	private void publishNtp(Long productId, String deviceNum, String message) {
		NtpModel ntpModel = JSON.parseObject(message, NtpModel.class);
		ntpModel.setServerRecvTime(System.currentTimeMillis());
		ntpModel.setServerSendTime(System.currentTimeMillis());
		emqxClient.publish(1, false, "/" + productId + "/" + deviceNum + pNtpTopic, JSON.toJSONString(ntpModel));
	}

	/**
	 * 3.发布属性
	 */
	public void publishProperty(Long productId, String deviceNum, List<IdentityAndName> thingsList) {
		if (thingsList == null) {
			emqxClient.publish(1, true, "/" + productId + "/" + deviceNum + pPropertyTopic, "");
		} else {
			emqxClient.publish(1, true, "/" + productId + "/" + deviceNum + pPropertyTopic,
					JSON.toJSONString(thingsList));
		}
	}

	/**
	 * 4.发布功能
	 */
	public void publishFunction(Long productId, String deviceNum, List<IdentityAndName> thingsList) {
		if (thingsList == null) {
			emqxClient.publish(1, true, "/" + productId + "/" + deviceNum + pFunctionTopic, "");
		} else {
			emqxClient.publish(1, true, "/" + productId + "/" + deviceNum + pFunctionTopic,
					JSON.toJSONString(thingsList));
		}

	}

}
