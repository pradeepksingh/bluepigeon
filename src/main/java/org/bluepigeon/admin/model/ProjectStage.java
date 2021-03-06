package org.bluepigeon.admin.model;
// Generated 16 May, 2017 11:21:31 PM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * ProjectStage generated by hbm2java
 */
@Entity
@Table(name = "project_stage", catalog = "blue_pigeon")
public class ProjectStage implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Byte isDeleted=0;
	private Set<ProjectSubstage> projectSubstages = new HashSet<ProjectSubstage>(0);

	public ProjectStage() {
	}

	public ProjectStage(String name, Byte status, Byte isDeleted, Set<ProjectSubstage> projectSubstages) {
		this.name = name;
		this.status = status;
		this.isDeleted = isDeleted;
		this.projectSubstages = projectSubstages;
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

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@Column(name = "is_deleted")
	public Byte getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Byte isDeleted) {
		this.isDeleted = isDeleted;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectStage")
	public Set<ProjectSubstage> getProjectSubstages() {
		return this.projectSubstages;
	}

	public void setProjectSubstages(Set<ProjectSubstage> projectSubstages) {
		this.projectSubstages = projectSubstages;
	}

}
