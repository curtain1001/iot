package net.pingfang.iot.core.tcp.parser;

import net.pingfang.iot.core.network.property.ValueObject;

public interface PayloadParserBuilder {

	PayloadParser build(PayloadParserType type, ValueObject configuration);

}
