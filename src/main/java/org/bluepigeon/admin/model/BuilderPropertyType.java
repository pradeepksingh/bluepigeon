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
 * BuilderPropertyType generated by hbm2java
 */
@Entity
@Table(name = "builder_property_type", catalog = "blue_pigeon")
public class BuilderPropertyType implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Set<BuilderProjectPropertyType> builderProjectPropertyTypes = new HashSet<BuilderProjectPropertyType>(0);
	private Set<BuilderLead> builderLeads = new HashSet<BuilderLead>(0);

	public BuilderPropertyType() {
	}

	public BuilderPropertyType(String name, Byte status, Set<BuilderProjectPropertyType> builderProjectPropertyTypes,
			Set<BuilderLead> builderLeads) {
		this.name = name;
		this.status = status;
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
		this.builderLeads = builderLeads;
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

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderPropertyType")
	public Set<BuilderProjectPropertyType> getBuilderProjectPropertyTypes() {
		return this.builderProjectPropertyTypes;
	}

	public void setBuilderProjectPropertyTypes(Set<BuilderProjectPropertyType> builderProjectPropertyTypes) {
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderPropertyType")
	public Set<BuilderLead> getBuilderLeads() {
		return this.builderLeads;
	}

	public void setBuilderLeads(Set<BuilderLead> builderLeads) {
		this.builderLeads = builderLeads;
	}

}
