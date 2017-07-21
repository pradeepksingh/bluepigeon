package org.bluepigeon.admin.data;

import java.util.Date;

public class CampaignList {
	private int campaignId;
	private String title;
	private Date setDate;
	private int campaignType;
	public int getCampaignId() {
		return campaignId;
	}
	public void setCampaignId(int campaignId) {
		this.campaignId = campaignId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getSetDate() {
		return setDate;
	}
	public void setSetdate(Date setDate) {
		this.setDate = setDate;
	}
	public int getCampaignType() {
		return campaignType;
	}
	public void setCampaignType(int campaignType) {
		this.campaignType = campaignType;
	}
	
}