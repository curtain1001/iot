package net.pingfang.iot.core.network.property;

import lombok.Getter;

@Getter
public class Version {
	public static Version current = new Version();

	private final String edition = "community";

	private final String version = "1.12.0-SNAPSHOT";

}
