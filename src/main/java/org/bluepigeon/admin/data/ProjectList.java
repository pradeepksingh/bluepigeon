package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class ProjectList {
	
	private int id;
	private String name;
	private int status;
	private int builderId;
	private String builderName;
	private int cityId;
	private String cityName;
	private int localityId=0;
	private String localityName;
	private double sold = 0.0;
	private double totalSold = 0.0;
	private BigInteger totalLeads;
	private Double totalRevenu = 0.0;
	private Double completionStatus = 0.0;
	private String image = "";
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getBuilderId() {
		return builderId;
	}
	public void setBuilderId(int builderId) {
		this.builderId = builderId;
	}
	public String getBuilderName() {
		return builderName;
	}
	public void setBuilderName(String builderName) {
		this.builderName = builderName;
	}
	public int getCityId() {
		return cityId;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public int getLocalityId() {
		return localityId;
	}
	public void setLocalityId(int localityId) {
		this.localityId = localityId;
	}
	public String getLocalityName() {
		return localityName;
	}
	public void setLocalityName(String localityName) {
		this.localityName = localityName;
	}
	
	public double getSold() {
		return sold;
	}
	public void setSold(double sold) {
		this.sold = sold;
	}
	public double getTotalSold() {
		return totalSold;
	}
	public void setTotalSold(double totalSold) {
		this.totalSold = totalSold;
	}
	public BigInteger getTotalLeads() {
		return totalLeads;
	}
	public void setTotalLeads(BigInteger totalLeads) {
		this.totalLeads = totalLeads;
	}
	public Double getCompletionStatus() {
		return completionStatus;
	}
	public void setCompletionStatus(Double completionStatus) {
		this.completionStatus = completionStatus;
	}
	public Double getTotalRevenu() {
		return totalRevenu;
	}
	public void setTotalRevenu(Double totalRevenu) {
		this.totalRevenu = totalRevenu;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}