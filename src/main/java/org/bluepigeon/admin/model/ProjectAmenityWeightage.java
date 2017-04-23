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
@Table(name = "project_amenity_weightage", catalog = "blue_pigeon")
public class ProjectAmenityWeightage {
	private Integer id;
	private BuilderProject builderProject;
	private BuilderProjectAmenity builderProjectAmenity;
	private Double amenityWeightage;
	private BuilderProjectAmenityStages builderProjectAmenityStages;
	private Double stageWeightage;
	private BuilderProjectAmenitySubstages builderProjectAmenitySubstages;
	private Double substageWeightage;
	private boolean status;
	
	public ProjectAmenityWeightage() {
	}

	public ProjectAmenityWeightage(
			BuilderProject builderProject, BuilderProjectAmenity builderProjectAmenity, 
			Double amenityWeightage, BuilderProjectAmenityStages builderProjectAmenityStages,
			Double stageWeightage, BuilderProjectAmenitySubstages builderProjectAmenitySubstages,
			Double substageWeightage, boolean status
	) {
		this.builderProject = builderProject;
		this.builderProjectAmenity = builderProjectAmenity;
		this.amenityWeightage = amenityWeightage;
		this.builderProjectAmenityStages = builderProjectAmenityStages;
		this.stageWeightage = stageWeightage;
		this.builderProjectAmenitySubstages = builderProjectAmenitySubstages;
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
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "amenity_id")
	public BuilderProjectAmenity getBuilderProjectAmenity() {
		return builderProjectAmenity;
	}

	public void setBuilderProjectAmenity(BuilderProjectAmenity builderProjectAmenity) {
		this.builderProjectAmenity = builderProjectAmenity;
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
	public BuilderProjectAmenityStages getBuilderProjectAmenityStages() {
		return builderProjectAmenityStages;
	}

	public void setBuilderProjectAmenityStages(
			BuilderProjectAmenityStages builderProjectAmenityStages) {
		this.builderProjectAmenityStages = builderProjectAmenityStages;
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
	public BuilderProjectAmenitySubstages getBuilderProjectAmenitySubstages() {
		return builderProjectAmenitySubstages;
	}

	public void setBuilderProjectAmenitySubstages(
			BuilderProjectAmenitySubstages builderProjectAmenitySubstages) {
		this.builderProjectAmenitySubstages = builderProjectAmenitySubstages;
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
