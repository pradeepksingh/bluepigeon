package org.bluepigeon.admin.data;

import java.util.List;

public class NameDetails {
	private String image;
	private double percentage;
	private List<NameDetailList> list;
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public double getPercentage() {
		return percentage;
	}
	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}
	public List<NameDetailList> getList() {
		return list;
	}
	public void setList(List<NameDetailList> list) {
		this.list = list;
	}
}
