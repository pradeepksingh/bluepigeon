package org.bluepigeon.admin.data;

import java.math.BigInteger;
import java.util.Date;


public class BuildingPojo {
	private Integer id;
	private BigInteger empId;
	private Integer statusId;
	private Integer projectId;
	private String name;
	private Integer totalFloor;
	private Date launchDate;
	private Date possessionDate;
	private Double totalInventory = 0.0;
	private Double inventorySold = 0.0;
	private Double revenue = 0.0;
	private Double completionStatus = 0.0;
	private Double amenityWeightage = 0.0;
	private Double floorWeightage = 0.0;
	private Double weightage = 0.0;
	private Byte status;
	private String builderName;
	private String projectName;
	private String buildingStatus;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public BigInteger getEmpId() {
		return empId;
	}
	public void setEmpId(BigInteger empId) {
		this.empId = empId;
	}
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getTotalFloor() {
		return totalFloor;
	}
	public void setTotalFloor(Integer totalFloor) {
		this.totalFloor = totalFloor;
	}
	public Date getLaunchDate() {
		return launchDate;
	}
	public void setLaunchDate(Date launchDate) {
		this.launchDate = launchDate;
	}
	public Date getPossessionDate() {
		return possessionDate;
	}
	public void setPossessionDate(Date possessionDate) {
		this.possessionDate = possessionDate;
	}
	public Double getTotalInventory() {
		return totalInventory;
	}
	public void setTotalInventory(Double totalInventory) {
		this.totalInventory = totalInventory;
	}
	public Double getInventorySold() {
		return inventorySold;
	}
	public void setInventorySold(Double inventorySold) {
		this.inventorySold = inventorySold;
	}
	public Double getRevenue() {
		return revenue;
	}
	public void setRevenue(Double revenue) {
		this.revenue = revenue;
	}
	public Double getCompletionStatus() {
		return completionStatus;
	}
	public void setCompletionStatus(Double completionStatus) {
		this.completionStatus = completionStatus;
	}
	public Double getAmenityWeightage() {
		return amenityWeightage;
	}
	public void setAmenityWeightage(Double amenityWeightage) {
		this.amenityWeightage = amenityWeightage;
	}
	public Double getFloorWeightage() {
		return floorWeightage;
	}
	public void setFloorWeightage(Double floorWeightage) {
		this.floorWeightage = floorWeightage;
	}
	public Double getWeightage() {
		return weightage;
	}
	public void setWeightage(Double weightage) {
		this.weightage = weightage;
	}
	public Byte getStatus() {
		return status;
	}
	public void setStatus(Byte status) {
		this.status = status;
	}
	public String getBuilderName() {
		return builderName;
	}
	public void setBuilderName(String builderName) {
		this.builderName = builderName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getBuildingStatus() {
		return buildingStatus;
	}
	public void setBuildingStatus(String buildingStatus) {
		this.buildingStatus = buildingStatus;
	}
	
}
