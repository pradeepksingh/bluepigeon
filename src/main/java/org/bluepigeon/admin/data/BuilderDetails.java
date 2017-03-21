package org.bluepigeon.admin.data;

import java.util.Set;

import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;

public class BuilderDetails {
   private Builder builder;
   private Set<BuilderCompanyNames>  builderCompanyNames;
public Builder getBuilder() {
	return builder;
}
public void setBuilder(Builder builder) {
	this.builder = builder;
}
public Set<BuilderCompanyNames> getBuilderCompanyNames() {
	return builderCompanyNames;
}
public void setBuilderCompanyNames(Set<BuilderCompanyNames> builderCompanyNames) {
	this.builderCompanyNames = builderCompanyNames;
}
   
}
