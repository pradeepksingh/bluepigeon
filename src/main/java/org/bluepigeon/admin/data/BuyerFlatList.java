package org.bluepigeon.admin.data;

import org.bluepigeon.admin.model.Buyer;

public class BuyerFlatList {
	private int flatId;
	private String flatNo;
	private Buyer buyer[];
	public int getFlatId() {
		return flatId;
	}
	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	public Buyer[] getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer[] buyer) {
		this.buyer = buyer;
	}	
}