package net.pingfang.iot.core.util.quartz;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;

import net.pingfang.iot.core.domain.DeviceJob;

/**
 * 定时任务处理（禁止并发执行）
 *
 * @author ruoyi
 *
 */
@DisallowConcurrentExecution
public class QuartzDisallowConcurrentExecution extends AbstractQuartzJob {
	@Override
	protected void doExecute(JobExecutionContext context, DeviceJob deviceJob) throws Exception {
		JobInvokeUtil.invokeMethod(deviceJob);
	}
}
