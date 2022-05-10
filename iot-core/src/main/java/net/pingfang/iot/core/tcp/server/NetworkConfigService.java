package net.pingfang.iot.core.tcp.server;

import org.springframework.stereotype.Service;

import net.pingfang.iot.core.network.NetworkConfigManager;
import net.pingfang.iot.core.network.NetworkProperties;
import net.pingfang.iot.core.network.NetworkType;
import reactor.core.publisher.Mono;

/**
 * @author 王超
 * @description TODO
 * @date 2022-05-09 2:03
 */
@Service
public class NetworkConfigService implements NetworkConfigManager {
	@Override
	public Mono<NetworkProperties> getConfig(NetworkType networkType, String id) {
		return Mono.empty();
	}
}
