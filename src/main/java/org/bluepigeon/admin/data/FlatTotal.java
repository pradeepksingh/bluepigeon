package org.bluepigeon.admin.data;

public class FlatTotal {
	
	private int stageId;
	private Double totalSubstageWeight;
	private Double stageWeight;
	
	public FlatTotal() {
	}

	public FlatTotal(int stageId, Double totalSubstageWeight, Double stageWeight) {
		this.stageId = stageId;
		this.totalSubstageWeight = totalSubstageWeight;
		this.stageWeight = stageWeight;
	}
	
	public int getStageId() {
		return stageId;
	}
	public void setStageId(int stageId) {
		this.stageId = stageId;
	}
	public Double getTotalSubstageWeight() {
		return totalSubstageWeight;
	}
	public void setTotalSubstageWeight(Double totalSubstageWeight) {
		this.totalSubstageWeight = totalSubstageWeight;
	}
	public Double getStageWeight() {
		return stageWeight;
	}
	public void setStageWeight(Double stageWeight) {
		this.stageWeight = stageWeight;
	}
	
	
}
