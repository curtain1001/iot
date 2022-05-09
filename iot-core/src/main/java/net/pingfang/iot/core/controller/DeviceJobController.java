package net.pingfang.iot.core.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.pingfang.iot.common.annotation.Log;
import net.pingfang.iot.common.core.controller.BaseController;
import net.pingfang.iot.common.core.domain.AjaxResult;
import net.pingfang.iot.common.core.page.TableDataInfo;
import net.pingfang.iot.common.enums.BusinessType;
import net.pingfang.iot.common.exception.job.TaskException;
import net.pingfang.iot.common.utils.poi.ExcelUtil;
import net.pingfang.iot.core.domain.DeviceJob;
import net.pingfang.iot.core.service.IDeviceJobService;
import net.pingfang.iot.quartz.util.CronUtils;

/**
 * 调度任务信息操作处理
 *
 * @author kerwincui
 */
@RestController
@RequestMapping("/iot/job")
public class DeviceJobController extends BaseController {
	@Autowired
	private IDeviceJobService jobService;

	/**
	 * 查询定时任务列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:list')")
	@GetMapping("/list")
	public TableDataInfo list(DeviceJob deviceJob) {
		startPage();
		List<DeviceJob> list = jobService.selectJobList(deviceJob);
		return getDataTable(list);
	}

	/**
	 * 导出定时任务列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:export')")
	@Log(title = "定时任务", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	public void export(HttpServletResponse response, DeviceJob deviceJob) {
		List<DeviceJob> list = jobService.selectJobList(deviceJob);
		ExcelUtil<DeviceJob> util = new ExcelUtil<DeviceJob>(DeviceJob.class);
		util.exportExcel(response, list, "定时任务");
	}

	/**
	 * 获取定时任务详细信息
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:query')")
	@GetMapping(value = "/{jobId}")
	public AjaxResult getInfo(@PathVariable("jobId") Long jobId) {
		return AjaxResult.success(jobService.selectJobById(jobId));
	}

	/**
	 * 新增定时任务
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:add')")
	@Log(title = "定时任务", businessType = BusinessType.INSERT)
	@PostMapping
	public AjaxResult add(@RequestBody DeviceJob job) throws SchedulerException, TaskException {
		if (!CronUtils.isValid(job.getCronExpression())) {
			return error("新增任务'" + job.getJobName() + "'失败，Cron表达式不正确");
		}
		job.setCreateBy(getUsername());
		return toAjax(jobService.insertJob(job));
	}

	/**
	 * 修改定时任务
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@Log(title = "定时任务", businessType = BusinessType.UPDATE)
	@PutMapping
	public AjaxResult edit(@RequestBody DeviceJob job) throws SchedulerException, TaskException {
		if (!CronUtils.isValid(job.getCronExpression())) {
			return error("修改任务'" + job.getJobName() + "'失败，Cron表达式不正确");
		}
		job.setUpdateBy(getUsername());
		return toAjax(jobService.updateJob(job));
	}

	/**
	 * 定时任务状态修改
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@Log(title = "定时任务", businessType = BusinessType.UPDATE)
	@PutMapping("/changeStatus")
	public AjaxResult changeStatus(@RequestBody DeviceJob job) throws SchedulerException {
		DeviceJob newJob = jobService.selectJobById(job.getJobId());
		newJob.setStatus(job.getStatus());
		return toAjax(jobService.changeStatus(newJob));
	}

	/**
	 * 定时任务立即执行一次
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@Log(title = "定时任务", businessType = BusinessType.UPDATE)
	@PutMapping("/run")
	public AjaxResult run(@RequestBody DeviceJob job) throws SchedulerException {
		jobService.run(job);
		return AjaxResult.success();
	}

	/**
	 * 删除定时任务
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:remove')")
	@Log(title = "定时任务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{jobIds}")
	public AjaxResult remove(@PathVariable Long[] jobIds) throws SchedulerException, TaskException {
		jobService.deleteJobByIds(jobIds);
		return AjaxResult.success();
	}
}
