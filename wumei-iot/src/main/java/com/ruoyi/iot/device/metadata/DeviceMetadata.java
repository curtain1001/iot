package com.ruoyi.iot.device.metadata;

import java.util.List;

import com.ruoyi.iot.device.EventMetadata;
import com.ruoyi.iot.device.FunctionMetadata;
import com.ruoyi.iot.device.MergeOption;
import com.ruoyi.iot.device.PropertyMetadata;
import com.ruoyi.iot.device.ThingMetadata;

/**
 * 设备物模型定义
 *
 * @author zhouhao
 * @since 1.0.0
 */
public interface DeviceMetadata extends ThingMetadata {

	/**
	 * @return 所有属性定义
	 * @see org.jetlinks.core.message.property.ReadPropertyMessage
	 * @see org.jetlinks.core.message.property.WritePropertyMessage
	 * @see org.jetlinks.core.message.property.ReportPropertyMessage
	 * @see org.jetlinks.core.message.property.ReadPropertyMessageReply
	 * @see org.jetlinks.core.message.property.WritePropertyMessageReply
	 */
	List<PropertyMetadata> getProperties();

	/**
	 * @return 所有功能定义
	 * @see org.jetlinks.core.message.function.FunctionInvokeMessage
	 * @see org.jetlinks.core.message.function.FunctionInvokeMessageReply
	 */
	List<FunctionMetadata> getFunctions();

	/**
	 * @return 事件定义
	 * @see org.jetlinks.core.message.event.EventMessage
	 */
	List<EventMetadata> getEvents();

	/**
	 * @return 标签定义
	 * @see UpdateTagMessage
	 */
	List<PropertyMetadata> getTags();

	/**
	 * 合并物模型，合并后返回新的物模型对象
	 *
	 * @param metadata 要合并的物模型
	 * @since 1.1.6
	 */
	@Override
	default <T extends ThingMetadata> DeviceMetadata merge(T metadata) {
		return this.merge(metadata, MergeOption.DEFAULT_OPTIONS);
	}

	default <T extends ThingMetadata> DeviceMetadata merge(T metadata, MergeOption... options) {
		throw new UnsupportedOperationException("unsupported merge metadata");
	}
}
