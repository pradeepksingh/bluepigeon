package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.BuildingWeightage;

public class BuildingWeightageData {

	private Integer buildingId;
	private BuilderBuilding builderBuilding;
	private List<BuilderFloor> builderFloors; 
	private Set<BuildingWeightage> buildingWeightages = new HashSet<BuildingWeightage>(0);

	public Integer getBuildingId() {
		return buildingId;
	}

	public void setBuildingId(Integer buildingId) {
		this.buildingId = buildingId;
	}

	public Set<BuildingWeightage> getBuildingWeightages() {
		return buildingWeightages;
	}

	public void setBuildingWeightages(
			Set<BuildingWeightage> buildingWeightages) {
		this.buildingWeightages = buildingWeightages;
	}

	public BuilderBuilding getBuilderBuilding() {
		return builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	public List<BuilderFloor> getBuilderFloors() {
		return builderFloors;
	}

	public void setBuilderFloors(List<BuilderFloor> builderFloors) {
		this.builderFloors = builderFloors;
	}
}