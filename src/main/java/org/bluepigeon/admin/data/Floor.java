package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class Floor {
	private BigInteger flatCount;
	private BigInteger amenityCount;
	public BigInteger getFlatCount() {
		return flatCount;
	}
	public void setFlatCount(BigInteger flatCount) {
		this.flatCount = flatCount;
	}
	public BigInteger getAmenityCount() {
		return amenityCount;
	}
	public void setAmenityCount(BigInteger amenityCount) {
		this.amenityCount = amenityCount;
	}
}
