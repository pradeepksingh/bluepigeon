package org.bluepigeon.admin.data;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.AdminUser;
import org.bluepigeon.admin.model.AreaUnit;
import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;
import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectAmenityInfo;
import org.bluepigeon.admin.model.BuilderProjectApprovalInfo;
import org.bluepigeon.admin.model.BuilderProjectBankInfo;
import org.bluepigeon.admin.model.BuilderProjectOfferInfo;
import org.bluepigeon.admin.model.BuilderProjectPaymentInfo;
import org.bluepigeon.admin.model.BuilderProjectPriceInfo;
import org.bluepigeon.admin.model.BuilderProjectProjectType;
import org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo;
import org.bluepigeon.admin.model.BuilderProjectPropertyType;
import org.bluepigeon.admin.model.City;
import org.bluepigeon.admin.model.Country;
import org.bluepigeon.admin.model.Locality;
import org.bluepigeon.admin.model.ProjectAmenityWeightage;
import org.bluepigeon.admin.model.State;

public class ProjectDetails {
	private BuilderProject builderProject;
	private Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos = new HashSet<BuilderProjectPropertyConfigurationInfo>(
			0);
	private Set<BuilderProjectOfferInfo> builderProjectOfferInfos = new HashSet<BuilderProjectOfferInfo>(0);
	private Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos = new HashSet<BuilderProjectAmenityInfo>(0);
	private Set<BuilderProjectBankInfo> builderProjectBankInfos = new HashSet<BuilderProjectBankInfo>(0);
	private Set<BuilderProjectPriceInfo> builderProjectPriceInfos = new HashSet<BuilderProjectPriceInfo>(0);
	private Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new HashSet<BuilderProjectPaymentInfo>(0);
	private Set<BuilderProjectProjectType> builderProjectProjectTypes = new HashSet<BuilderProjectProjectType>(0);
	private Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos = new HashSet<BuilderProjectApprovalInfo>(0);
	private Set<BuilderProjectPropertyType> builderProjectPropertyTypes = new HashSet<BuilderProjectPropertyType>(0);
	private Set<ProjectAmenityWeightage> projectAmenityWeightages = new HashSet<ProjectAmenityWeightage>(0);
	public BuilderProject getBuilderProject() {
		return builderProject;
	}

	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}

	public Set<BuilderProjectPropertyConfigurationInfo> getBuilderProjectPropertyConfigurationInfos() {
		return builderProjectPropertyConfigurationInfos;
	}

	public void setBuilderProjectPropertyConfigurationInfos(
			Set<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos) {
		this.builderProjectPropertyConfigurationInfos = builderProjectPropertyConfigurationInfos;
	}

	public Set<BuilderProjectOfferInfo> getBuilderProjectOfferInfos() {
		return builderProjectOfferInfos;
	}

	public void setBuilderProjectOfferInfos(Set<BuilderProjectOfferInfo> builderProjectOfferInfos) {
		this.builderProjectOfferInfos = builderProjectOfferInfos;
	}

	public Set<BuilderProjectAmenityInfo> getBuilderProjectAmenityInfos() {
		return builderProjectAmenityInfos;
	}

	public void setBuilderProjectAmenityInfos(Set<BuilderProjectAmenityInfo> builderProjectAmenityInfos) {
		this.builderProjectAmenityInfos = builderProjectAmenityInfos;
	}

	public Set<BuilderProjectBankInfo> getBuilderProjectBankInfos() {
		return builderProjectBankInfos;
	}

	public void setBuilderProjectBankInfos(Set<BuilderProjectBankInfo> builderProjectBankInfos) {
		this.builderProjectBankInfos = builderProjectBankInfos;
	}

	public Set<BuilderProjectPriceInfo> getBuilderProjectPriceInfos() {
		return builderProjectPriceInfos;
	}

	public void setBuilderProjectPriceInfos(Set<BuilderProjectPriceInfo> builderProjectPriceInfos) {
		this.builderProjectPriceInfos = builderProjectPriceInfos;
	}

	public Set<BuilderProjectPaymentInfo> getBuilderProjectPaymentInfos() {
		return builderProjectPaymentInfos;
	}

	public void setBuilderProjectPaymentInfos(Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos) {
		this.builderProjectPaymentInfos = builderProjectPaymentInfos;
	}

	public Set<BuilderProjectProjectType> getBuilderProjectProjectTypes() {
		return builderProjectProjectTypes;
	}

	public void setBuilderProjectProjectTypes(Set<BuilderProjectProjectType> builderProjectProjectTypes) {
		this.builderProjectProjectTypes = builderProjectProjectTypes;
	}

	public Set<BuilderProjectApprovalInfo> getBuilderProjectApprovalInfos() {
		return builderProjectApprovalInfos;
	}

	public void setBuilderProjectApprovalInfos(Set<BuilderProjectApprovalInfo> builderProjectApprovalInfos) {
		this.builderProjectApprovalInfos = builderProjectApprovalInfos;
	}

	public Set<BuilderProjectPropertyType> getBuilderProjectPropertyTypes() {
		return builderProjectPropertyTypes;
	}

	public void setBuilderProjectPropertyTypes(Set<BuilderProjectPropertyType> builderProjectPropertyTypes) {
		this.builderProjectPropertyTypes = builderProjectPropertyTypes;
	}

	public Set<ProjectAmenityWeightage> getProjectAmenityWeightages() {
		return projectAmenityWeightages;
	}

	public void setProjectAmenityWeightages(
			Set<ProjectAmenityWeightage> projectAmenityWeightages) {
		this.projectAmenityWeightages = projectAmenityWeightages;
	}

}
