package org.bluepigeon.admin.data;

import java.util.Date;


public class SchedulePOJO {
	private Integer id;
	private String milestone;
	private Double netPayable;
	private Double amount;
	private boolean isPaid;
	private String scheduleDate;
	private String paieddate;
	private String flatNo;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMilestone() {
		return milestone;
	}
	public void setMilestone(String milestone) {
		this.milestone = milestone;
	}
	public Double getNetPayable() {
		return netPayable;
	}
	public void setNetPayable(Double netPayable) {
		this.netPayable = netPayable;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public boolean isPaid() {
		return isPaid;
	}
	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getPaieddate() {
		return paieddate;
	}
	public void setPaieddate(String paieddate) {
		this.paieddate = paieddate;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
}
