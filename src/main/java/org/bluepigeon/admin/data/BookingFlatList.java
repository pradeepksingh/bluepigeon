package org.bluepigeon.admin.data;

import java.util.List;

public class BookingFlatList {
	private int flatId;
	private int flatNo;
	private int floorId;
	private String image;
	private String flatType;
	private String carpetArea;
	private int bedroom;
	private int bathroom;
	private int balcony;
	private int flatStatus;
	private double length;
	private double breadth;
	//private String bedroomSize;
	
	public int getFlatId() {
		return flatId;
	}
	public void setFlatId(int flatId) {
		this.flatId = flatId;
	}
	public int getFlatNo() {
		return flatNo;
	}
	public void setFlatNo(int flatNo) {
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
	public String getCarpetArea() {
		return carpetArea;
	}
	public void setCarpetArea(String carpetArea) {
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
	
}