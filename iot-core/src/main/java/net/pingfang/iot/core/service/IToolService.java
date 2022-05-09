package net.pingfang.iot.core.service;

import net.pingfang.iot.core.model.RegisterUserInput;

/**
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public interface IToolService {
	/**
	 * 注册
	 */
	public String register(RegisterUserInput registerBody);

	/**
	 * 生成随机数字和字母
	 */
	public String getStringRandom(int length);
}
