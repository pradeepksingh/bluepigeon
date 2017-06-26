package org.bluepigeon.admin.data;

import java.util.List;

import org.bluepigeon.admin.model.BuilderFlat;

public class FlatListData {
	private int id;
	private BuildingData buildingData[];
	private FloorData floorData[];
	private FlatData flatData[];
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public BuildingData[] getBuildingData() {
		return buildingData;
	}
	public void setBuildingData(BuildingData[] buildingData) {
		this.buildingData = buildingData;
	}
	public FloorData[] getFloorData() {
		return floorData;
	}
	public void setFloorData(FloorData[] floorData) {
		this.floorData = floorData;
	}
	public FlatData[] getFlatData() {
		return flatData;
	}
	public void setFlatData(FlatData[] flatData) {
		this.flatData = flatData;
	}
}