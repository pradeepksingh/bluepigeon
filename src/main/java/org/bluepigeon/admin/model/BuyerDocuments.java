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
@Table(name = "buyer_documents", catalog = "blue_pigeon")
public class BuyerDocuments implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private String documents;

	public BuyerDocuments() {
	}

	public BuyerDocuments(Buyer buyer, String documents) {
		this.buyer = buyer;
		this.documents = documents;
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

	@Column(name = "documents", length = 225)
	public String getDocuments() {
		return this.documents;
	}

	public void setDocuments(String documents) {
		this.documents = documents;
	}

}
