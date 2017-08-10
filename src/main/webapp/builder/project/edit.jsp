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

<%
	int project_id = 0;
	int building_id = 0;
	int floor_id = 0;
	int flat_id = 0;
	int p_user_id = 0;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	BuilderProject builderProject = new ProjectDAO().getBuilderActiveProjectById(project_id);
	List<Builder> builders = new BuilderDetailsDAO().getActiveBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getActiveCountryList();
	session = request.getSession(false);
	BuilderEmployee adminuserproject = new BuilderEmployee();
	Set<State> states = null;
	Set<City> cities = null;
	String name = null;
	List<BuilderProjectType> projectTypes =null;
	List<BuilderPropertyType> propertyTypes =null;
	List<BuilderProjectPropertyConfiguration> projectConfigurations = null;
	List<BuilderProjectApprovalType> projectApprovals = null;
	List<BuilderProjectAmenity> projectAmenities  = null;
	List<AreaUnit> areaUnits = null;
	List<HomeLoanBanks> homeLoanBanks = null;
	List<BuilderProjectAmenityInfo> projectAmenityInfos = null;
	List<BuilderProjectProjectType> projectProjectTypes = null;
	List<BuilderProjectPropertyType> projectPropertyTypes = null;
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos =null;
	List<BuilderProjectApprovalInfo> projectApprovalInfos = null;
	List<BuilderProjectBankInfo> projectBankInfos = null;
	BuilderProjectPriceInfo projectPriceInfo = null;
	List<BuilderProjectPaymentInfo> projectPaymentInfos = null;
	List<BuilderProjectOfferInfo> projectOfferInfos = null;
	List<ProjectAmenityWeightage> amenityWeightages = null;
	Set<Locality> localities = null;
	List<Tax> taxes = new ArrayList<Tax>();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (BuilderEmployee)session.getAttribute("ubname");
			if(adminuserproject != null){
				p_user_id = adminuserproject.getBuilder().getId();
				projectTypes = new BuilderProjectTypeDAO().getBuilderProjectTypes();
				propertyTypes = new BuilderPropertyTypeDAO().getBuilderActivePropertyTypes();
				projectConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderActiveProjectConfigurations();
				projectAmenities = new BuilderProjectAmenityDAO().getBuilderActiveProjectAmenityList();
				projectApprovals = new BuilderProjectApprovalTypeDAO().getBuilderActiveProjectApprovalTypes();
				homeLoanBanks = new HomeLoanBanksDAO().getActiveHomeLoanBanksList();
				areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
				projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
				projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
				projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
				projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
				projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
				projectBankInfos = new BuilderProjectBankInfoDAO().getBuilderProjectBankInfos(project_id);
				projectPriceInfo = new BuilderProjectPriceInfoDAO().getBuilderProjectPriceInfo(project_id);
				projectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderActiveProjectPaymentInfo(project_id);
				projectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderActiveProjectOfferInfo(project_id);
				try{
					building_id = new ProjectDAO().getBuilderActiveProjectBuildings(project_id).get(0).getId();
					floor_id = new ProjectDAO().getActiveFloorsByBuildingId(building_id).get(0).getId();
					flat_id = new ProjectDAO().getBuilderActiveFloorFlats(floor_id).get(0).getId();
				}catch(Exception e){
				}
				amenityWeightages = new ProjectDAO().getActiveProjectAmenityWeightageByProjectId(project_id);
				if(builderProject.getPincode() != "" && builderProject.getPincode() != null) {
					taxes = new ProjectDAO().getProjectTaxByPincode(builderProject.getPincode());
				}
			}
		}
   	}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon - Review Project</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/custom.css" rel="stylesheet">
     <link href="../css/topbutton.css" rel="stylesheet">
    <link href="../css/custom1.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
	<script type="text/javascript">
	    $('input[type=checkbox]').click(function(){
	    if($(this).is(':checked')){
	          var tb = $('<input type=text />');    
	          $(this).after(tb)  ;
	    }
	    else if($(this).siblings('input[type=text]').length>0){
	        $(this).siblings('input[type=text]').remove();
	    }
	})
	</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        <%@include file="../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
       <div id="sidebar1"> 
       <%@include file="../partial/sidebar.jsp"%>
       </div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                 <div class="row">
                    <div class="col-lg-3 col-sm-3 col-xs-3">
