package net.pingfang.iot.core.task;

import java.lang.reflect.Method;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.stereotype.Component;

@Component
public class IotAsyncExceptionHander implements AsyncUncaughtExceptionHandler {

	private static final Logger logger = LoggerFactory.getLogger(IotAsyncExceptionHander.class);

	@Override
	public void handleUncaughtException(Throwable ex, Method method, Object... params) {
		logger.debug("=======>>>>>捕获线程异常信息");
		logger.error("======>>>>>> error message-{},method-name", ex.getMessage(), method.getName());

	}
}
