<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalType"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenitySubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.controller.GeneralController"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectType"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
  int builder_id=0;
int company_id = 0;
int company_size=0;
 List<BuilderCompanyNames> builderCompanyNames = null;
  List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
  if(builders.size()>0){
	  builder_id = builders.get(0).getId();
	  builderCompanyNames = new BuilderDetailsDAO().getBuilderCompanyNameList(builder_id);
	  company_size= builderCompanyNames.size();
	  company_id = builderCompanyNames.get(0).getId();
  }
  
  List<Locality> locality_list = null;
 
  int city_id=0;
  int state_id=0;
  int city_size =0;
  int country_size = 0;
  int state_size = 0;
  int locality_id=0;
  int locality_size=0;
  int country_id = 0;
  List<City> city_list = null;
  List<State> state_list = null;
  List<Country> country_list = null;
  CountryDAOImp countryService = new CountryDAOImp();
  List<Country> listCountry = countryService.getCountryList();
  StateImp stateList = new StateImp();
  country_size = listCountry.size(); 
//   if (request.getParameterMap().containsKey("state_id")) {
//     state_id = Integer.parseInt(request.getParameter("state_id"));
    city_list = new CityNamesImp().getCityNamesByStateId(state_id);
    city_size = city_list.size(); 
    if(city_size > 0) {
  	  country_id = city_list.get(0).getState().getCountry().getId();
  	  state_list = stateList.getStateByCountryId(country_id);
  	  state_size = state_list.size();
  	  city_id=city_list.get(0).getId();
  	  locality_list =new LocalityNamesImp().getLocalityByCityId(city_id);
  	  locality_size=locality_list.size();
    }
    List<BuilderProjectType> projectType = new BuilderProjectTypeDAO().getBuilderCompany();
    List<BuilderPropertyType> pBuilderPropertyTypes = new BuilderPropertyTypeDAO().getBuilderCompany();
    List<BuilderProjectPropertyConfiguration> builderProjectPropertyConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderCompany();
    List<BuilderProjectAmenitySubstages> builderProjectAmenitySubstages = new BuilderProjectAmenitySubstagesDAO().getBuilderProjectAmenitySubstagesList();
    List<AreaUnit> areaUnits = new AreaUnitDAO().getAreaUnitList(); 
    List<BuilderProjectApprovalType> builderProjectApprovalTypes = new BuilderProjectApprovalTypeDAO().getBuilderCompany();
    List<HomeLoanBanks> homeLoanBanks = new HomeLoanBanksDAO().getHomeLoanBanksList();
    
     session = request.getSession(false);
	 AdminUser adminuser6 = new AdminUser();
 	int user_id6 = 0;
 	if(session!=null)
 	{
 		if(session.getAttribute("uname") != null)
 		{
 			adminuser6  = (AdminUser)session.getAttribute("uname");
   				System.out.println();
   				System.out.println("user id : "+adminuser6.getId());
   				user_id6 = adminuser6.getId();
   				System.out.println();
 		}
    }
 // }
