package org.bluepigeon.admin.model;


import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "project_weightage", catalog = "blue_pigeon")
public class ProjectWeightage {
	
	private Integer id;
	private BuilderProject builderProject;
	private ProjectStage projectStage;
	private Double stageWeightage;
	private ProjectSubstage projectSubstage;
	private Double substageWeightage;
	private Boolean status;

	public ProjectWeightage() {
		
	}

	public ProjectWeightage(
			BuilderProject builderProject, 
			ProjectStage projectStage, 
			Double stageWeightage, 
			ProjectSubstage projectSubstage,
			Double substageWeightage,
			Boolean status
	) {
		this.builderProject = builderProject;
		this.projectStage = projectStage;
		this.stageWeightage = stageWeightage;
		this.projectSubstage = projectSubstage;
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
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "stage_id")
	public ProjectStage getProjectStage() {
		return projectStage;
	}

	public void setProjectStage(ProjectStage projectStage) {
		this.projectStage = projectStage;
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
	public ProjectSubstage getProjectSubstage() {
		return projectSubstage;
	}

	public void setProjectSubstage(ProjectSubstage projectSubstage) {
		this.projectSubstage = projectSubstage;
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
