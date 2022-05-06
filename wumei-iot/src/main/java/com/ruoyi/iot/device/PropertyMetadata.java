package com.ruoyi.iot.device;

/**
 * @author zhouhao
 * @since 1.0.0
 */
public interface PropertyMetadata extends Metadata {

    DataType getValueType();

    default PropertyMetadata merge(PropertyMetadata another, MergeOption... option){
        throw new UnsupportedOperationException("不支持属性物模型合并");
    }
}
