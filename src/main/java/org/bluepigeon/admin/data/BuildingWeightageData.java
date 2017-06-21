package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.BuildingWeightage;

public class BuildingWeightageData {

	private Integer buildingId;
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
}
