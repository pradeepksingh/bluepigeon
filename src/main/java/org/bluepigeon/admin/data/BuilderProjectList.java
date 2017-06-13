package org.bluepigeon.admin.data;

public class BuilderProjectList {
	private int id;
	private String name;
	private String image;
	private String city;
	private double sold;
	private double totalSold;
	private int totalLeads;
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
	public int getTotalLeads() {
		return totalLeads;
	}
	public void setTotalLeads(int totalLeads) {
		this.totalLeads = totalLeads;
	}
}