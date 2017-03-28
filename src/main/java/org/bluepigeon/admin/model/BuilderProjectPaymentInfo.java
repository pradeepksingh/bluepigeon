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
 * BuilderProjectPaymentInfo generated by hbm2java
 */
@Entity
@Table(name = "builder_project_payment_info", catalog = "blue_pigeon")
public class BuilderProjectPaymentInfo implements java.io.Serializable {

	private Integer id;
	private BuilderProject builderProject;
	private String schedule;
	private Double payable;
	private Double amount;
	private Byte status;

	public BuilderProjectPaymentInfo() {
	}

	public BuilderProjectPaymentInfo(BuilderProject builderProject, String schedule, Double payable, Double amount,
			Byte status) {
		this.builderProject = builderProject;
		this.schedule = schedule;
		this.payable = payable;
		this.amount = amount;
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
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@Column(name = "schedule", length = 128)
	public String getSchedule() {
		return this.schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	@Column(name = "payable", precision = 22, scale = 0)
	public Double getPayable() {
		return this.payable;
	}

	public void setPayable(Double payable) {
		this.payable = payable;
	}

	@Column(name = "amount", precision = 22, scale = 0)
	public Double getAmount() {
		return this.amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

}
