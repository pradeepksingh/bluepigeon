package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.FloorWeightage;

public class FloorWeightageData {
	
	private Integer floorId;
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

}
