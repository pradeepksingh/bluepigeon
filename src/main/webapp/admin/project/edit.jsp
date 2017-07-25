   <%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.Tax"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectType"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalType"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectProjectType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectBankInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPriceInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectOfferInfo"%>
<%@page import="org.bluepigeon.admin.model.ProjectAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.ProjectStage"%>
<%@page import="org.bluepigeon.admin.model.ProjectSubstage"%>
<%@page import="org.bluepigeon.admin.model.ProjectWeightage"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectBankInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPriceInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPaymentInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectOfferInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectSubstagesDAO"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	int project_id = 0;
	int p_user_id = 0;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	BuilderProject builderProject = new ProjectDAO().getBuilderProjectById(project_id);
	List<Builder> builders = new BuilderDetailsDAO().getActiveBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getActiveCountryList();
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	Set<State> states = null;
	Set<City> cities = null;
	Set<Locality> localities = null;
	List<Tax> taxes = new ArrayList<Tax>();
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
   	}
	List<BuilderProjectType> projectTypes = new BuilderProjectTypeDAO().getBuilderProjectTypes();
	List<BuilderPropertyType> propertyTypes = new BuilderPropertyTypeDAO().getBuilderActivePropertyTypes();
	List<BuilderProjectPropertyConfiguration> projectConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderActiveProjectConfigurations();
	List<BuilderProjectAmenity> projectAmenities = new BuilderProjectAmenityDAO().getBuilderActiveProjectAmenityList();
	List<BuilderProjectApprovalType> projectApprovals = new BuilderProjectApprovalTypeDAO().getBuilderActiveProjectApprovalTypes();
	List<HomeLoanBanks> homeLoanBanks = new HomeLoanBanksDAO().getActiveHomeLoanBanksList();
	List<AreaUnit> areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectApprovalInfo> projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectBankInfo> projectBankInfos = new BuilderProjectBankInfoDAO().getBuilderProjectBankInfos(project_id);
	BuilderProjectPriceInfo projectPriceInfo = new BuilderProjectPriceInfoDAO().getBuilderProjectPriceInfo(project_id);
	List<BuilderProjectPaymentInfo> projectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(project_id);
	List<BuilderProjectOfferInfo> projectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
	List<ProjectAmenityWeightage> amenityWeightages = new ProjectDAO().getProjectAmenityWeightageByProjectId(project_id);
	if(builderProject.getPincode() != "" && builderProject.getPincode() != null) {
		taxes = new ProjectDAO().getProjectTaxByPincode(builderProject.getPincode());
	}
	List<ProjectStage> projectStages = new ProjectStageDAO().getActiveProjectStages();
	List<ProjectWeightage> projectWeightages = new ProjectDAO().getProjectWeightage(project_id);
	List<BuilderBuilding> builderBuildings = new ProjectDAO().getBuilderProjectBuildings(project_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/list.jsp">Project</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Update 
					<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp" class="btn btn-default btn-sm"> << Project List</a></span>
				</h1>
			</div>
			<ul class="nav nav-tabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#projectimageupload">Project Image</a></li>
			  	<li><a data-toggle="tab" href="#projectdetail">Project Details</a></li>
			  	<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			  	<li><a data-toggle="tab" href="#productsubstage"> Project Weightage</a></li>
			</ul>
			<div class="tab-content">
			  	<div id="basic" class="tab-pane fade in active">
			  		<form id="basicfrm" name="basicfrm" method="post">
			  			<div id="basicresponse"></div>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="id" id="id" value="<% out.print(project_id);%>"/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-builder_id">
													<label class="control-label col-sm-4">Builder Group <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
														<select id="builder_id" name="builder_id" class="form-control">
															<option value="">Select Builder Group</option>
															<% for (Builder builder : builders) { %>
															<option value="<%out.print(builder.getId());%>" <% if(builderProject.getBuilder().getId() ==  builder.getId()) { %>selected<% } %>> <% out.print(builder.getName()); %> </option>
															<% } %>
														</select>
														</div>
														<div class="messageContainer"></div>
													</div>
													
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-company_id">
													<label class="control-label col-sm-4">Builder Company <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select id="company_id" name="company_id" class="form-control">
																<option value="">Select Builder Company</option>
																<% for (Builder builder : builders) { %>
																<% for (BuilderCompanyNames builderCompanyNames : builder.getBuilderCompanyNameses()) { %>
																<% if(builderProject.getBuilder().getId() ==  builder.getId()) { %>
																<option value="<%out.print(builderCompanyNames.getId());%>" <% if(builderProject.getBuilderCompanyNames().getId() ==  builderCompanyNames.getId()) { %>selected<% } %>> <% out.print(builderCompanyNames.getName()); %> </option>
																<% } %>
																<% } %>
																<% } %>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
													
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Project Name <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderProject.getName());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Landmark  <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="landmark" name="landmark" value="<% if(builderProject.getAddr1()!=null){out.print(builderProject.getAddr1());}%>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-sublocation">
													<label class="control-label col-sm-4">Sub Location  <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="sublocation" name="sublocation" value="<% if(builderProject.getAddr2() != null){out.print(builderProject.getAddr2());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-country_id">
													<label class="control-label col-sm-4">Country <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select name="country_id" id="country_id" class="form-control">
											                    <option value="">Select Country</option>
											                    <% 
											                    	if(listCountry != null){
											                    	for(Country country : listCountry){ 
											                    		
											                    	%>
											                    <% 	if(builderProject.getCountry().getId() == country.getId()) { 
											                    		states = country.getStates();
											                    	}
											                    %>
																<option value="<% out.print(country.getId());%>" <% if(builderProject.getCountry().getId() == country.getId()) { %>selected<% } %>><% out.print(country.getName());%></option>
																<% }} %>
												             </select>
											             </div>
											             <div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-4">State <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select name="state_id" id="state_id" class="form-control">
											                    <option value="">Select State</option>
											                    <% 
											                    	if(states !=null){
											                    	for(State state : states) { 
											                    	
											                    %>
											                    <% 	if(builderProject.getState().getId() == state.getId()) {
											                    		cities = state.getCities();
											                    		out.print(state.getName());
											                    	}
											                    	if(state.getStatus() == 1) {
											                    %>
																<option value="<% out.print(state.getId());%>" <% if(builderProject.getState().getId() == state.getId()) { %>selected<% } %>><% out.print(state.getName());%></option>
																<% }}} %>
												          	</select>
											          	</div>
											          	<div class="messageContainer"></div>
													</div>
													
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-city_id">
													<label class="control-label col-sm-4">City <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select name="city_id" id="city_id" class="form-control">
											                	<option value="">Select City</option>
											                    <%	if(cities !=null){ 
											                    	for(City city : cities){ %>
											                    <% 	if(builderProject.getCity().getId() == city.getId()) { 
											                    		localities = city.getLocalities();
											                    	}
											                    	if(city.getStatus() == 1) {
											                    %>
																<option value="<% out.print(city.getId());%>" <% if(builderProject.getCity().getId() == city.getId()) { %>selected<% } %>><% out.print(city.getName());%></option>
																<% }} }%>
												          	</select>
											          	</div>
											          	<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-locality_id">
													<label class="control-label col-sm-4">Locality <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select name="locality_id" id="locality_id" class="form-control">
											                	<option value="">Select Locality</option>
											                	<% 
											                		if(localities != null){
											                			for(Locality locality : localities){ 
											                				if(locality.getStatus()) {
											                	%>
																<option value="<% out.print(locality.getId());%>" <% if(builderProject.getLocality().getId() == locality.getId()) { %>selected<% } %>><% out.print(locality.getName());%></option>
																<% }}} %>
												          	</select>
											          	</div>
											          	<div class="messageContainer"></div>
													</div>
													
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-pincode">
													<label class="control-label col-sm-4">Pincode <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="pincode" name="pincode" autocomplete="off" value="<% out.print(builderProject.getPincode());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-latitude">
													<label class="control-label col-sm-4">Latitude <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
														<input type="text" class="form-control" id="latitude" name="latitude" autocomplete="off" value="<% out.print(builderProject.getLatitude());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-longitude">
													<label class="control-label col-sm-4">Longitude <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="longitude" name="longitude" autocomplete="off" value="<% out.print(builderProject.getLongitude());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group">
													<label class="control-label col-sm-4">Description </label>
													<div class="col-sm-8">
														<textarea class="form-control" id="description" name="description"><% out.print(builderProject.getDescription());%></textarea>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group">
													<label class="control-label col-sm-4">Highlight (USP) </label>
													<div class="col-sm-8">
														<textarea class="form-control" id="highlight" name="highlight"><% out.print(builderProject.getHighlights());%></textarea>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-highlight">
													<label class="control-label col-sm-4">Status </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<option value="0" <% if(builderProject.getStatus() == 0) { %>selected<% } %>>Inactive</option>
															<option value="1" <% if(builderProject.getStatus() == 1) { %>selected<% } %>>Active</option>
														</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
										<div class="col-lg-6">
												<div class="col-sm-12">
													<button type="submit" name="basicbtn" class="btn btn-success btn-sm">Submit</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="projectimageupload" class="tab-pane fade">
					<form id="updateimage" name="updateimage" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div id="imageresponse"></div>
							<input type="hidden" name="project_id" id="project_id" value="<% out.print(builderProject.getId());%>"/>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Project Image</h3>
										<br>
										<div class="row" id="project_images">
											<div class="col-lg-4 margin-bottom-5">
											<% if( builderProject != null) { %>
											
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Project Images" src="${baseUrl}/<% out.print(builderProject.getImage()); %>" width="200px;">
													</div>
												</div>
											<% } %>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">'
												<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id="project_image" name="project_image[]" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom">
												<div class="form-group" id="error-landmark">'
												<label class="control-label col-sm-4">Image Title </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="text" class="form-control" id="project_image_title" name="project_image_title" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" name="imagebtn" class="btn btn-success btn-sm" onclick="updateProjectImages();">SAVE</button>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div id="projectdetail" class="tab-pane fade">
					<form id="detailfrm" name="detailfrm" method="post">
			 			<div class="row">
			 				<div id="detailresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Project Type <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderProjectType builderProjectType : projectTypes) { 
															String is_checked = "";
															for(BuilderProjectProjectType projectProjectType :projectProjectTypes) {
																if(builderProjectType.getId() == projectProjectType.getBuilderProjectType().getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="project_type[]" value="<% out.print(builderProjectType.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderProjectType.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-property_type">
													<label class="control-label col-sm-2">Property Type <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderPropertyType builderPropertyType : propertyTypes) { 
															String is_checked = "";
															int prop_value = 0;
															for(BuilderProjectPropertyType projectPropertyType :projectPropertyTypes) {
																if(builderPropertyType.getId() == projectPropertyType.getBuilderPropertyType().getId()) {
																	is_checked = "checked";
																	if(projectPropertyType.getValue() != null)
																	prop_value = projectPropertyType.getValue();
																}
															}
														%>
														<div class="col-sm-3">
															<div>
																<input type="checkbox" name="property_type[]" value="<% out.print(builderPropertyType.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderPropertyType.getName());%>
															</div>
															<div>
																<input type="number" class="form-control" id="property_type<% out.print(builderPropertyType.getId());%>" name="property_type<% out.print(builderPropertyType.getId());%>" value="<% out.print(prop_value); %>" placeholder="No. Of <% out.print(builderPropertyType.getName());%>"/>
															</div>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-configuration">
													<label class="control-label col-sm-2">Configurations <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderProjectPropertyConfiguration projectConfiguration : projectConfigurations) { 
															String is_checked = "";
															for(BuilderProjectPropertyConfigurationInfo projectConfigurationInfo :projectConfigurationInfos) {
																if(projectConfiguration.getId() == projectConfigurationInfo.getBuilderProjectPropertyConfiguration().getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="configuration[]" value="<% out.print(projectConfiguration.getId());%>" <% out.print(is_checked); %>/> <% out.print(projectConfiguration.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Project Amenities </label>
													<div class="col-sm-10">
														<% 	for(BuilderProjectAmenity projectAmenity : projectAmenities) { 
															String is_checked = "";
															for(BuilderProjectAmenityInfo projectAmenityInfo :projectAmenityInfos) {
																if(projectAmenity.getId() == projectAmenityInfo.getBuilderProjectAmenity().getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(projectAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(projectAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Project Amenities Weightage </label>
													<div class="col-sm-10">
														<% 	for(BuilderProjectAmenity projectAmenity : projectAmenities) { 
															String is_checked = "";
															for(BuilderProjectAmenityInfo projectAmenityInfo :projectAmenityInfos) {
																if(projectAmenity.getId() == projectAmenityInfo.getBuilderProjectAmenity().getId()) {
																	is_checked = "checked";
																}
															}
															Double amenity_wt = 0.0;
															for(ProjectAmenityWeightage projectAmenityWeightage :amenityWeightages) {
																if(projectAmenity.getId() == projectAmenityWeightage.getBuilderProjectAmenity().getId()) {
																	amenity_wt = projectAmenityWeightage.getAmenityWeightage();
																}
															}
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(projectAmenity.getId());%>" style="<% if(is_checked == "checked") {%>display:block;<% } else { %>display:none;<% } %>margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;"><strong><% out.print(projectAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" onkeypress=" return isNumber(event, this);" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(projectAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
																</div>
															</div>
															<% 	for(BuilderProjectAmenityStages bpaStages :projectAmenity.getBuilderProjectAmenityStageses()) { 
																Double stage_wt = 0.0;
																for(ProjectAmenityWeightage projectAmenityWeightage :amenityWeightages) {
																	if(bpaStages.getId() == projectAmenityWeightage.getBuilderProjectAmenityStages().getId()) {
																		stage_wt = projectAmenityWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(projectAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control" onkeypress=" return isNumber(event, this);" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderProjectAmenitySubstages bpaSubstage :bpaStages.getBuilderProjectAmenitySubstageses()) { 
																		Double substage_wt = 0.0;
																		for(ProjectAmenityWeightage projectAmenityWeightage :amenityWeightages) {
																			if(bpaSubstage.getId() == projectAmenityWeightage.getBuilderProjectAmenitySubstages().getId()) {
																				substage_wt = projectAmenityWeightage.getSubstageWeightage();
																			}
																		}
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="text" onkeypress=" return isNumber(event, this);" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
																		</div>
																	<% } %>
																	</fieldset>
																</div>
															</fieldset>
															<% } %>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-approval_type">
													<label class="control-label col-sm-2">Project Approvals </label>
													<div class="col-sm-10">
														<% for(BuilderProjectApprovalType projectApproval : projectApprovals) { 
															String is_checked = "";
															for(BuilderProjectApprovalInfo projectApprovalInfo :projectApprovalInfos) {
																if(projectApproval.getId() == projectApprovalInfo.getBuilderProjectApprovalType().getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="approval_type[]" value="<% out.print(projectApproval.getId());%>" <% out.print(is_checked); %>/> <% out.print(projectApproval.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-homeloan_bank">
													<label class="control-label col-sm-2">Home Loan Banks </label>
													<div class="col-sm-10">
														<% 	for(HomeLoanBanks homeLoanBank : homeLoanBanks) { 
															String is_checked = "";
															for(BuilderProjectBankInfo projectBankInfo :projectBankInfos) {
																if(homeLoanBank.getId() == projectBankInfo.getHomeLoanBanks().getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="homeloan_bank[]" value="<% out.print(homeLoanBank.getId());%>" <% out.print(is_checked); %>/> <% out.print(homeLoanBank.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<hr/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Project Area <span class='text-danger'>*</span></label>
													<div class="col-sm-4">
														<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="project_area" name="project_area" value="<% if(builderProject.getProjectArea() != null) { out.print(builderProject.getProjectArea());}%>"/>
													</div>
													<div class="messageContainer"></div>
													<div class="col-sm-4">
														<select name="area_unit" id="area_unit" class="form-control">
															<% for(AreaUnit areaUnit :areaUnits) { %>
															<option value="<% out.print(areaUnit.getId()); %>" <% if(builderProject.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
															<% } %>
														</select>
													</div>
												</div>
											</div>
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Launch Date </label>
													<div class="col-sm-4">
														<input type="text" class="form-control" id="launch_date" name="launch_date" value="<% if(builderProject.getLaunchDate() != null) { out.print(dt1.format(builderProject.getLaunchDate()));} %>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6">
												<div class="col-sm-12">
													<button type="submit" class="btn btn-success btn-sm" id="detailbtn">SAVE</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="pricing" class="tab-pane fade">
					<form id="pricingfrm" name="pricingfrm" method="post">
						<input type="hidden" name="id" value="<% out.print(projectPriceInfo.getId());%>"/>
						<input type="hidden" name="project_id" value="<% out.print(project_id);%>"/>
			 			<div class="row">
			 				<div id="pricingresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="row">
											<div class="col-lg-6">
												<div class="form-group" id="error-base_unit">
													<label class="control-label col-sm-4">Pricing Unit <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<select name="base_unit" id="base_unit" class="form-control">
																<%	if(projectPriceInfo.getAreaUnit() != null){ 
																for(AreaUnit areaUnit :areaUnits) { %>
																<option value="<% out.print(areaUnit.getId()); %>" <% if(projectPriceInfo.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
																<% }} %>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-base_rate">
													<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% if(projectPriceInfo.getBasePrice() != null){ out.print(projectPriceInfo.getBasePrice());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-rise_rate">
													<label class="control-label col-sm-4">Floor Rise Rate<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<% if(projectPriceInfo.getRiseRate() != null){ out.print(projectPriceInfo.getRiseRate());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-post">
													<label class="control-label col-sm-4">Applicable Post <span class='text-danger'>*</span></label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<div>
															<input type="text" class="form-control" id="post" name="post" value="<% if(projectPriceInfo.getPost() != null){ out.print(projectPriceInfo.getPost());}%>"/>
															<span class="input-group-addon">floor</span>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-maintenance">
													<label class="control-label col-sm-4">Maintenance Charge <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(projectPriceInfo.getMaintenance() != null){ out.print(projectPriceInfo.getMaintenance());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure <span class='text-danger'>*</span></label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
															<div>
																<input type="text" class="form-control" id="tenure" name="tenure" value="<% out.print(projectPriceInfo.getTenure());%>"/>
																<span class="input-group-addon">Months</span>
															</div>
															<div class="messageContainer"></div>
													</div>
														
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% if(projectPriceInfo.getAmenityRate() != null){ out.print(projectPriceInfo.getAmenityRate());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="parking" name="parking" value="<% if(projectPriceInfo.getParking() != null){ out.print(projectPriceInfo.getParking());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Stamp Duty <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(projectPriceInfo.getStampDuty() != null){ out.print(projectPriceInfo.getStampDuty());} else {if(taxes.size() > 0){out.print(taxes.get(0).getStampDuty());}}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="tax" name="tax" value="<% if(projectPriceInfo.getTax() != null){ out.print(projectPriceInfo.getTax());} else {if(taxes.size() > 0){out.print(taxes.get(0).getTax());}}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-vat">
													<label class="control-label col-sm-4">VAT <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
														<input type="text" class="form-control" id="vat" name="vat" value="<% if(projectPriceInfo.getVat() != null){ out.print(projectPriceInfo.getVat());} else {if(taxes.size() > 0){out.print(taxes.get(0).getVat());}}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tech_fee">
													<label class="control-label col-sm-4">Tech Fees<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<div>
															<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(projectPriceInfo.getFee() != null){ out.print(projectPriceInfo.getFee());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="col-sm-12">
													<button type="submit" class="btn btn-success btn-sm" id="pricebtn">SAVE</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="payment" class="tab-pane fade">
					<form id="paymentfrm" name="paymentfrm" method="post" action=""  enctype="multipart/form-data">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(projectPaymentInfos.size()+1);%>"/>
						<input type="hidden" name="project_id" id="project_id[]" value="<%out.print(project_id);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% 	int i = 1;
  												for(BuilderProjectPaymentInfo projectPaymentInfo :projectPaymentInfos) {  
 											%> 
 											<input type="hidden" id="schedule_id" name="schedule_id[]" value="<%out.print(projectPaymentInfo.getId());%>"/>
											<div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getSchedule() != null) { out.print(projectPaymentInfo.getSchedule());}%>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable <span class='text-danger'>*</span></label>
														<div class="col-sm-4">
															<input type="text" class="form-control" onkeyup="javascript:vaildPayablePer(<%out.print(i); %>)" onkeypress=" return isNumber(event, this);" id="payable<%out.print(i); %>" name="payable[]" value="<% if(projectPaymentInfo.getPayable() != null) { out.print(projectPaymentInfo.getPayable());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<!-- div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount <span class='text-danger'>*</span></label>
														<div class="col-sm-6">
															<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="amount" name="amount[]" value="<% if(projectPaymentInfo.getAmount() != null) { out.print(projectPaymentInfo.getAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div-->
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% i++; } %>
											<% if(i <= 1) { %>
											<input type="hidden" id="schedule_id" name="schedule_id[]" value="0"/>
											<div class="row" id="schedule-0">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable <span class='text-danger'>*</span></label>
														<div class="col-sm-4">
															<input type="text" class="form-control"  onkeypress=" return isNumber(event, this);" id="payable" name="payable[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% } %>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a>
												</span>
											</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="submit" class="btn btn-success btn-sm" id="paymentbtn">SAVE</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="offer" class="tab-pane fade">
					<form id="offerfrm" name="offerfrm" method="post" action=""  enctype="multipart/form-data">
						<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(projectOfferInfos.size()+10000); %>"/>
						<input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id);%>"/>
			 			<div class="row">
			 			<div id="offerresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<% 	int j = 1;
												for(BuilderProjectOfferInfo projectOfferInfo :projectOfferInfos) { 
											%>
											<div class="row" id="offer-<% out.print(projectOfferInfo.getId()); %>">
												<input type="hidden" name="offer_id[]" value="<% out.print(projectOfferInfo.getId()); %>" />
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(projectOfferInfo.getId()); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% out.print(projectOfferInfo.getTitle()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-6">Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-6">
															<input type="text" class="form-control " id="discount" onkeypress=" return isNumber(event, this);" name="discount[]" value="<% out.print(projectOfferInfo.getPer()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-4 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-6">Discount Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="discount_amount<%out.print(j); %>" onkeyup=" javascript:onlyNumber(<%out.print(j); %>);" name="discount_amount[]" value="<% out.print(projectOfferInfo.getAmount()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Description </label>
														<div class="col-sm-8">
															<textarea class="form-control" id="description" name="description[]" ><% if(projectOfferInfo.getDescription() != null) { out.print(projectOfferInfo.getDescription());} %></textarea>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-6">Offer Type </label>
														<div class="col-sm-6">
															<select class="form-control" id="offer_type" name="offer_type[]">
																<option value="1" <% if(projectOfferInfo.getType() == 1) { %>selected<% } %>>Percentage</option>
																<option value="2" <% if(projectOfferInfo.getType() == 2) { %>selected<% } %>>Flat Amount</option>
																<option value="3" <% if(projectOfferInfo.getType() == 3) { %>selected<% } %>>Other</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-4 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-6">Status </label>
														<div class="col-sm-6">
															<select class="form-control" id="offer_status" name="offer_status[]">
																<option value="1" <% if(projectOfferInfo.getStatus().toString() == "1") { %>selected<% } %>>Active</option>
																<option value="0" <% if(projectOfferInfo.getStatus().toString() == "0") { %>selected<% } %>>Inactive</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<% j++; } %>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreOffer();" class="btn btn-info btn-xs">+ Add More Offers</a>
												</span>
											</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="submit" class="btn btn-success btn-sm" id="offerbtn">SAVE</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="productsubstage" class="tab-pane fade">
					<form id="subpfrm" name="subpfrm" method="post">
			 			<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<div class="row">
												<div class="col-lg-12 margin-bottom-5">
														<div class="row" id="error-amenity_type">
															<div class="col-sm-6">
																<div class="form-group" id="error-amenity_weightage">
																	<label class="control-label col-sm-6">Amenity Weightage </label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="amenity_weightage" name="amenity_weightage" value="<%out.print(builderProject.getAmenityWeightage());%>" placeholder="amenity weightage in %"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="row" id="error-amenity_type">
															<div class="col-sm-6">
																<div class="form-group" id="error-discount_amount">
																	<label class="control-label col-sm-6">Building Weightage</label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control" id="building_weightage" onkeypress=" return isNumber(event, this);" name="building_weightage" value="<%out.print(builderProject.getBuildingWeightage());%>"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="col-sm-12">
															<label class="control-label col-sm-6">Buildings</label>
														</div>
														<%
														  if(builderBuildings != null){
															  for(BuilderBuilding builderBuilding : builderBuildings ){
														%>
														<input type="hidden" id="building_ids" name="building_ids[]" value="<%out.print(builderBuilding.getId());%>">
														<div class="col-sm-4 margin-bottom-5">
															<div class="form-group" id="error-discount_amount">
																<label class="control-label col-sm-6"><%out.print(builderBuilding.getName()); %></label>
																<div class="col-sm-6">
																	<input type="text" class="form-control" id="weightage[]" name="weightage[]" onkeypress=" return isNumber(event, this);" value="<%out.print(builderBuilding.getWeightage());%>"/>
																</div>
																<div class="messageContainer"></div>
															</div>
														</div>	  
														<%	  }
														  }
														%>
													</div>
												</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" class="btn btn-success btn-sm" id="subpbtn">SAVE</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<br> <br>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
	.margin-bottom-5 {
		padding-bottom:5px;
	}
	fieldset.scheduler-border {
	    border: 1px groove #ddd !important;
	    padding: 0 1.4em 1.4em 1.4em !important;
	    margin: 0 0 1.5em 0 !important;
	    -webkit-box-shadow:  0px 0px 0px 0px #000;
	            box-shadow:  0px 0px 0px 0px #000;
	}
	legend.scheduler-border {
	    width:inherit; /* Or auto */
	    padding:0 10px; /* To give a bit of padding on the left and right */
	    border-bottom:none;
	    margin-bottom:5px;
	}
</style>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/css/bootstrap-select.min.css" />
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>
<script>
// $(".errorMsg").keypress(function(event){
// 	alert("Hello");
// 	return isNumber(event, this)
// });

$("input.errorMsg").keypress(function(event){
	//alert("Hello");
	return isNumber(event, this)
});
function vaildPayablePer(id){
	//alert($("#discount"+id).val());
	var x = $("#payable"+id).val();
	//alert(x);
	if( x<0 || x >100){
		alert("The percentage must be between 0 and 100");
		$("#payable"+id).val('');
	}
}
$('#latitude').keypress(function (event) {
    return isNumber(event, this)
});
$('#longitude').keypress(function (event) {
    return isNumber(event, this)
});
$('#project_area').keypress(function (event) {
    return isNumber(event, this)
});

$('#landmark').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9, ]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
});

$('#sublocation').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9, ]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
});
$("#pincode").attr('maxlength','6');
$('#pincode').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease use only numbers.'); return ''; } ) );
});
$('#post').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease use only numbers.'); return ''; } ) );
});
$('#tenure').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease use only numbers.'); return ''; } ) );
});
$('#base_rate').keypress(function (event) {
    return isNumber(event, this)
});
$('#rise_rate').keypress(function (event) {
    return isNumber(event, this)
});
$('#maintenance').keypress(function (event) {
    return isNumber(event, this)
});
$('#amenity_rate').keypress(function (event) {
    return isNumber(event, this)
});
$('#parking').keypress(function (event) {
    return isNumber(event, this)
});
$('#stamp_duty').keypress(function (event) {
    return isNumber(event, this)
});
$('#tax').keypress(function (event) {
    return isNumber(event, this)
});
$('#vat').keypress(function (event) {
    return isNumber(event, this)
});
$('#tech_fee').keypress(function (event) {
    return isNumber(event, this)
});
$('#payable').keypress(function (event) {
    return isNumber(event, this)
});
$('#amount').keypress(function (event) {
    return isNumber(event, this)
});
$('#discount').keypress(function (event) {
    return isNumber(event, this)
});
$('#discount_amount').keypress(function (event) {
    return isNumber(event, this)
});
$("#amenity_weightage").keypress(function(event){
	return isNumber(event, this)
});
$("#building_weightage").keypress(function(event){
	return isNumber(event, this)
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode
    if ((charCode != 46 || $(element).val().indexOf('.') != -1) && (charCode < 48 || charCode > 57))
        return false;

    return true;
} 




function onlyNumber(id){
	
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
}

function notEmpty(){
	//alert("Again Not Empty");
	
}
$('#schedule').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9, ]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
});
$('#launch_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#detailfrm').data('bootstrapValidator').revalidateField('launch_date');
});
$("#builder_id").change(function(){
	if($("#builder_id").val() != "") {
		$.get("${baseUrl}/webapi/create/project/list/",{ builder_id: $("#builder_id").val() }, function(data){
			var html = '<option value="">Select Builder Comapny</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#company_id").html(html);
		},'json');
	}
});
$("#country_id").change(function(){
	if($("#country_id").val() != "") {
		$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
			var html = '<option value="">Select State</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#state_id").html(html);
		},'json');
	}
});

$("#state_id").change(function(){
	if($("#state_id").val() != "") {
		$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
			var html = '<option value="">Select City</option>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			});
			$("#city_id").html(html);
		},'json');
	}
});
$("#city_id").change(function(){
	if($("#city_id").val() != "") {
		$.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#city_id").val() }, function(data){
			var html = '<option value="">Select Locality</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#locality_id").html(html);
		},'json');
	}
});
function updateProjectImages() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddImageRequest,
	 		success :  showAddImageResponse,
	 		url : '${baseUrl}/webapi/project/image/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateimage').ajaxSubmit(options);
}

function showAddImageRequest(formData, jqForm, options){
	$("#imageresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddImageResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#imageresponse").removeClass('alert-success');
       	$("#imageresponse").addClass('alert-danger');
		$("#imageresponse").html(resp.message);
		$("#imageresponse").show();
  	} else {
  		$("#imageresponse").removeClass('alert-danger');
        $("#imageresponse").addClass('alert-success');
        $("#imageresponse").html(resp.message);
        $("#imageresponse").show();
        alert(resp.message);
  	}
}
$('#basicfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	builder_id: {
            validators: {
                notEmpty: {
                    message: 'Builder Group is required and cannot be empty'
                }
            }
        },
    	company_id: {
            validators: {
                notEmpty: {
                    message: 'Company Name is required and cannot be empty'
                }
            }
        },
        name: {
            validators: {
                notEmpty: {
                    message: 'Project Name is required and cannot be empty'
                }
            }
        },
        sublocation:{
        	 validators: {
                 notEmpty: {
                          message: 'Sub location is required and cannot be empty'
                 }
             }
        },
        landmark:{
        	 validators: {
                 notEmpty: {
                          message: 'landmark is required and cannot be empty'
                 }
             }
        },
        country_id: {
            validators: {
                notEmpty: {
                         message: 'Country Name is required and cannot be empty'
                }
            }
        },
        state_id: {
            validators: {
                notEmpty: {
                    message: 'State Name is required and cannot be empty'
                }
            }
        },
        city_id: {
            validators: {
                notEmpty: {
                    message: 'City Name is required and cannot be empty'
                }
            }
        },
        locality_id: {
            validators: {
                notEmpty: {
                    message: 'Locality Name is required and cannot be empty'
                }
            }
        },
        pincode: {
            validators: {
                notEmpty: {
                    message: 'The Pincode is required and cannot be empty'
                },
                stringLength: {
                    max: 6,
                    min: 6,
                    message: 'Invalid pin code.'
                }
            }
        },
        latitude: {
            validators: {
                notEmpty: {
                    message: 'Latitude is required and cannot be empty'
                }
            }
        },
        longitude: {
            validators: {
                notEmpty: {
                    message: 'Longitude is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProject();
});

function updateProject() {
	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/basic/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#basicfrm').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#basicresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#basicresponse").removeClass('alert-success');
       	$("#basicresponse").addClass('alert-danger');
		$("#basicresponse").html(resp.message);
		$("#basicresponse").show();
  	} else {
  		$("#basicresponse").removeClass('alert-danger');
        $("#basicresponse").addClass('alert-success');
        $("#basicresponse").html(resp.message);
        $("#basicresponse").show();
        alert(resp.message);
  	}
}

$('#pricingfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	base_rate: {
    		validators: {
                notEmpty: {
                    message: 'Base Rate is required and cannot be empty'
                },
                numeric: {
                 	message: 'Base Rate is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        base_unit: {
    		validators: {
                notEmpty: {
                    message: 'Pricing Unit is required and cannot be empty'
                },
            }
        },
        rise_rate:{
        	validators: {
                notEmpty: {
                    message: 'Floor rise rate is required and cannot be empty'
                },
            }
        },
        post:{
        	validators: {
                notEmpty: {
                    message: 'Applicable post is required and cannot be empty'
                },
            }
        },
        maintenance:{
        	validators: {
                notEmpty: {
                    message: 'Maintenance charges is required and cannot be empty'
                },
            }
        },
        tenure:{
        	validators: {
                notEmpty: {
                    message: 'Tenure is required and cannot be empty'
                },
            }
        },
        amenity_rate:{
        	validators: {
                notEmpty: {
                    message: 'Amenity rate is required and cannot be empty'
                },
            }
        },
        parking:{
        	validators: {
                notEmpty: {
                    message: 'Parking charges is required and cannot be empty'
                },
            }
        },
        stamp_duty:{
        	validators: {
                notEmpty: {
                    message: 'Stamp duty is required and cannot be empty'
                },
            }
        },
        tax:{
        	validators: {
                notEmpty: {
                    message: 'Tax is required and cannot be empty'
                },
            }
        },
        vat:{
        	validators: {
                notEmpty: {
                    message: 'Vat is required and cannot be empty'
                },
            }
        },
        tech_fee:{
       	 validators: {
                notEmpty: {
                    message: 'Tech fee is required and cannot be empty'
                }
            }
       }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProjectPrice();
});

function updateProjectPrice() {
	var options = {
	 		target : '#pricingresponse', 
	 		beforeSubmit : showPriceRequest,
	 		success :  showPriceResponse,
	 		url : '${baseUrl}/webapi/project/price/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#pricingfrm').ajaxSubmit(options);
}

function showPriceRequest(formData, jqForm, options){
	$("#pricingresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showPriceResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#pricingresponse").removeClass('alert-success');
       	$("#pricingresponse").addClass('alert-danger');
		$("#pricingresponse").html(resp.message);
		$("#pricingresponse").show();
  	} else {
  		$("#pricingresponse").removeClass('alert-danger');
        $("#pricingresponse").addClass('alert-success');
        $("#pricingresponse").html(resp.message);
        $("#pricingresponse").show();
        alert(resp.message);
  	}
}

$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

function saveProjectDetails(){
	var amenityWeightage = [];
	var projectType = [];
	var propertyType = [];
	var configuration = [];
	var amenityType = [];
	var approvalType = [];
	var homeLoanInfo = [];
	var paw = null;
	$('input[name="amenity_type[]"]:checked').each(function() {
		amenity_id = $(this).val();
		$('input[name="stage_weightage'+amenity_id+'[]"]').each(function() {
			stage_id = $(this).attr("id");
			stage_weightage = $(this).val();
			$('input[name="substage'+stage_id+'[]"]').each(function() {
				amenityWeightage.push({builderProject:{id:$("#id").val()},builderProjectAmenity:{id:amenity_id},amenityWeightage:$("#amenity_weightage"+amenity_id).val(),builderProjectAmenityStages:{id:stage_id},stageWeightage:stage_weightage,builderProjectAmenitySubstages:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
			});
		});
	});
	var project = {id:$("#id").val(),projectArea:$("#project_area").val(),areaUnit:{id:$("#area_unit").val()},launchDate:new Date($("#launch_date").val())};
	$('input[name="project_type[]"]:checked').each(function() {
		projectType.push({builderProjectType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	$('input[name="property_type[]"]:checked').each(function() {
		val = $("#property_type"+$(this).val()).val();
		propertyType.push({value:val,builderPropertyType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	$('input[name="configuration[]"]:checked').each(function() {
		configuration.push({builderProjectPropertyConfiguration:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	$('input[name="amenity_type[]"]:checked').each(function() {
		amenityType.push({builderProjectAmenity:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	$('input[name="approval_type[]"]:checked').each(function() {
		approvalType.push({builderProjectApprovalType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	$('input[name="homeloan_bank[]"]:checked').each(function() {
		homeLoanInfo.push({homeLoanBanks:{id:$(this).val()},builderProject:{id:$("#id").val()}});
	});
	var final_data = {builderProject:project,builderProjectProjectTypes:projectType,builderProjectPropertyTypes:propertyType,builderProjectPropertyConfigurationInfos:configuration,builderProjectAmenityInfos:amenityType,builderProjectApprovalInfos:approvalType,builderProjectBankInfos:homeLoanInfo,projectAmenityWeightages:amenityWeightage}
	$.ajax({
	    url: '${baseUrl}/webapi/project/detail/update',
	    type: 'POST',
	    data: JSON.stringify(final_data),
	    contentType: 'application/json; charset=utf-8',
	    dataType: 'json',
	    async: false,
	    success: function(data) {
			if (data.status == 0) {
				alert(data.message);
			} else {
				alert(data.message);
			}
		},
		error : function(data)
		{
			alert("Fail to save data");
		}
		
	});
}

$('#paymentfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	'schedule[]': {
            validators: {
		    	notEmpty: {
		    		message: 'Schedule is required and cannot be empty'
		        },
            }
        },
        'payable[]': {
            validators: {
            	between: {
                    min: 0,
                    max: 100,
                    message: 'The percentage must be between 0 and 100'
	        	},
// 	        	 callback: {
//                      message: 'The sum of percentages must be 100',
//                      callback: function(value, validator, $field) {
//                          var percentage = validator.getFieldElements('payable[]'),
//                              length     = percentage.length,
//                              sum        = 0;

//                          for (var i = 0; i < length; i++) {
//                              sum += parseFloat($(percentage[i]).val());
//                          }
//                          if (sum === 100) {
//                              validator.updateStatus('payable[]', 'VALID', 'callback');
//                              return true;
//                          }

//                          return false;
//                      }
//                  },
		        notEmpty: {
		    		message: 'Payable is required and cannot be empty'
		        },
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updatePaymentSchudle();
});
 
function updatePaymentSchudle(){
		var options = {
		 		target : '#paymentresponse', 
		 		beforeSubmit : showPaymentRequest,
		 		success :  showPaymentResponse,
		 		url : '${baseUrl}/webapi/project/payment/update',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#paymentfrm').ajaxSubmit(options);
}
function showPaymentRequest(formData, jqForm, options){
	$("#paymentresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showPaymentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#paymentresponse").removeClass('alert-success');
       	$("#paymentresponse").addClass('alert-danger');
		$("#paymentresponse").html(resp.message);
		$("#paymentresponse").show();
  	} else {
  		$("#paymentresponse").removeClass('alert-danger');
        $("#paymentresponse").addClass('alert-success');
        $("#paymentresponse").html(resp.message);
        $("#paymentresponse").show();
        alert(resp.message);
  	}
}
// function updateOffers(){
// 	var offerInfo = [];
// 	var discount = [];
// 	var amount = [];
// 	var description = [];
// 	var type = [];
// 	var status = [];
// 	$('input[name="discount[]"]').each(function(index) {
// 		alert($(this).val());
// 		discount.push($(this).val());
// 	});
// 	$('input[name="discount_amount[]"]').each(function(index) {
// 		alert($(this).val());
// 		amount.push($(this).val());
// 	});
// 	$('input[name="description[]"]').each(function(index) {
// 		alert($(this).val());
// 		description.push($(this).val());
// 	});
// 	$('select[name="offer_type[]"] option:selected').each(function(index) {
// 		alert($(this).val());
// 		type.push($(this).val());
// 	});
// 	$('select[name="offer_status[]"] option:selected').each(function(index) {
// 		status.push($(this).val());
// 	});
// 	$('input[name="offer_title[]"]').each(function(index) {
// 		if($(this).val() != "") {
// 			offerInfo.push({title:$(this).val(),per:discount[index],amount:amount[index],description:description[index],type:type[index],status:status[index],builderProject:{id:$("#id").val()}});
// 		}
// 	});
// 	var project = {id:$("#id").val()};
// 	var final_data = {builderProjectOfferInfos:offerInfo,builderProject:project}
// 	if(offerInfo.length > 0) {
// 		$.ajax({
// 		    url: '${baseUrl}/webapi/project/offer/project/update',
// 		    type: 'POST',
// 		    data: JSON.stringify(final_data),
// 		    contentType: 'application/json; charset=utf-8',
// 		    dataType: 'json',
// 		    async: false,
// 		    success: function(data) {
// 				if (data.status == 0) {
// 					alert(data.message);
// 				} else {
// 					alert(data.message);
// 				}
// 			},
// 			error : function(data)
// 			{
// 				alert("Fail to save data");
// 			}
			
// 		});
// 	} else {
// 		alert("Please enter offer details");
// 	}
// }

function validPer(id){
	//alert($("#discount"+id).val());
	var x = $("#discount"+id).val();
	//alert(x);
	if( x<0 || x >100){
		alert("The percentage must be between 0 and 100");
		$("#discount"+id).val('');
	}
}

$('#offerfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	'offer_title[]':{
    		validators: {
	            notEmpty: {
	                message: 'offer title is required and cannot be empty'
	            }
	        }
	    },
	    'discount[]': {
	        validators: {
	        	between: {
                    min: 0,
                    max: 100,
                    message: 'The percentage must be between 0 and 100'
	        	},
	            notEmpty: {
	                message: 'discount is required and cannot be empty'
	            }
	        }
	    },
	    'discount_amount[]': {
	        validators: {
	            notEmpty: {
	                message: 'discount amount is required and cannot be empty'
	            }
	        }
	    }
    		
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProjectOffers();
});
function updateProjectOffers(){
		var options = {
		 		target : '#offerresponse', 
		 		beforeSubmit : showOfferRequest,
		 		success :  showOfferResponse,
		 		url : '${baseUrl}/webapi/project/offerdetails/update',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#offerfrm').ajaxSubmit(options);
}
function showOfferRequest(formData, jqForm, options){
	$("#offerresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showOfferResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#offerresponse").removeClass('alert-success');
       	$("#offerresponse").addClass('alert-danger');
		$("#offerresponse").html(resp.message);
		$("#offerresponse").show();
  	} else {
  		$("#offerresponse").removeClass('alert-danger');
        $("#offerresponse").addClass('alert-success');
        $("#offerresponse").html(resp.message);
        $("#offerresponse").show();
        alert(resp.message);
  	}
}


function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="'+offers+'" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control errorMsg notEmpty" required id="offer_title" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
			+'<div class="form-group" id="error-discount">'
				+'<label class="control-label col-sm-6">Discount(%) <span class="text-danger">*</span></label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control  notEmpty" required id="discount'+offers+'" onkeyup="javascript:vaildPer('+offers+')"name="discount[]" value="" onkeypress="return isNumber(event, this);"/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-6">Discount Amount </label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control  notEmpty" required id="discount_amount'+offers+'" name="discount_amount[]" value=""  onkeyup="javascript:onlyNumber('+offers+');"/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4">Description </label>'
			+'<div class="col-sm-8">'
			+'<textarea class="form-control" id="description" name="description[]" ></textarea>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
		+'<div class="form-group" id="error-applicable_on">'
		+'<label class="control-label col-sm-6">Offer Type </label>'
		+'<div class="col-sm-6">'
		+'<select class="form-control" id="offer_type" name="offer_type[]">'
		+'<option value="1">Percentage</option>'
		+'<option value="2">Flat Amount</option>'
		+'<option value="3">Other</option>'
		+'</select>'
		+'</div>'
		+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-apply">'
			+'<label class="control-label col-sm-6">Status </label>'
			+'<div class="col-sm-6">'
			+'<select class="form-control" id="offer_status" name="offer_status[]">'
			+'<option value="1">Active</option>'
			+'<option value="0">Inactive</option>'
			+'</select>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'</div>';
	$("#offer_area").append(html);
	$("#offer_count").val(offers);
}
function removeOffer(id) {
	$("#offer-"+id).remove();
}
function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	var html = '<div class="row" id="schedule-'+schedule_count+'">'
				+'<input type="hidden" id="schedule_id" name="schedule_id[]" value="0"/>'
				+'<hr/>'
				+'<div class="col-lg-5 margin-bottom-5">'
				+'<div class="form-group" id="error-schedule">'
				+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
				+'<div>'
				+'<input type="text" class="form-control" id="schedule" required name="schedule[]"/>'
				+'</div>'
// 				+'<div  id="s-'+schedule_count+'"></div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-payable">'
				+'<label class="control-label col-sm-8">% of Net Payable <span class="text-danger">*</span></label>'
				+'<div class="col-sm-4">'
				+'<input type="text" class="form-control" required=true id="payable'+schedule_count+'" onkeyup="javascript:vaildPayablePer('+schedule_count+')" onkeypress="return isNumber(event, this);" name="payable[]"/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<!--div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount <span class="text-danger">*</span></label>'
				+'<div class="col-sm-6">'
				+'<input type="text" class="form-control" required=true onkeypress=" return isNumber(event, this);" name="amount[]"/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div -->'
				+'<div class="col-lg-1">'
				+'<span><a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs">x</a></span>'
				+'</div>'
			+'</div>';
	$("#payment_schedule").append(html);
	$("#schedule_count").val(schedule_count);
}
function removeSchedule(id) {
	$("#schedule-"+id).remove();
}


$("#subpbtn").click(function(){
// 	var amenityWeightage = [];
// 	$('input[name="stage_weightage[]"]').each(function() {
// 		stage_id = $(this).attr("id");
// 		stage_weightage = $(this).val();
// 		$('input[name="substage_weightage'+stage_id+'[]"]').each(function() {
// 			amenityWeightage.push({builderProject:{id:$("#id").val()},projectStage:{id:stage_id},stageWeightage:stage_weightage,projectSubstage:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
// 		});
// 	});
//	var final_data = {projectId: $("#id").val(),projectWeightages:amenityWeightage}
    var building_id = [];
    var buildings = [];
    
    $('input[name="building_ids[]"]').each(function(index){
    	building_id.push($(this).val());
    });
    $('input[name="weightage[]"]').each(function(index){
    	buildings.push({id : building_id[index],weightage: $(this).val()});
    });
    var projects = {id:$("#id").val(),amenityWeightage : $("#amenity_weightage").val(),buildingWeightage:$("#building_weightage").val()};
    var final_data = {builderProject:projects, builderBuildings:buildings};
	
	$.ajax({
	    url: '${baseUrl}/webapi/project/substage/update',
	    type: 'POST',
	    data: JSON.stringify(final_data),
	    contentType: 'application/json; charset=utf-8',
	    dataType: 'json',
	    async: false,
	    success: function(data) {
			if (data.status == 0) {
				alert(data.message);
			} else {
				alert(data.message);
			}
		},
		error : function(data)
		{
			alert("Fail to save data");
		}
		
	});
});

function deleteOffer(id) {
	var b=$("#offer").val();
	var flag = confirm("Are you sure ? You want to delete offer ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/offer/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#offer-"+id).remove();
			}
		});
	}
}
$('#detailfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	project_area:{
            validators: {
            	 notEmpty: {
                     message: 'Project Area is required and cannot be empty'
                 }   	
            }
    	},
    
    	launch_date: {
            validators: {
                callback: {
                    message: 'Wrong Launch Date',
                    callback: function (value, validator) {
                        var m = new moment(value, 'DD MMM YYYY', true);
                        if (!m.isValid()) {
                            return false;
                        } else {
                        	return true;
                        }
                    }
                }
            }
        },
        possession_date: {
            validators: {
                callback: {
                    message: 'Wrong Possession Date',
                    callback: function (value, validator) {
                        var m = new moment(value, 'DD MMM YYYY', true);
                        if (!m.isValid()) {
                            return false;
                        } else {
                        	return true;
                        }
                    }
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	saveProjectDetails();
});
</script>
</body>
</html>
