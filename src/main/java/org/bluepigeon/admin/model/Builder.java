package org.bluepigeon.admin.model;
// Generated 27 Mar, 2017 5:55:47 PM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Builder generated by hbm2java
 */
@Entity
@Table(name = "builder", catalog = "blue_pigeon")
public class Builder implements java.io.Serializable {

	private Integer id;
	private String name;
	private String headOffice;
	private String email;
	private String mobile;
	private String aboutBuilder;
	private Byte status;
	private Set<BuilderProject> builderProjects = new HashSet<BuilderProject>(0);
	private Set<BuilderCompanyNames> builderCompanyNameses = new HashSet<BuilderCompanyNames>(0);
	private Set<BuilderFlatType> builderFlatTypes = new HashSet<BuilderFlatType>(0);

	public Builder() {
	}

	public Builder(String name, String headOffice, String email, String mobile, String aboutBuilder, Byte status,
			Set<BuilderProject> builderProjects, Set<BuilderCompanyNames> builderCompanyNameses,
			Set<BuilderFlatType> builderFlatTypes) {
		this.name = name;
		this.headOffice = headOffice;
		this.email = email;
		this.mobile = mobile;
		this.aboutBuilder = aboutBuilder;
		this.status = status;
		this.builderProjects = builderProjects;
		this.builderCompanyNameses = builderCompanyNameses;
		this.builderFlatTypes = builderFlatTypes;
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

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "head_office", length = 65535)
	public String getHeadOffice() {
		return this.headOffice;
	}

	public void setHeadOffice(String headOffice) {
		this.headOffice = headOffice;
	}

	@Column(name = "email", length = 65535)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "mobile", length = 65535)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "about_builder", length = 65535)
	public String getAboutBuilder() {
		return this.aboutBuilder;
	}

	public void setAboutBuilder(String aboutBuilder) {
		this.aboutBuilder = aboutBuilder;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builder")
	public Set<BuilderProject> getBuilderProjects() {
		return this.builderProjects;
	}

	public void setBuilderProjects(Set<BuilderProject> builderProjects) {
		this.builderProjects = builderProjects;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "builder")
	public Set<BuilderCompanyNames> getBuilderCompanyNameses() {
		return this.builderCompanyNameses;
	}

	public void setBuilderCompanyNameses(Set<BuilderCompanyNames> builderCompanyNameses) {
		this.builderCompanyNameses = builderCompanyNameses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builder")
	public Set<BuilderFlatType> getBuilderFlatTypes() {
		return this.builderFlatTypes;
	}

	public void setBuilderFlatTypes(Set<BuilderFlatType> builderFlatTypes) {
		this.builderFlatTypes = builderFlatTypes;
	}

}
