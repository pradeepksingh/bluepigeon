package org.bluepigeon.admin.model;
// Generated 27 Mar, 2017 5:55:47 PM by Hibernate Tools 4.0.0

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
 * BuilderPaymentSubstages generated by hbm2java
 */
@Entity
@Table(name = "builder_payment_substages", catalog = "blue_pigeon")
public class BuilderPaymentSubstages implements java.io.Serializable {

	private Integer id;
	private BuilderPaymentStages builderPaymentStages;
	private String name;
	private Byte status;

	public BuilderPaymentSubstages() {
	}

	public BuilderPaymentSubstages(BuilderPaymentStages builderPaymentStages, String name, Byte status) {
		this.builderPaymentStages = builderPaymentStages;
		this.name = name;
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "payment_id")
	public BuilderPaymentStages getBuilderPaymentStages() {
		return this.builderPaymentStages;
	}

	public void setBuilderPaymentStages(BuilderPaymentStages builderPaymentStages) {
		this.builderPaymentStages = builderPaymentStages;
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

}
