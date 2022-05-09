package net.pingfang.iot.core.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.core.domain.DeviceLog;
import net.pingfang.iot.core.mapper.DeviceLogMapper;
import net.pingfang.iot.core.model.MonitorModel;
import net.pingfang.iot.core.service.IDeviceLogService;

/**
 * 设备日志Service业务层处理
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class DeviceLogServiceImpl implements IDeviceLogService {
	@Autowired
	private DeviceLogMapper deviceLogMapper;

	/**
	 * 查询设备日志
	 *
	 * @param logId 设备日志主键
	 * @return 设备日志
	 */
	@Override
	public DeviceLog selectDeviceLogByLogId(Long logId) {
		return deviceLogMapper.selectDeviceLogByLogId(logId);
	}

	/**
	 * 查询设备日志列表
	 *
	 * @param deviceLog 设备日志
	 * @return 设备日志
	 */
	@Override
	public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
		return deviceLogMapper.selectDeviceLogList(deviceLog);
	}

	/**
	 * 查询设备监测数据
	 *
	 * @param deviceLog 设备日志
	 * @return 设备日志
	 */
	@Override
	public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
		return deviceLogMapper.selectMonitorList(deviceLog);
	}

	/**
	 * 新增设备日志
	 *
	 * @param deviceLog 设备日志
	 * @return 结果
	 */
	@Override
	public int insertDeviceLog(DeviceLog deviceLog) {
		deviceLog.setCreateTime(DateUtils.getNowDate());
		return deviceLogMapper.insertDeviceLog(deviceLog);
	}

	/**
	 * 修改设备日志
	 *
	 * @param deviceLog 设备日志
	 * @return 结果
	 */
	@Override
	public int updateDeviceLog(DeviceLog deviceLog) {
		return deviceLogMapper.updateDeviceLog(deviceLog);
	}

	/**
	 * 批量删除设备日志
	 *
	 * @param logIds 需要删除的设备日志主键
	 * @return 结果
	 */
	@Override
	public int deleteDeviceLogByLogIds(Long[] logIds) {
		return deviceLogMapper.deleteDeviceLogByLogIds(logIds);
	}

	/**
	 * 根据设备Ids批量删除设备日志
	 *
	 * @param deviceIds 需要删除数据的设备Ids
	 * @return 结果
	 */
	@Override
	public int deleteDeviceLogByDeviceIds(Long[] deviceIds) {
		return deviceLogMapper.deleteDeviceLogByDeviceIds(deviceIds);
	}

	/**
	 * 删除设备日志信息
	 *
	 * @param logId 设备日志主键
	 * @return 结果
	 */
	@Override
	public int deleteDeviceLogByLogId(Long logId) {
		return deviceLogMapper.deleteDeviceLogByLogId(logId);
	}
}
