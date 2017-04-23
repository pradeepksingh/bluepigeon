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
	private City city;
	private String title;
	private Integer type;
	private Date setDate;
	private String content;
	private String terms;
	private Integer recipientType;

	public Campaign() {
	}

	public Campaign(AdminUser adminUser, City city, String title, Integer type, Date setDate, String content,
			String terms, Integer recipientType) {
		this.adminUser = adminUser;
		this.city = city;
		this.title = title;
		this.type = type;
		this.setDate = setDate;
		this.content = content;
		this.terms = terms;
		this.recipientType = recipientType;
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
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
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
}