package org.bluepigeon.admin.data;

import java.util.Date;

public class PossessionList {
	private int id;
	private String buyerName;
	private int projectId;
	private String projectName;
	private int buildingId;
	private String buildingName;
	private int floorId;
	//private String FloorNo;
	private Date possessionDate;
	private int flatId;
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
	public int getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(int buildingId) {
		this.buildingId = buildingId;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public int getFloorId() {
		return floorId;
	}
	public void setFloorId(int floorId) {
		this.floorId = floorId;
	}
	
public Date getPossessionDate() {
		return possessionDate;
	}
	public void setPossessionDate(Date possessionDate) {
		this.possessionDate = possessionDate;
	}
	//	public String getFloorNo() {
//		return FloorNo;
//	}
//	public void setFloorNo(String floorNo) {
//		FloorNo = floorNo;
//	}
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
}