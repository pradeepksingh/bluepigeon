package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.ProjectWeightage;

public class ProjectWeightageData {
	
	private Integer projectId;
	private Set<ProjectWeightage> projectWeightages = new HashSet<ProjectWeightage>(0);

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Set<ProjectWeightage> getProjectWeightages() {
		return projectWeightages;
	}

	public void setProjectWeightages(
			Set<ProjectWeightage> projectWeightages) {
		this.projectWeightages = projectWeightages;
	}
	
}
