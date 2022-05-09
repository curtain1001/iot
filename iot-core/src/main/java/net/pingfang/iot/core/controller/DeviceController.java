package net.pingfang.iot.core.controller;

import java.util.ArrayList;
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

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.pingfang.iot.common.annotation.Log;
import net.pingfang.iot.common.core.controller.BaseController;
import net.pingfang.iot.common.core.domain.AjaxResult;
import net.pingfang.iot.common.core.page.TableDataInfo;
import net.pingfang.iot.common.enums.BusinessType;
import net.pingfang.iot.common.utils.poi.ExcelUtil;
import net.pingfang.iot.core.domain.Device;
import net.pingfang.iot.core.model.DeviceAllShortOutput;
import net.pingfang.iot.core.model.DeviceShortOutput;
import net.pingfang.iot.core.service.IDeviceService;

/**
 * 设备Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "设备管理")
@RestController
@RequestMapping("/iot/device")
public class DeviceController extends BaseController {
	@Autowired
	private IDeviceService deviceService;

	/**
	 * 查询设备列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:list')")
	@GetMapping("/list")
	@ApiOperation("设备分页列表")
	public TableDataInfo list(Device device) {
		startPage();
		List<Device> list = new ArrayList<>();
		if (device.getUserId() == null) {
			list = deviceService.selectDeviceList(device);
		} else {
			// 精确查询
			list = deviceService.selectDeviceListAccurate(device);
		}
		return getDataTable(list);
	}

	/**
	 * 查询设备简短列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:list')")
	@GetMapping("/shortList")
	@ApiOperation("设备分页简短列表")
	public TableDataInfo shortList(Device device) {
		startPage();
		List<DeviceShortOutput> list = new ArrayList<>();
		if (device.getUserId() == null) {
			list = deviceService.selectDeviceShortList(device);
		} else {
			// 精确查询
			list = deviceService.selectDeviceShortListAccurate(device);
		}
		return getDataTable(list);
	}

	/**
	 * 查询所有设备简短列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:list')")
	@GetMapping("/all")
	@ApiOperation("查询所有设备简短列表")
	public TableDataInfo allShortList(Device device) {
		List<DeviceAllShortOutput> list = new ArrayList<>();
		if (device.getUserName() == null || device.getUserName() == "") {
			list = deviceService.selectAllDeviceShortList();
		} else {
			list = deviceService.selectAllDeviceShortListAccurate(device.getUserName());
		}
		return getDataTable(list);
	}

	/**
	 * 导出设备列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:export')")
	@Log(title = "设备", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	@ApiOperation("导出设备")
	public void export(HttpServletResponse response, Device device) {
		List<Device> list = deviceService.selectDeviceList(device);
		ExcelUtil<Device> util = new ExcelUtil<Device>(Device.class);
		util.exportExcel(response, list, "设备数据");
	}

	/**
	 * 获取设备详细信息
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:query')")
	@GetMapping(value = "/{deviceId}")
	@ApiOperation("获取设备详情")
	public AjaxResult getInfo(@PathVariable("deviceId") Long deviceId) {
		return AjaxResult.success(deviceService.selectDeviceByDeviceId(deviceId));
	}

	/**
	 * 获取设备详细信息
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:query')")
	@GetMapping(value = "/runningStatus/{deviceId}")
	@ApiOperation("获取设备详情和运行状态")
	public AjaxResult getRunningStatusInfo(@PathVariable("deviceId") Long deviceId) {
		return AjaxResult.success(deviceService.selectDeviceRunningStatusByDeviceId(deviceId));
	}

	/**
	 * 新增设备
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:add')")
	@Log(title = "设备", businessType = BusinessType.INSERT)
	@PostMapping
	@ApiOperation("添加设备")
	public AjaxResult add(@RequestBody Device device) {
		return AjaxResult.success(deviceService.insertDevice(device));
	}

	/**
	 * 修改设备
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@Log(title = "设备", businessType = BusinessType.UPDATE)
	@PutMapping
	@ApiOperation("修改设备")
	public AjaxResult edit(@RequestBody Device device) {
		return toAjax(deviceService.updateDevice(device));
	}

	/**
	 * 重置设备状态
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@Log(title = "设备", businessType = BusinessType.UPDATE)
	@PutMapping("/reset/{serialNumber}")
	@ApiOperation("重置设备设备")
	public AjaxResult resetDeviceStatus(@PathVariable String serialNumber) {
		Device device = new Device();
		device.setSerialNumber(serialNumber);
		return toAjax(deviceService.resetDeviceStatus(device.getSerialNumber()));
	}

	/**
	 * 删除设备
	 */
	@PreAuthorize("@ss.hasPermi('iot:device:remove')")
	@Log(title = "设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceIds}")
	@ApiOperation("批量删除设备")
	public AjaxResult remove(@PathVariable Long[] deviceIds) throws SchedulerException {
		return toAjax(deviceService.deleteDeviceByDeviceIds(deviceIds));
	}

	@PreAuthorize("@ss.hasPermi('iot:device:edit')")
	@GetMapping("/generator")
	@ApiOperation("生成设备编号")
	public AjaxResult generatorDeviceNum() {
		return AjaxResult.success("操作成功", deviceService.generationDeviceNum());
	}
}
