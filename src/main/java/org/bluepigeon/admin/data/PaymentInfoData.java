package org.bluepigeon.admin.data;

public class PaymentInfoData {
	private int id = 0;
	private String name;
	private Double amount;
	private Double payable;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getPayable() {
		return payable;
	}
	public void setPayable(Double payable) {
		this.payable = payable;
	}
}