package org.bluepigeon.admin.data;

import java.util.Date;
import java.util.List;

import org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration;

public class NewLeadList {
	private int id;
	private String leadName;
	private String email;
	private String phoneNo;
	private String source;
	private int leadStatus;
	private String leadStatusName;
	private String salemanName;
	private Date lDate;
	private String strDate;
	private int min;
	private int max;
	private String ConfigName;
	private List<ConfigData> configDatas;
	private String salesheadName;
	private int currentLeadStatus;
	private int salesmanId;
	private int salesHeadId;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLeadName() {
		return leadName;
	}
	public void setLeadName(String leadName) {
		this.leadName = leadName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public int getLeadStatus() {
		return leadStatus;
	}
	public void setLeadStatus(int leadStatus) {
		this.leadStatus = leadStatus;
	}
	public String getSalemanName() {
		return salemanName;
	}
	public void setSalemanName(String salemanName) {
		this.salemanName = salemanName;
	}
	public Date getlDate() {
		return lDate;
	}
	public void setlDate(Date lDate) {
		this.lDate = lDate;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public List<ConfigData> getConfigDatas() {
		return configDatas;
	}
	public void setConfigDatas(List<ConfigData> configDatas) {
		this.configDatas = configDatas;
	}
	public String getLeadStatusName() {
		return leadStatusName;
	}
	public void setLeadStatusName(String leadStatusName) {
		this.leadStatusName = leadStatusName;
	}
	public String getStrDate() {
		return strDate;
	}
	public void setStrDate(String strDate) {
		this.strDate = strDate;
	}
	public String getConfigName() {
		return ConfigName;
	}
	public void setConfigName(String configName) {
		ConfigName = configName;
	}
	public String getSalesheadName() {
		return salesheadName;
	}
	public void setSalesheadName(String salesheadName) {
		this.salesheadName = salesheadName;
	}
	public int getCurrentLeadStatus() {
		return currentLeadStatus;
	}
	public void setCurrentLeadStatus(int currentLeadStatus) {
		this.currentLeadStatus = currentLeadStatus;
	}
	public int getSalesmanId() {
		return salesmanId;
	}
	public void setSalesmanId(int salesmanId) {
		this.salesmanId = salesmanId;
	}
	public int getSalesHeadId() {
		return salesHeadId;
	}
	public void setSalesHeadId(int salesHeadId) {
		this.salesHeadId = salesHeadId;
	}
}