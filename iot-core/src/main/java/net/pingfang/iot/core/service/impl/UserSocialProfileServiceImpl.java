package net.pingfang.iot.core.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.pingfang.iot.common.constant.HttpStatus;
import net.pingfang.iot.common.core.domain.AjaxResult;
import net.pingfang.iot.common.core.redis.RedisCache;
import net.pingfang.iot.common.enums.SocialPlatformType;
import net.pingfang.iot.core.domain.SocialUser;
import net.pingfang.iot.core.domain.UserSocialProfile;
import net.pingfang.iot.core.model.login.BindIdValue;
import net.pingfang.iot.core.service.ISocialPlatformService;
import net.pingfang.iot.core.service.ISocialUserService;
import net.pingfang.iot.core.service.IUserSocialProfileService;

@Service
public class UserSocialProfileServiceImpl implements IUserSocialProfileService {

	@Autowired
	private RedisCache redisCache;
	@Autowired
	private ISocialUserService iSocialUserService;
	@Autowired
	private ISocialPlatformService iSocialPlatformService;

	@Override
	public List<UserSocialProfile> selectUserSocialProfile(Long sysUserId) {
		SocialUser selectSocialUser = new SocialUser();
		selectSocialUser.setSysUserId(sysUserId);
		List<SocialUser> socialUserList = iSocialUserService.selectSocialUserList(selectSocialUser);
		List<UserSocialProfile> userSocialProfileList = new ArrayList<>();
		for (SocialUser socialUser : socialUserList) {
			// 如果是删除的标记
			if (socialUser.getDelFlag().equals("1")) {
				continue;
			}
			UserSocialProfile userSocialProfile = new UserSocialProfile();
			userSocialProfile.setSocialUserId(socialUser.getSocialUserId());
			userSocialProfile.setAvatar(socialUser.getAvatar());
			userSocialProfile.setSource(socialUser.getSource());
			userSocialProfile.setUsername(socialUser.getUsername());
			userSocialProfile.setNickname(socialUser.getNickname());
			userSocialProfile.setStatus(socialUser.getStatus());
			userSocialProfileList.add(userSocialProfile);
		}
		return userSocialProfileList;
	}

	@Override
	public AjaxResult bindUser(String bindId, Long sysUserId) {
		BindIdValue bindValue = redisCache.getCacheObject(SocialLoginServiceImpl.BIND_REDIS_KEY + bindId);
		if (bindValue == null) {
			// 不作提示
			return AjaxResult.error(HttpStatus.NO_MESSAGE_ALERT, "未知异常");
		}
		SocialUser socialUser = findSocialUser(bindValue.getUuid(), bindValue.getSource());
		SocialUser updateSocialUser = new SocialUser();
		updateSocialUser.setSocialUserId(socialUser.getSocialUserId());
		updateSocialUser.setSysUserId(sysUserId);
		iSocialUserService.updateSocialUser(updateSocialUser);
		redisCache.deleteObject(SocialLoginServiceImpl.BIND_REDIS_KEY + bindId);
		return AjaxResult.success("绑定成功！");
	}

	@Override
	public AjaxResult bindSocialAccount(String platform) {
		try {
			SocialPlatformType.valueOf(platform);
		} catch (Exception e) {
			return AjaxResult.error("错误平台类型");
		}
		return AjaxResult.success();
	}

	@Override
	public AjaxResult unbindSocialAccount(Long socialUserId, Long sysUserId) {
		SocialUser socialUser = iSocialUserService.selectSocialUserBySocialUserId(socialUserId);
		if (socialUser == null) {
			return AjaxResult.error("绑定账户不存在！");
		} else if (!socialUser.getSysUserId().equals(socialUserId)) {
			return AjaxResult.error("用户账户和绑定账户不匹配！");
		} else {
			SocialUser updateSocialUser = new SocialUser();
			updateSocialUser.setSocialUserId(socialUserId);
			updateSocialUser.setSysUserId(-1L);
			iSocialUserService.updateSocialUser(updateSocialUser);
			return AjaxResult.success("解除绑定成功！");
		}
	}

	public SocialUser findSocialUser(String uuid, String source) {
		SocialUser socialUser = new SocialUser();
		socialUser.setSource(source);
		socialUser.setUuid(uuid);
		List<SocialUser> socialUserList = iSocialUserService.selectSocialUserList(socialUser);
		return socialUserList == null || socialUserList.isEmpty() ? null : socialUserList.get(0);

	}
}