<!--                         <div id="project" class="top-blue-box ">PROJECT</div> -->
				 			<button type="submit" id="project" class="btn11 btn-submit waves-effect waves-light m-t-15">PROJECT</button>
                    </div>
                    <%if(building_id > 0){ %>
	                <div  class="col-lg-3 col-sm-3 col-xs-3">
<!-- 	                        <div id="building" class="top-white-box ">BUILDING</div> -->
	                         <button type="submit" id="building" class="btn11 top-white-box waves-effect waves-light m-t-15">BUILDING</button>
	               </div>
	               <%} %>
	               <%if(building_id > 0 && floor_id > 0){ %>
                    <div  class="col-lg-3 col-sm-3 col-xs-3">
<!--                         	<div id="floor" class="top-white-box" >FLOOR</div> -->
                        	 <button type="submit" id="floor"  class="btn11 top-white-box waves-effect waves-light m-t-15">FLOOR</button>
                    </div>
                    <%} %>
                    <%if(building_id > 0 && floor_id > 0 && flat_id > 0){ %>
                    <div  class="col-lg-3 col-sm-3 col-xs-3">
	                    
<!-- 	                        <div id="flat" class="top-white-box">FLAT</div> -->
	                    <button type="submit" id="flat"  class="btn11 top-white-box waves-effect waves-light m-t-15">FLAT</button>
                    </div>
                    <%} %>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                        	<div class="color-box">
                             <ul class="nav  nav-tabs">
                                 <li class="active">
                                     <a data-toggle="tab"  href="#vimessages" > <span>Basic Information</span></a>
                                 </li>
                                  <li>
                                     <a  data-toggle="tab" href="#vimessages1"><span>Project Details</span></a>
                                 </li>
                                 <li>
                                     <a  data-toggle="tab" href="#vimessages2"><span>Pricing Details</span></a>
                                 </li>
                                     <li >
                                        <a  data-toggle="tab" href="#vimessages3"><span>Payment Schedules</span></a>
                                    </li>
                                 <li>
                                     <a  data-toggle="tab" href="#vimessages4"><span>Offers</span></a>
                                 </li>
                                 <!--   <li class="tab nav-item">
                                     <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages5"><span>Pricing Rate</span></a>
                                 </li>-->
                             </ul>
                              <div class="tab-content"> 
	                           <div id="vimessages" class="tab-pane active" aria-expanded="false">
	                                <div class="col-12">
		                                <form id="basicfrm" name="basicfrm" method="post">
		                                <input type="hidden" id="id" name="id" value="<% out.print(project_id);%>"/>
			                                <div class="row">
			                                	<div class="col-md-6 ">
				                                	<div class="form-group row" id="error-builder_id">
				                                  	  <label  class="col-sm-4 control-label">Builder Group<span class='text-danger'>*</span></label>
				                                    <div class="col-sm-6">
				                                    <div>
				                                        <!-- <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">-->
				                                        <input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builderProject.getBuilder().getId());%>">
				                                        <select id="builder_id" name="builder_id" class="form-control" disabled>
															<option value="">Select Builder Group</option>
			<%-- 												<% for (Builder builder : builders) { %> --%>
			<%-- 												<option value="<%out.print(builder.getId());%>" <% if(builderProject.getBuilder().getId() ==  builder.getId()) { %>selected<% } %>> <% out.print(builder.getName()); %> </option> --%>
			<%-- 												<% } %> --%>
															<option value="<%out.print(adminuserproject.getId()); %>" selected><%out.print(adminuserproject.getName()); %>
														</select>
				                                  	  </div>
				                                  	   <div class="messageContainer "></div>
				                                  	  </div>
				                                    
				                                  </div>
			                                    </div>
			                                    <div class="col-md-6 ">
				                                    <div class="form-group row" id="error-builder_id">
				                                    	<label for="example-text-input" class="col-sm-4 control-label">Builder Company<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    <input type="hidden"id="company_id" name="company_id" value="<%out.print(builderProject.getBuilderCompanyNames().getId());%>"/>
						                                    <div>
						                                       <select id="company_id" name="company_id" class="form-control" disabled>
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
			                                	<div class="col-md-6">
					                                <div class="form-group row">
					                                    <label for="example-search-input" class="col-sm-4 control-label">Project Name<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    	<div>
					                                        	<input class="form-control" type="text" readonly="true" id="name" name="name" value="<% out.print(builderProject.getName());%>">
					                                    	</div>
					                                    	<div class="messageContainer"></div>
					                                    </div>
					                                 </div>
					                              </div>
					                              <div class="col-md-6">
					                                 	<div class="form-group row">
					                                    	<label for="example-search-input" class="col-sm-4 control-label">Landmark<span class='text-danger'>*</span></label>
					                                    	<div class="col-sm-6">
					                                    		<div>
					                                        		<input class="form-control" type="text" readonly="true" id="landmark" name="landmark" value="<% out.print(builderProject.getAddr1());%>">
					                                    		</div>
					                                   		 	<div class="messageContainer"></div>
					                                   		 </div>
					                                    </div>
					                             </div>
			                               </div>
		                                	<div class="row">
			                                	<div class="col-md-6">
					                                 <div class="form-group row">
					                                      <label for="example-tel-input" class="col-sm-4 control-label">Sub Location<span class='text-danger'>*</span></label>
					                                      <div class="col-sm-6">
						                                      <div>
							                                     <div>
							                                        <input class="form-control" type="text" readonly="true" id="sublocation" name="sublocation" value="<% out.print(builderProject.getAddr2());%>">
							                                    </div>
							                                    <div class="messageContainer"></div>
						                                    </div>
					                                    </div>
					                                </div>
					                            </div>
					                            <div class="col-md-6">
							                          <div class="form-group row">
							                               <label for="example-tel-input" class="col-sm-4 control-label">Country<span class='text-danger'>*</span></label>
							                               <div class="col-sm-6">
							                               <input type="hidden" name="country_id" id="country_id" value="<%out.print(builderProject.getCountry().getId());%>">
						                                       <div>
							                                    	<div>
								                                        <select name="country_id" id="country_id" class="form-control" disabled>
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
				                                </div>
				                             </div>
											
											<div class="row">
			                                	<div class="col-md-6">
			                                		<div class="form-group row">
			                                   		 	<label for="example-tel-input" class="col-sm-4 control-label">State<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    		<input type="hidden" name="state_id" id="state_id" value="<%out.print(builderProject.getState().getId());%>"/>			                                    			<div>
				                                    			<div>
							                                         <select name="state_id" id="state_id" class="form-control" disabled>
													                    <option value="">Select State</option>
													                    <%
													                    if(states != null){
													                    for(State state : states) { %>
													                    <% 	if(builderProject.getState().getId() == state.getId()) {
													                    		cities = state.getCities();
													                    		out.print(state.getName());
													                    	}
													                    %>
																		<option value="<% out.print(state.getId());%>" <% if(builderProject.getState().getId() == state.getId()) { %>selected<% } %>><% out.print(state.getName());%></option>
																		<% }} %>
														          	</select>
				                                   				</div>
			                                    				<div class="messageContainer"></div>
			                                    			</div>	
			                                   		 	</div>
			                                   		</div>
			                                   	</div>	 
			                                   	<div class="col-md-6">
			                                   		<div class="form-group row">
					                                    <label for="example-tel-input" class="col-sm-4 control-label">City<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
						                                     <div>
						                                     	<input type="hidden" id="city_id" name="city_id" value="<%out.print(builderProject.getCity().getId());%>"/>
						                                         <select name="city_id" id="city_id" class="form-control" disabled>
												                	<option value="">Select City</option>
												                    <%
												                    if(cities != null){
												                    for(City city : cities){ %>
												                    <% 	if(builderProject.getCity().getId() == city.getId()) { 
												                    		localities = city.getLocalities();
												                    	}
												                    %>
																	<option value="<% out.print(city.getId());%>" <% if(builderProject.getCity().getId() == city.getId()) { %>selected<% } %>><% out.print(city.getName());%></option>
																	<% } }%>
													          	</select>
						                                    </div>
					                                        <div class="messageContainer"></div>
					                                  </div>
					                              </div>
					                           </div> 
			                                </div>
			                                <div class="row">
			                                	<div class="col-md-6">
					                                <div class="form-group row">
					                                    <label for="example-text-input" class="col-sm-4 control-label">Locality<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    	<div>
							                                    <div>
							                                        <!-- <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">-->
							                                        <input class="form-control" type="text" readonly="true" name="locality_name" id="locality_name" value="<%out.print(builderProject.getLocalityName());%>"/>
							                                        
																</div>
																<div class="messageContainer"></div>
															</div>
														</div>
													</div>
												</div>		
												<div class="col-md-6">
					                                <div class="form-group row">		
					                                    <label for="example-text-input" class="col-sm-4 control-label">Pincode<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    	<div>
							                                    <div>
							                                        <input class="form-control" type="text"  readonly="true" id="pincode" name="pincode" autocomplete="off" value="<% out.print(builderProject.getPincode());%>"/>
							                                    </div>
							                                    <div class="messageContainer"></div>
							                                    </div>
							                            </div>     
					                                </div>
					                             </div>   
			                                </div>
			                                <div class="row">
			                                	<div class="col-md-6">
					                                <div class="form-group row">
					                                    <label for="example-search-input" class="col-sm-4 control-label">Latitude<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    	<div>
						                                    	<div>
						                                        	<input class="form-control" type="text" readonly="true" id="latitude" name="latitude" autocomplete="off" value="<% out.print(builderProject.getLatitude());%>"/>
						                                   		</div>
						                                    	<div class="messageContainer"></div>
					                                    	</div>
					                                    </div>
					                                </div>
					                            </div>
					                            <div class="col-md-6">
					                                <div class="form-group row">  
					                                    <label for="example-search-input" class="col-sm-4 control-label">Longitude<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-6">
					                                    	<div>
							                                    <div>
							                                        <input class="form-control" type="text" id="longitude" name="longitude" readonly="true" autocomplete="off" value="<% out.print(builderProject.getLongitude());%>"/>
							                                    </div>
