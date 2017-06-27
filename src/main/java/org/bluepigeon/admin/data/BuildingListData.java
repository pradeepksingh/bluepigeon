package org.bluepigeon.admin.data;

import java.util.List;

public class BuildingListData {
	private int buildingId;
	private String buildingName;
	List<FloorListData> floorListDatas;
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
	public List<FloorListData> getFloorListDatas() {
		return floorListDatas;
	}
	public void setFloorListDatas(List<FloorListData> floorListDatas) {
		this.floorListDatas = floorListDatas;
	}
}