%>
		<div class="main-content">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
						</li>

						<li><a href="#">Create Project</a></li>
						<li class="active">New Project</li>
					</ul>
					<!-- /.breadcrumb -->

				</div>
					<input type="hidden" value="" name="builder_id" id="builder_id">
				<div class="page-content">
					<div class="page-header">
						<h1>New Project</h1>
					</div>
					<!-- /.page-header -->

					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<form class="form-horizontal" role="form">
							<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Builder Group </label>

									<div class="col-sm-4">
										<select id="searchbuilderid" name="standard" class="form-control">
											<option value="0">Select Builder Group</option>
											<%
												if(builders.size() > 0){
													for (int i = 0; i < builders.size(); i++) {
												Builder builder = builders.get(i);
											%>
											<option value="<%out.print(builder.getId());%>">
											<%
												out.print(builder.getName());
											%>
											</option>
											<%
												}
											}
											%>

										</select>
									</div>
							</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Builder Company Name</label>
									<div class="col-sm-4">
										<select id="searchcompanyid" name="company" class="form-control">
											<option value="0">Select Builder Company</option>
										</select>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Project Name </label>

									<div class="col-sm-9">
										<input type="text" id="bname" placeholder="project Name"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Landmark</label>
									<div class="col-sm-4">
										<textarea id="addr_1"
											class="autosize-transition form-control"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Sub location</label>
									<div class="col-sm-4">
										<textarea id="addr_2"
											class="autosize-transition form-control"></textarea>
									</div>
								</div>
								<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">Country </label>
									<div class="col-sm-4">
										 <select name="searchcountryId" id="searchcountryId" class="form-control">
							                    <option value="">Select Country</option>
							                    <% for(int i=0; i < country_size ; i++){ %>
												<option value="<% out.print(listCountry.get(i).getId());%>" <% if(country_id == listCountry.get(i).getId()) { %>selected<% } %>><% out.print(listCountry.get(i).getName());%></option>
												<% } %>
							                </select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">State </label>
									<div class="col-sm-4">
										  <select name="searchstateId" id="searchstateId" class="form-control">
							                    <option value="0">Select State</option>
							                    <% for(int i=0; i < state_size ; i++){ %>
												<option value="<% out.print(state_list.get(i).getId());%>" <% if(state_id == state_list.get(i).getId()) { %>selected<% } %>><% out.print(state_list.get(i).getName());%></option>
												<% } %>
							                </select>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">City </label>
										<div class="col-sm-4">
											 <select name="searchcityId" id="searchcityId" class="form-control">
								                    <option value="0">Select City</option>
								                    <% for(int i=0; i < city_size ; i++){ %>
													<option value="<% out.print(city_list.get(i).getId());%>" <% if(city_id == city_list.get(i).getId()) { %>selected<% } %>><% out.print(city_list.get(i).getName());%></option>
													<% } %>
								              </select>
										</div>
									</div>
						
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Locality </label>

									<div class="col-sm-4">
								 <select name="searchlocalityId" id="searchlocalityId" class="form-control">
							                    <option value="0">Select Locality</option>
