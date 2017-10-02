package org.bluepigeon.admin.data;

public class BuilderFlatList {
	
	private int id;
	private String flatNo;
	private int floorNo;
	private String buyerName;
	private String flatStatus;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	public String getFlatStatus() {
		return flatStatus;
	}
	public void setFlatStatus(String flatStatus) {
		this.flatStatus = flatStatus;
	}
	public int getFloorNo() {
		return floorNo;
	}
	public void setFloorNo(int floorNo) {
		this.floorNo = floorNo;
	}

}
