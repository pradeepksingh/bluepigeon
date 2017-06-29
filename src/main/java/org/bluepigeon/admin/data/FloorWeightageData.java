package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.model.BuilderFlat;
import org.bluepigeon.admin.model.BuilderFloor;
import org.bluepigeon.admin.model.FloorWeightage;

public class FloorWeightageData {
	
	private Integer floorId;
	private BuilderFloor builderFloor;
	private List<BuilderFlat> builderFlats;
	private Set<FloorWeightage> floorWeightages = new HashSet<FloorWeightage>(0);
	
	
	public Integer getFloorId() {
		return floorId;
	}

	public void setFloorId(Integer floorId) {
		this.floorId = floorId;
	}

	public Set<FloorWeightage> getFloorWeightages() {
		return floorWeightages;
	}

	public void setFloorWeightages(
			Set<FloorWeightage> floorWeightages) {
		this.floorWeightages = floorWeightages;
	}

	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}

	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}

	public List<BuilderFlat> getBuilderFlats() {
		return builderFlats;
	}

	public void setBuilderFlats(List<BuilderFlat> builderFlats) {
		this.builderFlats = builderFlats;
	}
}