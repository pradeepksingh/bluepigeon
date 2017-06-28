package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "flat_payment_schedule", catalog = "blue_pigeon")
public class FlatPricingDetails {
	private Integer id;
	private BuilderFlat builderFlat;
	private Integer salebleArea;
	private Integer rate;
	private Integer cost;
	private Integer stampDuty;
	private Integer registration;
	private Integer serviceTax;
	private Integer vat;
	private Integer otherExp;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "flat_id")
	public BuilderFlat getBuilderFlat() {
		return builderFlat;
	}
	public void setBuilderFlat(BuilderFlat builderFlat) {
		this.builderFlat = builderFlat;
	}
	@Column(name = "saleble_area")
	public Integer getSalebleArea() {
		return salebleArea;
	}
	public void setSalebleArea(Integer salebleArea) {
		this.salebleArea = salebleArea;
	}
	@Column(name = "rate")
	public Integer getRate() {
		return rate;
	}
	public void setRate(Integer rate) {
		this.rate = rate;
	}
	@Column(name = "cost")
	public Integer getCost() {
		return cost;
	}
	public void setCost(Integer cost) {
		this.cost = cost;
	}
	@Column(name = "stamp_duty")
	public Integer getStampDuty() {
		return stampDuty;
	}
	public void setStampDuty(Integer stampDuty) {
		this.stampDuty = stampDuty;
	}
	@Column(name = "registration")
	public Integer getRegistration() {
		return registration;
	}
	public void setRegistration(Integer registration) {
		this.registration = registration;
	}
	@Column(name = "service_tax")
	public Integer getServiceTax() {
		return serviceTax;
	}
	public void setServiceTax(Integer serviceTax) {
		this.serviceTax = serviceTax;
	}
	@Column(name = "vat")
	public Integer getVat() {
		return vat;
	}
	public void setVat(Integer vat) {
		this.vat = vat;
	}
	@Column(name = "other_exp")
	public Integer getOtherExp() {
		return otherExp;
	}
	public void setOtherExp(Integer otherExp) {
		this.otherExp = otherExp;
	}
	
	
}
