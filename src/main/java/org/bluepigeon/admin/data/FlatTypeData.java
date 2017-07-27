package org.bluepigeon.admin.data;

import java.util.List;

public class FlatTypeData {
	private int bathRoom;
	private int bedRoom;
	private int balcony;
	private int dryBalcony;
	private int superBuildupArea;
	private List<RoomData> roomdata;
	
	public int getBathRoom() {
		return bathRoom;
	}
	public void setBathRoom(int bathRoom) {
		this.bathRoom = bathRoom;
	}
	public int getBedRoom() {
		return bedRoom;
	}
	public void setBedRoom(int bedRoom) {
		this.bedRoom = bedRoom;
	}
	public int getBalcony() {
		return balcony;
	}
	public void setBalcony(int balcony) {
		this.balcony = balcony;
	}
	public int getDryBalcony() {
		return dryBalcony;
	}
	public void setDryBalcony(int dryBalcony) {
		this.dryBalcony = dryBalcony;
	}
	
	public int getSuperBuildupArea() {
		return superBuildupArea;
	}
	public void setSuperBuildupArea(int superBuildupArea) {
		this.superBuildupArea = superBuildupArea;
	}	
	
	public List<RoomData> getRoomdata() {
		return roomdata;
	}
	public void setRoomdata(List<RoomData> roomdata) {
		this.roomdata = roomdata;
	}
}