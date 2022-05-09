package net.pingfang.iot.core.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import net.pingfang.iot.core.domain.Firmware;
import net.pingfang.iot.core.service.IFirmwareService;

/**
 * 产品固件Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "产品固件")
@RestController
@RequestMapping("/iot/firmware")
public class FirmwareController extends BaseController {
	private static final Logger log = LoggerFactory.getLogger(FirmwareController.class);

	@Autowired
	private IFirmwareService firmwareService;

	/**
	 * 查询产品固件列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:firmware:list')")
	@GetMapping("/list")
	@ApiOperation("产品固件分页列表")
	public TableDataInfo list(Firmware firmware) {
		startPage();
		System.out.print("租户名称" + firmware.getTenantName() + "hs");
		List<Firmware> list = firmwareService.selectFirmwareList(firmware);
		return getDataTable(list);
	}

	/**
	 * 导出产品固件列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:firmware:export')")
	@Log(title = "产品固件", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	@ApiOperation("导出固件")
	public void export(HttpServletResponse response, Firmware firmware) {
		List<Firmware> list = firmwareService.selectFirmwareList(firmware);
		ExcelUtil<Firmware> util = new ExcelUtil<Firmware>(Firmware.class);
		util.exportExcel(response, list, "产品固件数据");
	}

	/**
	 * 获取产品固件详细信息
	 */
	@ApiOperation("获取固件详情")
	@PreAuthorize("@ss.hasPermi('iot:firmware:query')")
	@GetMapping(value = "/{firmwareId}")
	public AjaxResult getInfo(@PathVariable("firmwareId") Long firmwareId) {
		return AjaxResult.success(firmwareService.selectFirmwareByFirmwareId(firmwareId));
	}

	/**
	 * 新增产品固件
	 */
	@ApiOperation("添加产品固件")
	@PreAuthorize("@ss.hasPermi('iot:firmware:add')")
	@Log(title = "产品固件", businessType = BusinessType.INSERT)
	@PostMapping
	public AjaxResult add(@RequestBody Firmware firmware) {
		return toAjax(firmwareService.insertFirmware(firmware));
	}

	/**
	 * 修改产品固件
	 */
	@ApiOperation("修改产品固件")
	@PreAuthorize("@ss.hasPermi('iot:firmware:edit')")
	@Log(title = "产品固件", businessType = BusinessType.UPDATE)
	@PutMapping
	public AjaxResult edit(@RequestBody Firmware firmware) {
		return toAjax(firmwareService.updateFirmware(firmware));
	}

	/**
	 * 删除产品固件
	 */
	@ApiOperation("批量删除产品固件")
	@PreAuthorize("@ss.hasPermi('iot:firmware:remove')")
	@Log(title = "产品固件", businessType = BusinessType.DELETE)
	@DeleteMapping("/{firmwareIds}")
	public AjaxResult remove(@PathVariable Long[] firmwareIds) {
		return toAjax(firmwareService.deleteFirmwareByFirmwareIds(firmwareIds));
	}
}
