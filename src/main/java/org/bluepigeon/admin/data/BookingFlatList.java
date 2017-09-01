package org.bluepigeon.admin.data;

import java.util.ArrayList;
import java.util.List;

import org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom;

public class BookingFlatList {
	private int flatId;
	private String flatNo;
	private int floorId;
	private String image;
	private String flatType;
	private Double carpetArea;
	private int bedroom;
	private int bathroom;
	private int balcony;
	private int flatStatus;
	private double length;
	private double breadth;
	private String areaUint;
	private String carpetAreaunit;
	private String roomName;
	private String buyerName;
	private String buildingName;
	private String projectName;
	private String buyerEmail;
	private String buyerMobile;
	private String buyerPanNo;
	private String buyerPermanentAddress;
	private String buyerPhoto;
	private Short isDeleted;
	private List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms = new ArrayList<BuilderBuildingFlatTypeRoom>();
	//private String bedroomSize;
	
	public int getFlatId() {
		return flatId;
	}
	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}
	public String getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(String flatNo) {
		this.flatNo = flatNo;
	}
	
	
	public int getFloorId() {
		return floorId;
	}
	public void setFloorId(int floorId) {
		this.floorId = floorId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getFlatType() {
		return flatType;
	}
	public void setFlatType(String flatType) {
		this.flatType = flatType;
	}
	public Double getCarpetArea() {
		return carpetArea;
	}
	public void setCarpetArea(Double carpetArea) {
		this.carpetArea = carpetArea;
	}
	public int getBedroom() {
		return bedroom;
	}
	public void setBedroom(int bedroom) {
		this.bedroom = bedroom;
	}
	public int getBathroom() {
		return bathroom;
	}
	public void setBathroom(int bathroom) {
		this.bathroom = bathroom;
	}
	public int getBalcony() {
		return balcony;
	}
	public void setBalcony(int balcony) {
		this.balcony = balcony;
	}
	public int getFlatStatus() {
		return flatStatus;
	}
	public void setFlatStatus(int flatStatus) {
		this.flatStatus = flatStatus;
	}
//	public String getBedroomSize() {
//		return bedroomSize;
//	}
//	public void setBedroomSize(String bedroomSize) {
//		this.bedroomSize = bedroomSize;
//	}
	public double getLength() {
		return length;
	}
	public void setLength(double length) {
		this.length = length;
	}
	public double getBreadth() {
		return breadth;
	}
	public void setBreadth(double breadth) {
		this.breadth = breadth;
	}
	public String getAreaUint() {
		return areaUint;
	}
	public void setAreaUint(String areaUint) {
		this.areaUint = areaUint;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getCarpetAreaunit() {
		return carpetAreaunit;
	}
	public void setCarpetAreaunit(String carpetAreaunit) {
		this.carpetAreaunit = carpetAreaunit;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
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
	public String getBuyerEmail() {
		return buyerEmail;
	}
	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}
	public String getBuyerMobile() {
		return buyerMobile;
	}
	public void setBuyerMobile(String buyerMobile) {
		this.buyerMobile = buyerMobile;
	}
	public String getBuyerPanNo() {
		return buyerPanNo;
	}
	public void setBuyerPanNo(String buyerPanNo) {
		this.buyerPanNo = buyerPanNo;
	}
	public String getBuyerPermanentAddress() {
		return buyerPermanentAddress;
	}
	public void setBuyerPermanentAddress(String buyerPermanentAddress) {
		this.buyerPermanentAddress = buyerPermanentAddress;
	}
	public String getBuyerPhoto() {
		return buyerPhoto;
	}
	public void setBuyerPhoto(String buyerPhoto) {
		this.buyerPhoto = buyerPhoto;
	}
	public Short getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(Short isDeleted) {
		this.isDeleted = isDeleted;
	}
	public List<BuilderBuildingFlatTypeRoom> getBuilderBuildingFlatTypeRooms() {
		return builderBuildingFlatTypeRooms;
	}
	public void setBuilderBuildingFlatTypeRooms(List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms) {
		this.builderBuildingFlatTypeRooms = builderBuildingFlatTypeRooms;
	}
	
	
}
