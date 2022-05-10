package net.pingfang.iot.core.tcp.parser;

import net.pingfang.iot.core.network.property.ValueObject;

public interface PayloadParserBuilderStrategy {
	PayloadParserType getType();

	PayloadParser build(ValueObject config);
}
