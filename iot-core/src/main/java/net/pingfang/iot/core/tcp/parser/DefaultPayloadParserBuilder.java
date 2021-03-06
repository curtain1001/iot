package net.pingfang.iot.core.tcp.parser;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;

import net.pingfang.iot.core.network.property.ValueObject;
import net.pingfang.iot.core.tcp.parser.strateies.DelimitedPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.strateies.DirectPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.strateies.FixLengthPayloadParserBuilder;
import net.pingfang.iot.core.tcp.parser.strateies.ScriptPayloadParserBuilder;

@Component
public class DefaultPayloadParserBuilder implements PayloadParserBuilder, BeanPostProcessor {

	private final Map<PayloadParserType, PayloadParserBuilderStrategy> strategyMap = new ConcurrentHashMap<>();

	public DefaultPayloadParserBuilder() {
		register(new FixLengthPayloadParserBuilder());
		register(new DelimitedPayloadParserBuilder());
		register(new ScriptPayloadParserBuilder());
		register(new DirectPayloadParserBuilder());
	}

	@Override
	public PayloadParser build(PayloadParserType type, ValueObject configuration) {
		return Optional.ofNullable(strategyMap.get(type)).map(builder -> builder.build(configuration))
				.orElseThrow(() -> new UnsupportedOperationException("unsupported parser:" + type));
	}

	public void register(PayloadParserBuilderStrategy strategy) {
		strategyMap.put(strategy.getType(), strategy);
	}

	@Override
	public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
		if (bean instanceof PayloadParserBuilderStrategy) {
			register(((PayloadParserBuilderStrategy) bean));
		}
		return bean;
	}
}
