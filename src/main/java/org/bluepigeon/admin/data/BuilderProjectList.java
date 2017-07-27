package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class BuilderProjectList {
	private int id;
	private String name;
	private String image = "";// "builder/plugins/images/Untitled-1.png";
	private String city;
	private double sold;
	private double totalSold;
	private BigInteger totalLeads;
	private Double completionStatus;
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
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
}