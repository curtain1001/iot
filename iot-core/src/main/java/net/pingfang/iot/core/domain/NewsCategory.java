package net.pingfang.iot.core.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import net.pingfang.iot.common.annotation.Excel;
import net.pingfang.iot.common.core.domain.BaseEntity;

/**
 * 新闻分类对象 news_category
 *
 * @author kerwincui
 * @date 2022-04-09
 */
public class NewsCategory extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/** 分类ID */
	@Excel(name = "分类ID")
	private Long categoryId;

	/** 分类名字 */
	@Excel(name = "分类名字")
	private String categoryName;

	/** 显示顺序 */
	@Excel(name = "显示顺序")
	private Integer orderNum;

	/** 删除标志（0代表存在 2代表删除） */
	private String delFlag;

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE).append("categoryId", getCategoryId())
				.append("categoryName", getCategoryName()).append("orderNum", getOrderNum())
				.append("delFlag", getDelFlag()).append("createBy", getCreateBy()).append("createTime", getCreateTime())
				.append("updateBy", getUpdateBy()).append("updateTime", getUpdateTime()).append("remark", getRemark())
				.toString();
	}
}