<%-- 							                    <% for(int i=0; i < locality_size ; i++){ %> --%>
<%-- 												<option value="<% out.print(locality_list.get(i).getId());%>"><% out.print(locality_list.get(i).getName());%></option> --%>
<%-- 												<% } %> --%>
							                </select>
									</div>
								</div>
						
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Pincode </label>

									<div class="col-sm-9">
										<input type="text" id="pincode" placeholder="enter pincode"
											class="col-xs-10 col-sm-5" />
									</div>
									
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Latitude </label>

									<div class="col-sm-9">
										<input type="text" id="latitude" placeholder="enter latitude"
											class="col-xs-10 col-sm-5" />
									</div>
									
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Longitude </label>

									<div class="col-sm-9">
										<input type="text" id="longitude" placeholder="enter longitude "
											class="col-xs-10 col-sm-5" />
									</div>
									
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Description</label>
									<div class="col-sm-4">
										<textarea id="description"
											class="autosize-transition form-control"></textarea>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Highlights (USP)</label>
									<div class="col-sm-4">
										<textarea id="highlights"
											class="autosize-transition form-control"></textarea>
									</div>
								</div>
								<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> <b> Project Details </b></label>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Project Type *</label>
									<div class="col-sm-4">
										<div class="inline-checkboxes-holder" id="projects">

					<%
						if (projectType.size() > 0) {
							for (int i = 0, j = 0; i < projectType.size(); i++) {
								BuilderProjectType builderProjectType = projectType.get(i);
					%><div class="col-sm-3">
						<div class="inline-checkboxes-holder" id="project_type">
						
						<label class="checkbox"> <input type="checkbox"
							id="bproject_id" name="bproject[]"
							value="<%out.print(builderProjectType.getId());%>"> <%
								out.print(builderProjectType.getName());
							%>
						</label>
						</div>
				     </div>
					<%
							}
						}//end of if
					%>
				</div>
									</div>
								</div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right"
											for="form-field-1" for="form-field-11">Property Type *</label>
	 									<div class="col-sm-9"> 
	 										<div class="inline-checkboxes-holder" id="properties"> 
												<script>
												   var count = 0;
												</script>
												<% 				
													if (pBuilderPropertyTypes.size() > 0) {
														for (int i = 0, j = 0; i < pBuilderPropertyTypes.size(); i++) {
															BuilderPropertyType builderProjectType = pBuilderPropertyTypes.get(i);
	 											%>
	 											<div class="col-sm-4"> 
													<div class="inline-checkboxes-holder" id="property_type">
														<label class="checkbox"> 
															<input type="checkbox" id="check<%out.print(builderProjectType.getId());%>" onchange="javascript:valueChanged(<%out.print(builderProjectType.getId());%>)" name="bpropertytype[]"
	 															value="<%out.print(builderProjectType.getId());%>"> 
	 															<% out.print(builderProjectType.getName()); %> 
														</label>
													<script>
													    count++;
													</script>
														<input type="text" id="property_<%out.print(builderProjectType.getId());%>" name="txtBox<%out.print(builderProjectType.getId());%>" placeholder="No. of <%out.print(builderProjectType.getName());%>"/>
													</div>
							
	  											</div>
	  											<%
														}
													}//end of if
												%>
											</div>
								   		 </div>
									</div>
								
		
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Configuration *</label>
									<div class="col-sm-4">
										<div class="inline-checkboxes-holder" id="projects">

					<%
						if (builderProjectPropertyConfigurations.size() > 0) {
							for (int i = 0, j = 0; i < builderProjectPropertyConfigurations.size(); i++) {
								BuilderProjectPropertyConfiguration builderProjectType = builderProjectPropertyConfigurations.get(i);
					%><div class="col-sm-3">
						<div class="inline-checkboxes-holder" id="project_type">
						
						<label class="checkbox"> <input type="checkbox"
							id="bprojectconfig_id" name="bprojectconfig[]"
							value="<%out.print(builderProjectType.getId());%>"> <%
								out.print(builderProjectType.getName());
							%>
						</label>
						</div>
				     </div>
					<%
							}
						}//end of if
					%>
				</div>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Project Amenities *</label>
									<div class="col-sm-4">
										<div class="inline-checkboxes-holder" id="project_substages">

					<%
						if (builderProjectAmenitySubstages.size() > 0) {
							for (int i = 0, j = 0; i < builderProjectAmenitySubstages.size(); i++) {
								BuilderProjectAmenitySubstages builderProjectType = builderProjectAmenitySubstages.get(i);
					%><div class="col-sm-3">
						<div class="inline-checkboxes-holder" id="project_substage">
						
						<label class="checkbox"> <input type="checkbox"
							id="bprojectsubstage_id" name="bprojectsubstage[]"
							value="<%out.print(builderProjectType.getId());%>"> <%
								out.print(builderProjectType.getName());
							%>
						</label>
						</div>
				     </div>
					<%
							}
						}//end of if
					%>
				</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Project Area </label>

									<div class="col-sm-2">
										<input type="text" id="projectarea" placeholder="Enter project area"/>
									</div>
									
													<div class="col-sm-2">
										<select id="searchareaunitid" name="standard" class="form-control">
					<option value="0">-- Select Area Unit --</option>
					<%
					if(areaUnits.size() > 0){
						for (int i = 0; i < areaUnits.size(); i++) {

							AreaUnit areaUnit = areaUnits.get(i);
					%>
					<option value="<%out.print(areaUnit.getId());%>">
						<%
							out.print(areaUnit.getName());
						%>
					</option>

					<%
						}
					}
					%>

				</select>
									</div>
									
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Launch Date</label>
									<div class="col-sm-4">
										<input type="text" id="ldate" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Project Approval *</label>
									<div class="col-sm-5">
										<div class="inline-checkboxes-holder" id="projects">

					<%
						if (builderProjectApprovalTypes.size() > 0) {
							for (int i = 0, j = 0; i < builderProjectApprovalTypes.size(); i++) {
								BuilderProjectApprovalType builderProjectType = builderProjectApprovalTypes.get(i);
					%><div class="col-sm-3">
						<div class="inline-checkboxes-holder" id="project_type">
						
						<label class="checkbox"> <input type="checkbox"
							id="bproject_id" name="bprojectapproval[]"
							value="<%out.print(builderProjectType.getId());%>"> <%
								out.print(builderProjectType.getName());
							%>
						</label>
						</div>
				     </div>
					<%
							}
						}//end of if
					%>
				</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Home Loan Banks *</label>
									<div class="col-sm-4">
										<div class="inline-checkboxes-holder" id="projects">

					<%
						if (homeLoanBanks.size() > 0) {
							for (int i = 0, j = 0; i < homeLoanBanks.size(); i++) {
								HomeLoanBanks homeLoanBanks2 = homeLoanBanks.get(i);
					%><div class="col-sm-3">
						<div class="inline-checkboxes-holder" id="loan_banks">
						
						<label class="checkbox"> <input type="checkbox"
							id="bank_id" name="bankname[]"
							value="<%out.print(homeLoanBanks2.getId());%>"> <%
								out.print(homeLoanBanks2.getName());
							%>
						</label>
						</div>
				     </div>
					<%
							}
						}//end of if
					%>
				</div>
									</div>
								</div>
							
								 <div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> <b>Pricing Data</b></label>
							    </div>	
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Base Rate </label>

									<div class="col-sm-4">
										<input type="text" id="brates" placeholder="Enter base rates"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Floor Rise Rate </label>

									<div class="col-sm-4">
										<input type="text" id="frrate" placeholder="Enter floor rise rate"
											 />
									</div>
									
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Applicable Post </label>

									<div class="col-sm-4">
										<input type="text" id="apost" placeholder="enter no of floors"
											 />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Maintenance </label>

									<div class="col-sm-4">
										<input type="text" id="maintenance" placeholder="Enter Maintenance charges"
											/>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Tenure </label>

									<div class="col-sm-4">
										<input type="text" id="tenure" placeholder="Enter Tenure in Months" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Parking </label>

									<div class="col-sm-4">
										<input type="text" id="parking" placeholder="Enter Parking Rate"
											 />
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Stamp Duty </label>

									<div class="col-sm-4">
										<input type="text" id="sduty" placeholder="Enter Stamp Duty"
											 />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amenities Facing Rate </label>

									<div class="col-sm-4">
										<input type="text" id="afrate" placeholder="Enter Amenities Facing Rate"
											 />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Tax </label>

									<div class="col-sm-4">
										<input type="text" id="tax" placeholder="Enter TAX"
											 />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> VAT </label>

									<div class="col-sm-4">
										<input type="text" id="vat" placeholder="Enter VAT"
											 />
									</div>
								</div>
							
							
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Tech Fee </label>

									<div class="col-sm-4">
										<input type="text" id="tfee" placeholder="Enter Tech Fee"
											 />
									</div>
								</div>
									
									 <div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> <b>Add Offers </b></label>
									  </div>
									
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Offer Title </label>

									<div class="col-sm-4">
										
                       		<input type="text" id="title-1" placeholder="Enter offer title"
										name="title[]"	class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Offer Discount(%) </label>

									<div class="col-sm-4">
										
                       		<input type="text" id="odiscount-1" placeholder="Enter offer descount(%)"
										name="odiscount[]"	class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Offer Discount Amount </label>

									<div class="col-sm-4">
										
                       		<input type="text" id="damt-1" placeholder="Enter offer discount amount(Rs)"
										name="damt[]"	class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Applicable on </label>
									<div class="col-sm-4">
                       					<input type="text" id="aon-1" name="aon[]"placeholder="Enter applicable on"	class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Apply </label>
									<div class="col-sm-4">
			                       		<select name="apply[]" id="apply-1" class="form-control">
											<option value="1"> Yes </option>
											<option value="0"> No </option>
										</select>
									</div>
								</div>
								
								<div id="addOffers"></div>
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> </label>
									<div class="col-sm-4">
                       					<input id="addMoreOffer" value="Add Offers" onclick="javascript:addOffers()" class="btn btn-info" type="button">
									</div>
								</div>
								 <div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> <b> Payment Schedule </b></label>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>
									<div class="col-sm-4">
										<input type="text" id="psm-1" placeholder="Enter Payment Schedule Milestone"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"	for="form-field-1"> % of Net Payable </label>
									<div class="col-sm-4">
										<input type="text" id="netpayable-1" placeholder="Enter Net Payable"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"	for="form-field-1"> Amount </label>
									<div class="col-sm-4">
										<input type="text" id="amount-1" placeholder="Enter Amount"	/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Milestone </label>
									<div class="col-sm-4">
										<input type="text" id="psm-2" placeholder="Enter Payment Schedule Milestone"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-2" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-2" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-3" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-3" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-3" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-4" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-4" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-4" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-5" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-5" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-5" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-6" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-6" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-6" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">  Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-7" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-7" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-7" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">  Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-8" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-8" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-8" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-9" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-9" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-9" placeholder="Enter Amount"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">  Milestone </label>

									<div class="col-sm-4">
										<input type="text" id="psm-10" placeholder="Enter Payment Schedule Milestone"
											/>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> % of Net Payable </label>

									<div class="col-sm-4">
										<input type="text" id="netpayable-10" placeholder="Enter Net Payable"
											/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Amount </label>

									<div class="col-sm-4">
										<input type="text" id="amount-10" placeholder="Enter Amount"
											/>
									</div>
								</div>
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Status </label>

									<div class="col-sm-4">
										
                       		<select name="status" id="status" class="form-control">
								<option value="1"> Active </option>
								<option value="0"> Inactive </option>
							</select>
									</div>
								</div>
								<div class="clearfix form-actions">

									<div class="col-md-offset-3 col-md-9">
										
										<button id="saveProject" class="btn btn-info" type="button">
											<i class="ace-icon fa fa-check bigger-110"></i> Submit
										</button>

										&nbsp; &nbsp; &nbsp;
										<button class="btn" type="reset">
											<i class="ace-icon fa fa-undo bigger-110"></i> Reset
										</button>
									</div>
								</div>

							</form>
							

						<%@include file="../footer.jsp"%>
						<!-- inline scripts related to this page -->
						<script type="text/javascript">
			
						$("#searchbuilderid").change(function(){
							$.get("${baseUrl}/webapi/create/project/list/",{ builder_id: $("#searchbuilderid").val() }, function(data){
								var html = '<option value="">Select Company Name</option>';
								$(data).each(function(index){
									
									html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
								});
								$("#searchcompanyid").html(html);
							},'json');
						});
						
				
			function ValidateEmail(email) {
		        var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		        return expr.test(email);
		    };
		    $("#searchcountryId").change(function(){
		        $.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#searchcountryId").val() }, function(data){
		            var html = '<option value="">Select State</option>';
		            $(data).each(function(index){
		                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		            });
		            $("#searchstateId").html(html);
		        },'json');
		    });

		    $("#searchstateId").change(function(){
		        $.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#searchstateId").val() }, function(data){
		            var html = '<option value="">Select City</option>';
		            $(data).each(function(index){
		                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		            });
		            $("#searchcityId").html(html);
		        },'json');
		    	
		    });

		    $("#searchcityId").change(function(){
		    	
		    	 $.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#searchcityId").val() }, function(data){
		    	
			            var html = '<option value="">Select Locality</option>';
			            $(data).each(function(index){
			            	
			                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			            });
			            $("#searchlocalityId").html(html);
			        },'json');
		    });
		    
		    
		   
		    $("#saveProject").click(function(){
		    	saveNewProject();
		    })
		    function saveNewProject(){
		    	
		    var projectTypeData = getProjectTypeData();
		    var propertyConfigData = getPropertyConfigData();
	        var project_data = getProjectData();
	        var project_amenity_data=  getProjectAmenityData();
		    var project_loan_bank = getHomeLoanBankData();
		   var project_approval_data= getProjectApprovalData();
		   var loan_bank_data = getHomeLoanBankData();
		   var price_data =  getPriceData();
		   var payment_schedule= getPaymentSchedule();
		   var offers = getAddedOffers();
		   var final_data=[];
		       final_data={builderProject:project_data,builderProjectPropertyConfigurationInfo:propertyConfigData,builderProjectOfferInfos:offers,builderProjectBankInfos:loan_bank_data,builderProjectPriceInfos:price_data,builderProjectPaymentInfos:payment_schedule,builderProjectProjectTypes:projectTypeData,builderProjectAmenityInfos:project_amenity_data}
		    }
		  
		    for(var i=1;i<=count;i++){
		    	 $("#property_"+i).hide();
		    }
		   
		    function valueChanged(id)
		    {
		      if($('#check'+id).is(":checked")) 
		    	  
		    	  $("#property_"+id).show();
		       else
		           $("#property_"+id).hide();
		    }
		    
		    var batch_count =1;
		    function addOffers()
			{
		    	batch_count++;
		    	var batch='<div class="form-group">';
		    		batch+='<label class="col-sm-3 control-label no-padding-right"';
		    		batch+='for="form-field-1">Offer Title </label>';
		    		batch+='<div class="col-sm-4">';
		    		batch+='<input type="text" id="title-'+batch_count+'" placeholder="Enter offer title"';
		    		batch+='name="title[]"	class="col-xs-10 col-sm-5" />';
		    		batch+='</div>';
		    		batch+='</div>';
		    		batch+='<div class="form-group">';
		    		batch+='<label class="col-sm-3 control-label no-padding-right"';
		    		batch+='for="form-field-1">Offer Discount(%) </label>';
		    		batch+='<div class="col-sm-4">';
		    		batch+='<input type="text" id="odiscount-'+batch_count+'" placeholder="Enter offer descount(%)"';
		    		batch+='name="odiscount[]"	class="col-xs-10 col-sm-5" />';
		    		batch+='</div>';
		    		batch+='</div>';
		    		batch+='<div class="form-group">';
		    		batch+='<label class="col-sm-3 control-label no-padding-right"';
		    		batch+='for="form-field-1">Offer Discount Amount </label>';
		    		batch+='<div class="col-sm-4">';
		    		batch+='<input type="text" id="damt-'+batch_count+'" placeholder="Enter offer discount amount(Rs)"';
		    		batch+='name="damt[]"	class="col-xs-10 col-sm-5" />';
		    		batch+='</div>';
		    		batch+='</div>';
		    		batch+='<div class="form-group">';
		    		batch+='<label class="col-sm-3 control-label no-padding-right"';
		    		batch+='for="form-field-1">Applicable on </label>';
		    		batch+='<div class="col-sm-4">';
		    		batch+='<input type="text" id="aon-'+batch_count+'" name="aon[]"placeholder="Enter applicable on"';
		    		batch+='class="col-xs-10 col-sm-5" />';
		    		batch+='</div>';
		    		batch+='</div>';
		    		batch+='<div class="form-group">';
		    		batch+='<label class="col-sm-3 control-label no-padding-right"';
		    		batch+='for="form-field-1">Apply </label>';
		    		batch+='<div class="col-sm-4">';
		    		batch+='<select name="apply[]" id="apply-'+batch_count+'" class="form-control">';
		    		batch+='<option value="1"> Yes </option>';
		    		batch+='<option value="0"> No </option>';
		    		batch+='</select>';
		    		batch+='</div>';
		    		batch+='</div>';
		    	
		    	$("#addOffers").append(batch);
		    	
		    	}	
	  
		    $('#ldate').datepicker({
		        format: "d M yyyy"
		    });
		    
		    function getProjectTypeData() {
				var builderProjectType = null;
				var projectTypeItem =null;
				var project_type_data = [];
				$('input[name="bproject[]"]:checked').each(function() {
					projectTypeItem = {builderProjectType:{id:$(this).val()}};
					project_type_data.push(projectTypeItem);
				});
				return project_type_data;
			}

		    function getPropertyConfigData() {
				var builderProjectPropertyConfiguration = null;
				var propertyConfigurationItem =null;
				var property_config_data = [];
				$('input[name="bprojectconfig[]"]:checked').each(function() {
					propertyConfigurationItem = {builderProjectPropertyConfiguration:{id:$(this).val()}};
					property_config_data.push(propertyConfigurationItem);
				});
				return property_config_data;
			}
		    
		    function getProjectAmenityData() {
				var builderProjectAmenitySubstages = null;
				var builderProjectAmenitySubstagesItem =null;
				var project_amenity_data = [];
				$('input[name="bprojectsubstage[]"]:checked').each(function() {
					builderProjectAmenitySubstagesItem = {builderProjectAmenitySubstages:{id:$(this).val()}};
					project_amenity_data.push(builderProjectAmenitySubstagesItem);
				});
				return project_amenity_data;
			}
		    
		    function getProjectApprovalData() {
				var builderProjectApprovalType = null;
				var builderProjectApprovalTypeItem =null;
				var project_approval_data = [];
				$('input[name="bprojectapproval[]"]:checked').each(function() {
						
					builderProjectApprovalTypeItem = {builderProjectApprovalType:{id:$(this).val()}};
					project_approval_data.push(builderProjectApprovalTypeItem);
				});
				return project_approval_data;
			}
		    
		    function getHomeLoanBankData(){
		    	var homeLoanBanks = null;
				var homeLoanBanksItem =null;
				var home_loan_bank_data = [];
				$('input[name="bprojectapproval[]"]:checked').each(function() {
						
					builderProjectApprovalTypeItem = {builderProjectApprovalType:{id:$(this).val()}};
					project_approval_data.push(builderProjectApprovalTypeItem);
				});
				return project_approval_data;
		    }
			function getAdminUser(){
				var adminId = <%out.print(user_id6);%>
				adminUser = {adminUser:{id:adminId}};
				return adminUser;
			}
			
			function getProjectData(){
				var admin_user = getAdminUser();
				var project_data={
						builder:{id:$("#searchbuilderid").val()},
						builderCompanyName:{id:$("#searchcompanyid").val()},
						name:$("#bname").val(),
						addr_1:$("#addr_1").val(),
						addr_2:$("#addr_2").val(),
						locality:{id:$("#searchlocalityId").val()},
						city:{id:$("#searchcityId").val()},
						state:{id:$("#searchstateId").val()},
						country:{id:("#searchcountryId").val()},
						pincode:$("#pincode").val(),
						status:$("#status").val(),
						latitude:$("#latitude").val(),
						longitude:$("#longitude").val(),
						description:$("#description").val(),
						highlights:$("#highlights").val(),
						launchDate:$("#ldate").val(),
						projectArea:$("#projectarea").val(),
						areaUnit:{id:$("#searchareaunitid").val()},
						adminUser:admin_user,
						status:$("#status").val()
						}
				return project_data;
				}
			
			function getPriceData(){
				var priceData = {
						basePrice : $("#brates").val(),
						riseRate:$("#frrate").val(),
						post:$("#apost").val(),
						amenityRate:$("#afrate").val(),
						parking:$("#parking").val(),
						maintenance:$("#maintenance").val(),
						stampDuty:$("#sduty").val(),
						tenure:$("#tenure").val(),
						tax:$("#tax").val(),
						vat:$("#vat").val(),
						fee:$("#tfee").val()
				}
				return price_data;
			}
		    function getAddedOffers(){
		      var add_offers = [];
		      var offers;
		      for(var i=1;i<=batch_count;i++){
		    	  var title = "#title-"+i;
		    	  var odiscount = "#odiscount-"+i;
		    	  var damt = "#damt"+i;
		    	  var aon = "#aon-"+i;
		    	  var apply = "#apply-"+i;
		    	  if($("#title-"+i).val()!="" || typeof $("#title-"+i).val()!="undefined"){
		    		  title=$("#title-"+i).val();
				  }
				   if($("#odiscount-"+i).val()!="" || typeof $("#odiscount-"+i).val()!="undefined"){
					   odiscount=$("#odiscount-"+i).val();
				  }
				   if($("#damt"+i).val()!="" || typeof $("#damt"+i).val()!="undefined"){
					   damt=$("#damt"+i).val();
				  }
				   if($("#aon-"+i).val()!="" || typeof $("#aon-"+i).val()!="undefined"){
					   aon=$("#aon-"+i).val();
				  }
				   if($("#apply-"+i).val()!="" || typeof $("#apply-"+i).val()!="undefined"){
					   apply=$("#apply-"+i).val();
				  }
		    	  offers= {title:title,per:odiscount,amount:damt,applicable:aon,apply:apply}
		    	  add_offers.push(offers);
		      }
		      return add_offers;
		    }
		    
		    function getProjectType(){
		    	var homeLoanBanks = null;
				var homeLoanBanksItem =null;
				var home_loan_bank_data = [];
				$('input[name="bpropertytype[]"]:checked').each(function() {
					builderProjectApprovalTypeItems={builderProjectPropertyType:{builderProjectApprovalType:{id:$(this).val()}},value:$("#property_"+$(this).val()).val()};
					project_approval_data.push(builderProjectApprovalTypeItems);
				});
				return project_approval_data;
		    }
		    
		    function getPaymentSchedule(){
		    	var payment_data=[];
		    	var payment;
		    	for(var i=1;i<=10;i++){
		    		var psm="#psm-"+i;
		    		var netpayable="#netpayable-"+i;
		    		var amount="#amount-"+i;
		    		 if($("#psm-"+i).val()!="" || typeof $("#psm-"+i).val()!="undefined"){
			    		  psm=$("#psm-"+i).val();
					  }
					   if($("#netpayable-"+i).val()!="" || typeof $("#netpayable-"+i).val()!="undefined"){
						  
						   netpayable=$("#netpayable-"+i).val();
						
					  }
					   if($("#amount-"+i).val()!="" || typeof $("#amount-"+i).val()!="undefined"){
						   amount=$("#amount-"+i).val();
					  }
					   payment={schedule:psm,payable:netpayable,amount:amount};
					   payment_data.push(payment);
		    	}
		    	return payment_data;
		    }
		    </script>

