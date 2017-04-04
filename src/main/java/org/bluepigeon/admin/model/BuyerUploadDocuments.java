package org.bluepigeon.admin.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
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
	private String documentsUrl;

	public BuyerUploadDocuments() {
	}

	public BuyerUploadDocuments(Buyer buyer, String name, String documentsUrl) {
		this.buyer = buyer;
		this.name = name;
		this.documentsUrl = documentsUrl;
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

	@Column(name = "documents_url", length = 225)
	public String getDocumentsUrl() {
		return this.documentsUrl;
	}

	public void setDocumentsUrl(String documentsUrl) {
		this.documentsUrl = documentsUrl;
	}

}
