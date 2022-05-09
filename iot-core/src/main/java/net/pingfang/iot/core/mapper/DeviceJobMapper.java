package net.pingfang.iot.core.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import net.pingfang.iot.core.domain.DeviceJob;

/**
 * 调度任务信息 数据层
 *
 * @author kerwincui
 */
@Repository
public interface DeviceJobMapper {
	/**
	 * 查询调度任务日志集合
	 *
	 * @param job 调度信息
	 * @return 操作日志集合
	 */
	public List<DeviceJob> selectJobList(DeviceJob job);

	/**
	 * 根据设备Ids查询调度任务日志集合
	 *
	 * @param deviceIds 设备ID数组
	 * @return 操作日志集合
	 */
	public List<DeviceJob> selectShortJobListByDeviceIds(Long[] deviceIds);

	/**
	 * 查询所有调度任务
	 *
	 * @return 调度任务列表
	 */
	public List<DeviceJob> selectJobAll();

	/**
	 * 通过调度ID查询调度任务信息
	 *
	 * @param jobId 调度ID
	 * @return 角色对象信息
	 */
	public DeviceJob selectJobById(Long jobId);

	/**
	 * 通过调度ID删除调度任务信息
	 *
	 * @param jobId 调度ID
	 * @return 结果
	 */
	public int deleteJobById(Long jobId);

	/**
	 * 批量删除调度任务信息
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	public int deleteJobByIds(Long[] ids);

	/**
	 * 根据设备Ids批量删除调度任务信息
	 *
	 * @param deviceIds 需要删除的数据ID
	 * @return 结果
	 */
	public int deleteJobByDeviceIds(Long[] deviceIds);

	/**
	 * 修改调度任务信息
	 *
	 * @param job 调度任务信息
	 * @return 结果
	 */
	public int updateJob(DeviceJob job);

	/**
	 * 新增调度任务信息
	 *
	 * @param job 调度任务信息
	 * @return 结果
	 */
	public int insertJob(DeviceJob job);
}
