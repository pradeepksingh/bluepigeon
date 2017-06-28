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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * BuilderProject generated by hbm2java
 */
@Entity
@Table(name = "builder_project", catalog = "blue_pigeon")
public class BuilderProject implements java.io.Serializable {

	private Integer id;
	private State state;
	private AdminUser adminUser;
	private AreaUnit areaUnit;
	private Country country;
	private Locality locality;
	private City city;
	private Builder builder;
	private BuilderCompanyNames builderCompanyNames;
	private String name;
	private String addr1;
	private String addr2;
	private String pincode;
	private String latitude;
	private String longitude;
	private Double projectArea;
	private String description;
	private String highlights;
	private Date launchDate;
	private Date possessionDate;
	private Double totalInventory = 0.0;
	private Double inventorySold =0.0;
	private Integer availbale = 0;
	private Double revenue = 0.0;
	private Double completionStatus = 0.0;
	private Byte status;
	private Set<BuilderBuilding> builderBuildings = new HashSet<BuilderBuilding>(0);
	private Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = new HashSet<BuilderProjectPropertyConfigurationInfo>(
			0);
	private Set<ProjectPanoramicImage> projectPanoramicImages = new HashSet<ProjectPanoramicImage>(0);
	private Set<BuilderProjectPriceInfo> builderProjectPriceInfos = new HashSet<BuilderProjectPriceInfo>(0);
	private Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new HashSet<BuilderProjectPaymentInfo>(0);
	private Set<ProjectImageGallery> projectImageGalleries = new HashSet<ProjectImageGallery>(0);
	private Set<BuilderProjectPropertyType> builderProjectPropertyTypes = new HashSet<BuilderProjectPropertyType>(0);
	private Set<BuilderProjectOfferInfo> builderProjectOfferInfos = new HashSet<BuilderProjectOfferInfo>(0);
	private Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = new HashSet<BuilderProjectAmenityInfo>(0);
	private Set<BuilderProjectBankInfo> builderProjectBankInfos = new HashSet<BuilderProjectBankInfo>(0);
	private Set<BuilderProjectProjectType> builderProjectProjectTypes = new HashSet<BuilderProjectProjectType>(0);
	private Set<BuilderFlatType> builderFlatTypes = new HashSet<BuilderFlatType>(0);
	private Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = new HashSet<BuilderProjectApprovalInfo>(0);

	public BuilderProject() {
	}

