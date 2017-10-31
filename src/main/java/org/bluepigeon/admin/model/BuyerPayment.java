package org.bluepigeon.admin.model;

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

@Entity
@Table(name = "buyer_payment", catalog = "blue_pigeon")
public class BuyerPayment implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private String milestone;
	private Double netPayable;
	private Double amount;
	private boolean isPaid;
	private Date scheduleDate;
	private Date paieddate;
	private Integer transcationType=0;
	private String transactionNo;
	
	public BuyerPayment() {
	}

	public BuyerPayment(Buyer buyer, String milestone, Double netPayable, Double amount, Date scheduleDate,Date paiedDate,
			Integer transactionType,String transactionNo ) {
		this.buyer = buyer;
		this.milestone = milestone;
		this.netPayable = netPayable;
		this.amount = amount;
		this.scheduleDate = scheduleDate;
		this.paieddate = paiedDate;
		this.transactionNo = transactionNo;
		this.transcationType = transactionType;
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
	 @Temporal(TemporalType.TIMESTAMP)
	 @Column(name="schedule_date")
	public Date getScheduleDate() {
		return scheduleDate;
	}

	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	 @Temporal(TemporalType.TIMESTAMP)
	 @Column(name="paied_date")
	public Date getPaieddate() {
		return paieddate;
	}

	public void setPaieddate(Date paieddate) {
		this.paieddate = paieddate;
	}
	@Column(name="transaction_type")
	public Integer getTranscationType() {
		return transcationType;
	}

	public void setTranscationType(Integer transcationType) {
		this.transcationType = transcationType;
	}
	@Column(name="transaction_no")
	public String getTransactionNo() {
		return transactionNo;
	}

	public void setTransactionNo(String transactionNo) {
		this.transactionNo = transactionNo;
	}
}