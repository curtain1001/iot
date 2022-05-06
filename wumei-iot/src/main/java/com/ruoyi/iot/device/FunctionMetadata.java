package com.ruoyi.iot.device;

import java.util.List;
import javax.annotation.Nullable;
import javax.validation.constraints.NotNull;

/**
 * @author zhouhao
 * @since 1.0.0
 */
public interface FunctionMetadata extends Metadata {

    /**
     * @return 输入参数定义
     */
    @NotNull
    List<PropertyMetadata> getInputs();

    /**
     * @return 输出类型，为null表示无输出
     */
    @Nullable
    DataType getOutput();

    /**
     * @return 是否异步
     */
    boolean isAsync();

    default FunctionMetadata merge(FunctionMetadata another, MergeOption... option){
        throw new UnsupportedOperationException("不支持功能物模型合并");
    }
}
