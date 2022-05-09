package net.pingfang.iot.core.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import net.pingfang.iot.core.domain.Category;
import net.pingfang.iot.core.model.IdAndName;

/**
 * 产品分类Mapper接口
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Repository
public interface CategoryMapper {
	/**
	 * 查询产品分类
	 *
	 * @param categoryId 产品分类主键
	 * @return 产品分类
	 */
	public Category selectCategoryByCategoryId(Long categoryId);

	/**
	 * 查询产品分类列表
	 *
	 * @param category 产品分类
	 * @return 产品分类集合
	 */
	public List<Category> selectCategoryList(Category category);

	/**
	 * 查询产品简短分类列表
	 *
	 * @return 产品分类集合
	 */
	public List<IdAndName> selectCategoryShortList();

	/**
	 * 新增产品分类
	 *
	 * @param category 产品分类
	 * @return 结果
	 */
	public int insertCategory(Category category);

	/**
	 * 修改产品分类
	 *
	 * @param category 产品分类
	 * @return 结果
	 */
	public int updateCategory(Category category);

	/**
	 * 删除产品分类
	 *
	 * @param categoryId 产品分类主键
	 * @return 结果
	 */
	public int deleteCategoryByCategoryId(Long categoryId);

	/**
	 * 批量删除产品分类
	 *
	 * @param categoryIds 需要删除的数据主键集合
	 * @return 结果
	 */
	public int deleteCategoryByCategoryIds(Long[] categoryIds);

	/**
	 * 分类下的产品数量
	 *
	 * @param categoryIds 需要删除的数据主键集合
	 * @return 结果
	 */
	public int productCountInCategorys(Long[] categoryIds);

	// 精准查询
	List<Category> selectCategoryListAccurate(Category category);

	List<IdAndName> selectCategoryShortListAccurate(Category category);
}
