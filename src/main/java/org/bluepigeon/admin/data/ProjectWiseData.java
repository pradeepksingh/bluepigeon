package org.bluepigeon.admin.data;

import java.math.BigInteger;

public class ProjectWiseData {
	private int id;
	private BigInteger dataCount;
	private String name;
	private Double revenue=0.0;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getRevenue() {
		return revenue;
	}
	public void setRevenue(Double revenue) {
		this.revenue = revenue;
	}
	public BigInteger getDataCount() {
		return dataCount;
	}
	public void setDataCount(BigInteger dataCount) {
		this.dataCount = dataCount;
	}
}
