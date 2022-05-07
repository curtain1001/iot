package com.ruoyi.iot.device.codec;

import com.ruoyi.iot.device.message.MessageCodecDescription;
import com.ruoyi.iot.device.protocol.Transport;

import reactor.core.publisher.Mono;

/**
 * 设备消息转换器,用于对不同协议的消息进行转换
 *
 * @author zhouhao // * @see
 *         org.jetlinks.core.message.interceptor.DeviceMessageCodecInterceptor
 * @since 1.0.0
 */
public interface DeviceMessageCodec extends DeviceMessageEncoder, DeviceMessageDecoder {

	/**
	 * @return 返回支持的传输协议
	 * @see DefaultTransport
	 */
	Transport getSupportTransport();

	/**
	 * 获取协议描述
	 *
	 * @return 协议描述
	 */
	default Mono<? extends MessageCodecDescription> getDescription() {
		return Mono.empty();
	}
}
