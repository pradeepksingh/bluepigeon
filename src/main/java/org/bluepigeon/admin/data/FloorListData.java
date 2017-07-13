package org.bluepigeon.admin.data;

import java.util.List;

public class FloorListData {
	private int floorId;
	private String floorName;
	private List<FlatStatusData> flatStatusDatas;
	public int getFloorId() {
		return floorId;
	}
	public void setFloorId(int floorId) {
		this.floorId = floorId;
	}
	public String getFloorName() {
		return floorName;
	}
	public void setFloorName(String floorName) {
		this.floorName = floorName;
	}
	public List<FlatStatusData> getFlatStatusDatas() {
		return flatStatusDatas;
	}
	public void setFlatStatusDatas(List<FlatStatusData> flatStatusDatas) {
		this.flatStatusDatas = flatStatusDatas;
	}
}
