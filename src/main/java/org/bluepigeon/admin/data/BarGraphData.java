package org.bluepigeon.admin.data;

import java.util.Date;

public class BarGraphData {
	private Long totalFlats;
	private Long totalBuyers;
	private Long totalSold;
	private Date builtYear;
	
	public Long getTotalFlats() {
		return totalFlats;
	}
	
	public void setTotalFlats(Long totalFlats) {
		this.totalFlats = totalFlats;
	}
	
	public Long getTotalBuyers() {
		return totalBuyers;
	}
	
	public void setTotalBuyers(Long totalBuyers) {
		this.totalBuyers = totalBuyers;
	}
	
	public Long getTotalSold() {
		return totalSold;
	}
	
	public void setTotalSold(Long totalSold) {
		this.totalSold = totalSold;
	}

	public Date getBuiltYear() {
		return builtYear;
	}

	public void setBuiltYear(Date builtYear) {
		this.builtYear = builtYear;
	}

}