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
@Table(name = "flat_weightage", catalog = "blue_pigeon")
public class FlatWeightage {

	private Integer id;
	private BuilderFlat builderFlat;
	private FlatStage flatStage;
	private Double stageWeightage;
	private FlatSubstage flatSubstage;
	private Double substageWeightage;
	private Boolean status;

	public FlatWeightage() {
		
	}

	public FlatWeightage(
			BuilderFlat builderFlat, 
			FlatStage flatStage, 
			Double stageWeightage, 
			FlatSubstage flatSubstage,
			Double substageWeightage,
			Boolean status
	) {
		this.builderFlat = builderFlat;
		this.flatStage = flatStage;
		this.stageWeightage = stageWeightage;
		this.flatSubstage = flatSubstage;
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
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "stage_id")
	public FlatStage getFlatStage() {
		return flatStage;
	}

	public void setFlatStage(FlatStage flatStage) {
		this.flatStage = flatStage;
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
	public FlatSubstage getFlatSubstage() {
		return flatSubstage;
	}

	public void setFlatSubstage(FlatSubstage flatSubstage) {
		this.flatSubstage = flatSubstage;
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
