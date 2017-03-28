package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectAmenityInfo;
import org.bluepigeon.admin.model.BuilderProjectApprovalInfo;
import org.bluepigeon.admin.model.BuilderProjectBankInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo;
import org.bluepigeon.admin.model.BuilderProjectPropertyType;

public class ProjectDetail {
	private BuilderProject builderProject;
	private Set<BuilderProjectProjectType> builderProjectProjectTypes = new HashSet<BuilderProjectProjectType>(0);
	private Set<BuilderProjectPropertyType> builderProjectPropertyTypes = new HashSet<BuilderProjectPropertyType>(0);
	private Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = new HashSet<BuilderProjectPropertyConfigurationInfo>(0);
	private Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = new HashSet<BuilderProjectAmenityInfo>(0);
	private Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = new HashSet<BuilderProjectApprovalInfo>(0);
	private Set<BuilderProjectBankInfo> builderProjectBankInfos = new HashSet<BuilderProjectBankInfo>(0);
	
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	public Set<BuilderProjectProjectType> getBuilderProjectProjectTypes() {
		return builderProjectProjectTypes;
	}

	public void setBuilderProjectProjectTypes(Set<BuilderProjectProjectType> builderProjectProjectTypes) {
		this.builderProjectProjectTypes = builderProjectProjectTypes;
	}
	
	public Set<BuilderProjectPropertyType> getBuilderProjectPropertyTypes() {
		return builderProjectPropertyTypes;
	}

	public void setBuilderProjectPropertyTypes(Set<BuilderProjectPropertyType> builderProjectPropertyTypes) {
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
	}
	public Set<BuilderProjectPropertyConfigurationInfo> getBuilderProjectPropertyConfigurationInfos() {
		return builderProjectPropertyConfigurationInfos;
	}

	public void setBuilderProjectPropertyConfigurationInfos(
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos) {
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
	}
	
	public Set<BuilderProjectAmenityInfo> getBuilderProjectAmenityInfos() {
		return builderProjectAmenityInfos;
	}

	public void setBuilderProjectAmenityInfos(Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos) {
		this.builderProjectAmenityInfos = builderProjectAmenityInfos;
	}
	
	public Set<BuilderProjectApprovalInfo> getBuilderProjectApprovalInfos() {
		return builderProjectApprovalInfos;
	}

	public void setBuilderProjectApprovalInfos(Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos) {
		this.builderProjectApprovalInfos = builderProjectApprovalInfos;
	}
	
	public Set<BuilderProjectBankInfo> getBuilderProjectBankInfos() {
		return builderProjectBankInfos;
	}

	public void setBuilderProjectBankInfos(Set<BuilderProjectBankInfo> builderProjectBankInfos) {
		this.builderProjectBankInfos = builderProjectBankInfos;
	}

}
