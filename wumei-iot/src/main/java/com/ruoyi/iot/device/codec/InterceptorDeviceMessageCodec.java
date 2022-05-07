package com.ruoyi.iot.device.codec;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.annotation.Nonnull;

import org.reactivestreams.Publisher;

import com.ruoyi.iot.device.interceptor.DeviceMessageCodecInterceptor;
import com.ruoyi.iot.device.interceptor.DeviceMessageDecodeInterceptor;
import com.ruoyi.iot.device.interceptor.DeviceMessageEncodeInterceptor;
import com.ruoyi.iot.device.message.EncodedMessage;
import com.ruoyi.iot.device.message.Message;
import com.ruoyi.iot.device.message.MessageDecodeContext;
import com.ruoyi.iot.device.message.MessageEncodeContext;
import com.ruoyi.iot.device.protocol.Transport;

import reactor.core.publisher.Flux;

/**
 * @author wangchao 消息拦截器 实现编码解码
 * @since 1.0
 **/
public class InterceptorDeviceMessageCodec implements DeviceMessageCodec {

	private final DeviceMessageCodec messageCodec;

	private final List<DeviceMessageDecodeInterceptor> decodeDeviceMessageInterceptors = new CopyOnWriteArrayList<>();

	private final List<DeviceMessageEncodeInterceptor> encodeDeviceMessageInterceptors = new CopyOnWriteArrayList<>();

	public InterceptorDeviceMessageCodec(DeviceMessageCodec codec) {
		this.messageCodec = codec;
	}

	@Override
	public Transport getSupportTransport() {
		return messageCodec.getSupportTransport();
	}

	/**
	 * 注册解编码拦截器
	 *
	 * @param interceptor 解编码连接器
	 */
	public void register(DeviceMessageCodecInterceptor interceptor) {
		if (interceptor instanceof DeviceMessageDecodeInterceptor) {
			decodeDeviceMessageInterceptors.add(((DeviceMessageDecodeInterceptor) interceptor));
		}
		if (interceptor instanceof DeviceMessageEncodeInterceptor) {
			encodeDeviceMessageInterceptors.add(((DeviceMessageEncodeInterceptor) interceptor));
		}
	}

	@Nonnull
	@Override
	public Flux<? extends EncodedMessage> encode(@Nonnull MessageEncodeContext context) {
		return Flux.defer(() -> {
			for (DeviceMessageEncodeInterceptor interceptor : encodeDeviceMessageInterceptors) {
				interceptor.preEncode(context);
			}
			Flux<? extends EncodedMessage> message = Flux.from(messageCodec.encode(context));

			for (DeviceMessageEncodeInterceptor interceptor : encodeDeviceMessageInterceptors) {
				message = message.flatMap(msg -> interceptor.postEncode(context, msg));
			}

			return message;
		});

	}

	@Nonnull
	@Override
	public Publisher<? extends Message> decode(@Nonnull MessageDecodeContext context) {
		return Flux.defer(() -> {
			for (DeviceMessageDecodeInterceptor interceptor : decodeDeviceMessageInterceptors) {
				interceptor.preDecode(context);
			}
			Flux<? extends Message> message = Flux.from(messageCodec.decode(context));

			for (DeviceMessageDecodeInterceptor interceptor : decodeDeviceMessageInterceptors) {
				message = message.flatMap(msg -> interceptor.postDecode(context, msg));
			}

			return message;
		});
	}
}
