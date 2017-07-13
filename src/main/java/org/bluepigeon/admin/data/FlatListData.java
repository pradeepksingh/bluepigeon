package org.bluepigeon.admin.data;

import java.util.List;

public class FlatListData {
	private int projectid;
	private List<BuildingListData> buildingListDatas;
	
	public int getProjectid() {
		return projectid;
	}
	public void setProjectid(int projectid) {
		this.projectid = projectid;
	}
	public List<BuildingListData> getBuildingListDatas() {
		return buildingListDatas;
	}
	public void setBuildingListDatas(List<BuildingListData> buildingListDatas) {
		this.buildingListDatas = buildingListDatas;
	}
}