package net.pingfang.iot.core.service.impl;

import static net.pingfang.iot.common.utils.SecurityUtils.getLoginUser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.pingfang.iot.common.core.domain.entity.SysRole;
import net.pingfang.iot.common.core.domain.entity.SysUser;
import net.pingfang.iot.common.utils.DateUtils;
import net.pingfang.iot.core.domain.ThingsModelTemplate;
import net.pingfang.iot.core.mapper.ThingsModelTemplateMapper;
import net.pingfang.iot.core.service.IThingsModelTemplateService;

/**
 * 通用物模型Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class ThingsModelTemplateServiceImpl implements IThingsModelTemplateService {
	@Autowired
	private ThingsModelTemplateMapper thingsModelTemplateMapper;

	/**
	 * 查询通用物模型
	 *
	 * @param templateId 通用物模型主键
	 * @return 通用物模型
	 */
	@Override
	public ThingsModelTemplate selectThingsModelTemplateByTemplateId(Long templateId) {
		return thingsModelTemplateMapper.selectThingsModelTemplateByTemplateId(templateId);
	}

	/**
	 * 查询通用物模型列表
	 *
	 * @param thingsModelTemplate 通用物模型
	 * @return 通用物模型
	 */
	@Override
	public List<ThingsModelTemplate> selectThingsModelTemplateList(ThingsModelTemplate thingsModelTemplate) {
		return thingsModelTemplateMapper.selectThingsModelTemplateList(thingsModelTemplate);
	}

	/**
	 * 新增通用物模型
	 *
	 * @param thingsModelTemplate 通用物模型
	 * @return 结果
	 */
	@Override
	public int insertThingsModelTemplate(ThingsModelTemplate thingsModelTemplate) {
		SysUser user = getLoginUser().getUser();
		List<SysRole> roles = user.getRoles();
		if (roles == null || roles.size() == 0) {
			return 0;
		}
		// 系统管理员
		if (roles.stream().anyMatch(a -> a.getRoleKey().equals("admin"))) {
			thingsModelTemplate.setIsSys(1);
		}
		thingsModelTemplate.setTenantId(user.getUserId());
		thingsModelTemplate.setTenantName(user.getUserName());
		thingsModelTemplate.setCreateTime(DateUtils.getNowDate());
		return thingsModelTemplateMapper.insertThingsModelTemplate(thingsModelTemplate);
	}

	/**
	 * 修改通用物模型
	 *
	 * @param thingsModelTemplate 通用物模型
	 * @return 结果
	 */
	@Override
	public int updateThingsModelTemplate(ThingsModelTemplate thingsModelTemplate) {
		thingsModelTemplate.setUpdateTime(DateUtils.getNowDate());
		return thingsModelTemplateMapper.updateThingsModelTemplate(thingsModelTemplate);
	}

	/**
	 * 批量删除通用物模型
	 *
	 * @param templateIds 需要删除的通用物模型主键
	 * @return 结果
	 */
	@Override
	public int deleteThingsModelTemplateByTemplateIds(Long[] templateIds) {
		return thingsModelTemplateMapper.deleteThingsModelTemplateByTemplateIds(templateIds);
	}

	/**
	 * 删除通用物模型信息
	 *
	 * @param templateId 通用物模型主键
	 * @return 结果
	 */
	@Override
	public int deleteThingsModelTemplateByTemplateId(Long templateId) {
		return thingsModelTemplateMapper.deleteThingsModelTemplateByTemplateId(templateId);
	}

	// 精准查询
	@Override
	public List<ThingsModelTemplate> selectThingsModelTemplateListAccurate(ThingsModelTemplate thingsModelTemplate) {
		return thingsModelTemplateMapper.selectThingsModelTemplateListAccurate(thingsModelTemplate);
	}
}
