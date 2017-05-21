package org.bluepigeon.admin.data;

public class ProjectSubstageList {
	private int id;
	private String projectStageName;
	private String projectSubstageName;
	private byte status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProjectStageName() {
		return projectStageName;
	}
	public void setProjectStageName(String projectStageName) {
		this.projectStageName = projectStageName;
	}
	public String getProjectSubstageName() {
		return projectSubstageName;
	}
	public void setProjectSubstageName(String projectSubstageName) {
		this.projectSubstageName = projectSubstageName;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}