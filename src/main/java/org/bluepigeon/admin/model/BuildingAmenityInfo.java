package org.bluepigeon.admin.model;
// Generated 28 Mar, 2017 12:04:04 AM by Hibernate Tools 4.0.0

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * BuildingAmenityInfo generated by hbm2java
 */
@Entity
@Table(name = "building_amenity_info", catalog = "blue_pigeon")
public class BuildingAmenityInfo implements java.io.Serializable {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderBuildingAmenity builderBuildingAmenity;

	public BuildingAmenityInfo() {
	}

	public BuildingAmenityInfo(BuilderBuilding builderBuilding, BuilderBuildingAmenity builderBuildingAmenity) {
		this.builderBuilding = builderBuilding;
		this.builderBuildingAmenity = builderBuildingAmenity;
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
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "amenity_id")
	public BuilderBuildingAmenity getBuilderBuildingAmenity() {
		return this.builderBuildingAmenity;
	}

	public void setBuilderBuildingAmenity(BuilderBuildingAmenity builderBuildingAmenity) {
		this.builderBuildingAmenity = builderBuildingAmenity;
	}

}
