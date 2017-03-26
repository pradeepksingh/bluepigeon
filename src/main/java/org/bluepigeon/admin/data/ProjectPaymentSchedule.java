package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectPaymentInfo;

public class ProjectPaymentSchedule {
	
	private BuilderProject builderProject;
	private Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new HashSet<BuilderProjectPaymentInfo>(0);
	
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	public Set<BuilderProjectPaymentInfo> getBuilderProjectPaymentInfos() {
		return builderProjectPaymentInfos;
	}
	public void setBuilderProjectPaymentInfos(Set<BuilderProjectPaymentInfo> builderProjectPaymentInfos) {
		this.builderProjectPaymentInfos = builderProjectPaymentInfos;
	}

}
