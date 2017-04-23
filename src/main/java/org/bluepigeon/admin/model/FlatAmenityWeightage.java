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
@Table(name = "flat_amenity_weightage", catalog = "blue_pigeon")
public class FlatAmenityWeightage {
	private Integer id;
	private BuilderFlat builderFlat;
	private BuilderFlatAmenity builderFlatAmenity;
	private Double amenityWeightage;
	private BuilderFlatAmenityStages builderFlatAmenityStages;
	private Double stageWeightage;
	private BuilderFlatAmenitySubstages builderFlatAmenitySubstages;
	private Double substageWeightage;
	private boolean status;
	
	public FlatAmenityWeightage() {
	}

	public FlatAmenityWeightage(
			BuilderFlat builderFlat, BuilderFlatAmenity builderFlatAmenity, 
			Double amenityWeightage, BuilderFlatAmenityStages builderFlatAmenityStages,
			Double stageWeightage, BuilderFlatAmenitySubstages builderFlatAmenitySubstages,
			Double substageWeightage, boolean status
	) {
		this.builderFlat = builderFlat;
		this.builderFlatAmenity = builderFlatAmenity;
		this.amenityWeightage = amenityWeightage;
		this.builderFlatAmenityStages = builderFlatAmenityStages;
		this.stageWeightage = stageWeightage;
		this.builderFlatAmenitySubstages = builderFlatAmenitySubstages;
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
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "amenity_id")
	public BuilderFlatAmenity getBuilderFlatAmenity() {
		return builderFlatAmenity;
	}

	public void setBuilderFlatAmenity(BuilderFlatAmenity builderFlatAmenity) {
		this.builderFlatAmenity = builderFlatAmenity;
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
	public BuilderFlatAmenityStages getBuilderFlatAmenityStages() {
		return builderFlatAmenityStages;
	}

	public void setBuilderFlatAmenityStages(
			BuilderFlatAmenityStages builderFlatAmenityStages) {
		this.builderFlatAmenityStages = builderFlatAmenityStages;
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
	public BuilderFlatAmenitySubstages getBuilderFlatAmenitySubstages() {
		return builderFlatAmenitySubstages;
	}

	public void setBuilderFlatAmenitySubstages(
			BuilderFlatAmenitySubstages builderFlatAmenitySubstages) {
		this.builderFlatAmenitySubstages = builderFlatAmenitySubstages;
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