<!-- 							                                    <div class="messageContainer"></div> -->
							                                </div>
					                                    </div>
					                                </div>
					                           </div>  
			                               </div>
			                               <div class="row">
			                               		<div class="col-sm -6">   
					                                <div class="form-group row">
					                                    <label for="example-tel-input" class="col-sm-4 control-label">Description</label>
					                                    <div class="col-sm-6">
					                                        <textarea class="form-control" id="description"  name="description"><% out.print(builderProject.getDescription());%></textarea>
					                                    </div>
					                                 </div>
					                              </div>
					                              <div class="col-sm -6">   
					                                <div class="form-group row">  
					                                    <label for="example-tel-input" class="col-sm-4 control-label">Highlight(USP)</label>
					                                    <div class="col-sm-6">
					                                    	<textarea class="form-control" id="highlight"  name="highlight"><% out.print(builderProject.getHighlights());%></textarea>
					                                    </div>
<!-- 					                                    <div class="messageContainer"></div> -->
					                                </div>
					                            </div> 
			                                </div>
			                                <input type="hidden" id="status" name="status" value="<%out.print(builderProject.getStatus());%>"/>
			                            
		                                	<div class="offset-sm-5 col-sm-7">
		                                        <button type="submit" name="basicbtn" class="btn btn-submit waves-effect waves-light m-t-10">Submit</button>
		                                 	</div>
		                               </form>
	                               </div>
                             </div>
                             <div id="vimessages1" class="tab-pane" aria-expanded="false">
	                          	 <form  id="detailfrm" name="detailfrm" method="post">
	                          	  <input type="hidden" id="id" name="id" value="<% out.print(project_id);%>"/>
	                               <div class="form-group row">
	                                  <label for="example-text-input" class="col-sm-2 col-form-label">Project Type<span class='text-danger'>*</span></label>
	                                 <% 	int a = projectProjectTypes.size();
                                     for(int i = 0;i < projectProjectTypes.size();i++ ){
                                     	if(a > 1){
                                     		out.print(projectProjectTypes.get(i).getBuilderProjectType().getName()+", ");
                                     			a--;
                                     	}else{
                                     		out.print(projectProjectTypes.get(i).getBuilderProjectType().getName());
                                     	}
                                  }
								%>
	                              </div><hr>
	                                <div class="form-group row">
	                                  <label for="example-text-input" class="col-sm-2 col-form-label">Property Type<span class='text-danger'>*</span></label>
	                                  <% 	
	                                  int propertytypeCount = projectPropertyTypes.size();
										for(int i = 0;i < projectPropertyTypes.size();i++){
											if(propertytypeCount > 1){
												out.print(projectPropertyTypes.get(i).getBuilderPropertyType().getName()+"("+projectPropertyTypes.get(i).getValue()+"), ");
												propertytypeCount--;
											}else{
												out.print(projectPropertyTypes.get(i).getBuilderPropertyType().getName()+"("+projectPropertyTypes.get(i).getValue()+")");
											}
										}
										%>
	                                </div><hr>
	                                 <div class="form-group row">
	                                    <label for="example-text-input" class="col-sm-2 col-form-label">Configurations*</label>
	                                    <% 	
	                                      int cg = projectConfigurationInfos.size();
	                                    		for(int i = 0;i < projectConfigurationInfos.size();i++){
	                                    			if(cg > 1){
	                                    				out.print(projectConfigurationInfos.get(i).getBuilderProjectPropertyConfiguration().getName()+", ");
	                                    				cg--;
	                                    			}else{
	                                    				out.print(projectConfigurationInfos.get(i).getBuilderProjectPropertyConfiguration().getName());
	                                    			}
	                                    		}
										%>
	                                </div><hr>
	                                <div class="form-group row">
	                                    <label for="example-text-input" class="col-sm-2 col-form-label">Project Amenities<span class='text-danger'>*</span></label>
	                                    <% int pai = projectAmenityInfos.size();
	                                    		for(int i=0;i<projectAmenityInfos.size();i++){
	                                    			if(pai > 1){
	                                    				out.print(projectAmenityInfos.get(i).getBuilderProjectAmenity().getName()+", ");
	                                    				pai--;
	                                    			}else{
	                                    				out.print(projectAmenityInfos.get(i).getBuilderProjectAmenity().getName());
	                                    			}
	                                    		}
	                                    		%>
	                                </div><hr>
	                                <div class="form-group row">
	                                   <label for="example-text-input" class="col-sm-2 col-form-label">Project Approval<span class='text-danger'>*</span></label>
	                                   <%
	                                      int pa = projectApprovalInfos.size();
	                                		   for(int i = 0;i<projectApprovalInfos.size();i++){
	                                			   if(pa > 1){
	                                				   out.print(projectApprovalInfos.get(i).getBuilderProjectApprovalType().getName()+", ");
	                                				   pa--;
	                                			   }else{
	                                				   out.print(projectApprovalInfos.get(i).getBuilderProjectApprovalType().getName());
	                                			   }
	                                		   }
	                                   %>
	                                </div><hr>
	                                <div class="form-group row">
	                                   <label for="example-text-input" class="col-sm-2 col-form-label">Home Loan Banks</label>
	                                   <% int hlb = projectBankInfos.size();
	                                		for(int i = 0; i < projectBankInfos.size(); i++){
	                                			if(hlb > 1){
	                                				out.print(projectBankInfos.get(i).getHomeLoanBanks().getName()+", ");
	                                				hlb--;
	                                			}else{
	                                				out.print(projectBankInfos.get(i).getHomeLoanBanks().getName());
	                                			}
	                                		}
	                                   %>
	                                </div><hr>
	                                 <div class="form-group row">
		                                  <label for="example-text-input" class="col-sm-2 col-form-label">Project Area</label>
		                                   	<div class="col-sm-3 form-group">
		                                   		<% if(builderProject.getProjectArea() != null) { out.print(builderProject.getProjectArea());} %>
		                                   		<% if(builderProject.getAreaUnit() != null){ out.print(builderProject.getAreaUnit().getName());} %>
		                                   	</div>
		                             </div><hr>
	                                 <div class="form-group row">
	                                    <%
											SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
									 	%>
									 	 <label for="example-text-input" class="col-sm-2 col-form-label">Launch Date </label>
	                                    <div class="col-sm-3 form-group">
	                                    	<div class="">
	                                   			<% if(builderProject.getLaunchDate() != null) { out.print(dt1.format(builderProject.getLaunchDate()));} %>
	                                   		</div>
	                                   </div>
	                                   </div><hr>
	                                    <div class="form-group row">
	                                    <label for="example-text-input" class="col-sm-2 col-form-label">Possession Date </label>
	                                    <div class="col-sm-3">
	                                    	<div>
	                                   			<% if(builderProject.getPossessionDate() != null) { out.print(dt1.format(builderProject.getPossessionDate()));} %>
	                                   		</div>
	                                   </div>
	                                 </div><hr>
	                                <div class="offset-sm-5 col-sm-7">
	                                        <button type="button" id="detailbtn" class="btn btn-submit waves-effect waves-light m-t-10">NEXT</button>
	                                 </div>
	                                </form>   
	                            </div>
		                		<div id="vimessages2" class="tab-pane" aria-expanded="false">
	                                 <div class="col-12">
	                                 	<form id="pricingfrm" name="pricingfrm" method="post">
		                                	<input type="hidden" name="id" value="<% out.print(projectPriceInfo.getId());%>"/>
											<input type="hidden" name="project_id" value="<% out.print(project_id);%>"/>
											<div class="row">
												<div class="col-md-6">
			                                	 	<div class="form-group row">
			                                    		<label for="example-text-input" class="col-sm-4 col-form-label">Pricing Unit<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6"> 
			                                    			<div>
				                                        		<select name="base_unit" id="base_unit" class="form-control">
																	<% for(AreaUnit areaUnit :areaUnits) {
																		if(projectPriceInfo.getAreaUnit() !=null){
																		%>
																		<option value="<% out.print(areaUnit.getId()); %>" <% if(projectPriceInfo.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
																	<% } else{
																	%>
																		<option value="<% out.print(areaUnit.getId()); %>"><% out.print(areaUnit.getName()); %></option>
																	<%
																		}
																	}
																	%>	
																</select>
			                                    			</div>
			                                    			<div class="messageContainer"></div>
			                                    		</div>
			                                      </div>
			                                      </div>
			                                      <div class="col-md-6">
				                                      <div class="form-group row">
				                                    		<label for="example-text-input" class="col-sm-4 col-form-label">Base Rate<span class='text-danger'>*</span></label>
						                                    <div class="col-sm-6">
						                                    	<div>
						                                    		<div>
						                                        		<input class="form-control" type="text" id="base_rate" name="base_rate" value="<% if(projectPriceInfo.getBasePrice() != null){ out.print(projectPriceInfo.getBasePrice());}%>"/>
						                                    		</div>
						                                    		<div class="messageContainer"></div>
						                                    	</div>
						                                   </div>
						                              </div> 
					                              </div>
					                        </div>
					                        <div class="row">
					                        	<div class="col-md-6">
					                                <div class="form-group row">
				        		                            <label for="example-search-input" class="col-sm-4 col-form-label">Floor Rising Rate<span class='text-danger'>*</span></label>
				                		                    <div class="col-sm-6">
				                		                    	<div>
						                		                    <div>
						                        		                <input class="form-control" type="text" id="rise_rate" name="rise_rate" value="<% if(projectPriceInfo.getRiseRate() != null){ out.print(projectPriceInfo.getRiseRate());}%>"/>
						                                	        </div>
						                                   	 		<div class="messageContainer"></div>
						                                   	 	</div>
				                                   	 		</div>
				                                   	</div>	
				                                </div>
				                                <div class="col-md-6"> 	
				                                	<div class="form-group row">
				                                    		<label for="example-search-input" class="col-sm-4 col-form-label">Application Post<span class='text-danger'>*</span></label>
						                                    <div class="col-sm-6">
						                                    <div>
						                                        <input class="form-control" type="text" id="post" name="post" value="<% if(projectPriceInfo.getPost() != null){ out.print(projectPriceInfo.getPost());}%>"/>
						                                    </div>
				                                    		<div class="messageContainer"></div>
				                                    		</div>
			                                		</div>
			                                	</div>	
	                                		</div>
	                                		<div class="row">
	                                			<div class="col-sm-6">
			                                 		<div class="form-group row">
			                                    		<label for="example-tel-input" class="col-sm-4 col-form-label">Maintenance Charge<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
					                                    		<div>
					                                        		<input class="form-control" type="text" id="maintenance" name="maintenance" value="<% if(projectPriceInfo.getMaintenance() != null){ out.print(projectPriceInfo.getMaintenance());}%>"/>
					                                    		</div>
					                                    		<div class="messageContainer"></div>
					                                    	</div>	
			                                    		</div>
			                                    	</div>
			                                    </div>
			                                    <div class="col-sm-6">
			                                    	<div class="form-group row">
			                                    		<label for="example-tel-input" class="col-sm-4 col-form-label">Tenure</label>
			                                    		<div class="col-sm-6">
			                                    			<div>
					                                    		<div>
					                                        		<input class="form-control" type="text" id="tenure" name="tenure" value="<% out.print(projectPriceInfo.getTenure());%>">
					                                    		</div>
					                                    		<div class="messageContainer"></div>
					                                    	</div>
			                                    		</div>
			                                		</div>
			                                	</div>
			                                </div>	
			                                <div class="row">
			                                	<div class="col-sm-6">	
					                                <div class="form-group row">
			        		                            <label for="example-tel-input" class="col-sm-4 col-form-label">Amenities facing Rate<span class='text-danger'>*</span></label>
			                		                    <div class="col-sm-6">
			                		                    	<div>
					                		                    <div>
					                        		                <input class="form-control" type="text" id="amenity_rate" name="amenity_rate" value="<% if(projectPriceInfo.getAmenityRate() != null){ out.print(projectPriceInfo.getAmenityRate());}%>"/>
					                                		    </div>
					                                		    <div class="messageContainer"></div>
					                                		</div>
			                                		    </div>
			                                		 </div>
			                                	</div>
			                                	<div class="col-sm-6">
			                                		<div class="form-group row">
			                                    		<label for="example-tel-input" class="col-sm-4 col-form-label">Parking<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                         			<input class="form-control" type="text" id="parking" name="parking" value="<% if(projectPriceInfo.getParking() != null){ out.print(projectPriceInfo.getParking());}%>"/>
				                                         		</div>	
			                                    				<div class="messageContainer"></div>
			                                    			</div>
			                                    		</div>
			                                		</div>
			                                	</div>
			                                </div>
			                                <div class="row">
			                                	<div class="col-sm-6">
					                                <div class="form-group row">
			        		                            <label for="example-text-input" class="col-sm-4 col-form-label">Stamp Duty<span class='text-danger'>*</span></label>
			                		                    <div class="col-sm-6">
			                		                    	<div>
				                		                    	<div>
				                        		               		<input class="form-control" type="text" id="stamp_duty" name="stamp_duty" value="<% if(projectPriceInfo.getStampDuty() != null){ out.print(projectPriceInfo.getStampDuty());} else {if(taxes.size() > 0){out.print(taxes.get(0).getStampDuty());}}%>"/>
				                                		    	</div>
				                                		    	<div class="messageContainer"></div>
				                                		    </div>
			                                		    </div>
			                                		</div>
			                                   </div>
			                                   <div class="col-sm-6">
			                                		<div class="form-group row">
			                                   			<label for="example-text-input" class="col-sm-4 col-form-label">Tax<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input class="form-control" type="text" id="tax" name="tax" value="<% if(projectPriceInfo.getTax() != null){ out.print(projectPriceInfo.getTax());} else {if(taxes.size() > 0){out.print(taxes.get(0).getTax());}}%>"/>
				                                    			</div>
				                                    			<div class="messageContainer"></div>
				                                    		</div>
			                                    		</div>
			                                    	</div>
			                                   </div>
			                                </div>
			                                <div class="row">
			                                	 <div class="col-sm-6">
			                                		<div class="form-group row">
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">VAT<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input class="form-control" type="text" id="vat" name="vat" value="<% if(projectPriceInfo.getVat() != null){ out.print(projectPriceInfo.getVat());} else {if(taxes.size() > 0){out.print(taxes.get(0).getVat());}}%>"/>
				                                    			</div>
				                                    			<div class="messageContainer"></div>
				                                    		</div>
			                                    		</div>
			                                    	</div>
			                                    </div>
			                                    <div class="col-sm-6">
			                                    	<div class="form-group row">	
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">Tech Fees<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
			                                        			<input class="form-control" type="text" id="tech_fee" name="tech_fee" value="<% if(projectPriceInfo.getFee() != null){ out.print(projectPriceInfo.getFee());}%>"/>
			                                    			</div>
			                                    			<div class="messageContainer"></div>
			                                    		</div>	
			                                		</div>
			                                	</div>
			                                </div>
			                                <div class="offset-sm-5 col-sm-7">
	        	                               	<button type="submit" id="pricebtn" class="btn btn-submit waves-effect waves-light m-t-10">UPDATE</button>
	            		                     </div>
	                    	            </form>
                                	</div>
             					</div>
                                 <div id="vimessages3" class="tab-pane" aria-expanded="false">        
                                 	<form id="paymentfrm" name="paymentfrm" method="post" action=""  enctype="multipart/form-data">
                                 	 	<input type="hidden" id="project_id" name="project_id" value="<% out.print(project_id);%>"/>
                                   		<input type="hidden" name="schedule_count" id="schedule_count" value="<%if(projectPaymentInfos != null && projectPaymentInfos.size() >0 ){ out.print(projectPaymentInfos.size()+1000);}else{%>1000<%}%>"/>
                                   		<div id="payment_schedule">
	                                   	<% 	int i = 1;
	                                   	if(projectPaymentInfos != null){
	                                   			for(BuilderProjectPaymentInfo projectPaymentInfo :projectPaymentInfos) {  
												%>
												<input type="hidden" id="schedule_id" name="schedule_id[]" value="<%out.print(projectPaymentInfo.getId());%>"/>
												  <div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
													<hr/>
													<% } %>
														<div class="col-lg-12" style="padding-bottom:5px;">
															<span class="pull-right"><a href="javascript:deleteSchudle(<% out.print(projectPaymentInfo.getId()); %>);" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span>
														</div>
														<div class="col-sm-6">
				                                			<div class="form-group row">
							                                    <label for="example-search-input" class="col-sm-4 control-label">Milestone<span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-6">
				                                    				<div>
				                                        				<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getSchedule() != null) { out.print(projectPaymentInfo.getSchedule());}%>"/>
					                                    			</div>
					                                    			<div class="messageContainer"></div>
					                                 			</div>
					                                 		</div>
					                                 	</div>
					                                 	<div class="col-sm-6">
					                                 		<div class="form-group row">
				                                    			<label for="example-search-input" class="col-sm-4 control-label">% of net payable<span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-6">
				                                    				<div>
				                                        				<input class="form-control" type="text" onkeyup="javascript:vaildPayablePer(<%out.print(i); %>)" onkeypress=" return isNumber(event, this);" id="payable" name="payable[]" value="<% if(projectPaymentInfo.getPayable() != null) { out.print(projectPaymentInfo.getPayable());}%>"/>
					                                    			</div>
					                                    			<div class="messageContainer"></div>
					                                  			</div>
				                                			</div>
				                               			</div>
			                               			
	                               				</div>
	                               <%i++;}}%>
	                               		</div>
	                               		<div>
											<div class="col-sm-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-submit btn-sm">+ Add More Schedule</a>
												</span>
											</div>
										</div>
										<div class="row">
			                                <div class="offset-sm-5 col-sm-7">
		                                        <button type="submit" id="paymentbtn" class="btn btn-submit waves-effect waves-light m-t-10">UPDATE</button>
		                                    </div>
	                                 	</div>
	                                </form>
	                           </div>
                         
                               <div id="vimessages4" class="tab-pane" aria-expanded="true">
                                <div id="offer" class="tab-pane fade active in">
										<form id="offerfrm" name="offerfrm" method="post" action=""  enctype="multipart/form-data">
										 	<input type="hidden" id="project_id" name="project_id" value="<% out.print(project_id);%>"/>
											<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(projectOfferInfos.size()+10000); %>"/>
								 			<div class="row">
												<div class="col-lg-12">
															<div id="offer_area">
																<% int j = 1;
																		for(BuilderProjectOfferInfo projectOfferInfo :projectOfferInfos) { 
																%>
																<div class="row" id="offer-<% out.print(projectOfferInfo.getId()); %>">
																	<input type="hidden" name="offer_id[]" value="<% out.print(projectOfferInfo.getId()); %>" />
																	<div class="col-lg-12" style="padding-bottom:5px;">
																		<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(projectOfferInfo.getId()); %>);" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span>
																	</div>
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-offer_title">
																			<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																			<div class="col-sm-8">
																				<div>
																					<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% out.print(projectOfferInfo.getTitle()); %>">
																				</div>
																				<div class="messageContainer"></div>
																			</div>
																		</div>
																	</div>
																	<div class="col-lg-3 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-6">Offer Type </label>
																			<div class="col-sm-6">
																				<select class="form-control" id="offer_type<%out.print(j); %>"  onchange="txtEnabaleDisable(<%out.print(j); %>);" name="offer_type[]">
																					<option value="1" <% if(projectOfferInfo.getType() == 1) { %>selected<% } %>>Percentage</option>
																					<option value="2" <% if(projectOfferInfo.getType() == 2) { %>selected<% } %>>Flat Amount</option>
																					<option value="3" <% if(projectOfferInfo.getType() == 3) { %>selected<% } %>>Other</option>
																				</select>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-4 margin-bottom-5">
																		<div class="form-group" id="error-discount_amount">
																			<label class="control-label col-sm-6">Discount Amount <span class='text-danger'>*</span></label>
																			<div class="col-sm-6">
																				<input type="text" class="form-control" <%if(projectOfferInfo.getType() == 3){ %>disabled<%} %> id="discount_amount<%out.print(j); %>"   onkeyup=" javascript:validPerAmount(<%out.print(j); %>);" name="discount_amount[]" value="<%if(projectOfferInfo.getAmount()!=null){ out.print(projectOfferInfo.getAmount());} %>"/>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-4">Description </label>
																			<div class="col-sm-8">
																				<textarea class="form-control" id="description" name="description[]"><% if(projectOfferInfo.getDescription() != null) { out.print(projectOfferInfo.getDescription());} %></textarea>
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
																		<a href="javascript:addMoreOffer();" id="addMoreOffers" class="btn btn-submit btn-sm">+ Add More Offers</a>
																	</span>
																</div>
															</div>
														</div>
													</div>
												<div class="row">
													 <div class="offset-sm-5 col-sm-7">
		                                        		<button type="submit" id="offerbtn" class="btn btn-submit waves-effect waves-light m-t-10">SAVE</button>
		                                   			</div>
		                                   		</div>
											</form>
										</div>
                                	</div>
                           		</div>
                        	</div>
                        </div>
                     </div>
                 </div>
             </div>
         	<div id="sidebar1"> 
		       <%@include file="../partial/footer.jsp"%>
			</div>   
         </div>
    </div>
