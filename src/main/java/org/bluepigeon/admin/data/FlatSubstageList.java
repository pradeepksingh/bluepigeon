package org.bluepigeon.admin.data;

public class FlatSubstageList {
	private int id;
	private String flatStageName;
	private String flatSubstageName;
	private byte status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFlatStageName() {
		return flatStageName;
	}
	public void setFlatStageName(String flatStageName) {
		this.flatStageName = flatStageName;
	}
	public String getFlatSubstageName() {
		return flatSubstageName;
	}
	public void setFlatSubstageName(String flatSubstageName) {
		this.flatSubstageName = flatSubstageName;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	
}