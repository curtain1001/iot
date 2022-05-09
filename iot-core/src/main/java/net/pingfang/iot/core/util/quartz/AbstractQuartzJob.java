package net.pingfang.iot.core.util.quartz;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.pingfang.iot.common.constant.Constants;
import net.pingfang.iot.common.constant.ScheduleConstants;
import net.pingfang.iot.common.utils.ExceptionUtil;
import net.pingfang.iot.common.utils.StringUtils;
import net.pingfang.iot.common.utils.bean.BeanUtils;
import net.pingfang.iot.common.utils.spring.SpringUtils;
import net.pingfang.iot.core.domain.DeviceJob;
import net.pingfang.iot.quartz.domain.SysJobLog;
import net.pingfang.iot.quartz.service.ISysJobLogService;

/**
 * 抽象quartz调用
 *
 * @author ruoyi
 */
public abstract class AbstractQuartzJob implements Job {
	private static final Logger log = LoggerFactory.getLogger(AbstractQuartzJob.class);

	/**
	 * 线程本地变量
	 */
	private static ThreadLocal<Date> threadLocal = new ThreadLocal<>();

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		DeviceJob deviceJob = new DeviceJob();
		BeanUtils.copyBeanProp(deviceJob, context.getMergedJobDataMap().get(ScheduleConstants.TASK_PROPERTIES));
		try {
			before(context, deviceJob);
			if (deviceJob != null) {
				doExecute(context, deviceJob);
			}
			after(context, deviceJob, null);
		} catch (Exception e) {
			log.error("任务执行异常  - ：", e);
			after(context, deviceJob, e);
		}
	}

	/**
	 * 执行前
	 *
	 * @param context   工作执行上下文对象
	 * @param deviceJob 系统计划任务
	 */
	protected void before(JobExecutionContext context, DeviceJob deviceJob) {
		threadLocal.set(new Date());
	}

	/**
	 * 执行后
	 *
	 * @param context   工作执行上下文对象
	 * @param deviceJob 系统计划任务
	 */
	protected void after(JobExecutionContext context, DeviceJob deviceJob, Exception e) {
		Date startTime = threadLocal.get();
		threadLocal.remove();

		final SysJobLog sysJobLog = new SysJobLog();
		sysJobLog.setJobName(deviceJob.getJobName());
		sysJobLog.setJobGroup(deviceJob.getJobGroup());
		sysJobLog.setInvokeTarget(deviceJob.getDeviceName());
		sysJobLog.setStartTime(startTime);
		sysJobLog.setStopTime(new Date());
		long runMs = sysJobLog.getStopTime().getTime() - sysJobLog.getStartTime().getTime();
		sysJobLog.setJobMessage(sysJobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (e != null) {
			sysJobLog.setStatus(Constants.FAIL);
			String errorMsg = StringUtils.substring(ExceptionUtil.getExceptionMessage(e), 0, 2000);
			sysJobLog.setExceptionInfo(errorMsg);
		} else {
			sysJobLog.setStatus(Constants.SUCCESS);
		}

		// 写入数据库当中
		SpringUtils.getBean(ISysJobLogService.class).addJobLog(sysJobLog);
	}

	/**
	 * 执行方法，由子类重载
	 *
	 * @param context   工作执行上下文对象
	 * @param deviceJob 系统计划任务
	 * @throws Exception 执行过程中的异常
	 */
	protected abstract void doExecute(JobExecutionContext context, DeviceJob deviceJob) throws Exception;
}
