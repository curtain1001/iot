package com.ruoyi.iot.device;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;
import reactor.core.publisher.Mono;

/**
 * 设备操作接口,用于发送指令到设备{@link DeviceOperator#messageSender()}以及获取配置等相关信息
 *
 * @author zhouhao
 * @since 1.0.0
 */
public interface DeviceOperator extends {

    /**
     * @return 设备ID
     */
    String getDeviceId();

    /**
     */
    Mono<String> getConnectionServerId();

    /**
     * @return 当前设备连接会话ID
     */
    Mono<String> getSessionId();

    /**
     * 获取设备地址,通常是ip地址.
     *
     * @return 地址
     */
    Mono<String> getAddress();

    /**
     * 设置设备地址
     *
     * @param address 地址
     * @return Mono
     */
    Mono<Void> setAddress(String address);

    /**
     * @param state 状态
     */
    Mono<Boolean> putState(byte state);

    /**
     * 获取设备当前缓存的状态,此状态可能与实际的状态不一致.
     * @return 获取当前状态
     */
    Mono<Byte> getState();

    /**
     * 检查设备的真实状态,此操作将检查设备真实的状态.
     * <br>
     * 默认的状态检查逻辑:
     * <br>
     *
     */
    Mono<Byte> checkState();

    /**
     * @return 上线时间
     */
    Mono<Long> getOnlineTime();

    /**
     * @return 离线时间
     */
    Mono<Long> getOfflineTime();

    /**
     * 设备上线,通常不需要手动调用
     *
     * @param serverId  设备所在服务ID
     * @param sessionId 会话ID
     */
    default Mono<Boolean> online(String serverId, String sessionId) {
        return online(serverId, sessionId, null);
    }

    Mono<Boolean> online(String serverId, String sessionId, String address);



    /**
     * @return 是否在线
     */
     Boolean isOnline();

    /**
     * 设置设备离线
     *
     */
    Boolean offline();

    /**
     * 断开设备连接
     *
     * @return 断开结果
     */
    Boolean disconnect();

    /**
     * @return 获取设备的元数据
     */
    DeviceMetadata getMetadata();

    /**
     * @return 获取此设备使用的协议支持
     */
    Mono<ProtocolSupport> getProtocol();

    /**
     * @return 消息发送器, 用于发送消息给设备
     */
    DeviceMessageSender messageSender();

    /**
     * 设置当前设备的独立物模型,如果没有设置,这使用产品的物模型配置
     *
     * @param metadata 物模型
     */
    Mono<Boolean> updateMetadata(String metadata);

    /**
     * 重置当前设备的独立物模型
     *
     * @return void
     * @since 1.1.6
     */
    Mono<Void> resetMetadata();

    /**
     * @return 获取设备对应的产品操作接口
     */
    Mono<DeviceProductOperator> getProduct();

    @Override
    default Mono<DeviceProductOperator> getTemplate() {
        return getProduct();
    }
}
