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
@Table(name = "buyer_payment", catalog = "blue_pigeon")
public class BuyerPayment implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private String milestone;
	private Double netPayable;
	private Double amount;
	private boolean isPaid;

	public BuyerPayment() {
	}

	public BuyerPayment(Buyer buyer, String milestone, Double netPayable, Double amount) {
		this.buyer = buyer;
		this.milestone = milestone;
		this.netPayable = netPayable;
		this.amount = amount;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "buyer_id")
	public Buyer getBuyer() {
		return this.buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}

	@Column(name = "milestone", length = 128)
	public String getMilestone() {
		return this.milestone;
	}

	public void setMilestone(String milestone) {
		this.milestone = milestone;
	}

	@Column(name = "net_payable", precision = 22, scale = 0)
	public Double getNetPayable() {
		return this.netPayable;
	}

	public void setNetPayable(Double netPayable) {
		this.netPayable = netPayable;
	}

	@Column(name = "amount", precision = 22, scale = 0)
	public Double getAmount() {
		return this.amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
	@Column(name = "is_paid")
	public boolean isPaid() {
		return this.isPaid;
	}

	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}
	
}
