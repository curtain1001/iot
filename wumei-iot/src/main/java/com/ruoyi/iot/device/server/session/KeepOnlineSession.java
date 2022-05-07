package com.ruoyi.iot.device.server.session;

import java.net.InetSocketAddress;
import java.time.Duration;
import java.util.Optional;

import javax.annotation.Nullable;

import com.ruoyi.iot.device.DeviceOperator;
import com.ruoyi.iot.device.message.EncodedMessage;
import com.ruoyi.iot.device.protocol.Transport;
import com.ruoyi.iot.enums.ErrorCode;
import com.ruoyi.iot.exception.DeviceOperationException;

import lombok.AccessLevel;
import lombok.Setter;
import reactor.core.publisher.Mono;

public class KeepOnlineSession implements DeviceSession, ReplaceableDeviceSession, PersistentSession {

	DeviceSession parent;

	@Setter(AccessLevel.PACKAGE)
	private long lastKeepAliveTime = System.currentTimeMillis();

	private final long connectTime = System.currentTimeMillis();

	private long keepAliveTimeOutMs;

	public KeepOnlineSession(DeviceSession parent, Duration keepAliveTimeOut) {
		this.parent = parent;
		setKeepAliveTimeout(keepAliveTimeOut);
	}

	@Override
	public String getId() {
		return parent.getId();
	}

	@Override
	public String getDeviceId() {
		return parent.getDeviceId();
	}

	@Nullable
	@Override
	public DeviceOperator getOperator() {
		return parent.getOperator();
	}

	@Override
	public long lastPingTime() {
		return lastKeepAliveTime;
	}

	@Override
	public long connectTime() {
		return connectTime;
	}

	@Override
	public Mono<Boolean> send(EncodedMessage encodedMessage) {
		return Mono.defer(() -> {
			if (parent.isAlive()) {
				return parent.send(encodedMessage);
			}
			return Mono.error(new DeviceOperationException(ErrorCode.CONNECTION_LOST));
		});
	}

	@Override
	public Transport getTransport() {
		return parent.getTransport();
	}

	@Override
	public void close() {
		parent.close();
	}

	@Override
	public void ping() {
		lastKeepAliveTime = System.currentTimeMillis();
		parent.keepAlive();
	}

	@Override
	public boolean isAlive() {
		return keepAliveTimeOutMs <= 0 || System.currentTimeMillis() - lastKeepAliveTime < keepAliveTimeOutMs
				|| parent.isAlive();
	}

	@Override
	public void onClose(Runnable call) {
		parent.onClose(call);
	}

	@Override
	public Optional<String> getServerId() {
		return parent.getServerId();
	}

	@Override
	public Optional<InetSocketAddress> getClientAddress() {
		return parent.getClientAddress();
	}

	@Override
	public void setKeepAliveTimeout(Duration timeout) {
		keepAliveTimeOutMs = timeout.toMillis();
		parent.setKeepAliveTimeout(timeout);
	}

	@Override
	public Duration getKeepAliveTimeout() {
		return Duration.ofMillis(keepAliveTimeOutMs);
	}

	@Override
	public boolean isWrapFrom(Class<?> type) {
		return type == KeepOnlineSession.class || parent.isWrapFrom(type);
	}

	@Override
	public <T extends DeviceSession> T unwrap(Class<T> type) {
		return type == KeepOnlineSession.class ? type.cast(this) : parent.unwrap(type);
	}

	@Override
	public void replaceWith(DeviceSession session) {
		this.parent = session;
	}

	@Override
	public String getProvider() {
		return KeepOnlineDeviceSessionProvider.ID;
	}

}
