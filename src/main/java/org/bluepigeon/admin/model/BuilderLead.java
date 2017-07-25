package org.bluepigeon.admin.model;
// Generated 29 Mar, 2017 11:09:39 PM by Hibernate Tools 4.0.0

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
 * BuilderLead generated by hbm2java
 */
@Entity
@Table(name = "builder_lead", catalog = "blue_pigeon")
public class BuilderLead implements java.io.Serializable {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderFlat builderFlat;
	private BuilderProject builderProject;
	private BuilderPropertyType builderPropertyType;
	private String name;
	private String mobile;
	private String email;
	private String area;
	private String city;
	private Source source;
	private Integer intrestedIn;
	private String discountOffered;
	private Integer addedBy;
	private Integer status;

	public BuilderLead() {
	}

	public BuilderLead(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	public BuilderLead(BuilderBuilding builderBuilding, BuilderFlat builderFlat, BuilderProject builderProject,
			BuilderPropertyType builderPropertyType, String name, String mobile, String email, String area, String city,
			Source source, Integer intrestedIn, String discountOffered, Integer addedBy, Integer status) {
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
		this.builderPropertyType = builderPropertyType;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.area = area;
		this.city = city;
		this.source = source;
		this.intrestedIn = intrestedIn;
		this.discountOffered = discountOffered;
		this.addedBy = addedBy;
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
	@JoinColumn(name = "project_id", nullable = false)
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "type_id")
	public BuilderPropertyType getBuilderPropertyType() {
		return this.builderPropertyType;
	}

	public void setBuilderPropertyType(BuilderPropertyType builderPropertyType) {
		this.builderPropertyType = builderPropertyType;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "mobile", length = 225)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "email", length = 225)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "area", length = 128)
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "city", length = 128)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "source")
	public Source getSource() {
		return this.source;
	}

	public void setSource(Source source) {
		this.source = source;
	}

	@Column(name = "intrested_in")
	public Integer getIntrestedIn() {
		return this.intrestedIn;
	}

	public void setIntrestedIn(Integer intrestedIn) {
		this.intrestedIn = intrestedIn;
	}

	@Column(name = "discount_offered", length = 65535)
	public String getDiscountOffered() {
		return this.discountOffered;
	}

	public void setDiscountOffered(String discountOffered) {
		this.discountOffered = discountOffered;
	}

	@Column(name = "added_by")
	public Integer getAddedBy() {
		return this.addedBy;
	}

	public void setAddedBy(Integer addedBy) {
		this.addedBy = addedBy;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
