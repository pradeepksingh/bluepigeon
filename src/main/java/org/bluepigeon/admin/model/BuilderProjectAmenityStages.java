package org.bluepigeon.admin.model;
// Generated 27 Mar, 2017 5:55:47 PM by Hibernate Tools 4.0.0

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

/**
 * BuilderProjectAmenityStages generated by hbm2java
 */
@Entity
@Table(name = "builder_project_amenity_stages", catalog = "blue_pigeon")
public class BuilderProjectAmenityStages implements java.io.Serializable {

	private Integer id;
	private BuilderProjectAmenity builderProjectAmenity;
	private String name;
	private Byte status;
	private Set<BuilderProjectAmenitySubstages> builderProjectAmenitySubstageses = new HashSet<BuilderProjectAmenitySubstages>(
			0);

	public BuilderProjectAmenityStages() {
	}

	public BuilderProjectAmenityStages(BuilderProjectAmenity builderProjectAmenity, String name, Byte status,
			Set<BuilderProjectAmenitySubstages> builderProjectAmenitySubstageses) {
		this.builderProjectAmenity = builderProjectAmenity;
		this.name = name;
		this.status = status;
		this.builderProjectAmenitySubstageses = builderProjectAmenitySubstageses;
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "amenity_id")
	public BuilderProjectAmenity getBuilderProjectAmenity() {
		return this.builderProjectAmenity;
	}

	public void setBuilderProjectAmenity(BuilderProjectAmenity builderProjectAmenity) {
		this.builderProjectAmenity = builderProjectAmenity;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProjectAmenityStages")
	public Set<BuilderProjectAmenitySubstages> getBuilderProjectAmenitySubstageses() {
		return this.builderProjectAmenitySubstageses;
	}

	public void setBuilderProjectAmenitySubstageses(
			Set<BuilderProjectAmenitySubstages> builderProjectAmenitySubstageses) {
		this.builderProjectAmenitySubstageses = builderProjectAmenitySubstageses;
	}

}
