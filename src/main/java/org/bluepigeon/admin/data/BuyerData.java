package org.bluepigeon.admin.data;

import java.util.List;

import org.bluepigeon.admin.model.Buyer;
import org.bluepigeon.admin.model.BuyerDocuments;

public class BuyerData {
	private Buyer buyer;
	private List<BuyerDocuments> buyerDocuments;
   
	public Buyer getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	public List<BuyerDocuments> getBuyerDocuments() {
		return buyerDocuments;
	}
	public void setBuyerDocuments(List<BuyerDocuments> buyerDocuments) {
		this.buyerDocuments = buyerDocuments;
	}
}