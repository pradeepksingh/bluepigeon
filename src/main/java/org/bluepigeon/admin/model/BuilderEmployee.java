package org.bluepigeon.admin.model;

import java.awt.geom.Area;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "builder_employee", catalog = "blue_pigeon")
public class BuilderEmployee implements java.io.Serializable {

	private Integer id;
	private String name;
	private String mobile;
	private String email;
	private String password;
	private String currentAddress;
	private String permanentAddress;
	private String designation;
	private Builder builder;
	private BuilderEmployee builderEmployee;
	private BuilderEmployeeAccessType builderEmployeeAccessType;
	private String employeeId;
	private BuilderProject builderProject;
	private City city;
	private Locality locality;
	private boolean status;
	private int loginStatus;

	public BuilderEmployee() {
	}

	public BuilderEmployee(String name, String mobile, String email, String currentAddress, String permanentAddress,
			String designation, BuilderEmployee builderEmployee, BuilderEmployeeAccessType builderEmployeeAccessType,
			Builder builder, String employeeId, BuilderProject builderProject, City city, Locality locality, boolean status
	) {
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.currentAddress = currentAddress;
		this.permanentAddress = permanentAddress;
		this.designation = designation;
		this.builderEmployee = builderEmployee;
		this.builderEmployeeAccessType = builderEmployeeAccessType;
		this.employeeId = employeeId;
		this.builderProject = builderProject;
		this.city = city;
		this.locality = locality;
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

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "mobile", length = 12)
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "email", length = 128)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "current_address", length = 65535)
	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	@Column(name = "permanent_address", length = 65535)
	public String getPermanentAddress() {
		return permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	@Column(name = "designation", length = 128)
	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "reporting_id")
	public BuilderEmployee getBuilderEmployee() {
		return builderEmployee;
	}

	public void setBuilderEmployee(BuilderEmployee builderEmployee) {
		this.builderEmployee = builderEmployee;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "access_type_id")
	public BuilderEmployeeAccessType getBuilderEmployeeAccessType() {
		return builderEmployeeAccessType;
	}

	public void setBuilderEmployeeAccessType(
			BuilderEmployeeAccessType builderEmployeeAccessType) {
		this.builderEmployeeAccessType = builderEmployeeAccessType;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@Column(name = "employee_id", length = 128)
	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "city_id")
	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "area_id")
	public Locality getLocality() {
		return locality;
	}

	public void setLocality(Locality locality) {
		this.locality = locality;
	}

	@Column(name = "status")
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	@Column(name = "login_status")
	public int getLoginStatus() {
		return loginStatus;
	}

	public void setLoginStatus(int loginStatus) {
		this.loginStatus = loginStatus;
	}
	
}
