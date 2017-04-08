package org.bluepigeon.admin.data;

public class AgreementList {
	private int id;
	private String buyerName;
	private String projectName;
	private String buildingName;
	private String FloorNo;
	private String flatNo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	
	public String getFloorNo() {
		return FloorNo;
	}
	public void setFloorNo(String floorNo) {
		FloorNo = floorNo;
	}
	
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
}