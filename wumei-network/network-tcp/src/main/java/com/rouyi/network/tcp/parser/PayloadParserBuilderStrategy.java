package com.rouyi.network.tcp.parser;

import org.jetlinks.community.ValueObject;

public interface PayloadParserBuilderStrategy {
	PayloadParserType getType();

	PayloadParser build(ValueObject config);
}
