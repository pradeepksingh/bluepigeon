package org.bluepigeon.admin.data;

public class BuyerPaymentList {
	private int paymentId;
	private String name;
	private String email;
	private String contact;
	private String paymentMilestone;
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getPaymentMilestone() {
		return paymentMilestone;
	}
	public void setPaymentMilestone(String paymentMilestone) {
		this.paymentMilestone = paymentMilestone;
	}
}