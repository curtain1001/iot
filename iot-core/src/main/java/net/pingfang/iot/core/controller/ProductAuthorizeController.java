package net.pingfang.iot.core.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

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
import net.pingfang.iot.common.utils.poi.ExcelUtil;
import net.pingfang.iot.core.domain.ProductAuthorize;
import net.pingfang.iot.core.model.ProductAuthorizeVO;
import net.pingfang.iot.core.service.IProductAuthorizeService;

/**
 * 产品授权码Controller
 *
 * @author kami
 * @date 2022-04-11
 */
@RestController
@RequestMapping("/iot/authorize")
public class ProductAuthorizeController extends BaseController {
	@Autowired
	private IProductAuthorizeService productAuthorizeService;

	/**
	 * 查询产品授权码列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:list')")
	@GetMapping("/list")
	public TableDataInfo list(ProductAuthorize productAuthorize) {
		startPage();
		List<ProductAuthorize> list = productAuthorizeService.selectProductAuthorizeList(productAuthorize);
		return getDataTable(list);
	}

	/**
	 * 导出产品授权码列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:export')")
	@Log(title = "产品授权码", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	public void export(HttpServletResponse response, ProductAuthorize productAuthorize) {
		List<ProductAuthorize> list = productAuthorizeService.selectProductAuthorizeList(productAuthorize);
		ExcelUtil<ProductAuthorize> util = new ExcelUtil<ProductAuthorize>(ProductAuthorize.class);
		util.exportExcel(response, list, "产品授权码数据");
	}

	/**
	 * 获取产品授权码详细信息
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:query')")
	@GetMapping(value = "/{authorizeId}")
	public AjaxResult getInfo(@PathVariable("authorizeId") Long authorizeId) {
		return AjaxResult.success(productAuthorizeService.selectProductAuthorizeByAuthorizeId(authorizeId));
	}

	/**
	 * 新增产品授权码
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:add')")
	@Log(title = "产品授权码", businessType = BusinessType.INSERT)
	@PostMapping
	public AjaxResult add(@RequestBody ProductAuthorize productAuthorize) {
		return toAjax(productAuthorizeService.insertProductAuthorize(productAuthorize));
	}

	/**
	 * 根据数量批量新增产品授权码
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:add')")
	@Log(title = "根据数量批量新增产品授权码", businessType = BusinessType.INSERT)
	@PostMapping("addProductAuthorizeByNum")
	public AjaxResult addProductAuthorizeByNum(@RequestBody ProductAuthorizeVO productAuthorizeVO) {
		return toAjax(productAuthorizeService.addProductAuthorizeByNum(productAuthorizeVO));
	}

	/**
	 * 修改产品授权码
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:edit')")
	@Log(title = "产品授权码", businessType = BusinessType.UPDATE)
	@PutMapping
	public AjaxResult edit(@RequestBody ProductAuthorize productAuthorize) {
		return toAjax(productAuthorizeService.updateProductAuthorize(productAuthorize));
	}

	/**
	 * 删除产品授权码
	 */
	@PreAuthorize("@ss.hasPermi('iot:authorize:remove')")
	@Log(title = "产品授权码", businessType = BusinessType.DELETE)
	@DeleteMapping("/{authorizeIds}")
	public AjaxResult remove(@PathVariable Long[] authorizeIds) {
		return toAjax(productAuthorizeService.deleteProductAuthorizeByAuthorizeIds(authorizeIds));
	}
}
