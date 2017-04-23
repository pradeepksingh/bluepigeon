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
@Table(name = "floor_amenity_weightage", catalog = "blue_pigeon")
public class FloorAmenityWeightage {
	private Integer id;
	private BuilderFloor builderFloor;
	private BuilderFloorAmenity builderFloorAmenity;
	private Double amenityWeightage;
	private BuilderFloorAmenityStages builderFloorAmenityStages;
	private Double stageWeightage;
	private BuilderFloorAmenitySubstages builderFloorAmenitySubstages;
	private Double substageWeightage;
	private boolean status;
	
	public FloorAmenityWeightage() {
	}

	public FloorAmenityWeightage(
			BuilderFloor builderFloor, BuilderFloorAmenity builderFloorAmenity, 
			Double amenityWeightage, BuilderFloorAmenityStages builderFloorAmenityStages,
			Double stageWeightage, BuilderFloorAmenitySubstages builderFloorAmenitySubstages,
			Double substageWeightage, boolean status
	) {
		this.builderFloor = builderFloor;
		this.builderFloorAmenity = builderFloorAmenity;
		this.amenityWeightage = amenityWeightage;
		this.builderFloorAmenityStages = builderFloorAmenityStages;
		this.stageWeightage = stageWeightage;
		this.builderFloorAmenitySubstages = builderFloorAmenitySubstages;
		this.substageWeightage = substageWeightage;
		this.status = status;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "floor_id")
	public BuilderFloor getBuilderFloor() {
		return builderFloor;
	}

	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "amenity_id")
	public BuilderFloorAmenity getBuilderFloorAmenity() {
		return builderFloorAmenity;
	}

	public void setBuilderFloorAmenity(BuilderFloorAmenity builderFloorAmenity) {
		this.builderFloorAmenity = builderFloorAmenity;
	}

	@Column(name = "amenity_weightage", precision = 21, scale = 2)
	public Double getAmenityWeightage() {
		return amenityWeightage;
	}

	public void setAmenityWeightage(Double amenityWeightage) {
		this.amenityWeightage = amenityWeightage;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "stage_id")
	public BuilderFloorAmenityStages getBuilderFloorAmenityStages() {
		return builderFloorAmenityStages;
	}

	public void setBuilderFloorAmenityStages(
			BuilderFloorAmenityStages builderFloorAmenityStages) {
		this.builderFloorAmenityStages = builderFloorAmenityStages;
	}

	@Column(name = "stage_weightage", precision = 21, scale = 2)
	public Double getStageWeightage() {
		return stageWeightage;
	}

	public void setStageWeightage(Double stageWeightage) {
		this.stageWeightage = stageWeightage;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "substage_id")
	public BuilderFloorAmenitySubstages getBuilderFloorAmenitySubstages() {
		return builderFloorAmenitySubstages;
	}

	public void setBuilderFloorAmenitySubstages(
			BuilderFloorAmenitySubstages builderFloorAmenitySubstages) {
		this.builderFloorAmenitySubstages = builderFloorAmenitySubstages;
	}

	@Column(name = "substage_weightage", precision = 21, scale = 2)
	public Double getSubstageWeightage() {
		return substageWeightage;
	}

	public void setSubstageWeightage(Double substageWeightage) {
		this.substageWeightage = substageWeightage;
	}

	@Column(name = "status")
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
}
