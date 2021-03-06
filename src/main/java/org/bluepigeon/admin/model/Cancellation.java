package org.bluepigeon.admin.model;
// Generated 11 May, 2017 11:55:53 AM by Hibernate Tools 4.0.0

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
 * Cancellation generated by hbm2java
 */
@Entity
@Table(name = "cancellation", catalog = "blue_pigeon")
public class Cancellation implements java.io.Serializable {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderFlat builderFlat;
	private BuilderProject builderProject;
	private String buyerName;
	private String panCard;
	private String buyerContact;
	private String reason;
	private Double charges;
	private boolean isApproved = false;
	private Integer cancelStatus =0;
    private Integer buyerId = 0;
	public Cancellation() {
	}

	public Cancellation(BuilderBuilding builderBuilding, BuilderFlat builderFlat, BuilderProject builderProject) {
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
	}

	public Cancellation(BuilderBuilding builderBuilding, BuilderFlat builderFlat, BuilderProject builderProject,
			String buyerName, String panCard, String buyerContact, String reason, Double charges, Boolean isApproved, Integer cancelStatus,Integer buyerId) {
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
		this.buyerName = buyerName;
		this.panCard = panCard;
		this.buyerContact = buyerContact;
		this.reason = reason;
		this.charges = charges;
		this.isApproved = isApproved;
		this.cancelStatus = cancelStatus;
		this.buyerId = buyerId;
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
	@JoinColumn(name = "building_id", nullable = false)
	public BuilderBuilding getBuilderBuilding() {
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "flat_id", nullable = false)
	public BuilderFlat getBuilderFlat() {
		return this.builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id", nullable = false)
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@Column(name = "buyer_name", length = 128)
	public String getBuyerName() {
		return this.buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	@Column(name = "pan_card", length = 10)
	public String getPanCard() {
		return this.panCard;
	}

	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}

	@Column(name = "buyer_contact", length = 10)
	public String getBuyerContact() {
		return this.buyerContact;
	}

	public void setBuyerContact(String buyerContact) {
		this.buyerContact = buyerContact;
	}

	@Column(name = "reason", length = 65535)
	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Column(name = "charges", precision = 22, scale = 0)
	public Double getCharges() {
		return this.charges;
	}

	public void setCharges(Double charges) {
		this.charges = charges;
	}
	@Column(name = "is_approved")
	public boolean isApproved() {
		return isApproved;
	}

	public void setApproved(boolean isApproved) {
		this.isApproved = isApproved;
	}
	@Column(name = "cancel_status")
	public Integer getCancelStatus() {
		return cancelStatus;
	}

	public void setCancelStatus(Integer cancelStatus) {
		this.cancelStatus = cancelStatus;
	}
	@Column(name = "buyer_id")
	public Integer getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
	}
	
	
}