</body></html>
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script> -->
<script src="../js/bootstrapValidator.min.js"></script>
<script src="../js/bootstrap-datepicker.min.js"></script>
<script src="../js/jquery.form.js"></script>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script>
function validPerAmount(id){
	if($("#offer_type"+id).val()==1){
			 isNumber(event, this);
				 validPercentage(id);
	}
	if($("#offer_type"+id).val()==2){
		onlyNumber(id);
	}
}
function validPercentage(id){
	 var x = $("#discount_amount"+id).val();
	 if(isNaN(x) || x<0 || x >100){
		 alert("The percentage must be between 0 and 100");
		 $("#discount_amount"+id).val('');
	 }
}
function onlyNumber(id){
	
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only numbers.'); return ''; } ) );
}
function vaildPayablePer(id){
	var x = $("#payable"+id).val();
	if( x<0 || x >100){
		alert("The percentage must be between 0 and 100");
		$("#payable"+id).val('');
	}
}
// $('#detailfrm').bootstrapValidator({
// 	container: function($field, validator) {
// 		return $field.parent().next('.messageContainer');
//    	},
//     feedbackIcons: {
//         validating: 'glyphicon glyphicon-refresh'
//     },
//     excluded: ':disabled',
//     fields: {
//     	launch_date: {
//             validators: {
//                 callback: {
//                     message: 'Wrong Launch Date',
//                     callback: function (value, validator) {
//                         var m = new moment(value, 'DD MMM YYYY', true);
//                         if (!m.isValid()) {
//                             return false;
//                         } else {
//                         	return true;
//                         }
//                     }
//                 }
//             }
//         },
//         possession_date: {
//             validators: {
//                 callback: {
//                     message: 'Wrong Possession Date',
//                     callback: function (value, validator) {
//                         var m = new moment(value, 'DD MMM YYYY', true);
//                         if (!m.isValid()) {
//                             return false;
//                         } else {
//                         	return true;
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }).on('success.form.bv', function(event,data) {
// 	// Prevent form submission
// 	event.preventDefault();
// 	saveProjectDetails();
// });
$("#detailbtn").click(function(){
	$('.active').removeClass('active').next('li').addClass('active');
    $("#vimessages2").addClass('active');
});

$('#latitude').keypress(function (event) {
    return isNumber(event, this)
});
$('#longitude').keypress(function (event) {
    return isNumber(event, this)
});
$('#project_area').keypress(function (event) {
    return isNumber(event, this)
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
}   
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
$('#discount_amount').keypress(function (event) {
    return isNumber(event, this)
});
$("#amenity_weightage").keypress(function(event){
	return isNumber(event, this)
});
$("#building_weightage").keypress(function(event){
	return isNumber(event, this)
});
 
function onlyNumber(id){
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only numbers.'); return ''; } ) );
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

$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#detailfrm').data('bootstrapValidator').revalidateField('possession_date');
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
function txtEnabaleDisable(id){
	$th = $("#offer_type"+id).val();
	 if($th == 3){
	  	$('#discount_amount'+id).attr('disabled', true);
	  	$("#discount_amount"+id).val('');
	 }else{
		$('#discount_amount'+id).attr('disabled', false); 
		$("#discount_amount"+id).val('');
	 }
}

$("#floor").click(function(){
	window.location.href="${baseUrl}/builder/project/building/floor/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>";
});

$("#building").click(function(){
	window.location.href="${baseUrl}/builder/project/building/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>";
});
$("#flat").click(function(){
	window.location.href = "${baseUrl}/builder/project/building/floor/flat/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>&flat_id=<%out.print(flat_id); %>";
});
//needed to change color of div on click event.
// $("#project").click(function(){
// 	var check = $("#project").hasClass('top-blue-box');
// 	if(!check){
// 		$("#project").removeClass('top-white-box');
// 		$("#project").addClass('top-blue-box');
// 		var isBuilding = $("#building").hasClass('top-blue-box');
// 		if(isBuilding){
// 			$("#building").removeClass('top-blue-box');
// 			$("#building").addClass('top-white-box');
// 		}
// 		var isFloor = $("#floor").hasClass('top-blue-box');
// 		if(isFloor){
// 			$("#floor").removeClass('top-blue-box');
// 			$('#floor').addClass('top-white-box');
// 		}
// 		var isFlat = $("#flat").hasClass('top-blue-box');
// 		if(isFlat){
// 			$("#flat").removeClass('top-blue-box');
// 			$("#flat").addClass('top-white-box');
// 		}
// 	}
// });

// $("#building").click(function(){
// 	 var check = $("#building").hasClass('top-lue-box');
// 	 if(!check){
// 		 $("#building").removeClass('top-white-box');
// 		 $("#building").addClass('top-blue-box');
// 		 var isProject = $("#project").hasClass('top-blue-box');
// 		 if(isProject){
// 			 $("#project").removeClass('top-blue-box');
// 			 $('#project').addClass('top-white-box');
// 		 }
// 		 var isFloor = $('#floor').hasClass('top-blue-box');
// 		 if(isFloor){
// 			 $('#floor').removeClass('top-blue-box');
// 			 $('#floor').addClass('top-white-box');
// 		 }
// 		 var isFlat = $("#flat").hasClass('top-blue-box');
// 		 if(isFlat){
// 			 $('#flat').removeClass('top-blue-box');
// 			 $('#flat').addClass('top-white-box');
// 		 }
// 	 }
	
// });

// $("#floor").click(function(){
// 	var check = $("#floor").hasClass('top-blue-box');
// 	if(!check){
// 		$("#floor").removeClass('top-white-box');
// 		$('#floor').addClass('top-blue-box');
// 		var isProject = $("#project").hasClass('top-blue-box');
// 		if(isProject){
// 			$('#project').removeClass('top-blue-box');
// 			$("#project").addClass('top-white-box');
// 		}
// 		var isBuilding = $('#building').hasClass('top-blue-box');
// 		if(isBuilding){
// 			$("#building").removeClass('top-blue-box');
// 			$("#building").addClass('top-white-box');
// 		}
// 		var isFlat = $("#flat").hasClass('top-blue-box');
// 		if(isFlat){
// 			$('#flat').removeClass('top-blue-box');
// 			$("#flat").addClass('top-white-box');
// 		}
// 	}
// });

// $("#flat").click(function(){
// 	var check = $('#flat').hasClass('top-blue-top');
// 	if(!check){
// 		$('#flat').removeClass('top-white-box');
// 		$('#flat').addClass('top-blue-box');
// 		var isProject = $('#project').hasClass('top-blue-box');
// 		if(isProject){
// 			$('#project').removeClass('top-blue-box');
// 			$('#project').addClass('top-white-box');
// 		}
// 		var isBuilding = $('#building').hasClass('top-blue-box');
// 		if(isBuilding){
// 			$('#building').removeClass('top-blue-box');
// 			$('#building').addClass('top-white-box');
// 		}
// 		var isFloor = $('#floor').hasClass('top-blue-box');
// 		if(isFloor){
// 			$('#floor').removeClass('top-blue-box');
// 			$('#floor').addClass('top-white-box');
// 		}
// 	}
// });

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
        locality_name: {
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
        $('.active').removeClass('active').next('li').addClass('active');
        $("#vimessages1").addClass('active');
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
        $('.active').removeClass('active').next('li').addClass('active');
        $("#vimessages3").addClass('active');
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
	var project = {id:$("#id").val(),projectArea:$("#project_area").val(),areaUnit:{id:$("#area_unit").val()},launchDate:new Date($("#launch_date").val()), possessionDate:new Date($("#possession_date").val())};
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
	        	 callback: {
                     message: 'The sum of percentages must be 100',
                     callback: function(value, validator, $field) {
                         var percentage = validator.getFieldElements('payable[]'),
                             length     = percentage.length,
                             sum        = 0;

                         for (var i = 0; i < length; i++) {
                             sum += parseFloat($(percentage[i]).val());
                         }
                         if (sum === 100) {
                             validator.updateStatus('payable[]', 'VALID', 'callback');
                             return true;
                         }

                         return false;
                     }
                 },
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
        $('.active').removeClass('active').next('li').addClass('active');
        $("#vimessages4").addClass('active');
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
	//alert("Hello");
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
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title'+offers+'" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
		+'<div class="form-group" id="error-applicable_on">'
		+'<label class="control-label col-sm-6">Offer Type </label>'
		+'<div class="col-sm-6">'
		+'<select class="form-control"  id="offer_type'+offers+'" onchange="txtEnabaleDisable('+offers+');"  name="offer_type[]">'
		+'<option value="1">Percentage</option>'
		+'<option value="2">Flat Amount</option>'
		+'<option value="3">Other</option>'
		+'</select>'
		+'</div>'
		+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-6">Discount Amount </label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control errorMsg" id="discount_amount'+offers+'" onkeyup=" javascript:validPerAmount('+offers+');" name="discount_amount[]" value=""/>'
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
				+'<div class="col-lg-12" style="padding-bottom:5px;">'
				+'<span class="pull-right"><a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span>'
				+'</div>'
				+'<div class="col-sm-6">'
               	+'<div class="form-group row">'
                +'<label for="example-search-input" class="col-sm-4 control-label">Milestone<span class="text-danger">*</span></label>'
           		+'<div class="col-sm-6">'
           		+'<div>'
               	+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
               	+'</div>'
               	+'<div class="messageContainer"></div>'
            	+'</div>'
            	+'</div>'
            	+'</div>'
              	+'<div class="col-sm-6">'
	    		+'<div class="form-group row">'
	   			+'<label for="example-search-input" class="col-sm-4 control-label">% of net payable<span class="text-danger">*</span></label>'
	   			+'<div class="col-sm-6">'
	   			+'<div>'
	       		+'<input class="form-control" type="text" onkeyup="javascript:vaildPayablePer('+schedule_count+')" onkeypress=" return isNumber(event, this);" id="payable" name="payable[]" value=""/>'
       			+'</div>'
       			+'<div class="messageContainer"></div>'
     			+'</div>'
				+'</div>'
				+'</div>'
				+'</div>';
	$("#payment_schedule").append(html);
	$("#schedule_count").val(schedule_count);
}
function removeSchedule(id) {
	$("#schedule-"+id).remove();
}
function deleteOffer(id) {
	
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

function deleteSchudle(id){
	
	var flag = confirm("Are you sure ? You want to delete schedule ?");
	if(flag){
		$.get("${baseUrl}/webapi/project/payment/delete/"+id,{}, function(data){
			alert(data.message);
			if(data.status == 1){
				$("#schedule-"+id).remove();
			}
		})
	}
}
</script>