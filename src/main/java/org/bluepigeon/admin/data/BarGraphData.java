package org.bluepigeon.admin.data;

import java.util.Date;

public class BarGraphData {
	private int totalFlats;
	private int totalBuyers;
	private int totalSold;
	private int builtYear;
	private int id;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTotalFlats() {
		return totalFlats;
	}
	
	public void setTotalFlats(int totalFlats) {
		this.totalFlats = totalFlats;
	}
	
	public int getTotalBuyers() {
		return totalBuyers;
	}
	
	public void setTotalBuyers(int totalBuyers) {
		this.totalBuyers = totalBuyers;
	}
	
	public int getTotalSold() {
		return totalSold;
	}
	
	public void setTotalSold(int totalSold) {
		this.totalSold = totalSold;
	}

	public int getBuiltYear() {
		return builtYear;
	}

	public void setBuiltYear(int builtYear) {
		this.builtYear = builtYear;
	}

}