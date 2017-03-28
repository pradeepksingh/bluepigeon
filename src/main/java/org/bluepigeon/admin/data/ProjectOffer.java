package org.bluepigeon.admin.data;

import java.util.HashSet;
import java.util.Set;

import org.bluepigeon.admin.model.BuilderProject;
import org.bluepigeon.admin.model.BuilderProjectOfferInfo;

public class ProjectOffer {

	private BuilderProject builderProject;
	private Set<BuilderProjectOfferInfo> builderProjectOfferInfos = new HashSet<BuilderProjectOfferInfo>(0);
	
	public BuilderProject getBuilderProject() {
		return builderProject;
	}
	public void setBuilderProject(BuilderProject builderProject) {
		this.builderProject = builderProject;
	}
	public Set<BuilderProjectOfferInfo> getBuilderProjectOfferInfos() {
		return builderProjectOfferInfos;
	}

	public void setBuilderProjectOfferInfos(Set<BuilderProjectOfferInfo> builderProjectProjectTypes) {
		this.builderProjectOfferInfos = builderProjectOfferInfos;
	}
}
