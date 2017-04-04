package org.bluepigeon.admin.data;

import java.util.ArrayList;
import java.util.List;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.FloorAmenityInfo;

public class FloorDetail {
	private BuilderFloor builderFloor;
	private List<FloorAmenityInfo> floorAmenityInfos = new ArrayList<FloorAmenityInfo>();
	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}
	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}
	public List<FloorAmenityInfo> getFloorAmenityInfos() {
		return floorAmenityInfos;
	}
	public void setFloorAmenityInfos(List<FloorAmenityInfo> floorAmenityInfos) {
		this.floorAmenityInfos = floorAmenityInfos;
	}
}
