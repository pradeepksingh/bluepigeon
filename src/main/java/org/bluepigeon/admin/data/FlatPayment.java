package org.bluepigeon.admin.data;

public class FlatPayment {
	private String milestone;
	private Double payable;
	private Double amount;
	public String getMilestone() {
		return milestone;
	}
	public void setMilestone(String milestone) {
		this.milestone = milestone;
	}
	public Double getPayable() {
		return payable;
	}
	public void setPayable(Double payable) {
		this.payable = payable;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
}