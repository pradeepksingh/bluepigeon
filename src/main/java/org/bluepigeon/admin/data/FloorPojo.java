package org.bluepigeon.admin.data;


public class FloorPojo {
	private Integer id;
	private Integer buildingId;
	private Integer statusId;
	private String name;
	private Integer floorNo;
	private Integer totalFlats = 0;
	private Double completionStatus = 0.0;
	private Double amenityWeightage = 0.0;
	private Double flatWeightage = 0.0;
	private Double weightage = 0.0;
	private Byte status;
	private String buildingName;
	private String projectName;
	private String floorStatus;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(Integer buildingId) {
		this.buildingId = buildingId;
	}
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getFloorNo() {
		return floorNo;
	}
	public void setFloorNo(Integer floorNo) {
		this.floorNo = floorNo;
	}
	public Integer getTotalFlats() {
		return totalFlats;
	}
	public void setTotalFlats(Integer totalFlats) {
		this.totalFlats = totalFlats;
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
	public Double getFlatWeightage() {
		return flatWeightage;
	}
	public void setFlatWeightage(Double flatWeightage) {
		this.flatWeightage = flatWeightage;
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
	public String getFloorStatus() {
		return floorStatus;
	}
	public void setFloorStatus(String floorStatus) {
		this.floorStatus = floorStatus;
	}
	
	
}
