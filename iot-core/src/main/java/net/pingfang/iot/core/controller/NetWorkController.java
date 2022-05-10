package net.pingfang.iot.core.controller;

import java.util.Collections;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.vertx.core.Vertx;
import io.vertx.core.net.NetClientOptions;
import net.pingfang.iot.core.tcp.client.TcpClientProperties;
import net.pingfang.iot.core.tcp.client.VertxTcpClientProvider;
import net.pingfang.iot.core.tcp.parser.DefaultPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.PayloadParserType;
import reactor.core.publisher.Mono;

/**
 * @author 王超
 * @description TODO
 * @date 2022-05-11 0:20
 */
@RequestMapping("network")
@RestController
public class NetWorkController {

	@PostMapping("create")
	public void create() {
		Vertx vertx = Vertx.vertx();

		vertx.createNetServer().connectHandler(socket -> {
			socket.write("tes");
			socket.write("ttest");
		}).listen(12311);

		VertxTcpClientProvider provider = new VertxTcpClientProvider(id -> Mono.empty(), vertx,
				new DefaultPayloadParserBuilder());

		TcpClientProperties properties = new TcpClientProperties();
		properties.setHost("127.0.0.1");
		properties.setPort(12311);
		properties.setParserType(PayloadParserType.FIXED_LENGTH);
		properties.setParserConfiguration(Collections.singletonMap("size", 4));
		properties.setOptions(new NetClientOptions());

		provider.createNetwork(properties);
	}
}
