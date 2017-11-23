package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class Project {
	private BigInteger buildingCount;
	private BigInteger amenityCount;
	public BigInteger getBuildingCount() {
		return buildingCount;
	}
	public void setBuildingCount(BigInteger buildingCount) {
		this.buildingCount = buildingCount;
	}
	public BigInteger getAmenityCount() {
		return amenityCount;
	}
	public void setAmenityCount(BigInteger amenityCount) {
		this.amenityCount = amenityCount;
	}
}
