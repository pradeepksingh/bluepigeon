package org.bluepigeon.admin.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_campaign", catalog = "blue_pigeon")
public class UserCampaign {
	private Integer id;
	private Integer campaignId;
	private Integer cityId=0;
	private Integer projectId=0;
	private Integer buildingId=0;
	private Integer userId=0;
	private Integer userType=0;
	private String userName;
	private String userEmail;
	private String userMobile;
	private boolean isOpen=false;
	private String campaignLink;
	public UserCampaign(Integer id, Integer campaignId, Integer cityId, Integer projectId, Integer buildingId,
			Integer userId, Integer userType, String userName, String userEmail, String userMobile, boolean isOpen,
			String campaignLink) {
		super();
		this.id = id;
		this.campaignId = campaignId;
		this.cityId = cityId;
		this.projectId = projectId;
		this.buildingId = buildingId;
		this.userId = userId;
		this.userType = userType;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userMobile = userMobile;
		this.isOpen = isOpen;
		this.campaignLink = campaignLink;
	}
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(name = "campaign_id")
	public Integer getCampaignId() {
		return campaignId;
	}
	public void setCampaignId(Integer campaignId) {
		this.campaignId = campaignId;
	}
	@Column(name = "city_id")
	public Integer getCityId() {
		return cityId;
	}
	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}
	@Column(name = "project_id")
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	@Column(name = "building_id")
	public Integer getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(Integer buildingId) {
		this.buildingId = buildingId;
	}
	@Column(name = "user_id")
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Column(name = "user_type")
	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	@Column(name = "user_name")
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@Column(name = "user_email")
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	@Column(name = "user_mobile")
	public String getUserMobile() {
		return userMobile;
	}
	public void setUserMobile(String userMobile) {
		this.userMobile = userMobile;
	}
	@Column(name = "is_open")
	public boolean isOpen() {
		return isOpen;
	}
	public void setOpen(boolean isOpen) {
		this.isOpen = isOpen;
	}
	@Column(name = "campaign_link")
	public String getCampaignLink() {
		return campaignLink;
	}
	public void setCampaignLink(String campaignLink) {
		this.campaignLink = campaignLink;
	}
}