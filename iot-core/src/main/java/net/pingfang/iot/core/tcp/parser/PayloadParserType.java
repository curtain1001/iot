package net.pingfang.iot.core.tcp.parser;

import org.hswebframework.web.dict.Dict;
import org.hswebframework.web.dict.EnumDict;

import lombok.AllArgsConstructor;
import lombok.Getter;
import net.pingfang.iot.core.tcp.parser.strateies.PipePayloadParser;
import net.pingfang.iot.core.tcp.parser.strateies.ScriptPayloadParserBuilder;

@Getter
@AllArgsConstructor
@Dict("tcp-payload-parser-type")
public enum PayloadParserType implements EnumDict<String> {

	DIRECT("不处理"),

	FIXED_LENGTH("固定长度"),

	DELIMITED("分隔符"),

	/**
	 * @see ScriptPayloadParserBuilder
	 * @see PipePayloadParser
	 */
	SCRIPT("自定义脚本");

	private String text;

	@Override
	public String getValue() {
		return name();
	}
}
