package org.bluepigeon.admin.data;

import java.util.List;

import org.bluepigeon.admin.model.Buyer;

public class BuyerProjectList {
	private int projectId;
	private String projectName;
	private Buyer buyer[];
	private int buyerId[];
	private String buyerName[];
	//private int buyerId;
	//private String buyerName;
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public Buyer[] getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer[] buyer) {
		this.buyer = buyer;
	}
	
	public String[] getBuyerName() {
		return buyerName;
	}
	public int[] getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(int[] buyerId) {
		this.buyerId = buyerId;
	}
	public void setBuyerName(String[] buyerName) {
		this.buyerName = buyerName;
	}
	
	
//	public int getBuyerId() {
//		return buyerId;
//	}
//	public void setBuyerId(int buyerId) {
//		this.buyerId = buyerId;
//	}
//	public String getBuyerName() {
//		return buyerName;
//	}
//	public void setBuyerName(String buyerName) {
//		this.buyerName = buyerName;
//	}
	
}