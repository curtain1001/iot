package com.rouyi.network.tcp.parser.strateies;

import org.jetlinks.community.ValueObject;
import org.jetlinks.community.network.tcp.parser.PayloadParserType;

import io.vertx.core.parsetools.RecordParser;

public class FixLengthPayloadParserBuilder extends VertxPayloadParserBuilder {
	@Override
	public PayloadParserType getType() {
		return PayloadParserType.FIXED_LENGTH;
	}

	@Override
	protected RecordParser createParser(ValueObject config) {
		return RecordParser.newFixed(
				config.getInt("size").orElseThrow(() -> new IllegalArgumentException("size can not be null")));
	}

}
