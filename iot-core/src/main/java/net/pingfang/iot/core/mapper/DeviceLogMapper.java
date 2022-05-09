package net.pingfang.iot.core.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import net.pingfang.iot.core.domain.DeviceLog;
import net.pingfang.iot.core.model.MonitorModel;

/**
 * 设备日志Mapper接口
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Repository
public interface DeviceLogMapper {
	/**
	 * 查询设备日志
	 *
	 * @param logId 设备日志主键
	 * @return 设备日志
	 */
	public DeviceLog selectDeviceLogByLogId(Long logId);

	/**
	 * 查询设备日志列表
	 *
	 * @param deviceLog 设备日志
	 * @return 设备日志集合
	 */
	public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);

	/**
	 * 查询设备监测数据
	 *
	 * @param deviceLog 设备日志
	 * @return 设备日志集合
	 */
	public List<MonitorModel> selectMonitorList(DeviceLog deviceLog);

	/**
	 * 新增设备日志
	 *
	 * @param deviceLog 设备日志
	 * @return 结果
	 */
	public int insertDeviceLog(DeviceLog deviceLog);

	/**
	 * 修改设备日志
	 *
	 * @param deviceLog 设备日志
	 * @return 结果
	 */
	public int updateDeviceLog(DeviceLog deviceLog);

	/**
	 * 删除设备日志
	 *
	 * @param logId 设备日志主键
	 * @return 结果
	 */
	public int deleteDeviceLogByLogId(Long logId);

	/**
	 * 批量删除设备日志
	 *
	 * @param logIds 需要删除的数据主键集合
	 * @return 结果
	 */
	public int deleteDeviceLogByLogIds(Long[] logIds);

	/**
	 * 根据设备Ids批量删除设备日志
	 *
	 * @param deviceIds 需要删除的数据设备Ids
	 * @return 结果
	 */
	public int deleteDeviceLogByDeviceIds(Long[] deviceIds);
}
