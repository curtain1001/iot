package net.pingfang.iot.core.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 动作
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class MonitorModel {
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date time;

	private String value;

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
