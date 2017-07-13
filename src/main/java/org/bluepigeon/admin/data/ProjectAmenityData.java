package org.bluepigeon.admin.data;

import java.util.List;

import org.bluepigeon.admin.model.BuilderBuilding;
import org.bluepigeon.admin.model.BuilderProject;

public class ProjectAmenityData {
	private BuilderProject  builderProject;
	private List<BuilderBuilding> builderBuildings;
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	public List<BuilderBuilding> getBuilderBuildings() {
		return builderBuildings;
	}
	public void setBuilderBuildings(List<BuilderBuilding> builderBuildings) {
		this.builderBuildings = builderBuildings;
	}
}
