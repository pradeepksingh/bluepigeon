package org.bluepigeon.admin.data;

public class BuildingSubstageList {
	private int id;
	private String buildingStageName;
	private String buildingSubstageName;
	private byte status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBuildingStageName() {
		return buildingStageName;
	}
	public void setBuildingStageName(String buildingStageName) {
		this.buildingStageName = buildingStageName;
	}
	public String getBuildingSubstageName() {
		return buildingSubstageName;
	}
	public void setBuildingSubstageName(String buildingSubstageName) {
		this.buildingSubstageName = buildingSubstageName;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}