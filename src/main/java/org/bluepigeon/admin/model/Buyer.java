package org.bluepigeon.admin.model;

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

@Entity
@Table(name = "buyer", catalog = "blue_pigeon")
public class Buyer implements java.io.Serializable {

	private Integer id;
	private GlobalBuyer globalBuyer;
	private Builder builder;
	private BuilderEmployee builderEmployee;
	private BuilderProject builderProject;
	private BuilderBuilding builderBuilding;
	private BuilderFlat builderFlat;
	private boolean isPrimary;
	private String name;
	private String mobile;
	private String email;
	private String pancard;
	private String photo;
	private String address;
	private Short agreement;
	private Short possession;
	private Short isDeleted;
	private Short status;
	private Set<BuyerDocuments> buyerDocuments = new HashSet<BuyerDocuments>(0);
	
	public Buyer() {
	}

	public Buyer(
			GlobalBuyer globalBuyer, Builder builder, BuilderEmployee builderEmployee, BuilderProject builderProject,
			BuilderBuilding builderBuilding, BuilderFlat builderFlat, boolean isPrimary, String name, 
			String mobile, String email, String pancard, String photo, String address, Short agreement,
			Short possession, Short isDeleted, Short status, Set<BuyerDocuments> buyerDocuments
	) {
		this.globalBuyer = globalBuyer;
		this.builder = builder;
		this.builderEmployee = builderEmployee;
		this.builderProject = builderProject;
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.isPrimary = isPrimary;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.pancard = pancard;
		this.photo = photo;
		this.address = address;
		this.agreement = agreement;
		this.possession = possession;
		this.isDeleted = isDeleted;
		this.status = status;
		this.buyerDocuments = buyerDocuments;
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
	@JoinColumn(name = "user_id")
	public GlobalBuyer getGlobalBuyer() {
		return this.globalBuyer;
	}

	public void setGlobalBuyer(GlobalBuyer globalBuyer) {
		this.globalBuyer = globalBuyer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "emp_id")
	public BuilderEmployee getBuilderEmployee() {
		return this.builderEmployee;
	}

	public void setBuilderEmployee(BuilderEmployee builderEmployee) {
		this.builderEmployee = builderEmployee;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
	}

	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return this.builderFlat;
	}

	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}


	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@Column(name = "is_primary")
	public boolean getIsPrimary() {
		return this.isPrimary;
	}

	public void setIsPrimary(boolean isPrimary) {
		this.isPrimary = isPrimary;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "mobile", length = 12)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "email", length = 128)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "pancard", length = 10)
	public String getPancard() {
		return this.pancard;
	}

	public void setPancard(String pancard) {
		this.pancard = pancard;
	}
	
	@Column(name = "photo", length = 255)
	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Column(name = "address", length = 65535)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "agreement")
	public Short getAgreement() {
		return this.agreement;
	}

	public void setAgreement(Short agreement) {
		this.agreement = agreement;
	}

	@Column(name = "possession")
	public Short getPossession() {
		return this.possession;
	}

	public void setPossession(Short possession) {
		this.possession = possession;
	}

	@Column(name = "is_deleted")
	public Short getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Short isDeleted) {
		this.isDeleted = isDeleted;
	}

	@Column(name = "status")
	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "buyer")
	public Set<BuyerDocuments> getBuyerDocuments() {
		return this.buyerDocuments;
	}

	public void setBuyerDocuments(Set<BuyerDocuments> buyerDocuments) {
		this.buyerDocuments = buyerDocuments;
	}
	
}