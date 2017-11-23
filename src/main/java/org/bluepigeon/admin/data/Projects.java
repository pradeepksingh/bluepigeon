package org.bluepigeon.admin.data;

import java.util.List;

public class Projects {
	private List<ProjectAddress> projectAddresses;
	private int id;
	private String image;
	private String projectName;
	private String localityName;
	private String floorName;
	private String bookingDate;
	private double completionStatus;
	private String configName;
	private String areaUnitName;
	private double area;
	private double totalCost;
	private Project project;
	private Building building;
	private Floor floor;
	private Flat flat;
	public List<ProjectAddress> getProjectAddresses() {
		return projectAddresses;
	}

	public void setProjectAddresses(List<ProjectAddress> projectAddresses) {
		this.projectAddresses = projectAddresses;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getLocalityName() {
		return localityName;
	}

	public void setLocalityName(String localityName) {
		this.localityName = localityName;
	}

	public String getFloorName() {
		return floorName;
	}

	public void setFloorName(String floorName) {
		this.floorName = floorName;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	public double getCompletionStatus() {
		return completionStatus;
	}

	public void setCompletionStatus(double completionStatus) {
		this.completionStatus = completionStatus;
	}

	public String getConfigName() {
		return configName;
	}

	public void setConfigName(String configName) {
		this.configName = configName;
	}

	public String getAreaUnitName() {
		return areaUnitName;
	}

	public void setAreaUnitName(String areaUnitName) {
		this.areaUnitName = areaUnitName;
	}

	public double getArea() {
		return area;
	}

	public void setArea(double area) {
		this.area = area;
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Building getBuilding() {
		return building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public Floor getFloor() {
		return floor;
	}

	public void setFloor(Floor floor) {
		this.floor = floor;
	}

	public Flat getFlat() {
		return flat;
	}

	public void setFlat(Flat flat) {
		this.flat = flat;
	}
}
