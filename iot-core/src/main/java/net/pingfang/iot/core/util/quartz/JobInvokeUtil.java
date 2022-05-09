package net.pingfang.iot.core.util.quartz;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

import net.pingfang.iot.common.utils.spring.SpringUtils;
import net.pingfang.iot.core.domain.DeviceJob;
import net.pingfang.iot.core.model.Action;
import net.pingfang.iot.core.model.ThingsModels.IdentityAndName;
import net.pingfang.iot.core.mqtt.EmqxService;

/**
 * 任务执行工具
 *
 * @author kerwincui
 */
public class JobInvokeUtil {
	/**
	 * 执行方法
	 *
	 * @param deviceJob 系统任务
	 */
	public static void invokeMethod(DeviceJob deviceJob) throws Exception {
		if (deviceJob.getJobType() == 1) {
			System.out.println("------------------------执行定时任务-----------------------------");
			List<Action> actions = JSON.parseArray(deviceJob.getActions(), Action.class);
			List<IdentityAndName> propertys = new ArrayList<>();
			List<IdentityAndName> functions = new ArrayList<>();
			for (int i = 0; i < actions.size(); i++) {
				IdentityAndName model = new IdentityAndName();
				model.setId(actions.get(i).getId());
				model.setValue(actions.get(i).getValue());
				if (actions.get(i).getType() == 1) {
					propertys.add(model);
				} else if (actions.get(i).getType() == 2) {
					functions.add(model);
				}
			}
			EmqxService emqxService = SpringUtils.getBean(EmqxService.class);
			// 发布属性
			if (propertys.size() > 0) {
				emqxService.publishProperty(deviceJob.getProductId(), deviceJob.getSerialNumber(), propertys);
			}
			// 发布功能
			if (functions.size() > 0) {
				emqxService.publishFunction(deviceJob.getProductId(), deviceJob.getSerialNumber(), functions);
			}

		} else if (deviceJob.getJobType() == 2) {
			// 告警

			System.out.println("------------------------执行告警-----------------------------");
		} else if (deviceJob.getJobType() == 3) {
			// 场景联动

			System.out.println("------------------------执行场景联动-----------------------------");
		}
	}

}
