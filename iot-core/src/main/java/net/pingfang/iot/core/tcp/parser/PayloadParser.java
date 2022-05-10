package net.pingfang.iot.core.tcp.parser;

import io.vertx.core.buffer.Buffer;
import net.pingfang.iot.core.tcp.parser.strateies.DelimitedPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.strateies.FixLengthPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.strateies.PipePayloadParser;
import reactor.core.publisher.Flux;

/**
 * 用于处理TCP粘拆包的解析器,通常一个客户端对应一个解析器.
 *
 * @author zhouhao
 * @see PipePayloadParser
 * @see FixLengthPayloadParserBuilder
 * @see DelimitedPayloadParserBuilder
 * @since 1.0
 */
public interface PayloadParser {

	/**
	 * 处理一个数据包
	 *
	 * @param buffer 数据包
	 */
	void handle(Buffer buffer);

	/**
	 * 订阅完整的数据包流,每一个元素为一个完整的数据包
	 *
	 * @return 完整数据包流
	 */
	Flux<Buffer> handlePayload();

	/**
	 * 关闭以释放相关资源
	 */
	void close();

	/**
	 * 重置规则
	 */
	default void reset() {
	}
}