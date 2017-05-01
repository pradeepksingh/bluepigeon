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
@Table(name = "building_amenity_weightage", catalog = "blue_pigeon")
public class BuildingAmenityWeightage {
	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderBuildingAmenity builderBuildingAmenity;
	private Double amenityWeightage;
	private BuilderBuildingAmenityStages builderBuildingAmenityStages;
	private Double stageWeightage;
	private BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages;
	private Double substageWeightage;
	private boolean status;
	
	public BuildingAmenityWeightage() {
	}

	public BuildingAmenityWeightage(
			BuilderBuilding builderBuilding, BuilderBuildingAmenity builderBuildingAmenity, 
			Double amenityWeightage, BuilderBuildingAmenityStages builderBuildingAmenityStages,
			Double stageWeightage, BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages,
			Double substageWeightage, boolean status
	) {
		this.builderBuilding = builderBuilding;
		this.builderBuildingAmenity = builderBuildingAmenity;
		this.amenityWeightage = amenityWeightage;
		this.builderBuildingAmenityStages = builderBuildingAmenityStages;
		this.stageWeightage = stageWeightage;
		this.builderBuildingAmenitySubstages = builderBuildingAmenitySubstages;
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
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "amenity_id")
	public BuilderBuildingAmenity getBuilderBuildingAmenity() {
		return builderBuildingAmenity;
	}

	public void setBuilderBuildingAmenity(BuilderBuildingAmenity builderBuildingAmenity) {
		this.builderBuildingAmenity = builderBuildingAmenity;
	}

	@Column(name = "amenity_weightage", precision = 21, scale = 2)
	public Double getAmenityWeightage() {
		return amenityWeightage;
	}

	public void setAmenityWeightage(Double amenityWeightage) {
		this.amenityWeightage = amenityWeightage;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "stage_id")
	public BuilderBuildingAmenityStages getBuilderBuildingAmenityStages() {
		return builderBuildingAmenityStages;
	}

	public void setBuilderBuildingAmenityStages(
			BuilderBuildingAmenityStages builderBuildingAmenityStages) {
		this.builderBuildingAmenityStages = builderBuildingAmenityStages;
	}

	@Column(name = "stage_weightage", precision = 21, scale = 2)
	public Double getStageWeightage() {
		return stageWeightage;
	}

	public void setStageWeightage(Double stageWeightage) {
		this.stageWeightage = stageWeightage;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "substage_id")
	public BuilderBuildingAmenitySubstages getBuilderBuildingAmenitySubstages() {
		return builderBuildingAmenitySubstages;
	}

	public void setBuilderBuildingAmenitySubstages(
			BuilderBuildingAmenitySubstages builderBuildingAmenitySubstages) {
		this.builderBuildingAmenitySubstages = builderBuildingAmenitySubstages;
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
