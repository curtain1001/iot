package net.pingfang.iot.core.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.pingfang.iot.common.core.controller.BaseController;

/**
 * 设备告警Controller
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@RestController
@RequestMapping("/oauth/resource")
public class AuthResourceController extends BaseController {
	/**
	 * 查询设备告警列表
	 */
	@GetMapping("/product")
	public String findAll() {
		return "查询产品列表成功！";
	}

}
