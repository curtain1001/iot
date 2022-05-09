package net.pingfang.iot.core.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import net.pingfang.iot.common.annotation.Excel;
import net.pingfang.iot.core.model.ThingsModelItem.ArrayModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.BoolModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.DecimalModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.EnumModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.IntegerModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.ReadOnlyModelOutput;
import net.pingfang.iot.core.model.ThingsModelItem.StringModelOutput;

/**
 * 设备对象 iot_device
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceShortOutput {
	private static final long serialVersionUID = 1L;
	/** 产品分类ID */
	private Long deviceId;
	/** 产品分类名称 */
	@Excel(name = "设备名称")
	private String deviceName;
	/** 产品ID */
	@Excel(name = "产品ID")
	private Long productId;
	/** 产品名称 */
	@Excel(name = "产品名称")
	private String productName;
	/** 用户ID */
	@Excel(name = "用户ID")
	private Long userId;
	/** 用户昵称 */
	@Excel(name = "用户昵称")
	private String userName;
	/** 租户ID */
	@Excel(name = "租户ID")
	private Long tenantId;
	/** 租户名称 */
	@Excel(name = "租户名称")
	private String tenantName;
	/** 设备编号 */
	@Excel(name = "设备编号")
	private String serialNumber;
	/** 固件版本 */
	@Excel(name = "固件版本")
	private BigDecimal firmwareVersion;
	/** 设备状态（1-未激活，2-禁用，3-在线，4-离线） */
	@Excel(name = "设备状态")
	private Integer status;
	/** 设备影子 */
	private Integer isShadow;
	/**
	 * wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
	 */
	@Excel(name = "wifi信号强度")
	private Integer rssi;
	@Excel(name = "物模型")
	private String thingsModelValue;
	/** 激活时间 */
	@JsonFormat(pattern = "yyyy-MM-dd")
	@Excel(name = "激活时间", width = 30, dateFormat = "yyyy-MM-dd")
	private Date activeTime;
	/** 是否自定义位置 **/
	private Integer isCustomLocation;
	/** 图片地址 */
	private String imgUrl;
	private List<StringModelOutput> stringList;
	private List<IntegerModelOutput> integerList;
	private List<DecimalModelOutput> decimalList;
	private List<EnumModelOutput> enumList;
	private List<ArrayModelOutput> arrayList;
	private List<BoolModelOutput> boolList;
	private List<ReadOnlyModelOutput> readOnlyList;
	public DeviceShortOutput() {
		this.stringList = new ArrayList<>();
		this.integerList = new ArrayList<>();
		this.decimalList = new ArrayList<>();
		this.enumList = new ArrayList<>();
		this.arrayList = new ArrayList<>();
		this.readOnlyList = new ArrayList<>();
		this.boolList = new ArrayList<>();
	}

	public Integer getIsCustomLocation() {
		return isCustomLocation;
	}

	public void setIsCustomLocation(Integer isCustomLocation) {
		this.isCustomLocation = isCustomLocation;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public Integer getIsShadow() {
		return isShadow;
	}

	public void setIsShadow(Integer isShadow) {
		this.isShadow = isShadow;
	}

	public List<BoolModelOutput> getBoolList() {
		return boolList;
	}

	public void setBoolList(List<BoolModelOutput> boolList) {
		this.boolList = boolList;
	}

	public List<ReadOnlyModelOutput> getReadOnlyList() {
		return readOnlyList;
	}

	public void setReadOnlyList(List<ReadOnlyModelOutput> readOnlyList) {
		this.readOnlyList = readOnlyList;
	}

	public List<StringModelOutput> getStringList() {
		return stringList;
	}

	public void setStringList(List<StringModelOutput> stringList) {
		this.stringList = stringList;
	}

	public List<IntegerModelOutput> getIntegerList() {
		return integerList;
	}

	public void setIntegerList(List<IntegerModelOutput> integerList) {
		this.integerList = integerList;
	}

	public List<DecimalModelOutput> getDecimalList() {
		return decimalList;
	}

	public void setDecimalList(List<DecimalModelOutput> decimalList) {
		this.decimalList = decimalList;
	}

	public List<EnumModelOutput> getEnumList() {
		return enumList;
	}

	public void setEnumList(List<EnumModelOutput> enumList) {
		this.enumList = enumList;
	}

	public List<ArrayModelOutput> getArrayList() {
		return arrayList;
	}

	public void setArrayList(List<ArrayModelOutput> arrayList) {
		this.arrayList = arrayList;
	}

	public Integer getRssi() {
		return rssi;
	}

	public void setRssi(Integer rssi) {
		this.rssi = rssi;
	}

	public String getThingsModelValue() {
		return thingsModelValue;
	}

	public void setThingsModelValue(String thingsModelValue) {
		this.thingsModelValue = thingsModelValue;
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

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getTenantId() {
		return tenantId;
	}

	public void setTenantId(Long tenantId) {
		this.tenantId = tenantId;
	}

	public String getTenantName() {
		return tenantName;
	}

	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
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
