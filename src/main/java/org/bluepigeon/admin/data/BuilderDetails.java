package org.bluepigeon.admin.data;

import java.util.List;
import java.util.Set;

import org.bluepigeon.admin.model.Builder;
import org.bluepigeon.admin.model.BuilderCompanyNames;

public class BuilderDetails {
   private Builder builder;
   private List<BuilderCompanyNames>  builderCompanyNames;
public Builder getBuilder() {
	return builder;
}
public void setBuilder(Builder builder) {
	this.builder = builder;
}
public List<BuilderCompanyNames> getBuilderCompanyNames() {
	return builderCompanyNames;
}
public void setBuilderCompanyNames(List<BuilderCompanyNames> builderCompanyNames) {
	this.builderCompanyNames = builderCompanyNames;
}
   
}
