package com.rouyi.network.tcp.parser.strateies;

import org.apache.commons.lang.StringEscapeUtils;
import org.jetlinks.community.ValueObject;
import org.jetlinks.community.network.tcp.parser.PayloadParserType;

import io.vertx.core.parsetools.RecordParser;

public class DelimitedPayloadParserBuilder extends VertxPayloadParserBuilder {
	@Override
	public PayloadParserType getType() {
		return PayloadParserType.DELIMITED;
	}

	@Override
	protected RecordParser createParser(ValueObject config) {

		return RecordParser.newDelimited(StringEscapeUtils.unescapeJava(config.getString("delimited")
				.orElseThrow(() -> new IllegalArgumentException("delimited can not be null"))));
	}

}