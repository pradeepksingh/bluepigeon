package org.bluepigeon.admin.data;

public class FlatPaymentList {
	private int flatId;
	private String flatName;
	private int paymentId;
	private String paymentMilestone;
	public int getFlatId() {
		return flatId;
	}
	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}
	public String getFlatName() {
		return flatName;
	}
	public void setFlatName(String flatName) {
		this.flatName = flatName;
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