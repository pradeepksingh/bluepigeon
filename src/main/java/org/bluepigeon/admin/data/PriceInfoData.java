package org.bluepigeon.admin.data;

import java.util.List;

import org.bluepigeon.admin.model.AreaUnit;

public class PriceInfoData {
	private int id;
	private double baseRate;
	private double riseRate;
	private int post;
	private double amenityRate;
	private double parking;
	private int parkingId = 0;
	private double tax;
	private double vat;
	private int tenure;
	private double maintainance;
	private double stampDuty;
	private double fee;
	private int areaUnits;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getBaseRate() {
		return baseRate;
	}
	public void setBaseRate(double baseRate) {
		this.baseRate = baseRate;
	}
	public double getRiseRate() {
		return riseRate;
	}
	public void setRiseRate(double riseRate) {
		this.riseRate = riseRate;
	}
	public int getPost() {
		return post;
	}
	public void setPost(int post) {
		this.post = post;
	}
	public double getAmenityRate() {
		return amenityRate;
	}
	public void setAmenityRate(double amenityRate) {
		this.amenityRate = amenityRate;
	}
	public double getParking() {
		return parking;
	}
	public void setParking(double parking) {
		this.parking = parking;
	}
	public double getTax() {
		return tax;
	}
	public void setTax(double tax) {
		this.tax = tax;
	}
	public double getVat() {
		return vat;
	}
	public void setVat(double vat) {
		this.vat = vat;
	}
	public int getTenure() {
		return tenure;
	}
	public void setTenure(int tenure) {
		this.tenure = tenure;
	}
	public double getMaintainance() {
		return maintainance;
	}
	public void setMaintainance(double maintainance) {
		this.maintainance = maintainance;
	}
	public double getStampDuty() {
		return stampDuty;
	}
	public void setStampDuty(double stampDuty) {
		this.stampDuty = stampDuty;
	}
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	public int getAreaUnits() {
		return areaUnits;
	}
	public void setAreaUnits(int areaUnits) {
		this.areaUnits = areaUnits;
	}
	public int getParkingId() {
		return parkingId;
	}
	public void setParkingId(int parkingId) {
		this.parkingId = parkingId;
	}
	

}


