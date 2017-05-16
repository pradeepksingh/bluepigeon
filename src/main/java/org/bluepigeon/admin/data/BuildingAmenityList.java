package org.bluepigeon.admin.data;

public class BuildingAmenityList {
	private int id;
	private String buildingAmenityName;
	private String buildingAmenityStageName;
	private byte status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBuildingAmenityName() {
		return buildingAmenityName;
	}
	public void setBuildingAmenityName(String buildingAmenityName) {
		this.buildingAmenityName = buildingAmenityName;
	}
	public String getBuildingAmenityStageName() {
		return buildingAmenityStageName;
	}
	public void setBuildingAmenityStageName(String buildingAmenityStageName) {
		this.buildingAmenityStageName = buildingAmenityStageName;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}