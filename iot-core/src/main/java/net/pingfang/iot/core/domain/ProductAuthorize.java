package net.pingfang.iot.core.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import net.pingfang.iot.common.annotation.Excel;
import net.pingfang.iot.common.core.domain.BaseEntity;

/**
 * 产品授权码对象 iot_product_authorize
 *
 * @author kami
 * @date 2022-04-11
 */
public class ProductAuthorize extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/** 授权码ID */
	private Long authorizeId;

	/** 授权码 */
	@Excel(name = "授权码")
	private String authorizeCode;

	/** 产品ID */
	@Excel(name = "产品ID")
	private Long productId;

	/** 设备ID */
	@Excel(name = "设备ID")
	private Long deviceId;

	/** 设备编号 */
	@Excel(name = "设备编号")
	private String serialNumber;

	/** 用户ID */
	@Excel(name = "用户ID")
	private Long userId;

	/** 用户名称 */
	@Excel(name = "用户名称")
	private String userName;

	/** 删除标志（0代表存在 2代表删除） */
	private String delFlag;

	public ProductAuthorize() {
	}

	public ProductAuthorize(String authorizeCode, Long productId, Long deviceId, String serialNumber, Long userId,
			String userName) {
		this.authorizeCode = authorizeCode;
		this.productId = productId;
		this.deviceId = deviceId;
		this.serialNumber = serialNumber;
		this.userId = userId;
		this.userName = userName;
	}

	public Long getAuthorizeId() {
		return authorizeId;
	}

	public void setAuthorizeId(Long authorizeId) {
		this.authorizeId = authorizeId;
	}

	public String getAuthorizeCode() {
		return authorizeCode;
	}

	public void setAuthorizeCode(String authorizeCode) {
		this.authorizeCode = authorizeCode;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE).append("authorizeId", getAuthorizeId())
				.append("authorizeCode", getAuthorizeCode()).append("productId", getProductId())
				.append("deviceId", getDeviceId()).append("serialNumber", getSerialNumber())
				.append("userId", getUserId()).append("userName", getUserName()).append("delFlag", getDelFlag())
				.append("createBy", getCreateBy()).append("createTime", getCreateTime())
				.append("updateBy", getUpdateBy()).append("updateTime", getUpdateTime()).append("remark", getRemark())
				.toString();
	}
}
