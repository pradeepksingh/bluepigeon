package org.bluepigeon.admin.model;
// Generated 16 May, 2017 11:21:31 PM by Hibernate Tools 4.0.0

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
 * FlatSubstage generated by hbm2java
 */
@Entity
@Table(name = "flat_substage", catalog = "blue_pigeon")
public class FlatSubstage implements java.io.Serializable {

	private Integer id;
	private FlatStage flatStage;
	private String name;
	private Byte status;
	private Byte isDeleted=0;

	public FlatSubstage() {
	}

	public FlatSubstage(FlatStage flatStage) {
		this.flatStage = flatStage;
	}

	public FlatSubstage(FlatStage flatStage, String name, Byte status, Byte isDeleted) {
		this.flatStage = flatStage;
		this.name = name;
		this.status = status;
		this.isDeleted = isDeleted;
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
	@JoinColumn(name = "stage_id", nullable = false)
	public FlatStage getFlatStage() {
		return this.flatStage;
	}

	public void setFlatStage(FlatStage flatStage) {
		this.flatStage = flatStage;
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

}
