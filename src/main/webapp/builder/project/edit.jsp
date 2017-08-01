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
                    <div class="col-lg-3 col-sm-6 col-xs-12 m-t-15 ">
                        <div class="top-blue-box " style="font-size:20px;">
                     <p class="center" style="color:#FFF">PROJECT</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12 m-t-15">
                        <div class="top-white-box " style="font-size:20px;">
                         <p class="center">   BUILDING</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12  m-t-15">
                        <div class="top-white-box" style="font-size:20px;">
                        <p class="center">  FLOOR</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12  m-t-15">
                        <div class="top-white-box" style="font-size:20px;">
                         <p class="center"> FLAT</p>
                        </div>
                    </div>
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
<!--                                      <li > -->
<!--                                         <a  data-toggle="tab" href="#vimessages3"><span>Payment Schedules</span></a> -->
<!--                                     </li> -->
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
			                                	<div class="col-lg-6 ">
				                                	<div class="form-group row" id="error-builder_id">
				                                  	  <label  class="col-sm-4 control-label">Builder Group<span class='text-danger'>*</span></label>
				                                    <div class="col-sm-8">
				                                    <div>
				                                        <!-- <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">-->
				                                        <select id="builder_id" name="builder_id" class="form-control">
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
			                                    <div class="col-lg-6 ">
				                                    <div class="form-group row" id="error-builder_id">
				                                    	<label for="example-text-input" class="col-sm-4 control-label">Builder Company<span class='text-danger'>*</span></label>
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
			                                	<div class="col-md-6">
					                                <div class="form-group row">
					                                    <label for="example-search-input" class="col-sm-4 control-label">Project Name<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-8">
					                                    	<div>
					                                        	<input class="form-control" type="text" id="name" name="name" value="<% out.print(builderProject.getName());%>">
					                                    	</div>
					                                    	<div class="messageContainer"></div>
					                                    </div>
					                                 </div>
					                              </div>
					                              <div class="col-md-6">
					                                 	<div class="form-group row">
					                                    	<label for="example-search-input" class="col-sm-4 control-label">Landmark<span class='text-danger'>*</span></label>
					                                    	<div class="col-sm-8">
					                                    		<div>
					                                        		<input class="form-control" type="text" id="landmark" name="landmark" value="<% out.print(builderProject.getAddr1());%>">
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
					                                      <div class="col-sm-8">
						                                      <div>
							                                     <div>
							                                        <input class="form-control" type="text" id="sublocation" name="sublocation" value="<% out.print(builderProject.getAddr2());%>">
							                                    </div>
							                                    <div class="messageContainer"></div>
						                                    </div>
					                                    </div>
					                                </div>
					                            </div>
					                            <div class="col-md-6">
							                          <div class="form-group row">
							                               <label for="example-tel-input" class="col-sm-4 control-label">Country<span class='text-danger'>*</span></label>
							                               <div class="col-sm-8">
						                                       <div>
							                                    	<div>
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
				                                </div>
				                             </div>
											
											<div class="row">
			                                	<div class="col-md-6">
			                                		<div class="form-group row">
			                                   		 	<label for="example-tel-input" class="col-sm-4 control-label">State<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-8">
			                                    			<div>
				                                    			<div>
							                                         <select name="state_id" id="state_id" class="form-control">
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
					                                    <div class="col-sm-8">
						                                     <div>
						                                         <select name="city_id" id="city_id" class="form-control">
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
					                                    <div class="col-sm-8">
					                                    	<div>
							                                    <div>
							                                        <!-- <input class="form-control" type="text" value="Artisanal kale" id="example-text-input">-->
							                                        <select name="locality_id" id="locality_id" class="form-control">
													                	<option value="">Select Locality</option>
													                	<%
													                	if(localities != null){
													                	for(Locality locality : localities){ %>
																		<option value="<% out.print(locality.getId());%>" <% if(builderProject.getLocality().getId() == locality.getId()) { %>selected<% } %>><% out.print(locality.getName());%></option>
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
					                                    <label for="example-text-input" class="col-sm-4 control-label">Pincode<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-8">
					                                    	<div>
							                                    <div>
							                                        <input class="form-control" type="text" id="pincode" name="pincode" autocomplete="off" value="<% out.print(builderProject.getPincode());%>"/>
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
					                                    <div class="col-sm-8">
					                                    	<div>
						                                    	<div>
						                                        	<input class="form-control" type="text" id="latitude" name="latitude" autocomplete="off" value="<% out.print(builderProject.getLatitude());%>"/>
						                                   		</div>
						                                    	<div class="messageContainer"></div>
					                                    	</div>
					                                    </div>
					                                </div>
					                            </div>
					                            <div class="col-md-6">
					                                <div class="form-group row">  
					                                    <label for="example-search-input" class="col-sm-4 control-label">Longitude<span class='text-danger'>*</span></label>
					                                    <div class="col-sm-8">
					                                    	<div>
							                                    <div>
							                                        <input class="form-control" type="text" id="longitude" name="longitude" autocomplete="off" value="<% out.print(builderProject.getLongitude());%>"/>
							                                    </div>
							                                    <div class="messageContainer"></div>
							                                </div>
					                                    </div>
					                                </div>
					                           </div>  
			                               </div>
			                               <div class="row">
			                               		<div class="col-sm -6">   
					                                <div class="form-group row">
					                                    <label for="example-tel-input" class="col-sm-4 control-label">Description</label>
					                                    <div class="col-sm-8">
					                                        <textarea class="form-control" id="description" name="description"><% out.print(builderProject.getDescription());%></textarea>
					                                    </div>
					                                 </div>
					                              </div>
					                              <div class="col-sm -6">   
					                                <div class="form-group row">  
					                                    <label for="example-tel-input" class="col-sm-4 control-label">Highlight(USP)</label>
					                                    <div class="col-sm-8">
					                                    	<textarea class="form-control" id="highlight" name="highlight"><% out.print(builderProject.getHighlights());%></textarea>
					                                    </div>
					                                    <div class="messageContainer"></div>
					                                </div>
					                            </div> 
			                                </div>
			                                <input type="hidden" id="status" name="status" value="<%out.print(builderProject.getStatus());%>"/>
			                            
		                                	<div class="offset-sm-5 col-sm-7">
		                                        <button type="submit" name="basicbtn" class="btn btn-info waves-effect waves-light m-t-10">Submit</button>
		                                 	</div>
		                               </form>
	                               </div>
                             </div>
                             <div id="vimessages1" class="tab-pane" aria-expanded="false">
	                          	 <form  id="detailfrm" name="detailfrm" method="post">
	                          	  <input type="hidden" id="id" name="id" value="<% out.print(project_id);%>"/>
	                               <div class="form-group row">
	                                  <label for="example-text-input" class="col-12 col-form-label">Project Type<span class='text-danger'>*</span></label><br/>
	                                  <% 	for(BuilderProjectType builderProjectType : projectTypes) { 
									String is_checked = "";
									for(BuilderProjectProjectType projectProjectType :projectProjectTypes) {
										if(builderProjectType.getId() == projectProjectType.getBuilderProjectType().getId()) {
											is_checked = "checked";
										}
									}
								%>
	                                  <div class="col-3">
	                                      <input type="checkbox" name="project_type[]" value="<% out.print(builderProjectType.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderProjectType.getName());%>
	                                  </div>
	                                  <% } %>
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
									<input type="hidden" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(projectAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
									
								<% 	for(BuilderProjectAmenityStages bpaStages :projectAmenity.getBuilderProjectAmenityStageses()) { 
										Double stage_wt = 0.0;
										for(ProjectAmenityWeightage projectAmenityWeightage :amenityWeightages) {
											if(bpaStages.getId() == projectAmenityWeightage.getBuilderProjectAmenityStages().getId()) {
												stage_wt = projectAmenityWeightage.getStageWeightage();
											}
										}
								%>
								<% 	for(BuilderProjectAmenitySubstages bpaSubstage :bpaStages.getBuilderProjectAmenitySubstageses()) { 
										Double substage_wt = 0.0;
										for(ProjectAmenityWeightage projectAmenityWeightage :amenityWeightages) {
											if(bpaSubstage.getId() == projectAmenityWeightage.getBuilderProjectAmenitySubstages().getId()) {
												substage_wt = projectAmenityWeightage.getSubstageWeightage();
											}
										}
								%>
									<input name="stage_weightage<% out.print(projectAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="hidden" class="form-control" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/>
									<input type="hidden" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
								<% 
									}
									}
								}
								%>
								
	                              </div><hr>
	                                
	                                <div class="form-group row">
	                                  <label for="example-text-input" class="col-12 col-form-label">Property Type<span class='text-danger'>*</span></label>
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
	                                    <div class="col-3">
	                                        <input type="checkbox" name="property_type[]" value="<% out.print(builderPropertyType.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderPropertyType.getName());%>
	                                    </div>
	                                	<input type="hidden" class="form-control" id="property_type<% out.print(builderPropertyType.getId());%>" name="property_type<% out.print(builderPropertyType.getId());%>" value="<% out.print(prop_value); %>" placeholder="No. Of <% out.print(builderPropertyType.getName());%>"/>
	                                <%} %>
	                                </div><hr>
	                                 <div class="form-group row">
	                                    <label for="example-text-input" class="col-12 col-form-label">Configurations*</label>
	                                    <% 	for(BuilderProjectPropertyConfiguration projectConfiguration : projectConfigurations) { 
											String is_checked = "";
											for(BuilderProjectPropertyConfigurationInfo projectConfigurationInfo :projectConfigurationInfos) {
												if(projectConfiguration.getId() == projectConfigurationInfo.getBuilderProjectPropertyConfiguration().getId()) {
													is_checked = "checked";
												}
											}
										%>
	                                    <div class="col-3">
	                                        <input type="checkbox" name="configuration[]" value="<% out.print(projectConfiguration.getId());%>" <% out.print(is_checked); %>/> <% out.print(projectConfiguration.getName());%>
	                                    </div>
	                                    <% } %>
	                                </div><hr>
	                                <div class="form-group row">
	                                    <label for="example-text-input" class="col-12 col-form-label">Project Amenities<span class='text-danger'>*</span></label>
	                                    <% 	for(BuilderProjectAmenity projectAmenity : projectAmenities) { 
											String is_checked = "";
											for(BuilderProjectAmenityInfo projectAmenityInfo :projectAmenityInfos) {
												if(projectAmenity.getId() == projectAmenityInfo.getBuilderProjectAmenity().getId()) {
													is_checked = "checked";
												}
											}
										%>
	                                    <div class="col-3">
	                                        <input type="checkbox" name="amenity_type[]" value="<% out.print(projectAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(projectAmenity.getName());%>
	                                    </div>
	                                    <%} %>
	                                    <div class="messageContainer"></div>
	                                </div><hr>
	                                
	                                <div class="form-group row">
	                                   <label for="example-text-input" class="col-12 col-form-label">Project Approval<span class='text-danger'>*</span></label>
	                                   <% for(BuilderProjectApprovalType projectApproval : projectApprovals) { 
											String is_checked1 = "";
											for(BuilderProjectApprovalInfo projectApprovalInfo :projectApprovalInfos) {
												if(projectApproval.getId() == projectApprovalInfo.getBuilderProjectApprovalType().getId()) {
													is_checked1 = "checked";
												}
											}
										%>
	                                    <div class="col-3">
	 										<input type="checkbox" name="approval_type[]" value="<% out.print(projectApproval.getId());%>" <% out.print(is_checked1); %>/> <% out.print(projectApproval.getName());%>
	                                    </div>
	                                    <% } %>
	                                </div><hr>
	
	                                <div class="form-group row">
	                                   <label for="example-text-input" class="col-12 col-form-label">Home Loan Banks</label>
	                                   <% 	for(HomeLoanBanks homeLoanBank : homeLoanBanks) { 
											String is_checked2 = "";
											for(BuilderProjectBankInfo projectBankInfo :projectBankInfos) {
												if(homeLoanBank.getId() == projectBankInfo.getHomeLoanBanks().getId()) {
													is_checked2 = "checked";
												}
											}
										%>
	                                    <div class="col-3">
	                                        <input type="checkbox" name="homeloan_bank[]" value="<% out.print(homeLoanBank.getId());%>" <% out.print(is_checked2); %>/> <% out.print(homeLoanBank.getName());%>
	                                    </div>
	                                    <% } %>
	                                </div><hr>
	                                <div class="row">
	                                 <div class="form-group row">
	                                 	
		                                   <label for="example-text-input" class="col-sm-3 col-form-label">Project Area</label>
		                                   <div class="col-sm-3">
		                                   		<input  type="text"  class="form-control" id="project_area" name="project_area" value="<% if(builderProject.getProjectArea() != null) { out.print(builderProject.getProjectArea());}%>"/>
		                                   </div>
		                                   <div class="col-sm-4">
			                                   <select name="area_unit" id="area_unit" class="form-control col-lg-3">
													<% for(AreaUnit areaUnit :areaUnits) { %>
													<option value="<% out.print(areaUnit.getId()); %>" <% if(builderProject.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
													<% } %>
												</select>
		                                   </div>
		                                  </div>
	                                    <div class="form-group row">
	                                    <%
											SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
									 	%>
									 	<label class="control-label col-sm-4">Launch Date </label>
	                                    <div class="col-sm-6 form-group">
	                                    	<div class="">
	                                   			<input type="text" class="form-control" id="launch_date" name="launch_date" value="<% if(builderProject.getLaunchDate() != null) { out.print(dt1.format(builderProject.getLaunchDate()));} %>"/>
	                                   		</div>
	                                   		<div class="messageContainer"></div>
	                                   </div>
	                                   </div>
	                                    <div class="form-group row">
	                                   <label class="control-label col-sm-6">Possession Date </label>
	                                    <div class="col-sm-6">
	                                    	<div>
	                                   			<input type="text" class="form-control"  id="possession_date" name="possession_date" value="<% if(builderProject.getPossessionDate() != null) { out.print(dt1.format(builderProject.getPossessionDate()));} %>"/>
	                                   		</div>
	                                   		<div class="messageContainer"></div>
	                                   </div>
	                                 </div>
	                                 </div>
	                                <div class="offset-sm-5 col-sm-7">
	                                        <button type="submit" id="detailbtn" class="btn btn-info waves-effect waves-light m-t-10">UPDATE</button>
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
			                                    		<label for="example-text-input" class="col-sm-6 col-form-label">Pricing Unit<span class='text-danger'>*</span></label>
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
				                                    		<label for="example-text-input" class="col-sm-6 col-form-label">Base Rate<span class='text-danger'>*</span></label>
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
				        		                            <label for="example-search-input" class="col-sm-6 col-form-label">Floor Rising Rate<span class='text-danger'>*</span></label>
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
				                                    		<label for="example-search-input" class="col-sm-6 col-form-label">Application Post<span class='text-danger'>*</span></label>
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
			                                    		<label for="example-tel-input" class="col-sm-6 col-form-label">Maintainence Charge<span class='text-danger'>*</span></label>
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
			                                    		<label for="example-tel-input" class="col-sm-6 col-form-label">Tenure</label>
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
			        		                            <label for="example-tel-input" class="col-sm-6 col-form-label">Aminities facing Rate<span class='text-danger'>*</span></label>
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
			                                    		<label for="example-tel-input" class="col-sm-6 col-form-label">Parking<span class='text-danger'>*</span></label>
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
			        		                            <label for="example-text-input" class="col-sm-6 col-form-label">Stamp Duty<span class='text-danger'>*</span></label>
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
			                                   			<label for="example-text-input" class="col-sm-6 col-form-label">Tax<span class='text-danger'>*</span></label>
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
			                                    		<label for="example-search-input" class="col-sm-6 col-form-label">VAT<span class='text-danger'>*</span></label>
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
			                                    		<label for="example-search-input" class="col-sm-6 col-form-label">Tech Fees<span class='text-danger'>*</span></label>
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
	        	                               	<button type="submit" id="pricebtn" class="btn btn-info waves-effect waves-light m-t-10">UPDATE</button>
	            		                     </div>
	                    	            </form>
                                	</div>
             					</div>
                                 <div id="vimessages3" class="tab-pane" aria-expanded="false">        
                                 	<form id="paymentfrm" name="paymentfrm" method="post" action=""  enctype="multipart/form-data">
                                 	 <input type="hidden" id="id" name="id" value="<% out.print(project_id);%>"/>
                                   	<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(projectPaymentInfos.size()+1);%>"/>
                                   	<% 	int i = 1;
                                   	if(projectPaymentInfos != null){
                                   			for(BuilderProjectPaymentInfo projectPaymentInfo :projectPaymentInfos) {  
											%>
											<input type="hidden" id="schedule_id" name="schedule_id[]" value="<%out.print(projectPaymentInfo.getId());%>"/>
											<!--  <div class="row" id="schedule- --><% //out.print(i); %>
											<% if(i > 1) { %>
												<hr/>
												<% } %>
										
	                                	<div class="form-group row" id="payment_schedule">
	                                    <label for="example-search-input" class="col-sm-2 col-form-label">Milestone<span class='text-danger'>*</span></label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getSchedule() != null) { out.print(projectPaymentInfo.getSchedule());}%>"/>
	                                    </div>
	                                    <label for="example-search-input" class="col-sm-2 col-form-label">% of net payable<span class='text-danger'>*</span></label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" id="payable" name="payable[]" value="<% if(projectPaymentInfo.getPayable() != null) { out.print(projectPaymentInfo.getPayable());}%>"/>
	                                    </div>
<!-- 	                                    <label for="example-search-input" class="col-sm-1 col-form-label">Amount<span class='text-danger'>*</span></label> -->
<!-- 	                                    <div class="col-2"> -->
<%-- 	                                        <input class="form-control" type="text" id="amount" name="amount[]" value="<% //if(projectPaymentInfo.getAmount() != null) { out.print(projectPaymentInfo.getAmount());}%>"/> --%>
<!-- 	                                    </div> -->
	                                </div>
	                               <%}}else{ %>
	                               <div class="form-group row" id="payment_schedule">
	                               		<input type="hidden" id="schedule_id" name="schedule_id[]" value="0"/>
	                                    <label for="example-search-input" class="col-sm-2 col-form-label">Milestone<span class='text-danger'>*</span></label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" id="schedule" name="schedule[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-sm-2 col-form-label">% of net payable<span class='text-danger'>*</span></label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" id="payable" name="payable[]" value=""/>
	                                    </div>
<!-- 	                                    <label for="example-search-input" class="col-sm-1 col-form-label">Amount<span class='text-danger'>*</span></label> -->
<!-- 	                                    <div class="col-2"> -->
<%-- 	                                        <input class="form-control" type="text" id="amount" name="amount[]" value="<% //if(projectPaymentInfo.getAmount() != null) { out.print(projectPaymentInfo.getAmount());}%>"/> --%>
<!-- 	                                    </div> -->
	                                </div>
	                                <%} %>
	                                <div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-sm">+ Add More Schedule</a>
												</span>
											</div>
										</div>
	                                <div class="offset-sm-5 col-sm-7">
                                        <button type="submit" id="paymentbtn" class="btn btn-info waves-effect waves-light m-t-10">UPDATE</button>
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
																		<div class="form-group" id="error-discount">
																			<label class="control-label col-sm-8">Discount(%) <span class="text-danger">*</span></label>
																			<div class="col-sm-6">
																				<input type="text" class="form-control discount" id="discount<%out.print(j); %>" name="discount[]" value="<% out.print(projectOfferInfo.getPer()); %>" onkeyup=" javascript:onlyNumber(<%out.print(j); %>);">
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-4 margin-bottom-5">
																		<div class="form-group" id="error-discount_amount">
																			<label class="control-label col-sm-6">Discount Amount <span class='text-danger'>*</span></label>
																			<div class="col-sm-6">
																				<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% out.print(projectOfferInfo.getAmount()); %>">
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
<%-- 																<div class="row" id="offer-<% out.print(j);%>"> --%>
<%-- 																<% if(j > 1) { %> --%>
<!-- 																<hr/> -->
<%-- 																<% } %> --%>
<!-- 																	<div class="col-lg-12" style="padding-bottom:5px;"> -->
<!-- 																		<span class="pull-right"><a href="javascript:removeOffer(1);" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-5 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-offer_title"> -->
<!-- 																			<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label> -->
<!-- 																			<div class="col-sm-8"> -->
<!-- 																				<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-3 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-discount"> -->
<!-- 																			<label class="control-label col-sm-8">Discount(%) <span class="text-danger">*</span></label> -->
<!-- 																			<div class="col-sm-6"> -->
<!-- 																				<input type="text" class="form-control" id="discount" name="discount[]" value=""> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-4 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-discount_amount"> -->
<!-- 																			<label class="control-label col-sm-6">Discount Amount </label> -->
<!-- 																			<div class="col-sm-6"> -->
<!-- 																				<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-5 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-applicable_on"> -->
<!-- 																			<label class="control-label col-sm-4">Description </label> -->
<!-- 																			<div class="col-sm-8"> -->
<!-- 																				<textarea class="form-control" id="description" name="description[]"></textarea> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-3 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-applicable_on"> -->
<!-- 																			<label class="control-label col-sm-6">Offer Type </label> -->
<!-- 																			<div class="col-sm-6"> -->
<!-- 																				<select class="form-control" id="offer_type" name="offer_type[]"> -->
<!-- 																					<option value="1">Percentage</option> -->
<!-- 																					<option value="2">Flat Amount</option> -->
<!-- 																					<option value="3">Other</option> -->
<!-- 																				</select> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																	<div class="col-lg-4 margin-bottom-5"> -->
<!-- 																		<div class="form-group" id="error-apply"> -->
<!-- 																			<label class="control-label col-sm-6">Status </label> -->
<!-- 																			<div class="col-sm-6"> -->
<!-- 																				<select class="form-control" id="offer_status" name="offer_status[]"> -->
<!-- 																					<option value="1">Active</option> -->
<!-- 																					<option value="0">Inactive</option> -->
<!-- 																				</select> -->
<!-- 																			</div> -->
<!-- 																			<div class="messageContainer"></div> -->
<!-- 																		</div> -->
<!-- 																	</div> -->
<!-- 																</div> -->
															</div>
															<div>
																<div class="col-lg-12">
																	<span class="pull-right">
																		<a href="javascript:addMoreOffer();" id="addMoreOffers" class="btn btn-info btn-sm">+ Add More Offers</a>
																	</span>
																</div>
															</div>
													
												</div>
											</div>
											<div class="row">
												 <div class="offset-sm-5 col-sm-7">
	                                        		<button type="submit" id="offerbtn" class="btn btn-info waves-effect waves-light m-t-10">SAVE</button>
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
$('#detailfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
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
// function isNumber(evt, element) {

//     var charCode = (evt.which) ? evt.which : event.keyCode

//     if (
//         (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
//         (charCode < 48 || charCode > 57))
//         return false;

//     return true;
// } 

function onlyNumber(id){
	
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
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

// $('#offerfrm').bootstrapValidator({
// 	container: function($field, validator) {
// 		return $field.parent().next('.messageContainer');
//    	},
//     feedbackIcons: {
//         validating: 'glyphicon glyphicon-refresh'
//     },
//    // excluded: ':disabled',
//     fields: {
//     	'offer_title[]': {
//             validators: {
//                 notEmpty: {
//                     message: 'Offer title is required and cannot be empty'
//                 }
//             }
//         }
//     }
// }).on('success.form.bv', function(event,data) {
// 	// Prevent form submission
// 	event.preventDefault();
// 	alert("success");
// 	//updateProject();
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
				//alert(data.id);
			//	alert(data.status);
				alert(data.message);
			} else {
			//	alert(data.id);
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

// $("#paymentbtn").click(function(){
// 	var paymentInfo = [];
// 	var payable = [];
// 	var amount = [];
// 	$('input[name="payable[]"]').each(function(index) {
// 		payable.push($(this).val());
// 	});
// 	$('input[name="amount[]"]').each(function(index) {
// 		amount.push($(this).val());
// 	});
// 	$('input[name="schedule[]"]').each(function(index) {
// 		if($(this).val() != "") {
// 			paymentInfo.push({schedule:$(this).val(),payable:payable[index],amount:amount[index],status:1,builderProject:{id:$("#id").val()}});
// 		}
// 	});
// 	var project = {id:$("#id").val()};
// 	var final_data = {builderProjectPaymentInfos:paymentInfo,builderProject:project}
// 	if(paymentInfo.length > 0) {
// 		$.ajax({
// 		    url: '${baseUrl}/webapi/project/payment/update',
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
// 		alert("Please enter payment schedule details");
// 	}
// });

// $("#offerbtn").click(function(){
// 	var offerInfo = [];
// 	var discount = [];
// 	var amount = [];
// 	var description = [];
// 	var type = [];
// 	var status = [];
// 	$('input[name="discount[]"]').each(function(index) {
// 		discount.push($(this).val());
// 	});
// 	$('input[name="discount_amount[]"]').each(function(index) {
// 		amount.push($(this).val());
// 	});
// 	$('input[name="description[]"]').each(function(index) {
// 		description.push($(this).val());
// 	});
// 	$('select[name="offer_type[]"] option:selected').each(function(index) {
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
// 		    url: '${baseUrl}/webapi/project/offer/update',
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
// });






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
	alert("Hello");
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
// function addMoreOffer() {
// 	var offers = parseInt($("#offer_count").val());
// 	offers++;
// 	var html = '<div class="form-group row" id="offer-"'+offers+'>'
// 		+'<label for="example-search-input" class="col-2 col-form-label">Offer Title*</label>'
// 		+'<div class="col-2">'
//             +'<input class="form-control" type="text" id="offer_title" name="offer_title[]" value=""/>'
//         +'</div>'
//         +'<div class="messageContainer"></div>'
//         +'<label for="example-search-input" class="col-2 col-form-label">Discount(%)*</label>'
//         +'<div class="col-2">'
//             +'<input class="form-control" type="text" id="discount" name="discount[]" value=""/>'
//         +'</div>'
//         +'<div class="messageContainer"></div>'
//         +'<label for="example-search-input" class="col-2 col-form-label">Discount Amount</label>'
//         +'<div class="col-2">'
//             +'<input class="form-control" type="text" id="discount_amount" name="discount_amount[]" value=""/>'
//         +'</div>'
//         +'<div class="messageContainer"></div>'
//         +'<label for="example-search-input" class="col-2 col-form-label">Description</label>'
//         +'<div class="col-2">'
//             +'<textarea class="form-control" id="description" name="description[]" ></textarea>'
//         +'</div>'
//         +'<label for="example-search-input" class="col-2 col-form-label">Offer Type</label>'
//         +'<div class="col-2">'
//         +'<select class="form-control" id="offer_type" name="offer_type[]">'
// 			+'<option value="1">Percentage</option>'
// 			+'<option value="2">Flat Amount</option>'
// 			+'<option value="3">Other</option>'
// 		+'</select>'
//         +'</div>'
//         +'<label for="example-search-input" class="col-2 col-form-label">Status</label>'
//         +'<div class="col-2">'
//          +'<select class="form-control" id="offer_status" name="offer_status[]">'
// 			+'<option value="1" >Active</option>'
// 			+'<option value="0" >Inactive</option>'
// 		+'</select>'
// 		+'</div>'
//     +'</div>'
//  +'</div>';
// 	$("#offer_area").append(html);
// 	$("#offer_count").val(offers);
// }
// function removeOffer(id) {
// 	var a=$("#offer").val();
// 	alert("remove="+a);
// 	$("#offer-"+id).remove();
// }

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="'+offers+'" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control"  name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
			+'<div class="form-group" id="error-discount">'
				+'<label class="control-label col-sm-6">Discount(%) <span class="text-danger">*</span></label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control discount"  name="discount[]" value="" onkeypress=" return isNumber(event, this);"/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-6">Discount Amount </label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control"  id="discount_amount'+offers+'"  name="discount_amount[]" value="" onkeyup="javascript:onlyNumber('+offers+');"/>'
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

// $('#addMoreOffers').click(function () {
//     var rowId = $('.row').length + 1;
//     var validator = $('#myForm').data('bootstrapValidator');
//     var klon = template.clone();          
//     klon.attr('id', 'line_' + rowId)
//         .insertAfter($('.row').last())
//         .find('input')
//         .each(function () {
//             $(this).attr('id', $(this).attr('id').replace(/_(\d*)$/, "_"+rowId));
//             validator.addField($(this));
//         })                   
// });


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
</script>