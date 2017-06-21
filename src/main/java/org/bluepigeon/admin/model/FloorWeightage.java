package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "floor_weightage", catalog = "blue_pigeon")
public class FloorWeightage {

	private Integer id;
	private BuilderFloor builderFloor;
	private FloorStage floorStage;
	private Double stageWeightage;
	private FloorSubstage floorSubstage;
	private Double substageWeightage;
	private Boolean status;

	public FloorWeightage() {
		
	}

	public FloorWeightage(
			BuilderFloor builderFloor, 
			FloorStage floorStage, 
			Double stageWeightage, 
			FloorSubstage floorSubstage,
			Double substageWeightage,
			Boolean status
	) {
		this.builderFloor = builderFloor;
		this.floorStage = floorStage;
		this.stageWeightage = stageWeightage;
		this.floorSubstage = floorSubstage;
		this.substageWeightage = substageWeightage;
		this.status = status;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "floor_id")
	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}

	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "stage_id")
	public FloorStage getFloorStage() {
		return floorStage;
	}

	public void setFloorStage(FloorStage floorStage) {
		this.floorStage = floorStage;
	}

	@Column(name = "stage_weightage")
	public Double getStageWeightage() {
		return stageWeightage;
	}

	public void setStageWeightage(Double stageWeightage) {
		this.stageWeightage = stageWeightage;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "substage_id")
	public FloorSubstage getFloorSubstage() {
		return floorSubstage;
	}

	public void setFloorSubstage(FloorSubstage floorSubstage) {
		this.floorSubstage = floorSubstage;
	}

	@Column(name = "substage_weightage")
	public Double getSubstageWeightage() {
		return substageWeightage;
	}

	public void setSubstageWeightage(Double substageWeightage) {
		this.substageWeightage = substageWeightage;
	}

	@Column(name = "status")
	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
}
