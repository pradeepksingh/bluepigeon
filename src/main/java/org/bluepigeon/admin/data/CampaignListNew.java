package org.bluepigeon.admin.data;

import java.util.Date;

public class CampaignListNew {
	private int id;
	private String name;
	private String image;
	private Date startDate;
	private Date endDate;
	private String content;
	private Long booking = (long)0;
	private Long leads = (long)0;
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getBooking() {
		return booking;
	}
	public void setBooking(Long booking) {
		this.booking = booking;
	}
	public Long getLeads() {
		return leads;
	}
	public void setLeads(Long leads) {
		this.leads = leads;
	}
}