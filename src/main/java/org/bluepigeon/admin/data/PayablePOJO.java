package org.bluepigeon.admin.data;

import java.util.Date;


public class PayablePOJO {
	private Integer id;
	private String bookingDate;
	private Double baseRate;
	private Double floorRiseRate;
	private Double amenityFacingRate;
	private Double parkingRate;
	private Double maintenance;
	private Integer tenure;
	private Double stampDuty;
	private Double taxes;
	private Double vat;
	private Double totalCost=0.0;
	private Integer post = 0;
	private int flatId;
	private String flatNo;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}
	public Double getBaseRate() {
		return baseRate;
	}
	public void setBaseRate(Double baseRate) {
		this.baseRate = baseRate;
	}
	public Double getFloorRiseRate() {
		return floorRiseRate;
	}
	public void setFloorRiseRate(Double floorRiseRate) {
		this.floorRiseRate = floorRiseRate;
	}
	public Double getAmenityFacingRate() {
		return amenityFacingRate;
	}
	public void setAmenityFacingRate(Double amenityFacingRate) {
		this.amenityFacingRate = amenityFacingRate;
	}
	public Double getParkingRate() {
		return parkingRate;
	}
	public void setParkingRate(Double parkingRate) {
		this.parkingRate = parkingRate;
	}
	public Double getMaintenance() {
		return maintenance;
	}
	public void setMaintenance(Double maintenance) {
		this.maintenance = maintenance;
	}
	public Integer getTenure() {
		return tenure;
	}
	public void setTenure(Integer tenure) {
		this.tenure = tenure;
	}
	public Double getStampDuty() {
		return stampDuty;
	}
	public void setStampDuty(Double stampDuty) {
		this.stampDuty = stampDuty;
	}
	public Double getTaxes() {
		return taxes;
	}
	public void setTaxes(Double taxes) {
		this.taxes = taxes;
	}
	public Double getVat() {
		return vat;
	}
	public void setVat(Double vat) {
		this.vat = vat;
	}
	public Double getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(Double totalCost) {
		this.totalCost = totalCost;
	}
	public Integer getPost() {
		return post;
	}
	public void setPost(Integer post) {
		this.post = post;
	}
	public int getFlatId() {
		return flatId;
	}
	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	
}
