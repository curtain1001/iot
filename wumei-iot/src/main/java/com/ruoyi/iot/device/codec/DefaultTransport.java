package com.ruoyi.iot.device.codec;

import java.util.Arrays;

import com.ruoyi.iot.device.protocol.Transport;
import com.ruoyi.iot.device.protocol.Transports;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author zhouhao
 * @since 1.0.0
 */
@AllArgsConstructor
public enum DefaultTransport implements Transport {
	MQTT("MQTT"), //
	MQTT_TLS("MQTT TLS"), //
	UDP("UDP"), //
	UDP_DTLS("UDP DTLS"), //
	CoAP("CoAP"), //
	CoAP_DTLS("CoAP DTLS"), //
	TCP("TCP"), //
	TCP_TLS("TCP TLS"), //
	HTTP("HTTP"), //
	HTTPS("HTTPS"), //
	WebSocket("WebSocket"), //
	WebSockets("WebSocket TLS");

	static {
		Transports.register(Arrays.asList(DefaultTransport.values()));
	}

	@Getter
	private final String name;

	@Override
	public String getId() {
		return name();
	}

}
