package org.bluepigeon.admin.data;

import org.bluepigeon.admin.model.Buyer;

public class BuyerBuildingList {
	private int buildingId;
	private String buildingName;
	private Buyer buyer[];
	public int getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(int buildingId) {
		this.buildingId = buildingId;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public Buyer[] getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer[] buyer) {
		this.buyer = buyer;
	}
}