package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "flat_pricing_details", catalog = "blue_pigeon")
public class FlatPricingDetails {
	private Integer id;
	private BuilderFlat builderFlat;
	private Double basePrice;
	private Double riseRate;
	private Integer post;
	private Double amenityRate;
	private int parkingId = 0;
	private Double parking;
	private Double maintenance;
	private Double stampDuty;
	private Integer tenure;
	private Double tax;
	private Double vat;
	private Double fee;
	private AreaUnit areaUnit;
	private Double totalCost = 0.0;
	
	public FlatPricingDetails() {
	}

	public FlatPricingDetails(BuilderFlat builderFlat, Double basePrice, Double riseRate, Integer post,
			Double amenityRate, int parkingId, Double parking, Double maintenance, Double stampDuty, Integer tenure, Double tax,
			Double vat, Double fee, AreaUnit areaUnit, Double totalCost) {
		this.builderFlat = builderFlat;
		this.basePrice = basePrice;
		this.riseRate = riseRate;
		this.post = post;
		this.amenityRate = amenityRate;
		this.parkingId = parkingId;
		this.parking = parking;
		this.maintenance = maintenance;
		this.stampDuty = stampDuty;
		this.tenure = tenure;
		this.tax = tax;
		this.vat = vat;
		this.fee = fee;
		this.areaUnit = areaUnit;
		this.totalCost = totalCost;
	}
	
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
	
	@Column(name = "base_rate", precision = 21, scale = 2)
	public Double getBasePrice() {
		return this.basePrice;
	}

	public void setBasePrice(Double basePrice) {
		this.basePrice = basePrice;
	}

	@Column(name = "rise_rate", precision = 22, scale = 2)
	public Double getRiseRate() {
		return this.riseRate;
	}

	public void setRiseRate(Double riseRate) {
		this.riseRate = riseRate;
	}

	@Column(name = "post")
	public Integer getPost() {
		return this.post;
	}

	public void setPost(Integer post) {
		this.post = post;
	}

	@Column(name = "aminity_rate", precision = 22, scale = 2)
	public Double getAmenityRate() {
		return this.amenityRate;
	}

	public void setAmenityRate(Double amenityRate) {
		this.amenityRate = amenityRate;
	}
	
	@Column(name = "parking_id")
	public int getParkingId() {
		return parkingId;
	}

	public void setParkingId(int parkingId) {
		this.parkingId = parkingId;
	}

	@Column(name = "parking", precision = 22, scale = 2)
	public Double getParking() {
		return this.parking;
	}

	public void setParking(Double parking) {
		this.parking = parking;
	}

	@Column(name = "maintainance", precision = 22, scale = 2)
	public Double getMaintenance() {
		return this.maintenance;
	}

	public void setMaintenance(Double maintenance) {
		this.maintenance = maintenance;
	}

	@Column(name = "stamp_duty", precision = 22, scale = 2)
	public Double getStampDuty() {
		return this.stampDuty;
	}

	public void setStampDuty(Double stampDuty) {
		this.stampDuty = stampDuty;
	}

	@Column(name = "tenure")
	public Integer getTenure() {
		return this.tenure;
	}

	public void setTenure(Integer tenure) {
		this.tenure = tenure;
	}

	@Column(name = "tax", precision = 22, scale = 2)
	public Double getTax() {
		return this.tax;
	}

	public void setTax(Double tax) {
		this.tax = tax;
	}

	@Column(name = "vat", precision = 22, scale = 2)
	public Double getVat() {
		return this.vat;
	}

	public void setVat(Double vat) {
		this.vat = vat;
	}

	@Column(name = "fee", precision = 22, scale = 2)
	public Double getFee() {
		return this.fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}
	
	@OneToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "base_unit")
	public AreaUnit getAreaUnit() {
		return this.areaUnit;
	}

	public void setAreaUnit(AreaUnit areaUnit) {
		this.areaUnit = areaUnit;
	}

	@Column(name = "total_cost", precision = 22, scale = 2)
	public Double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(Double totalCost) {
		this.totalCost = totalCost;
	}
	
	
}
