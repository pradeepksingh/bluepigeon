<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	int project_id = 0;
	int p_user_id = 0;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	BuilderProject builderProject = new ProjectDAO().getBuilderProjectById(project_id);
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getCountryList();
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	Set<State> states = null;
	Set<City> cities = null;
	Set<Locality> localities = null;
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
   	}
	List<BuilderProjectType> projectTypes = new BuilderProjectTypeDAO().getBuilderProjectTypes();
	List<BuilderPropertyType> propertyTypes = new BuilderPropertyTypeDAO().getBuilderPropertyTypes();
	List<BuilderProjectPropertyConfiguration> projectConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderProjectConfigurations();
	List<BuilderProjectAmenity> projectAmenities = new BuilderProjectAmenityDAO().getBuilderProjectAmenityList();
	List<BuilderProjectApprovalType> projectApprovals = new BuilderProjectApprovalTypeDAO().getBuilderProjectApprovalTypes();
	List<HomeLoanBanks> homeLoanBanks = new HomeLoanBanksDAO().getHomeLoanBanksList();
	List<AreaUnit> areaUnits = new AreaUnitDAO().getAreaUnitList();
	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectApprovalInfo> projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectBankInfo> projectBankInfos = new BuilderProjectBankInfoDAO().getBuilderProjectBankInfos(project_id);
	BuilderProjectPriceInfo projectPriceInfo = new BuilderProjectPriceInfoDAO().getBuilderProjectPriceInfo(project_id);
	List<BuilderProjectPaymentInfo> projectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(project_id);
	List<BuilderProjectOfferInfo> projectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
	
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Project</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Update 
				</h1>
			</div>
			<ul class="nav nav-tabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#projectdetail">Project Details</a></li>
			  	<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
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
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-company_id">
													<label class="control-label col-sm-4">Builder Company <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
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
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Project Name <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderProject.getName());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Landmark </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="landmark" name="landmark" value="<% out.print(builderProject.getAddr1());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-sublocation">
													<label class="control-label col-sm-4">Sub Location </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="sublocation" name="sublocation" value="<% out.print(builderProject.getAddr2());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-country_id">
													<label class="control-label col-sm-4">Country <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="country_id" id="country_id" class="form-control">
										                    <option value="">Select Country</option>
										                    <% for(Country country : listCountry){ %>
										                    <% 	if(builderProject.getCountry().getId() == country.getId()) { 
										                    		states = country.getStates();
										                    	}
										                    %>
															<option value="<% out.print(country.getId());%>" <% if(builderProject.getCountry().getId() == country.getId()) { %>selected<% } %>><% out.print(country.getName());%></option>
															<% } %>
											             </select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-4">State <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="state_id" id="state_id" class="form-control">
										                    <option value="">Select State</option>
										                    <% for(State state : states) { %>
										                    <% 	if(builderProject.getState().getId() == state.getId()) {
										                    		cities = state.getCities();
										                    		out.print(state.getName());
										                    	}
										                    %>
															<option value="<% out.print(state.getId());%>" <% if(builderProject.getState().getId() == state.getId()) { %>selected<% } %>><% out.print(state.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-city_id">
													<label class="control-label col-sm-4">City <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="city_id" id="city_id" class="form-control">
										                	<option value="">Select City</option>
										                    <% for(City city : cities){ %>
										                    <% 	if(builderProject.getCity().getId() == city.getId()) { 
										                    		localities = city.getLocalities();
										                    	}
										                    %>
															<option value="<% out.print(city.getId());%>" <% if(builderProject.getCity().getId() == city.getId()) { %>selected<% } %>><% out.print(city.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-locality_id">
													<label class="control-label col-sm-4">Locality <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="locality_id" id="locality_id" class="form-control">
										                	<option value="">Select Locality</option>
										                	<% for(Locality locality : localities){ %>
															<option value="<% out.print(locality.getId());%>" <% if(builderProject.getLocality().getId() == locality.getId()) { %>selected<% } %>><% out.print(locality.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-pincode">
													<label class="control-label col-sm-4">Pincode </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="pincode" name="pincode" autocomplete="off" value="<% out.print(builderProject.getPincode());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-latitude">
													<label class="control-label col-sm-4">Latitude </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="latitude" name="latitude" autocomplete="off" value="<% out.print(builderProject.getLatitude());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-longitude">
													<label class="control-label col-sm-4">Longitude </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="longitude" name="longitude" autocomplete="off" value="<% out.print(builderProject.getLongitude());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-longitude">
													<label class="control-label col-sm-4">Description </label>
													<div class="col-sm-8">
														<textarea class="form-control" id="description" name="description"><% out.print(builderProject.getDescription());%></textarea>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-highlight">
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
																<input type="text" class="form-control" id="property_type<% out.print(builderPropertyType.getId());%>" name="property_type<% out.print(builderPropertyType.getId());%>" value="<% out.print(prop_value); %>" placeholder="No. Of <% out.print(builderPropertyType.getName());%>"/>
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
														<input type="text" class="form-control" id="project_area" name="project_area" value="<% if(builderProject.getProjectArea() != null) { out.print(builderProject.getProjectArea());}%>"/>
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
													<div class="col-sm-8">
														<input type="text" class="form-control" id="launch_date" name="launch_date" value="<% if(builderProject.getLaunchDate() != null) { out.print(dt1.format(builderProject.getLaunchDate()));} %>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6">
												<div class="col-sm-12">
													<button type="button" class="btn btn-success btn-sm" id="detailbtn">SAVE</button>
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
														<select name="base_unit" id="base_unit" class="form-control">
															<% for(AreaUnit areaUnit :areaUnits) { %>
															<option value="<% out.print(areaUnit.getId()); %>" <% if(projectPriceInfo.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
															<% } %>
														</select>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-base_rate">
													<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% if(projectPriceInfo.getBasePrice() != null){ out.print(projectPriceInfo.getBasePrice());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-rise_rate">
													<label class="control-label col-sm-4">Floor Rise Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<% if(projectPriceInfo.getRiseRate() != null){ out.print(projectPriceInfo.getRiseRate());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-post">
													<label class="control-label col-sm-4">Applicable Post </label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="post" name="post" value="<% if(projectPriceInfo.getPost() != null){ out.print(projectPriceInfo.getPost());}%>"/>
														<span class="input-group-addon">floor</span>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-maintenance">
													<label class="control-label col-sm-4">Maintenance Charge </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(projectPriceInfo.getMaintenance() != null){ out.print(projectPriceInfo.getMaintenance());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure </label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="tenure" name="tenure" value="<% out.print(projectPriceInfo.getTenure());%>"/>
														<span class="input-group-addon">Months</span>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% if(projectPriceInfo.getAmenityRate() != null){ out.print(projectPriceInfo.getAmenityRate());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="parking" name="parking" value="<% if(projectPriceInfo.getParking() != null){ out.print(projectPriceInfo.getParking());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Stamp Duty </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(projectPriceInfo.getStampDuty() != null){ out.print(projectPriceInfo.getStampDuty());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tax" name="tax" value="<% if(projectPriceInfo.getTax() != null){ out.print(projectPriceInfo.getTax());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-vat">
													<label class="control-label col-sm-4">VAT </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="vat" name="vat" value="<% if(projectPriceInfo.getVat() != null){ out.print(projectPriceInfo.getVat());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tech_fee">
													<label class="control-label col-sm-4">Tech Fees</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(projectPriceInfo.getFee() != null){ out.print(projectPriceInfo.getFee());}%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
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
					<form id="paymentfrm" name="paymentfrm" method="post">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(projectPaymentInfos.size()+1);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% 	int i = 1;
												for(BuilderProjectPaymentInfo projectPaymentInfo :projectPaymentInfos) { 
											%>
											<div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getSchedule() != null) { out.print(projectPaymentInfo.getSchedule());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value="<% if(projectPaymentInfo.getPayable() != null) { out.print(projectPaymentInfo.getPayable());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value="<% if(projectPaymentInfo.getAmount() != null) { out.print(projectPaymentInfo.getAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% i++; } %>
											<div class="row" id="schedule-<% out.print(i);%>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
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
														<button type="button" class="btn btn-success btn-sm" id="paymentbtn">SAVE</button>
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
					<form id="offerfrm" name="offerfrm" method="post">
						<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(projectOfferInfos.size()+1); %>"/>
			 			<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<% 	int j = 1;
												for(BuilderProjectOfferInfo projectOfferInfo :projectOfferInfos) { 
											%>
											<div class="row" id="offer-<% out.print(j);%>">
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:removeOffer(<% out.print(j);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% if(projectOfferInfo.getTitle() != null) { out.print(projectOfferInfo.getTitle());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value="<% if(projectOfferInfo.getPer() != null) { out.print(projectOfferInfo.getPer());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Offer Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% if(projectOfferInfo.getAmount() != null) { out.print(projectOfferInfo.getAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value="<% if(projectOfferInfo.getApplicable() != null) { out.print(projectOfferInfo.getApplicable());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-4">Apply </label>
														<div class="col-sm-8">
															<select class="form-control" id="apply" name="apply[]">
																<option value="1" <% if(projectOfferInfo.getApply() == 1) { %>selected<% } %>>Yes</option>
																<option value="0" <% if(projectOfferInfo.getApply() == 0) { %>selected<% } %>>No</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<% j++; } %>
											<div class="row" id="offer-<% out.print(j);%>">
												<% if(j > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:removeOffer(<% out.print(j);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Offer Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-4">Apply </label>
														<div class="col-sm-8">
															<select class="form-control" id="apply" name="apply[]">
																<option value="1" >Yes</option>
																<option value="0" >No</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
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
														<button type="button" class="btn btn-success btn-sm" id="offerbtn">SAVE</button>
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
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#launch_date').datepicker({
	format: "dd MM yyyy"
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
			var html = '<option value="">Select City</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
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
                },
                integer: {
                    message: 'Invalid pin code.'
           		}
            }
        },
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

$("#detailbtn").click(function(){
	var projectType = [];
	var propertyType = [];
	var configuration = [];
	var amenityType = [];
	var approvalType = [];
	var homeLoanInfo = [];
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
	var final_data = {builderProject:project,builderProjectProjectTypes:projectType,builderProjectPropertyTypes:propertyType,builderProjectPropertyConfigurationInfos:configuration,builderProjectAmenityInfos:amenityType,builderProjectApprovalInfos:approvalType,builderProjectBankInfos:homeLoanInfo}
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
});

$("#paymentbtn").click(function(){
	var paymentInfo = [];
	var payable = [];
	var amount = [];
	$('input[name="payable[]"]').each(function(index) {
		payable.push($(this).val());
	});
	$('input[name="amount[]"]').each(function(index) {
		amount.push($(this).val());
	});
	$('input[name="schedule[]"]').each(function(index) {
		if($(this).val() != "") {
			paymentInfo.push({schedule:$(this).val(),payable:payable[index],amount:amount[index],status:1,builderProject:{id:$("#id").val()}});
		}
	});
	var project = {id:$("#id").val()};
	var final_data = {builderProjectPaymentInfos:paymentInfo,builderProject:project}
	if(paymentInfo.length > 0) {
		$.ajax({
		    url: '${baseUrl}/webapi/project/payment/update',
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
	} else {
		alert("Please enter payment schedule details");
	}
});

$("#offerbtn").click(function(){
	var offerInfo = [];
	var discount = [];
	var amount = [];
	var applicable = [];
	var apply = [];
	$('input[name="discount[]"]').each(function(index) {
		discount.push($(this).val());
	});
	$('input[name="discount_amount[]"]').each(function(index) {
		amount.push($(this).val());
	});
	$('input[name="applicable_on[]"]').each(function(index) {
		applicable.push($(this).val());
	});
	$('select[name="apply[]"] option:selected').each(function(index) {
		apply.push($(this).val());
	});
	$('input[name="offer_title[]"]').each(function(index) {
		if($(this).val() != "") {
			offerInfo.push({title:$(this).val(),per:discount[index],amount:amount[index],applicable:applicable[index],apply:apply[index],builderProject:{id:$("#id").val()}});
		}
	});
	var project = {id:$("#id").val()};
	var final_data = {builderProjectOfferInfos:offerInfo,builderProject:project}
	if(offerInfo.length > 0) {
		$.ajax({
		    url: '${baseUrl}/webapi/project/offer/update',
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
	} else {
		alert("Please enter offer details");
	}
});

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-discount">'
				+'<label class="control-label col-sm-4">Offer Discount(%) <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="discount" name="discount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-4">Offer Discount Amount </label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4">Applicable on </label>'
			+'<div class="col-sm-8">'
			+'<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value=""/>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-apply">'
			+'<label class="control-label col-sm-4">Apply </label>'
			+'<div class="col-sm-8">'
			+'<select class="form-control" id="apply" name="apply[]">'
			+'<option value="1">Yes</option>'
			+'<option value="0">No</option>'
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
				+'<hr/>'
				+'<div class="col-lg-5 margin-bottom-5">'
				+'<div class="form-group" id="error-schedule">'
				+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
				+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-payable">'
				+'<label class="control-label col-sm-8">% of Net Payable </label>'
				+'<div class="col-sm-4">'
				+'<input type="text" class="form-control" id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="text" class="form-control" id="amount" name="amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
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

</script>
</body>
</html>
