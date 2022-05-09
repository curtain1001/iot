package net.pingfang.iot.core.service.impl;

import static net.pingfang.iot.common.utils.SecurityUtils.getLoginUser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import net.pingfang.iot.common.core.domain.entity.SysUser;
import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.core.domain.DeviceUser;
import net.pingfang.iot.core.mapper.DeviceUserMapper;
import net.pingfang.iot.core.service.IDeviceUserService;

/**
 * 设备用户Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class DeviceUserServiceImpl implements IDeviceUserService {
	@Autowired
	private DeviceUserMapper deviceUserMapper;

	/**
	 * 查询设备用户
	 *
	 * @param deviceId 设备用户主键
	 * @return 设备用户
	 */
	@Override
	public List<DeviceUser> selectDeviceUserByDeviceId(Long deviceId) {
		return deviceUserMapper.selectDeviceUserByDeviceId(deviceId);
	}

	/**
	 * 查询设备用户列表
	 *
	 * @param deviceUser 设备用户
	 * @return 设备用户
	 */
	@Override
	public List<DeviceUser> selectDeviceUserList(DeviceUser deviceUser) {
		return deviceUserMapper.selectDeviceUserList(deviceUser);
	}

	/**
	 * 新增设备用户
	 *
	 * @param deviceUser 设备用户
	 * @return 结果
	 */
	@Override
	public int insertDeviceUser(DeviceUser deviceUser) {
		List<DeviceUser> deviceUsers = selectDeviceUserList(deviceUser);
		if (!deviceUsers.isEmpty())
			throw new RuntimeException("该用户已添加, 禁止重复添加");
		deviceUser.setCreateTime(DateUtils.getNowDate());
		deviceUser.setIsOwner(0);
		SysUser sysUser = getLoginUser().getUser();
		deviceUser.setTenantId(sysUser.getUserId());
		deviceUser.setTenantName(sysUser.getUserName());
		return deviceUserMapper.insertDeviceUser(deviceUser);
	}

	/**
	 * 修改设备用户
	 *
	 * @param deviceUser 设备用户
	 * @return 结果
	 */
	@Override
	public int updateDeviceUser(DeviceUser deviceUser) {
		deviceUser.setUpdateTime(DateUtils.getNowDate());
		return deviceUserMapper.updateDeviceUser(deviceUser);
	}

	/**
	 * 批量删除设备用户
	 *
	 * @param deviceIds 需要删除的设备用户主键
	 * @return 结果
	 */
	@Override
	public int deleteDeviceUserByDeviceIds(Long[] deviceIds) {
		return deviceUserMapper.deleteDeviceUserByDeviceIds(deviceIds);
	}

	/**
	 * 删除设备用户信息
	 *
	 * @param deviceId 设备用户主键
	 * @return 结果
	 */
	@Override
	public int deleteDeviceUserByDeviceId(Long deviceId) {
		return deviceUserMapper.deleteDeviceUserByDeviceId(deviceId);
	}

	@Override
	public int insertDeviceUserList(List<DeviceUser> deviceUsers) {
		try {
			deviceUsers.forEach(deviceUser -> {
				deviceUser.setCreateTime(DateUtils.getNowDate());
				deviceUser.setIsOwner(0);
				SysUser sysUser = getLoginUser().getUser();
				deviceUser.setTenantId(sysUser.getUserId());
				deviceUser.setTenantName(sysUser.getUserName());
			});
			return deviceUserMapper.insertDeviceUserList(deviceUsers);
		} catch (DuplicateKeyException e) {
			throw new RuntimeException("存在设备已经与用户绑定");
		}
	}

	@Override
	public DeviceUser selectDeviceUserByDeviceIdAndUserId(Long deviceId, Long userId) {
		return deviceUserMapper.selectDeviceUserByDeviceIdAndUserId(deviceId, userId);
	}

	@Override
	public int deleteDeviceUser(DeviceUser deviceUser) {
		return deviceUserMapper.deleteDeviceUser(deviceUser);
	}
}
