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
 * BuilderBuildingAmenityStages generated by hbm2java
 */
@Entity
@Table(name = "builder_building_amenity_stages", catalog = "blue_pigeon")
public class BuilderBuildingAmenityStages implements java.io.Serializable {

	private Integer id;
	private BuilderBuildingAmenity builderBuildingAmenity;
	private String name;
	private Byte status;
	private Byte isDeleted=0;
	private Set<BuilderBuildingAmenitySubstages> builderBuildingAmenitySubstageses = new HashSet<BuilderBuildingAmenitySubstages>(
			0);

	public BuilderBuildingAmenityStages() {
	}

	public BuilderBuildingAmenityStages(BuilderBuildingAmenity builderBuildingAmenity, String name, Byte status,
			Byte isDeleted, Set<BuilderBuildingAmenitySubstages> builderBuildingAmenitySubstageses) {
		this.builderBuildingAmenity = builderBuildingAmenity;
		this.name = name;
		this.status = status;
		this.isDeleted = isDeleted;
		this.builderBuildingAmenitySubstageses = builderBuildingAmenitySubstageses;
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
	public BuilderBuildingAmenity getBuilderBuildingAmenity() {
		return this.builderBuildingAmenity;
	}

	public void setBuilderBuildingAmenity(BuilderBuildingAmenity builderBuildingAmenity) {
		this.builderBuildingAmenity = builderBuildingAmenity;
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

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "builderBuildingAmenityStages")
	public Set<BuilderBuildingAmenitySubstages> getBuilderBuildingAmenitySubstageses() {
		return this.builderBuildingAmenitySubstageses;
	}

	public void setBuilderBuildingAmenitySubstageses(
			Set<BuilderBuildingAmenitySubstages> builderBuildingAmenitySubstageses) {
		this.builderBuildingAmenitySubstageses = builderBuildingAmenitySubstageses;
	}

}
