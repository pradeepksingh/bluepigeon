package org.bluepigeon.admin.data;

public class BuyerList {
	private int id;
	private String projectName;
	private String name;
	private String phone;
	private String email;
	private String buildingName;
	private String flatNumber;
	private byte agreement;
	private byte possession;
	private byte status;
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
	public byte getAgreement() {
		return agreement;
	}
	public void setAgreement(byte agreement) {
		this.agreement = agreement;
	}
	
	public byte getPossession() {
		return possession;
	}
	public void setPossession(byte possession) {
		this.possession = possession;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	
}