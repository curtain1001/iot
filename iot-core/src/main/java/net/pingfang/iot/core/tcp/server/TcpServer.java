package net.pingfang.iot.core.tcp.server;

import net.pingfang.iot.core.network.Network;
import net.pingfang.iot.core.tcp.client.TcpClient;
import reactor.core.publisher.Flux;

/**
 * TCP服务
 *
 * @author zhouhao
 * @version 1.0
 **/
public interface TcpServer extends Network {

	/**
	 * 订阅客户端连接
	 *
	 * @return 客户端流
	 * @see TcpClient
	 */
	Flux<TcpClient> handleConnection();

	/**
	 * 关闭服务端
	 */
	@Override
	void shutdown();
}
