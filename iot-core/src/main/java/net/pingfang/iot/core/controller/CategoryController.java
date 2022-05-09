package net.pingfang.iot.core.controller;

import java.util.ArrayList;
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

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.pingfang.iot.common.annotation.Log;
import net.pingfang.iot.common.core.controller.BaseController;
import net.pingfang.iot.common.core.domain.AjaxResult;
import net.pingfang.iot.common.core.page.TableDataInfo;
import net.pingfang.iot.common.enums.BusinessType;
import net.pingfang.iot.common.utils.poi.ExcelUtil;
import net.pingfang.iot.core.domain.Category;
import net.pingfang.iot.core.model.IdAndName;
import net.pingfang.iot.core.service.ICategoryService;

/**
 * 产品分类Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "产品分类")
@RestController
@RequestMapping("/iot/category")
public class CategoryController extends BaseController {
	@Autowired
	private ICategoryService categoryService;

	/**
	 * 查询产品分类列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:list')")
	@GetMapping("/list")
	@ApiOperation("分类分页列表")
	public TableDataInfo list(Category category) {
		startPage();
		List<Category> list = new ArrayList<>();
		if (category.getTenantName() == null || category.getTenantName() == "") {
			list = categoryService.selectCategoryList(category);
		} else {
			list = categoryService.selectCategoryListAccurate(category);
		}

		return getDataTable(list);
	}

	/**
	 * 查询产品简短分类列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:list')")
	@GetMapping("/shortlist")
	@ApiOperation("分类简短列表")
	public AjaxResult shortlist(Category category) {
		List<IdAndName> list = new ArrayList<>();
		if (category.getTenantName() == "" || category.getTenantName() == null) {
			list = categoryService.selectCategoryShortList();
		} else {
			list = categoryService.selectCategoryShortListAccurate(category);
		}
		return AjaxResult.success(list);
	}

	/**
	 * 导出产品分类列表
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:export')")
	@Log(title = "产品分类", businessType = BusinessType.EXPORT)
	@PostMapping("/export")
	@ApiOperation("导出分类")
	public void export(HttpServletResponse response, Category category) {
		List<Category> list = categoryService.selectCategoryList(category);
		ExcelUtil<Category> util = new ExcelUtil<Category>(Category.class);
		util.exportExcel(response, list, "产品分类数据");
	}

	/**
	 * 获取产品分类详细信息
	 */
	@ApiOperation("获取分类详情")
	@PreAuthorize("@ss.hasPermi('iot:category:query')")
	@GetMapping(value = "/{categoryId}")
	public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId) {
		return AjaxResult.success(categoryService.selectCategoryByCategoryId(categoryId));
	}

	/**
	 * 新增产品分类
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:add')")
	@Log(title = "产品分类", businessType = BusinessType.INSERT)
	@PostMapping
	@ApiOperation("添加分类")
	public AjaxResult add(@RequestBody Category category) {
		return toAjax(categoryService.insertCategory(category));
	}

	/**
	 * 修改产品分类
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:edit')")
	@Log(title = "产品分类", businessType = BusinessType.UPDATE)
	@PutMapping
	@ApiOperation("修改分类")
	public AjaxResult edit(@RequestBody Category category) {
		return toAjax(categoryService.updateCategory(category));
	}

	/**
	 * 删除产品分类
	 */
	@PreAuthorize("@ss.hasPermi('iot:category:remove')")
	@Log(title = "产品分类", businessType = BusinessType.DELETE)
	@DeleteMapping("/{categoryIds}")
	@ApiOperation("批量删除分类")
	public AjaxResult remove(@PathVariable Long[] categoryIds) {
		return categoryService.deleteCategoryByCategoryIds(categoryIds);
	}
}
