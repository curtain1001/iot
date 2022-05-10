package net.pingfang.iot.core.tcp.parser.strateies;

import lombok.SneakyThrows;
import net.pingfang.iot.core.network.property.ValueObject;
import net.pingfang.iot.core.tcp.parser.DirectRecordParser;
import net.pingfang.iot.core.tcp.parser.PayloadParser;
import net.pingfang.iot.core.tcp.parser.PayloadParserBuilderStrategy;
import net.pingfang.iot.core.tcp.parser.PayloadParserType;

public class DirectPayloadParserBuilder implements PayloadParserBuilderStrategy {

	@Override
	public PayloadParserType getType() {
		return PayloadParserType.DIRECT;
	}

	@Override
	@SneakyThrows
	public PayloadParser build(ValueObject config) {
		return new DirectRecordParser();
	}
}
