package net.pingfang.iot.core.service.impl;

import static net.pingfang.iot.common.utils.SecurityUtils.getLoginUser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.pingfang.iot.common.core.domain.entity.SysRole;
import net.pingfang.iot.common.core.domain.entity.SysUser;
import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.core.domain.Firmware;
import net.pingfang.iot.core.mapper.FirmwareMapper;
import net.pingfang.iot.core.service.IFirmwareService;

/**
 * 产品固件Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class FirmwareServiceImpl implements IFirmwareService {
	@Autowired
	private FirmwareMapper firmwareMapper;

	/**
	 * 查询产品固件
	 *
	 * @param firmwareId 产品固件主键
	 * @return 产品固件
	 */
	@Override
	public Firmware selectFirmwareByFirmwareId(Long firmwareId) {
		return firmwareMapper.selectFirmwareByFirmwareId(firmwareId);
	}

	/**
	 * 查询产品固件列表
	 *
	 * @param firmware 产品固件
	 * @return 产品固件
	 */
	@Override
	public List<Firmware> selectFirmwareList(Firmware firmware) {
		return firmwareMapper.selectFirmwareList(firmware);
	}

	/**
	 * 新增产品固件
	 *
	 * @param firmware 产品固件
	 * @return 结果
	 */
	@Override
	public int insertFirmware(Firmware firmware) {
		SysUser user = getLoginUser().getUser();
		List<SysRole> roles = user.getRoles();
		if (roles == null || roles.size() == 0) {
			return 0;
		}
		// 系统管理员
		if (roles.stream().anyMatch(a -> a.getRoleKey().equals("admin"))) {
			firmware.setIsSys(1);
		}
		firmware.setTenantId(user.getUserId());
		firmware.setTenantName(user.getUserName());
		firmware.setCreateTime(DateUtils.getNowDate());
		return firmwareMapper.insertFirmware(firmware);
	}

	/**
	 * 修改产品固件
	 *
	 * @param firmware 产品固件
	 * @return 结果
	 */
	@Override
	public int updateFirmware(Firmware firmware) {
		firmware.setUpdateTime(DateUtils.getNowDate());
		return firmwareMapper.updateFirmware(firmware);
	}

	/**
	 * 批量删除产品固件
	 *
	 * @param firmwareIds 需要删除的产品固件主键
	 * @return 结果
	 */
	@Override
	public int deleteFirmwareByFirmwareIds(Long[] firmwareIds) {
		return firmwareMapper.deleteFirmwareByFirmwareIds(firmwareIds);
	}

	/**
	 * 删除产品固件信息
	 *
	 * @param firmwareId 产品固件主键
	 * @return 结果
	 */
	@Override
	public int deleteFirmwareByFirmwareId(Long firmwareId) {
		return firmwareMapper.deleteFirmwareByFirmwareId(firmwareId);
	}
}
