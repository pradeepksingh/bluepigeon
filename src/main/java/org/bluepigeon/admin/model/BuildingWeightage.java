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
@Table(name = "building_weightage", catalog = "blue_pigeon")
public class BuildingWeightage {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuildingStage buildingStage;
	private Double stageWeightage;
	private BuildingSubstage buildingSubstage;
	private Double substageWeightage;
	private Boolean status;

	public BuildingWeightage() {
		
	}

	public BuildingWeightage(
			BuilderBuilding builderBuilding, 
			ProjectStage projectStage, 
			Double stageWeightage, 
			ProjectSubstage projectSubstage,
			Double substageWeightage,
			Boolean status
	) {
		this.builderBuilding = builderBuilding;
		this.buildingStage = buildingStage;
		this.stageWeightage = stageWeightage;
		this.buildingSubstage = buildingSubstage;
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
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "stage_id")
	public BuildingStage getBuildingStage() {
		return buildingStage;
	}

	public void setBuildingStage(BuildingStage buildingStage) {
		this.buildingStage = buildingStage;
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
	public BuildingSubstage getBuildingSubstage() {
		return buildingSubstage;
	}

	public void setBuildingSubstage(BuildingSubstage buildingSubstage) {
		this.buildingSubstage = buildingSubstage;
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
