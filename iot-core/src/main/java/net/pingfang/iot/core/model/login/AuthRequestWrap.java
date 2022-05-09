package net.pingfang.iot.core.model.login;

import me.zhyd.oauth.request.AuthRequest;
import net.pingfang.iot.core.domain.SocialPlatform;

public class AuthRequestWrap {
	private AuthRequest authRequest;

	private SocialPlatform socialPlatform;

	public AuthRequest getAuthRequest() {
		return authRequest;
	}

	public void setAuthRequest(AuthRequest authRequest) {
		this.authRequest = authRequest;
	}

	public SocialPlatform getSocialPlatform() {
		return socialPlatform;
	}

	public void setSocialPlatform(SocialPlatform socialPlatform) {
		this.socialPlatform = socialPlatform;
	}
}
