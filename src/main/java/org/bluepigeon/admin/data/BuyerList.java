package org.bluepigeon.admin.data;

public class BuyerList {
	private int id;
	private String projectName;
	private String name;
	private String phone;
	private String email;
	private String buildingName;
	private String flatNumber;
	private Short agreement;
	private Short possession;
	private Short status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getFlatNumber() {
		return flatNumber;
	}
	public void setFlatNumber(String flatNumber) {
		this.flatNumber = flatNumber;
	}
	public Short getAgreement() {
		return agreement;
	}
	public void setAgreement(Short agreements) {
		this.agreement = agreements;
	}
	
	public Short getPossession() {
		return possession;
	}
	public void setPossession(Short possession) {
		this.possession = possession;
	}
	public Short getStatus() {
		return status;
	}
	public void setStatus(Short status) {
		this.status = status;
	}
	
}