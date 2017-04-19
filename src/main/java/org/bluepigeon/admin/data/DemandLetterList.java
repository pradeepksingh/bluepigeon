package org.bluepigeon.admin.data;

public class DemandLetterList {
	private int id;
	private String projectName;
	private String buildingName;
	private String flatname;
	private String buyerName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getFlatname() {
		return flatname;
	}
	public void setFlatname(String flatname) {
		this.flatname = flatname;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
}