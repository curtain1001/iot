package net.pingfang.iot.core.tcp.client;

import io.vertx.core.net.NetClientOptions;
import java.util.HashMap;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.pingfang.iot.core.network.property.ValueObject;
import net.pingfang.iot.core.tcp.parser.PayloadParserType;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TcpClientProperties implements ValueObject {

	private String id;

	private int port;

	private String host;

	private String certId;

	private boolean ssl;

	private PayloadParserType parserType;

	private Map<String, Object> parserConfiguration = new HashMap<>();

	private NetClientOptions options;

	private boolean enabled;

	@Override
	public Map<String, Object> values() {
		return parserConfiguration;
	}
}
