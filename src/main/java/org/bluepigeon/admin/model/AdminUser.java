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
 * AdminUser generated by hbm2java
 */
@Entity
@Table(name = "admin_user", catalog = "blue_pigeon")
public class AdminUser implements java.io.Serializable {

	private Integer id;
	private AdminUserRole adminUserRole;
	private String name;
	private String email;
	private String password;
	private String mobile;
	private int status;
	private Date createdDate;
	private Long createdBy;
	private Set<BuilderFlatType> builderFlatTypes = new HashSet<BuilderFlatType>(0);
	private Set<BuilderLead> builderLeads = new HashSet<BuilderLead>(0);
	private Set<BuilderBuilding> builderBuildings = new HashSet<BuilderBuilding>(0);
	private Set<BuilderFlat> builderFlats = new HashSet<BuilderFlat>(0);
	private Set<BuilderProject> builderProjects = new HashSet<BuilderProject>(0);

	public AdminUser() {
	}

	public AdminUser(AdminUserRole adminUserRole, String name, String email, String password, String mobile, int status,
			Date createdDate) {
		this.adminUserRole = adminUserRole;
		this.name = name;
		this.email = email;
		this.password = password;
		this.mobile = mobile;
		this.status = status;
		this.createdDate = createdDate;
	}

	public AdminUser(AdminUserRole adminUserRole, String name, String email, String password, String mobile, int status,
			Date createdDate, Long createdBy, Set<BuilderFlatType> builderFlatTypes, Set<BuilderLead> builderLeads,
			Set<BuilderBuilding> builderBuildings, Set<BuilderFlat> builderFlats, Set<BuilderProject> builderProjects) {
		this.adminUserRole = adminUserRole;
		this.name = name;
		this.email = email;
		this.password = password;
		this.mobile = mobile;
		this.status = status;
		this.createdDate = createdDate;
		this.createdBy = createdBy;
		this.builderFlatTypes = builderFlatTypes;
		this.builderLeads = builderLeads;
		this.builderBuildings = builderBuildings;
		this.builderFlats = builderFlats;
		this.builderProjects = builderProjects;
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
	@JoinColumn(name = "role_id", nullable = false)
	public AdminUserRole getAdminUserRole() {
		return this.adminUserRole;
	}

	public void setAdminUserRole(AdminUserRole adminUserRole) {
		this.adminUserRole = adminUserRole;
	}

	@Column(name = "name", nullable = false, length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "email", nullable = false, length = 128)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password", nullable = false, length = 128)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "mobile", nullable = false, length = 10)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "status", nullable = false)
	public int getStatus() {
		return this.status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "created_date", nullable = false, length = 10)
	public Date getCreatedDate() {
		return this.createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	@Column(name = "created_by")
	public Long getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "adminUser")
	public Set<BuilderFlatType> getBuilderFlatTypes() {
		return this.builderFlatTypes;
	}

	public void setBuilderFlatTypes(Set<BuilderFlatType> builderFlatTypes) {
		this.builderFlatTypes = builderFlatTypes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "adminUser")
	public Set<BuilderLead> getBuilderLeads() {
		return this.builderLeads;
	}

	public void setBuilderLeads(Set<BuilderLead> builderLeads) {
		this.builderLeads = builderLeads;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "adminUser")
	public Set<BuilderBuilding> getBuilderBuildings() {
		return this.builderBuildings;
	}

	public void setBuilderBuildings(Set<BuilderBuilding> builderBuildings) {
		this.builderBuildings = builderBuildings;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "adminUser")
	public Set<BuilderFlat> getBuilderFlats() {
		return this.builderFlats;
	}

	public void setBuilderFlats(Set<BuilderFlat> builderFlats) {
		this.builderFlats = builderFlats;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "adminUser")
	public Set<BuilderProject> getBuilderProjects() {
		return this.builderProjects;
	}

	public void setBuilderProjects(Set<BuilderProject> builderProjects) {
		this.builderProjects = builderProjects;
	}

}
