package com.ruoyi.iot.exception;

import org.hswebframework.web.exception.I18nSupportException;

import lombok.Getter;

@Getter
public class ProductNotActivatedException extends I18nSupportException {
	private String productId;

	public ProductNotActivatedException(String productId) {
		super("error.product_not_activated", productId);
	}
}
