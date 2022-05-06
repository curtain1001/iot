package com.ruoyi.iot.device;

import lombok.Builder;
import lombok.Data;

/**
 * @author 王超
 * @description TODO
 * @date 2022-05-07 0:16
 */
@Data
@Builder
public class DeviceInfo {
    /**
     * 设备ID
     */
    private String id;

    /**
     * 产品ID
     */
    private String productId;

    /**
     * 产品版本
     */
    private String productVersion;

    /**
     * 消息协议
     *
     */
    private String protocol;

    /**
     * 物模型
     */
    private String metadata;
}
