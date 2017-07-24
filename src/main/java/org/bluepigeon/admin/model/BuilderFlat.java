package org.bluepigeon.admin.model;
// Generated 27 Mar, 2017 5:55:47 PM by Hibernate Tools 4.0.0

import java.util.Date;
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
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * BuilderFlat generated by hbm2java
 */
@Entity
@Table(name = "builder_flat", catalog = "blue_pigeon")
public class BuilderFlat implements java.io.Serializable {

	private Integer id;
	private BuilderFlatType builderFlatType;
	private AdminUser adminUser;
	private BuilderFloor builderFloor;
	private BuilderFlatStatus builderFlatStatus;
	private String flatNo;
	private Integer bedroom;
	private Integer bathroom;
	private Integer balcony;
	private Double totalInventory;
	private Double inventorySold;
	private Double revenue;
	private Double completionStatus = 0.0;
	private Date possessionDate;
	private Double amenityWeightage = 0.0;
	private Double weightage = 0.0;
	private Byte status;
	private String image = "";
	private Set<BuilderLead> builderLeads = new HashSet<BuilderLead>(0);

	public BuilderFlat() {
	}

	public BuilderFlat(BuilderFlatType builderFlatType, AdminUser adminUser, BuilderFloor builderFloor,
			BuilderFlatStatus builderFlatStatus, String flatNo, Integer bedroom, Integer bathroom, Integer balcony,
			Double totalInventory, Double inventorySold, Double revenue, Date possessionDate, Byte status,
			Set<BuilderLead> builderLeads, Double completionStatus, Double weightage, Double amenityWeightage, String image) {
		this.builderFlatType = builderFlatType;
		this.adminUser = adminUser;
		this.builderFloor = builderFloor;
		this.builderFlatStatus = builderFlatStatus;
		this.flatNo = flatNo;
		this.bedroom = bedroom;
		this.bathroom = bathroom;
		this.balcony = balcony;
		this.totalInventory = totalInventory;
		this.inventorySold = inventorySold;
		this.revenue = revenue;
		this.completionStatus = completionStatus;
		this.possessionDate = possessionDate;
		this.status = status;
		this.builderLeads = builderLeads;
		this.weightage = weightage;
		this.amenityWeightage = amenityWeightage;
		this.image = image;
	}
	
	@PrePersist
	public void prePersist() {
	    if(completionStatus == null) 
	    	completionStatus = 0.0;
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
	@JoinColumn(name = "flat_type_id")
	public BuilderFlatType getBuilderFlatType() {
		return this.builderFlatType;
	}

	public void setBuilderFlatType(BuilderFlatType builderFlatType) {
		this.builderFlatType = builderFlatType;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "emp_id")
	public AdminUser getAdminUser() {
		return this.adminUser;
	}

	public void setAdminUser(AdminUser adminUser) {
		this.adminUser = adminUser;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "floor_no")
	public BuilderFloor getBuilderFloor() {
		return this.builderFloor;
	}

	public void setBuilderFloor(BuilderFloor builderFloor) {
		this.builderFloor = builderFloor;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "status_id")
	public BuilderFlatStatus getBuilderFlatStatus() {
		return this.builderFlatStatus;
	}

	public void setBuilderFlatStatus(BuilderFlatStatus builderFlatStatus) {
		this.builderFlatStatus = builderFlatStatus;
	}

	@Column(name = "flat_no", length = 128)
	public String getFlatNo() {
		return this.flatNo;
	}

	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}

	@Column(name = "bedroom", length = 225)
	public Integer getBedroom() {
		return this.bedroom;
	}

	public void setBedroom(Integer bedroom) {
		this.bedroom = bedroom;
	}

	@Column(name = "bathroom", length = 225)
	public Integer getBathroom() {
		return this.bathroom;
	}

	public void setBathroom(Integer bathroom) {
		this.bathroom = bathroom;
	}

	@Column(name = "balcony", length = 225)
	public Integer getBalcony() {
		return this.balcony;
	}

	public void setBalcony(Integer balcony) {
		this.balcony = balcony;
	}

	@Column(name = "total_inventory", precision = 22, scale = 0)
	public Double getTotalInventory() {
		return this.totalInventory;
	}

	public void setTotalInventory(Double totalInventory) {
		this.totalInventory = totalInventory;
	}

	@Column(name = "inventory_sold", precision = 22, scale = 0)
	public Double getInventorySold() {
		return this.inventorySold;
	}

	public void setInventorySold(Double inventorySold) {
		this.inventorySold = inventorySold;
	}

	@Column(name = "revenue", precision = 22, scale = 0)
	public Double getRevenue() {
		return this.revenue;
	}

	public void setRevenue(Double revenue) {
		this.revenue = revenue;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "possession_date", length = 10)
	public Date getPossessionDate() {
		return this.possessionDate;
	}

	public void setPossessionDate(Date possessionDate) {
		this.possessionDate = possessionDate;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderFlat")
	public Set<BuilderLead> getBuilderLeads() {
		return this.builderLeads;
	}

	public void setBuilderLeads(Set<BuilderLead> builderLeads) {
		this.builderLeads = builderLeads;
	}

	@Column(name = "completion_status", columnDefinition = "Decimal(10,2) default '100.00'")
	public Double getCompletionStatus() {
		return this.completionStatus;
	}

	public void setCompletionStatus(Double completionStatus) {
		this.completionStatus = completionStatus;
	}
	@Column(name = "weightage", precision = 22, scale = 0)
	public Double getWeightage() {
		return weightage;
	}

	public void setWeightage(Double weightage) {
		this.weightage = weightage;
	}
	@Column(name = "amenity_weightage", precision = 22, scale = 0)
	public Double getAmenityWeightage() {
		return amenityWeightage;
	}

	public void setAmenityWeightage(Double amenityWeightage) {
		this.amenityWeightage = amenityWeightage;
	}
	@Column(name = "image", length=225)
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	

}
