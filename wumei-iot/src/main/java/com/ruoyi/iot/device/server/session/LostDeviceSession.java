package com.ruoyi.iot.device.server.session;

import com.ruoyi.iot.device.DeviceOperator;
import com.ruoyi.iot.device.message.EncodedMessage;
import com.ruoyi.iot.device.protocol.Transport;
import com.ruoyi.iot.enums.ErrorCode;
import com.ruoyi.iot.exception.DeviceOperationException;

import lombok.AllArgsConstructor;
import lombok.Getter;
import reactor.core.publisher.Mono;

@AllArgsConstructor
public class LostDeviceSession implements DeviceSession {
	@Getter
	private final String id;

	@Getter
	private final DeviceOperator operator;

	@Getter
	private final Transport transport;

	@Override
	public String getDeviceId() {
		return operator.getDeviceId();
	}

	@Override
	public long lastPingTime() {
		return -1;
	}

	@Override
	public long connectTime() {
		return -1;
	}

	@Override
	public Mono<Boolean> send(EncodedMessage encodedMessage) {
		return Mono.error(new DeviceOperationException(ErrorCode.CONNECTION_LOST));
	}

	@Override
	public void close() {

	}

	@Override
	public void ping() {

	}

	@Override
	public boolean isAlive() {
		return false;
	}

	@Override
	public void onClose(Runnable call) {

	}
}
