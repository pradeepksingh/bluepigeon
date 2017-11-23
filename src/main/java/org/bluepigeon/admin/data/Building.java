package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class Building {
	private BigInteger floorCount;
	private BigInteger amenityCount;
	public BigInteger getFloorCount() {
		return floorCount;
	}
	public void setFloorCount(BigInteger floorCount) {
		this.floorCount = floorCount;
	}
	public BigInteger getAmenityCount() {
		return amenityCount;
	}
	public void setAmenityCount(BigInteger amenityCount) {
		this.amenityCount = amenityCount;
	}
}