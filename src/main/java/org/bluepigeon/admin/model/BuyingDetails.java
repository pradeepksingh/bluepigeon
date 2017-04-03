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
@Table(name = "buying_details", catalog = "blue_pigeon")
public class BuyingDetails implements java.io.Serializable {

	private Integer id;
	private Buyer buyer;
	private Date bookingDate;
	private Double baseRate;
	private Double floorRiseRate;
	private Double amenityFacingRate;
	private Double parkingRate;
	private Double maintenance;
	private Double stampDuty;
	private Double registration;
	private Double taxes;
	private Double vat;

	public BuyingDetails() {
	}

	public BuyingDetails(Buyer buyer, Date bookingDate, Double baseRate, Double floorRiseRate, Double amenityFacingRate,
			Double parkingRate, Double maintenance, Double stampDuty, Double registration, Double taxes, Double vat) {
		this.buyer = buyer;
		this.bookingDate = bookingDate;
		this.baseRate = baseRate;
		this.floorRiseRate = floorRiseRate;
		this.amenityFacingRate = amenityFacingRate;
		this.parkingRate = parkingRate;
		this.maintenance = maintenance;
		this.stampDuty = stampDuty;
		this.registration = registration;
		this.taxes = taxes;
		this.vat = vat;
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

	@Temporal(TemporalType.DATE)
	@Column(name = "booking_date", length = 10)
	public Date getBookingDate() {
		return this.bookingDate;
	}

	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}

	@Column(name = "base_rate", precision = 22, scale = 0)
	public Double getBaseRate() {
		return this.baseRate;
	}

	public void setBaseRate(Double baseRate) {
		this.baseRate = baseRate;
	}

	@Column(name = "floor_rise_rate", precision = 22, scale = 0)
	public Double getFloorRiseRate() {
		return this.floorRiseRate;
	}

	public void setFloorRiseRate(Double floorRiseRate) {
		this.floorRiseRate = floorRiseRate;
	}

	@Column(name = "amenity_facing_rate", precision = 22, scale = 0)
	public Double getAmenityFacingRate() {
		return this.amenityFacingRate;
	}

	public void setAmenityFacingRate(Double amenityFacingRate) {
		this.amenityFacingRate = amenityFacingRate;
	}

	@Column(name = "parking_rate", precision = 22, scale = 0)
	public Double getParkingRate() {
		return this.parkingRate;
	}

	public void setParkingRate(Double parkingRate) {
		this.parkingRate = parkingRate;
	}

	@Column(name = "maintenance", precision = 22, scale = 0)
	public Double getMaintenance() {
		return this.maintenance;
	}

	public void setMaintenance(Double maintenance) {
		this.maintenance = maintenance;
	}

	@Column(name = "stamp_duty", precision = 22, scale = 0)
	public Double getStampDuty() {
		return this.stampDuty;
	}

	public void setStampDuty(Double stampDuty) {
		this.stampDuty = stampDuty;
	}

	@Column(name = "registration", precision = 22, scale = 0)
	public Double getRegistration() {
		return this.registration;
	}

	public void setRegistration(Double registration) {
		this.registration = registration;
	}

	@Column(name = "taxes", precision = 22, scale = 0)
	public Double getTaxes() {
		return this.taxes;
	}

	public void setTaxes(Double taxes) {
		this.taxes = taxes;
	}

	@Column(name = "vat", precision = 22, scale = 0)
	public Double getVat() {
		return this.vat;
	}

	public void setVat(Double vat) {
		this.vat = vat;
	}

}
