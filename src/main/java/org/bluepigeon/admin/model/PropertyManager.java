//package org.bluepigeon.admin.model;
//// Generated 21 Apr, 2017 5:15:25 PM by Hibernate Tools 4.0.0
//
//import java.util.HashSet;
//import java.util.Set;
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.FetchType;
//import javax.persistence.GeneratedValue;
//import static javax.persistence.GenerationType.IDENTITY;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.OneToMany;
//import javax.persistence.Table;
//
///**
// * PropertyManager generated by hbm2java
// */
//@Entity
//@Table(name = "property_manager", catalog = "blue_pigeon")
//public class PropertyManager implements java.io.Serializable {
//
//	private Integer id;
//	private AdminUserRole adminUserRole;
//	private AdminUser adminUserByAdminUserId;
//	private City city;
//	private AdminUser adminUserByAddedBy;
//	private String currentAddress;
//	private String permanentAddress;
//	public PropertyManager() {
//	}
//
//	public PropertyManager(AdminUserRole adminUserRole, AdminUser adminUserByAdminUserId, City city,
//			AdminUser adminUserByAddedBy, String currentAddress, String permanentAddress) {
//		this.adminUserRole = adminUserRole;
//		this.adminUserByAdminUserId = adminUserByAdminUserId;
//		this.city = city;
//		this.adminUserByAddedBy = adminUserByAddedBy;
//		this.currentAddress = currentAddress;
//		this.permanentAddress = permanentAddress;
//	}
//
//	@Id
//	@GeneratedValue(strategy = IDENTITY)
//
//	@Column(name = "id", unique = true, nullable = false)
//	public Integer getId() {
//		return this.id;
//	}
//
//	public void setId(Integer id) {
//		this.id = id;
//	}
//
//	@ManyToOne(fetch = FetchType.EAGER)
//	@JoinColumn(name = "admin_user_role_id")
//	public AdminUserRole getAdminUserRole() {
//		return this.adminUserRole;
//	}
//
//	public void setAdminUserRole(AdminUserRole adminUserRole) {
//		this.adminUserRole = adminUserRole;
//	}
//
//	@ManyToOne(fetch = FetchType.EAGER)
//	@JoinColumn(name = "admin_user_id")
//	public AdminUser getAdminUserByAdminUserId() {
//		return this.adminUserByAdminUserId;
//	}
//
//	public void setAdminUserByAdminUserId(AdminUser adminUserByAdminUserId) {
//		this.adminUserByAdminUserId = adminUserByAdminUserId;
//	}
//
//	@ManyToOne(fetch = FetchType.EAGER)
//	@JoinColumn(name = "city_id")
//	public City getCity() {
//		return this.city;
//	}
//
//	public void setCity(City city) {
//		this.city = city;
//	}
//
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "added_by")
//	public AdminUser getAdminUserByAddedBy() {
//		return this.adminUserByAddedBy;
//	}
//
//	public void setAdminUserByAddedBy(AdminUser adminUserByAddedBy) {
//		this.adminUserByAddedBy = adminUserByAddedBy;
//	}
//	@Column(name = "current_address", length = 65535)
//	public String getCurrentAddress() {
//		return this.currentAddress;
//	}
//
//	public void setCurrentAddress(String currentAddress) {
//		this.currentAddress = currentAddress;
//	}
//
//	@Column(name = "permanent_address", length = 65535)
//	public String getPermanentAddress() {
//		return this.permanentAddress;
//	}
//
//	public void setPermanentAddress(String permanentAddress) {
//		this.permanentAddress = permanentAddress;
//	}
//}
