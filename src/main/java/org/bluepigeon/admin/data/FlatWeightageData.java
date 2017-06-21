package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.FlatWeightage;

public class FlatWeightageData {

	private Integer flatId;
	private Set<FlatWeightage> flatWeightages = new HashSet<FlatWeightage>(0);
	
	public Integer getFlatId() {
		return flatId;
	}

	public void setFlatId(Integer flatId) {
		this.flatId = flatId;
	}

	public Set<FlatWeightage> getFlatWeightages() {
		return flatWeightages;
	}

	public void setFlatWeightages(
			Set<FlatWeightage> flatWeightages) {
		this.flatWeightages = flatWeightages;
	}
	
}
