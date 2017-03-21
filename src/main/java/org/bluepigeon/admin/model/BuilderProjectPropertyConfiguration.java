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
 * BuilderProjectPropertyConfiguration generated by hbm2java
 */
@Entity
@Table(name = "builder_project_property_configuration", catalog = "blue_pigeon")
public class BuilderProjectPropertyConfiguration implements java.io.Serializable {

	private Integer id;
	private String name;
	private Byte status;
	private Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = new HashSet<BuilderProjectPropertyConfigurationInfo>(
			0);

	public BuilderProjectPropertyConfiguration() {
	}

	public BuilderProjectPropertyConfiguration(String name, Byte status,
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos) {
		this.name = name;
		this.status = status;
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderProjectPropertyConfiguration")
	public Set<BuilderProjectPropertyConfigurationInfo> getBuilderProjectPropertyConfigurationInfos() {
		return this.builderProjectPropertyConfigurationInfos;
	}

	public void setBuilderProjectPropertyConfigurationInfos(
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos) {
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
	}

}
