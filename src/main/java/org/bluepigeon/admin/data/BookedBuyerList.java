package org.bluepigeon.admin.data;

public class BookedBuyerList {
	private String buyerName;
	private String buyerContact;
	private String buyerEmail;
	private String projectName;
	private String buildingName;
	private String flatNo;
	private String localityName;
	private String cityName;
	private String cancelReson;
	private Double charges;
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	public String getBuyerContact() {
		return buyerContact;
	}
	public void setBuyerContact(String buyerContact) {
		this.buyerContact = buyerContact;
	}
	public String getBuyerEmail() {
		return buyerEmail;
	}
	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	public String getLocalityName() {
		return localityName;
	}
	public void setLocalityName(String localityName) {
		this.localityName = localityName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCancelReson() {
		return cancelReson;
	}
	public void setCancelReson(String cancelReson) {
		this.cancelReson = cancelReson;
	}
	public Double getCharges() {
		return charges;
	}
	public void setCharges(Double charges) {
		this.charges = charges;
	}
}
