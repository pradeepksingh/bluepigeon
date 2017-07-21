package org.bluepigeon.admin.data;

import java.math.BigInteger;
import java.util.Date;

import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.BuilderFlatStatus;
import org.bluepigeon.admin.model.BuilderFlatType;
import org.bluepigeon.admin.model.BuilderFloor;

public class FlatPojo {
	private Integer id;
	private Integer flatTypeId;
	private BigInteger empId;
	private Integer floorNo;
	private Integer statusId;
	private String flatNo;
	private Integer bedroom;
	private Integer bathroom;
	private Integer balcony;
	private Double totalInventory;
	private Double inventorySold;
	private Double revenue;
	private Double completionStatus = 0.0;
	private Date possessionDate;
	private Double amenityWeightage = 0.0;
	private Double weightage = 0.0;
	private Byte status;
	private String floorName;
	private String buildingName;
	private String projectName;
	private String flatStatus;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getFlatTypeId() {
		return flatTypeId;
	}
	public void setFlatTypeId(Integer flatTypeId) {
		this.flatTypeId = flatTypeId;
	}
	public BigInteger getEmpId() {
		return empId;
	}
	public void setEmpId(BigInteger empId) {
		this.empId = empId;
	}
	public Integer getFloorNo() {
		return floorNo;
	}
	public void setFloorNo(Integer floorNo) {
		this.floorNo = floorNo;
	}
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	public Integer getBedroom() {
		return bedroom;
	}
	public void setBedroom(Integer bedroom) {
		this.bedroom = bedroom;
	}
	public Integer getBathroom() {
		return bathroom;
	}
	public void setBathroom(Integer bathroom) {
		this.bathroom = bathroom;
	}
	public Integer getBalcony() {
		return balcony;
	}
	public void setBalcony(Integer balcony) {
		this.balcony = balcony;
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
	public Date getPossessionDate() {
		return possessionDate;
	}
	public void setPossessionDate(Date possessionDate) {
		this.possessionDate = possessionDate;
	}
	public Double getAmenityWeightage() {
		return amenityWeightage;
	}
	public void setAmenityWeightage(Double amenityWeightage) {
		this.amenityWeightage = amenityWeightage;
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
	public String getFloorName() {
		return floorName;
	}
	public void setFloorName(String floorName) {
		this.floorName = floorName;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getFlatStatus() {
		return flatStatus;
	}
	public void setFlatStatus(String flatStatus) {
		this.flatStatus = flatStatus;
	}
	
}
