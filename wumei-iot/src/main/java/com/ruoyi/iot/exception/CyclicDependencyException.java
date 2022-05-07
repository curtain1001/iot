package com.ruoyi.iot.exception;

import java.util.Set;

import org.hswebframework.web.exception.I18nSupportException;

import lombok.Getter;

@Getter
public class CyclicDependencyException extends I18nSupportException {

	private final Set<?> ids;

	public CyclicDependencyException(Set<?> ids) {
		super("error.cyclic_dependence");
		this.ids = ids;
	}

}
