package com.ruoyi.iot.exception;

import org.hswebframework.web.exception.I18nSupportException;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MetadataUndefinedException extends I18nSupportException {

	private String deviceId;

	public MetadataUndefinedException(String deviceId) {
		super("validation.metadata_undefined", deviceId);
	}
}
