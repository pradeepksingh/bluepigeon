package org.bluepigeon.admin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "buyer_upload_documents", catalog = "blue_pigeon")
public class BuyerUploadDocuments implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private String name;
	private String docUrl;
	private Date uploadedDate;
	private boolean isBuilderdoc;

	public BuyerUploadDocuments() {
	}


	public BuyerUploadDocuments(Buyer buyer, String name, String docUrl, Date uploadedDate, boolean isBuilderdoc) {
		this.buyer = buyer;
		this.name = name;
		this.docUrl = docUrl;
		this.uploadedDate = uploadedDate;
		this.isBuilderdoc = isBuilderdoc;
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
	@JoinColumn(name = "buyer_id")
	public Buyer getBuyer() {
		return this.buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}

	@Column(name = "name", length = 128)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "doc_url", length = 225)
	public String getDocUrl() {
		return this.docUrl;
	}

	public void setDocUrl(String docUrl) {
		this.docUrl = docUrl;
	}
	
	@Column(name = "uploaded_date", nullable = false, updatable=false)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getUploadedDate() {
		return this.uploadedDate;
	}

	public void setUploadedDate(Date uploadedDate) {
		this.uploadedDate = uploadedDate;
	}

	@Column(name = "is_builderdoc")
	public boolean isBuilderdoc() {
		return isBuilderdoc;
	}


	public void setBuilderdoc(boolean isBuilderdoc) {
		this.isBuilderdoc = isBuilderdoc;
	}
	
	
	
}
