package com.ruoyi.iot.device.metadata;

import org.hswebframework.web.bean.FastBeanCopier;

import com.alibaba.fastjson.JSONObject;

/**
 * @author zhouhao
 * @since 1.0.0
 */
public interface Jsonable {

	default JSONObject toJson() {
		return FastBeanCopier.copy(this, JSONObject::new);
	}

	default void fromJson(JSONObject json) {
		FastBeanCopier.copy(json, this);
	}
}
