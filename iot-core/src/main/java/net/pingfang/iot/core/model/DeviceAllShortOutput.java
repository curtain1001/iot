package net.pingfang.iot.core.model;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 设备对象 iot_device
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceAllShortOutput {
	private static final long serialVersionUID = 1L;

	/** 产品分类ID */
	private Long deviceId;

	/** 产品分类名称 */
	private String deviceName;

	/** 产品名称 */
	private String productName;

	/** 用户昵称 */
	private String userName;

	/** 设备编号 */
	private String serialNumber;

	/** 固件版本 */
	private BigDecimal firmwareVersion;

	/** 设备状态（1-未激活，2-禁用，3-在线，4-离线） */
	private Integer status;

	/** 设备影子 */
	private Integer isShadow;

	/**
	 * wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
	 */
	private Integer rssi;

	/** 激活时间 */
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date activeTime;

	/** 是否自定义位置 **/
	private Integer isCustomLocation;

	/** 设备地址 */
	private String networkAddress;

	/** 经度 */
	private BigDecimal longitude;

	/** 纬度 */
	private BigDecimal latitude;

	public String getNetworkAddress() {
		return networkAddress;
	}

	public void setNetworkAddress(String networkAddress) {
		this.networkAddress = networkAddress;
	}

	public BigDecimal getLongitude() {
		return longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	public BigDecimal getLatitude() {
		return latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	public Integer getIsCustomLocation() {
		return isCustomLocation;
	}

	public void setIsCustomLocation(Integer isCustomLocation) {
		this.isCustomLocation = isCustomLocation;
	}

	public Integer getIsShadow() {
		return isShadow;
	}

	public void setIsShadow(Integer isShadow) {
		this.isShadow = isShadow;
	}

	public Integer getRssi() {
		return rssi;
	}

	public void setRssi(Integer rssi) {
		this.rssi = rssi;
	}

	public Long getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public BigDecimal getFirmwareVersion() {
		return firmwareVersion;
	}

	public void setFirmwareVersion(BigDecimal firmwareVersion) {
		this.firmwareVersion = firmwareVersion;
	}

	public Date getActiveTime() {
		return activeTime;
	}

	public void setActiveTime(Date activeTime) {
		this.activeTime = activeTime;
	}

}
