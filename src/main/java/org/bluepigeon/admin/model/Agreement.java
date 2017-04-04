package org.bluepigeon.admin.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "agreement", catalog = "blue_pigeon")
public class Agreement implements java.io.Serializable {

	private Integer id;
	private BuilderBuilding builderBuilding;
	private BuilderFlat builderFlat;
	private BuilderProject builderProject;
	private Integer buyerId;
	private String contact;
	private String email;
	private Date lastDate;
	private String remind;
	private String docUrl;
	private String content;

	public Agreement() {
	}

	public Agreement(BuilderBuilding builderBuilding, BuilderFlat builderFlat, BuilderProject builderProject,
			Integer buyerId, String contact, String email, Date lastDate, String remind, String docUrl,
			String content) {
		this.builderBuilding = builderBuilding;
		this.builderFlat = builderFlat;
		this.builderProject = builderProject;
		this.buyerId = buyerId;
		this.contact = contact;
		this.email = email;
		this.lastDate = lastDate;
		this.remind = remind;
		this.docUrl = docUrl;
		this.content = content;
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
	@JoinColumn(name = "building_id")
	public BuilderBuilding getBuilderBuilding() {
		return this.builderBuilding;
	}

	public void setBuilderBuilding(BuilderBuilding builderBuilding) {
		this.builderBuilding = builderBuilding;
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

	@Column(name = "buyer_id")
	public Integer getBuyerId() {
		return this.buyerId;
	}

	public void setBuyerId(Integer buyerId) {
		this.buyerId = buyerId;
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

	@Temporal(TemporalType.DATE)
	@Column(name = "last_date", length = 10)
	public Date getLastDate() {
		return this.lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

	@Column(name = "remind", length = 128)
	public String getRemind() {
		return this.remind;
	}

	public void setRemind(String remind) {
		this.remind = remind;
	}

	@Column(name = "doc_url", length = 225)
	public String getDocUrl() {
		return this.docUrl;
	}

	public void setDocUrl(String docUrl) {
		this.docUrl = docUrl;
	}

	@Column(name = "content", length = 65535)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
