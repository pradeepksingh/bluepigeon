package org.bluepigeon.admin.data;

import java.util.List;

public class FlatListData {
	private int id;
	private List<BuildingListData> buildingListDatas;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public List<BuildingListData> getBuildingListDatas() {
		return buildingListDatas;
	}
	public void setBuildingListDatas(List<BuildingListData> buildingListDatas) {
		this.buildingListDatas = buildingListDatas;
	}
}