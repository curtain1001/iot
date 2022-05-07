package com.ruoyi.iot.device.server.monitor;

public interface GatewayServerMonitor {

	String getCurrentServerId();

	GatewayServerMetrics metrics();
}
