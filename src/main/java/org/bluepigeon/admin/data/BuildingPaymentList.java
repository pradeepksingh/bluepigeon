package org.bluepigeon.admin.data;

public class BuildingPaymentList {
	private int buildingId;
	private String buildingName;
	private int paymentId;
	private String paymentMilestone;
	public int getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(int buildingId) {
		this.buildingId = buildingId;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public String getPaymentMilestone() {
		return paymentMilestone;
	}
	public void setPaymentMilestone(String paymentMilestone) {
		this.paymentMilestone = paymentMilestone;
	}
}