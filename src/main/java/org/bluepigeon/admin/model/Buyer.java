package org.bluepigeon.admin.model;

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

@Entity
@Table(name = "buyer", catalog = "blue_pigeon")
public class Buyer implements java.io.Serializable {

	private Integer id;
	private AdminUser adminUser;
	private BuilderFlat builderFlat;
	private BuilderProject builderProject;
	private Integer builderId;
	private Short isPrimary;
	private String name;
	private String contact;
	private String email;
	private String pan;
	private String address;
	private String photo;
	private Short agreement;
	private Short possession;
	private Short status;
	
	public Buyer() {
	}

	public Buyer(AdminUser adminUser, BuilderFlat builderFlat, BuilderProject builderProject, Integer builderId,
			Short isPrimary, String name, String contact, String email, String pan, String address, String photo,
			Short agreement, Short possession, Short status) {
		this.adminUser = adminUser;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
		this.builderId = builderId;
		this.isPrimary = isPrimary;
		this.name = name;
		this.contact = contact;
		this.email = email;
		this.pan = pan;
		this.address = address;
		this.photo = photo;
		this.agreement = agreement;
		this.possession = possession;
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
	@JoinColumn(name = "emp_id")
	public AdminUser getAdminUser() {
		return this.adminUser;
	}

	public void setAdminUser(AdminUser adminUser) {
		this.adminUser = adminUser;
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
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	@Column(name = "builder_id")
	public Integer getBuilderId() {
		return this.builderId;
	}

	public void setBuilderId(Integer builderId) {
		this.builderId = builderId;
	}

	@Column(name = "is_primary")
	public Short getIsPrimary() {
		return this.isPrimary;
	}

	public void setIsPrimary(Short isPrimary) {
		this.isPrimary = isPrimary;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "contact", length = 225)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "email", length = 225)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "pan", length = 10)
	public String getPan() {
		return this.pan;
	}

	public void setPan(String pan) {
		this.pan = pan;
	}

	@Column(name = "address", length = 65535)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "photo", length = 225)
	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Column(name = "agreement")
	public Short getAgreement() {
		return this.agreement;
	}

	public void setAgreement(Short agreement) {
		this.agreement = agreement;
	}

	@Column(name = "possession")
	public Short getPossession() {
		return this.possession;
	}

	public void setPossession(Short possession) {
		this.possession = possession;
	}

	@Column(name = "status")
	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}
}