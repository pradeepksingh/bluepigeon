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
@Table(name = "buyer_offer", catalog = "blue_pigeon")
public class BuyerOffer implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private String title;
	private String description;
	private Double offerPercentage;
	private Double offerAmount;
	private Byte applicable;
	private Byte status;

	public BuyerOffer() {
	}

	public BuyerOffer(Buyer buyer, String title, Double offerPercentage, Double offerAmount, Byte applicable,
			Byte status) {
		this.buyer = buyer;
		this.title = title;
		this.description = description;
		this.offerPercentage = offerPercentage;
		this.offerAmount = offerAmount;
		this.applicable = applicable;
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
	@JoinColumn(name = "buyer_id")
	public Buyer getBuyer() {
		return this.buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}

	@Column(name = "title", length = 128)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "offer_percentage", precision = 22, scale = 0)
	public Double getOfferPercentage() {
		return this.offerPercentage;
	}

	public void setOfferPercentage(Double offerPercentage) {
		this.offerPercentage = offerPercentage;
	}

	@Column(name = "offer_amount", precision = 22, scale = 0)
	public Double getOfferAmount() {
		return this.offerAmount;
	}

	public void setOfferAmount(Double offerAmount) {
		this.offerAmount = offerAmount;
	}

	@Column(name = "applicable")
	public Byte getApplicable() {
		return this.applicable;
	}

	public void setApplicable(Byte applicable) {
		this.applicable = applicable;
	}

	@Column(name = "status")
	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

}