	public BuilderProject(State state, AdminUser adminUser, AreaUnit areaUnit, Country country, Locality locality,
			City city, Builder builder, BuilderCompanyNames builderCompanyNames, String name, String addr1,
			String addr2, String pincode, String latitude, String longitude, Double projectArea, String description,
			String highlights, Date launchDate, Date possessionDate, Double totalInventory, Double inventorySold,
			Double revenue, Byte status, Set<BuilderBuilding> builderBuildings,
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos,
			Set<ProjectPanoramicImage> projectPanoramicImages, Set<BuilderProjectPriceInfo> builderProjectPriceInfos,
			Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos, Set<ProjectImageGallery> projectImageGalleries,
			Set<BuilderProjectPropertyType> builderProjectPropertyTypes,
			Set<BuilderProjectOfferInfo> builderProjectOfferInfos,
			Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos,
			Set<BuilderProjectBankInfo> builderProjectBankInfos,
			Set<BuilderProjectProjectType> builderProjectProjectTypes, Set<BuilderFlatType> builderFlatTypes,
			Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos, Double completionStatus, Integer availbale) {
		this.state = state;
		this.adminUser = adminUser;
		this.areaUnit = areaUnit;
		this.country = country;
		this.locality = locality;
		this.city = city;
		this.builder = builder;
		this.builderCompanyNames = builderCompanyNames;
		this.name = name;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.pincode = pincode;
		this.latitude = latitude;
		this.longitude = longitude;
		this.projectArea = projectArea;
		this.description = description;
		this.highlights = highlights;
		this.launchDate = launchDate;
		this.possessionDate = possessionDate;
		this.totalInventory = totalInventory;
		this.inventorySold = inventorySold;
		this.revenue = revenue;
		this.status = status;
		this.builderBuildings = builderBuildings;
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
		this.projectPanoramicImages = projectPanoramicImages;
		this.builderProjectPriceInfos = builderProjectPriceInfos;
		this.builderProjectPaymentInfos = builderProjectPaymentInfos;
		this.projectImageGalleries = projectImageGalleries;
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
		this.builderProjectOfferInfos = builderProjectOfferInfos;
		this.builderProjectAmenityInfos = builderProjectAmenityInfos;
		this.builderProjectBankInfos = builderProjectBankInfos;
		this.builderProjectProjectTypes = builderProjectProjectTypes;
		this.builderFlatTypes = builderFlatTypes;
		this.builderProjectApprovalInfos = builderProjectApprovalInfos;
		this.completionStatus = completionStatus;
		this.revenue = revenue;
		this.availbale = availbale;
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
	@JoinColumn(name = "state_id")
	public State getState() {
		return this.state;
	}

	public void setState(State state) {
		this.state = state;
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
	@JoinColumn(name = "area_unit_id")
	public AreaUnit getAreaUnit() {
		return this.areaUnit;
	}

	public void setAreaUnit(AreaUnit areaUnit) {
		this.areaUnit = areaUnit;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "country_id")
	public Country getCountry() {
		return this.country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "area_id")
	public Locality getLocality() {
		return this.locality;
	}

	public void setLocality(Locality locality) {
		this.locality = locality;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "city_id")
	public City getCity() {
		return this.city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "group_id")
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "company_id")
	public BuilderCompanyNames getBuilderCompanyNames() {
		return this.builderCompanyNames;
	}

	public void setBuilderCompanyNames(BuilderCompanyNames builderCompanyNames) {
		this.builderCompanyNames = builderCompanyNames;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "addr_1", length = 65535)
	public String getAddr1() {
		return this.addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	@Column(name = "addr_2", length = 65535)
	public String getAddr2() {
		return this.addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	@Column(name = "pincode", length = 6)
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Column(name = "latitude", length = 128)
	public String getLatitude() {
		return this.latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	@Column(name = "longitude", length = 128)
	public String getLongitude() {
		return this.longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	@Column(name = "project_area", precision = 22, scale = 0)
	public Double getProjectArea() {
		return this.projectArea;
	}

	public void setProjectArea(Double projectArea) {
		this.projectArea = projectArea;
	}

	@Column(name = "description", length = 65535)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "highlights", length = 65535)
	public String getHighlights() {
		return this.highlights;
	}

	public void setHighlights(String highlights) {
		this.highlights = highlights;
	}

	@Column(name = "availbale")
	public Integer getAvailbale() {
		return availbale;
	}

	public void setAvailbale(Integer availbale) {
		this.availbale = availbale;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "launch_date", length = 10)
	public Date getLaunchDate() {
		return this.launchDate;
	}

	public void setLaunchDate(Date launchDate) {
		this.launchDate = launchDate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "possession_date", length = 10)
	public Date getPossessionDate() {
		return this.possessionDate;
	}

	public void setPossessionDate(Date possessionDate) {
		this.possessionDate = possessionDate;
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

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderBuilding> getBuilderBuildings() {
		return this.builderBuildings;
	}

	public void setBuilderBuildings(Set<BuilderBuilding> builderBuildings) {
		this.builderBuildings = builderBuildings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectPropertyConfigurationInfo> getBuilderProjectPropertyConfigurationInfos() {
		return this.builderProjectPropertyConfigurationInfos;
	}

	public void setBuilderProjectPropertyConfigurationInfos(
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos) {
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<ProjectPanoramicImage> getProjectPanoramicImages() {
		return this.projectPanoramicImages;
	}

	public void setProjectPanoramicImages(Set<ProjectPanoramicImage> projectPanoramicImages) {
		this.projectPanoramicImages = projectPanoramicImages;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectPriceInfo> getBuilderProjectPriceInfos() {
		return this.builderProjectPriceInfos;
	}

	public void setBuilderProjectPriceInfos(Set<BuilderProjectPriceInfo> builderProjectPriceInfos) {
		this.builderProjectPriceInfos = builderProjectPriceInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectPaymentInfo> getBuilderProjectPaymentInfos() {
		return this.builderProjectPaymentInfos;
	}

	public void setBuilderProjectPaymentInfos(Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos) {
		this.builderProjectPaymentInfos = builderProjectPaymentInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<ProjectImageGallery> getProjectImageGalleries() {
		return this.projectImageGalleries;
	}

	public void setProjectImageGalleries(Set<ProjectImageGallery> projectImageGalleries) {
		this.projectImageGalleries = projectImageGalleries;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectPropertyType> getBuilderProjectPropertyTypes() {
		return this.builderProjectPropertyTypes;
	}

	public void setBuilderProjectPropertyTypes(Set<BuilderProjectPropertyType> builderProjectPropertyTypes) {
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectOfferInfo> getBuilderProjectOfferInfos() {
		return this.builderProjectOfferInfos;
	}

	public void setBuilderProjectOfferInfos(Set<BuilderProjectOfferInfo> builderProjectOfferInfos) {
		this.builderProjectOfferInfos = builderProjectOfferInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectAmenityInfo> getBuilderProjectAmenityInfos() {
		return this.builderProjectAmenityInfos;
	}

	public void setBuilderProjectAmenityInfos(Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos) {
		this.builderProjectAmenityInfos = builderProjectAmenityInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectBankInfo> getBuilderProjectBankInfos() {
		return this.builderProjectBankInfos;
	}

	public void setBuilderProjectBankInfos(Set<BuilderProjectBankInfo> builderProjectBankInfos) {
		this.builderProjectBankInfos = builderProjectBankInfos;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectProjectType> getBuilderProjectProjectTypes() {
		return this.builderProjectProjectTypes;
	}

	public void setBuilderProjectProjectTypes(Set<BuilderProjectProjectType> builderProjectProjectTypes) {
		this.builderProjectProjectTypes = builderProjectProjectTypes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderFlatType> getBuilderFlatTypes() {
		return this.builderFlatTypes;
	}

	public void setBuilderFlatTypes(Set<BuilderFlatType> builderFlatTypes) {
		this.builderFlatTypes = builderFlatTypes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProject")
	public Set<BuilderProjectApprovalInfo> getBuilderProjectApprovalInfos() {
		return this.builderProjectApprovalInfos;
	}

	public void setBuilderProjectApprovalInfos(Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos) {
		this.builderProjectApprovalInfos = builderProjectApprovalInfos;
	}
	
	@Column(name = "completion_status", precision = 22, scale = 0)
	public Double getCompletionStatus() {
		return this.completionStatus;
	}

	public void setCompletionStatus(Double completionStatus) {
		this.completionStatus = completionStatus;
	}

}
