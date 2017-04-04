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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * BuilderCompanyNames generated by hbm2java
 */
@Entity
@Table(name = "builder_company_names", catalog = "blue_pigeon")
public class BuilderCompanyNames implements java.io.Serializable {

	private Integer id;
	private Builder builder;
	private String name;
	private String contact;
	private String email;
	//private Set<BuilderProject> builderProjects = new HashSet<BuilderProject>(0);

	public BuilderCompanyNames() {
	}

	public BuilderCompanyNames(Builder builder, String name, String contact, String email){
			//Set<BuilderProject> builderProjects) {
		this.builder = builder;
		this.name = name;
		this.contact = contact;
		this.email = email;
		//this.builderProjects = builderProjects;
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
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "contact", length = 10)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "email", length = 65535)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderCompanyNames")
//	public Set<BuilderProject> getBuilderProjects() {
//		return this.builderProjects;
//	}
//
//	public void setBuilderProjects(Set<BuilderProject> builderProjects) {
//		this.builderProjects = builderProjects;
//	}

}
