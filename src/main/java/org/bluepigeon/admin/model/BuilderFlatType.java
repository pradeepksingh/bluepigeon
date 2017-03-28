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
 * BuilderFlatType generated by hbm2java
 */
@Entity
@Table(name = "builder_flat_type", catalog = "blue_pigeon")
public class BuilderFlatType implements java.io.Serializable {

	private Integer id;
	private Builder builder;
	private AdminUser adminUser;
	private BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration;
	private BuilderProject builderProject;
	private String name;
	private String superBuiltUp;
	private String builtUp;
	private Double carpetArea;
	private String dryBalcony;
	private Byte status;
	private Set<BuilderFlat> builderFlats = new HashSet<BuilderFlat>(0);

	public BuilderFlatType() {
	}

	public BuilderFlatType(Builder builder, AdminUser adminUser,
			BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration, BuilderProject builderProject,
			String name, String superBuiltUp, String builtUp, Double carpetArea, String dryBalcony, Byte status,
			Set<BuilderFlat> builderFlats) {
		this.builder = builder;
		this.adminUser = adminUser;
		this.builderProjectPropertyConfiguration = builderProjectPropertyConfiguration;
		this.builderProject = builderProject;
		this.name = name;
		this.superBuiltUp = superBuiltUp;
		this.builtUp = builtUp;
		this.carpetArea = carpetArea;
		this.dryBalcony = dryBalcony;
		this.status = status;
		this.builderFlats = builderFlats;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "emp_id")
	public AdminUser getAdminUser() {
		return this.adminUser;
	}

	public void setAdminUser(AdminUser adminUser) {
		this.adminUser = adminUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "config_id")
	public BuilderProjectPropertyConfiguration getBuilderProjectPropertyConfiguration() {
		return this.builderProjectPropertyConfiguration;
	}

	public void setBuilderProjectPropertyConfiguration(
			BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration) {
		this.builderProjectPropertyConfiguration = builderProjectPropertyConfiguration;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "super_built_up", length = 225)
	public String getSuperBuiltUp() {
		return this.superBuiltUp;
	}

	public void setSuperBuiltUp(String superBuiltUp) {
		this.superBuiltUp = superBuiltUp;
	}

	@Column(name = "built_up", length = 225)
	public String getBuiltUp() {
		return this.builtUp;
	}

	public void setBuiltUp(String builtUp) {
		this.builtUp = builtUp;
	}

	@Column(name = "carpet_area", precision = 22, scale = 0)
	public Double getCarpetArea() {
		return this.carpetArea;
	}

	public void setCarpetArea(Double carpetArea) {
		this.carpetArea = carpetArea;
	}

	@Column(name = "dry_balcony", length = 128)
	public String getDryBalcony() {
		return this.dryBalcony;
	}

	public void setDryBalcony(String dryBalcony) {
		this.dryBalcony = dryBalcony;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "builderFlatType")
	public Set<BuilderFlat> getBuilderFlats() {
		return this.builderFlats;
	}

	public void setBuilderFlats(Set<BuilderFlat> builderFlats) {
		this.builderFlats = builderFlats;
	}

}
