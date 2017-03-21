package org.bluepigeon.admin.model;
// Generated 16 Mar, 2017 3:30:20 PM by Hibernate Tools 4.0.0

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
 * BuilderProjectType generated by hbm2java
 */
@Entity
@Table(name = "builder_project_type", catalog = "blue_pigeon")
public class BuilderProjectType implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Set<BuilderProjectProjectType> builderProjectProjectTypes = new HashSet<BuilderProjectProjectType>(0);

	public BuilderProjectType() {
	}

	public BuilderProjectType(String name, Byte status, Set<BuilderProjectProjectType> builderProjectProjectTypes) {
		this.name = name;
		this.status = status;
		this.builderProjectProjectTypes = builderProjectProjectTypes;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProjectType")
	public Set<BuilderProjectProjectType> getBuilderProjectProjectTypes() {
		return this.builderProjectProjectTypes;
	}

	public void setBuilderProjectProjectTypes(Set<BuilderProjectProjectType> builderProjectProjectTypes) {
		this.builderProjectProjectTypes = builderProjectProjectTypes;
	}

}
