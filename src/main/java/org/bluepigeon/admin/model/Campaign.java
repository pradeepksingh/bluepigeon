package org.bluepigeon.admin.model;
// Generated 13 Apr, 2017 11:28:44 AM by Hibernate Tools 4.0.0

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
 * Campaign generated by hbm2java
 */
@Entity
@Table(name = "campaign", catalog = "blue_pigeon")
public class Campaign implements java.io.Serializable {

	private Integer id;
	private AdminUser adminUser;
	private BuilderProject builderProject;
	private Builder builder;
	private City city;
	private String title;
	private String type;
	private Date setDate;
	private Date endDate;
	private String content;
	private String terms;
	private Byte isDeleted = 0;
	private Integer recipientType;
	private String image; 

	public Campaign() {
	}

	public Campaign(AdminUser adminUser,BuilderProject builderProject,Builder builder, City city, String title, String type, Date setDate, String content,
			String terms, Integer recipientType, Byte isDeleted, String image, Date endDate) {
		this.adminUser = adminUser;
		this.builderProject = builderProject;
		this.city = city;
		this.title = title;
		this.type = type;
		this.setDate = setDate;
		this.content = content;
		this.terms = terms;
		this.recipientType = recipientType;
		this.isDeleted = isDeleted;
		this.image = image;
		this.endDate = endDate;
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
	@JoinColumn(name = "admin_id")
	public AdminUser getAdminUser() {
		return this.adminUser;
	}

	public void setAdminUser(AdminUser adminUser) {
		this.adminUser = adminUser;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "project_id")
	public BuilderProject getBuilderProject() {
		return this.builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "builder_id")
	public Builder getBuilder() {
		return this.builder;
	}

	public void setBuilder(Builder builder) {
		this.builder = builder;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "city_id")
	public City getCity() {
		return this.city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	@Column(name = "title", length = 128)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "type")
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "set_date", length = 10)
	public Date getSetDate() {
		return this.setDate;
	}

	public void setSetDate(Date setDate) {
		this.setDate = setDate;
	}

	@Column(name = "content", length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "terms", length = 65535)
	public String getTerms() {
		return this.terms;
	}

	public void setTerms(String terms) {
		this.terms = terms;
	}

	@Column(name = "recipient_type")
	public Integer getRecipientType() {
		return this.recipientType;
	}

	public void setRecipientType(Integer recipientType) {
		this.recipientType = recipientType;
	}

	@Column(name = "is_deleted")
	public Byte getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(Byte isDeleted) {
		this.isDeleted = isDeleted;
	}
	@Temporal(TemporalType.DATE)
	@Column(name = "end_date", length = 10)
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Column(name = "image", length = 128)
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}