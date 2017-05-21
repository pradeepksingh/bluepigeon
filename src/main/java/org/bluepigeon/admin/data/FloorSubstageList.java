package org.bluepigeon.admin.data;

public class FloorSubstageList {
	private int id;
	private String floorStageName;
	private String floorSubstageName;
	private byte status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFloorStageName() {
		return floorStageName;
	}
	public void setFloorStageName(String floorStageName) {
		this.floorStageName = floorStageName;
	}
	public String getFloorSubstageName() {
		return floorSubstageName;
	}
	public void setFloorSubstageName(String floorSubstageName) {
		this.floorSubstageName = floorSubstageName;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}