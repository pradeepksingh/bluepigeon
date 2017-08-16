<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectOfferInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectOfferInfo"%>
<%@page import="org.bluepigeon.admin.model.Tax"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.data.PriceInfoData"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuildingImageGallery"%>
<%@page import="org.bluepigeon.admin.model.BuildingPanoramicImage"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuildingAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuildingPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuildingOfferInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.BuildingAmenityWeightage"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	ServletContext webcontext = pageContext.getServletContext();
	int building_id = 0;
	int project_id = 0;
	int floor_id = 0;
	int flat_id = 0;
	int p_user_id = 0;
	int building_size_list = 0;
	String taxLabel1 = "";
	String taxLabel2 = "";
	String taxLabel3 = "";
	BuilderBuilding builderBuilding = null;
	List<BuilderBuilding> builderBuildings = null;
	List<BuilderBuilding> builderBuildingList = null;
	List<ProjectData> builderProjects = null;
	List<BuilderBuildingAmenity> builderBuildingAmenities = null;
	List<BuilderBuildingStatus> builderBuildingStatusList = null;
	List<BuildingImageGallery> buildingImageGalleries = null;
	List<BuildingPanoramicImage> buildingPanoramicImages = null;
	List<BuildingAmenityInfo> buildingAmenityInfos  = null;
//	List<BuildingPaymentInfo> buildingPaymentInfos = null;
	List<PaymentInfoData> buildingPaymentInfos = null;
	List<BuildingOfferInfo> buildingOfferInfos = null;
	List<BuilderProjectOfferInfo> builderProjectOfferInfos = null;
	PriceInfoData priceInfoData = null;
	List<AreaUnit> areaUnits = null;
	List<BuildingAmenityWeightage> buildingAmenityWeightages = null;
	List<Tax> taxes = null;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	String sbuilding_id =  request.getParameter("building_id");
	if(sbuilding_id != "" || sbuilding_id != null)
		building_id = Integer.parseInt(sbuilding_id);
	session = request.getSession(false);
	BuilderEmployee adminuserproject = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (BuilderEmployee)session.getAttribute("ubname");
			if(adminuserproject != null){
				p_user_id = adminuserproject.getBuilder().getId();
				builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(p_user_id);
				if(building_id>0 && project_id > 0){
					builderBuildings = new ProjectDAO().getBuilderProjectBuildingById(building_id);
					if(builderBuildings.size() > 0) {
						builderBuilding = builderBuildings.get(0);
					}
					builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
					building_size_list = builderBuildingList.size();
					builderBuildingStatusList = new BuilderBuildingStatusDAO().getActiveBuilderBuildingStatus();
					builderBuildingAmenities = new BuilderBuildingAmenityDAO().getActiveBuilderBuildingAmenityList();
					buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
				    buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
					buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
					//buildingPaymentInfos = new ProjectDAO().getActiveBuilderBuildingPaymentInfoById(building_id);
					buildingPaymentInfos = new ProjectDAO().getBuildingPaymentInfoById(building_id);
					buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
					buildingAmenityWeightages = new ProjectDAO().getActiveBuilderBuildingAmenityWeightageById(building_id);
					priceInfoData = new ProjectDAO().getBuildingPriceData(building_id);
					builderProjectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
					areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
					buildingPaymentInfos = new ProjectDAO().getBuildingPaymentInfoById(building_id);
					try{
						floor_id = new ProjectDAO().getActiveFloorsByBuildingId(building_id).get(0).getId();
						flat_id = new ProjectDAO().getBuilderActiveFloorFlats(floor_id).get(0).getId();
					}catch(Exception e){
					}
					BuilderProject builderProject = new ProjectDAO().getBuilderProjectById(project_id);
					if(builderProject.getPincode() != "" && builderProject.getPincode() != null) {
						taxes = new ProjectDAO().getProjectTaxByPincode(builderProject.getPincode());
					}
					taxLabel1 = builderProject.getCountry().getTaxLabel1();
					taxLabel2 = builderProject.getCountry().getTaxLabel2();
					taxLabel3 = builderProject.getCountry().getTaxLabel3();
				}
// 				}else if(project_id > 0 && building_id == 0){
// 					out.println("projectId :: "+project_id+" \n Building Id :: "+building_id);
// 					builderBuildings = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
// 					if(builderBuildings.size()>0){
// 						building_id = builderBuildings.get(0).getId();
// 						builderBuildingStatusList = new BuilderBuildingStatusDAO().getActiveBuilderBuildingStatus();
// 						builderBuildingAmenities = new BuilderBuildingAmenityDAO().getActiveBuilderBuildingAmenityList();
// 						buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
// 					    buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
// 						buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
// 						buildingPaymentInfos = new ProjectDAO().getActiveBuilderBuildingPaymentInfoById(building_id);
// 						buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
// 						buildingAmenityWeightages = new ProjectDAO().getActiveBuilderBuildingAmenityWeightageById(building_id);
// 					}
				}
			}
		}
	//}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Piegon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../css/custom.css" rel="stylesheet">
    <link href="../../css/topbutton.css" rel="stylesheet">
<!--     <link href="../../css/custom1.css" rel="stylesheet"> -->
    <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../js/jquery.form.js"></script>
    <script src="../../js/bootstrap-datepicker.min.js"></script>
  <script src="../../js/bootstrapValidator.min.js"></script>
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
        <div id="header">
        <%@include file="../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../partial/sidebar.jsp"%>
       </div>
    </div>
    <div id="page-wrapper" style="min-height: 2038px;">
        <div class="container-fluid">
          <div class="row">
                <div class="col-lg-3 col-sm-6 col-xs-12">
                       <button type="submit" id="project" class="btn11 top-white-box waves-effect waves-light m-t-15">PROJECT</button>
                </div>
            	 <div  class="col-lg-3 col-sm-3 col-xs-3">
	                   <button type="submit" id="building" class="btn11 top-blue-box waves-effect waves-light m-t-15">BUILDING</button>
            	</div>
            	<%if(building_id >0 && floor_id > 0){ %>
                <div  class="col-lg-3 col-sm-3 col-xs-3">
                	 <button type="submit" id="floor"  class="btn11 top-white-box waves-effect waves-light m-t-15">FLOOR</button>
                </div>
                <%} %>
                <%if(building_id > 0 && floor_id > 0 && flat_id > 0){ %>
                <div  class="col-lg-3 col-sm-3 col-xs-3">
                  <button type="submit" id="flat"  class="btn11 top-white-box waves-effect waves-light m-t-15">FLAT</button>
                </div>
                <%} %>
           </div>
           <div class="row">
          		<div class="col-md-4 col-sm-6 col-xs-12">
                     <select id="filter_building_id" name="filter_building_id">
                             <% for(BuilderBuilding builderBuilding2 : builderBuildingList){ %>
                     		<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName()); %></option>
                     		<%} %>
                     </select>
                </div>
           </div>
           <div class="row">
               <div class="col-lg-12">
                   <div class="white-box">
                   	<div class="color-box">
                           <ul class="nav nav-tabs">
                               <li class="active" >
                                   <a data-toggle="tab"  href="#vimessages" > <span>Basic Details</span></a>
                               </li>
                                <li>
                                   <a  data-toggle="tab" href="#vimessages1"><span>Pricing Details</span></a>
                               </li>
                               <li>
                                   <a  data-toggle="tab" href="#vimessages2"><span>Payment Schedule</span></a>
                               </li>
                               <li>
                                   <a  data-toggle="tab" href="#vimessages3"><span>Offers</span></a>
                               </li>
                           </ul>
                           <div class="tab-content"> 
                             <div id="vimessages" class="tab-pane active" aria-expanded="false">
                               <div id="basicresponse" class="col-sm-12"></div><br>
                           <div class="col-12">
                           		<form id="updatebuilding" name="updatebuilding" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                           		<input type="hidden" name="admin_id" id="admin_id" value="1"/>
								<input type="hidden" name="building_id" id="building_id" value="<% out.print(building_id);%>"/>
								<div class="row">
									<div class="col-md-6">
                           				<div class="form-group row">
                             		  	<label for="example-search-input" class="col-sm-4 col-form-label">Project Name*</label>
                              		  		<div class="col-sm-6">
                              		 	 		<div>
                                	   <!-- <input class="form-control" type="text" value="project" id="example-search-input">-->
                                		  			<select id="project_id" name="project_id" class="form-control" disabled>
													  <% 
													  if(builderProjects !=null){
													  
													    	for(ProjectData builderProject :builderProjects) {
													  %>
													   <option value="<%if(builderProject != null && builderProjects.size() >0){ out.print(builderProject.getId()); }%>" <% if(builderProject != null){if(builderProject.getId() == builderBuilding.getBuilderProject().getId()) { %>selected<% }} %>><% out.print(builderProject.getName()); %></option>
													   <%}} %>
												  </select>
                               	  	  			</div>
                               	  	  		</div>
                               	  	  </div>
                               	</div>
                              	<div class="col-md-6">
                                	<div class="form-group row">
                                		<label for="example-search-input" class="col-sm-4 col-form-label">Building Name</label>
                                		<div class="col-sm-6">
                                			<div>
												<input class="form-control" type="text" readonly="true" id="name" name="name" value="<% out.print(builderBuilding.getName()); %>">
                                			</div>
                                		</div>
                               		</div>
                               	</div>
                           </div>
                           <% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
                           <div class="row">
                           		<div class="col-md-6">
	                               <div class="form-group row">
	                                    <label for="example-search-input" class="col-sm-4 col-form-label">Total Floors</label>
	                                    <div class="col-sm-6">
		                                    <div>
		                                        <input class="form-control" readonly="true" type="text" id="total_floor" name="total_floor" value="<% out.print(builderBuilding.getTotalFloor());%>"/>
		                                    </div>
	                                    </div>
	                               </div>
                               </div>
                               <div class="col-md-6">
                               		<div class="form-group row">
                               			<label for="example-search-input" class="col-sm-4 col-form-label">Launch Date*</label>
                               			<div class="col-sm-6">
                               				<input class="form-control" type="text" disabled id="launch_date" name="launch_date" value="<% if(builderBuilding.getLaunchDate() != null) { out.print(dt1.format(builderBuilding.getLaunchDate()));}%>">
                               			</div>
                               		</div>
                               </div>
                           </div>
                           <div class="row">
                           		<div class="col-md-6">
                           			<div class="form-group row">
                           			<label for="example-search-input" class="col-sm-4 col-form-label">Possession Date</label>
                           				<div class="col-sm-6">
                           					<input class="form-control" type="text" disabled id="possession_date" name="possession_date" value="<% if(builderBuilding.getPossessionDate() != null) { out.print(dt1.format(builderBuilding.getPossessionDate()));}%>"/>
                           				</div>
                           			</div>
                           		</div>
                           		<div class="col-md-6">
                           			<div class="form-group row">
                           				<label for="example-search-input" class="col-sm-4 col-form-label">Building Status *</label>
                           				<div class="col-sm-6">
                           					<select id="status" name="status" class="form-control" disabled>
												<% 	for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
												<option value="<% out.print(builderBuildingStatus.getId());%>" <% if(builderBuildingStatus.getId() == builderBuilding.getBuilderBuildingStatus().getId()) { %>selected<% } %>><% out.print(builderBuildingStatus.getName()); %></option>
												<% } %>
											</select>
										</div>
                           			</div>
                           		</div>
                           </div>
<!--                            <hr> -->
<!--                            <div class="form-group row"> -->
<!--                              <label for="example-text-input" class="col-sm-2 col-form-label">Building Amenities *</label> -->
<%--                             <% --%>
<!-- // 		                            if(buildingAmenityInfos != null){ -->
<!-- // 		                            	int bai = buildingAmenityInfos.size(); -->
<!-- // 		                            	for(int i = 0; i < buildingAmenityInfos.size(); i++){ -->
<!-- // 		                            		if(bai > 1){ -->
<!-- // 		                            			out.print(buildingAmenityInfos.get(i).getBuilderBuildingAmenity().getName()+", "); -->
<!-- // 		                            			bai--; -->
<!-- // 		                            		}else{ -->
<!-- // 		                            			out.print(buildingAmenityInfos.get(i).getBuilderBuildingAmenity().getName()); -->
<!-- // 		                            		} -->
<!-- // 		                            	} -->
<!-- // 		                            } -->
<%-- 		                     %> --%>
<!--                            </div> -->
                               <div class="offset-sm-5 col-sm-7">
                                    <button type="button" id="basicdetail"  class="btn btn-submit waves-effect waves-light m-t-10">NEXT</button>
                               </div>
                          </form>
                      </div>
                   </div>
                   	<div id="vimessages1" class="tab-pane" aria-expanded="false">
	                                 <div class="col-12">
	                                 	<form id="updatepricing" name="updatepricing" method="post">
		                                	 <input type="hidden" name="id" value="<% if(priceInfoData != null){ out.print(priceInfoData.getId()); } else {%>0<% }%>"/>
											<input type="hidden" name="building_id" id="building_id" value="<% out.print(building_id);%>"/>
											<div class="row">
												<div class="col-md-6">
			                                	 	<div class="form-group row">
			                                    		<label for="example-text-input" class="col-sm-4 col-form-label">Pricing Unit<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6"> 
			                                    			<div>
				                                        		<select name="base_unit" id="base_unit" class="form-control">
																	<% for(AreaUnit areaUnit :areaUnits) {
																		%>
																		<option value="<% out.print(areaUnit.getId()); %>" <% if(priceInfoData.getAreaUnits() > 0 && priceInfoData.getAreaUnits() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
																	<% } 
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
						                                        		<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% if(priceInfoData.getBaseRate() > 0 && priceInfoData.getBaseRate() != 0){ out.print(priceInfoData.getBaseRate());}%>"/>
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
						                        		                <input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<% if(priceInfoData.getRiseRate() > 0){ out.print(priceInfoData.getRiseRate());}%>"/>
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
						                                        <input type="text" class="form-control" id="post" name="post" value="<% if(priceInfoData !=null && priceInfoData.getPost() != 0){ out.print(priceInfoData.getPost());}%>"/>
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
					                                        		<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(priceInfoData.getMaintainance() > 0 && priceInfoData.getMaintainance() != 0){ out.print(priceInfoData.getMaintainance());}%>"/>
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
					                                        		<input type="text" class="form-control" id="tenure" name="tenure" value="<%if(priceInfoData.getTenure() > 0 && priceInfoData.getTenure() != 0){ out.print(priceInfoData.getTenure()); } %>"/>
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
					                        		                <input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% if(priceInfoData.getAmenityRate() > 0 && priceInfoData.getAmenityRate() != 0){ out.print(priceInfoData.getAmenityRate());}%>"/>
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
			                                    			<select id="parking_id" name="parking_id" class="form-control">
																<option value="0"<%if(priceInfoData.getParkingId() == 0){ %>selected<%} %>>Select Parking Type</option>
																<option value="1" <%if(priceInfoData.getParkingId() == 1){ %>selected<%} %>>Open Parking</option>
																<option value="2" <%if(priceInfoData.getParkingId() == 2){ %>selected<%} %>>Shed Parking</option>
															</select>
			                                    		</div>
			                                		</div>
			                                	</div>
			                                	
			                                </div>
			                                <div class="row">
			                                	<div class="col-sm-6">
			                                		<div class="form-group row">
			                                    		<label for="example-tel-input" class="col-sm-4 col-form-label">Parking<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                         			<input type="text" class="form-control" id="parking" name="parking" value="<% if(priceInfoData.getParking() > 0 && priceInfoData.getParking() != 0){ out.print(priceInfoData.getParking());}%>"/>
				                                         		</div>	
			                                    				<div class="messageContainer"></div>
			                                    			</div>
			                                    		</div>
			                                		</div>
			                                	</div>
			                                	<%if(taxLabel1.trim().length() != 0 && taxLabel1 != null){ %>
			                                	<div class="col-sm-6">
					                                <div class="form-group row">
			        		                            <label for="example-text-input" class="col-sm-4 col-form-label"><%out.print(taxLabel1); %> <span class='text-danger'>*</span></label>
			                		                    <div class="col-sm-6">
			                		                    	<div>
				                		                    	<div>
				                        		               		<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(priceInfoData.getStampDuty() > 0 && priceInfoData.getStampDuty() != 0){ out.print(priceInfoData.getStampDuty());} else {if(taxes.size() > 0){out.print(taxes.get(0).getStampDuty());}}%>"/>
				                                		    	</div>
				                                		    	<div class="messageContainer"></div>
				                                		    </div>
			                                		    </div>
			                                		</div>
			                                   </div>
			                                   <%}else{ %>
													<input type="hidden"  id="stamp_duty" name="stamp_duty" value="0"/>
												<%} %>
			                                </div>
			                                <div class="row">
			                                	<%if(taxLabel2.trim().length() != 0 && taxLabel2 != null){ %>
			                                	<div class="col-sm-6">
			                                		<div class="form-group row">
			                                   			<label for="example-text-input" class="col-sm-4 col-form-label"><%out.print(taxLabel2); %><span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input type="text" class="form-control" id="tax" name="tax" value="<% if(priceInfoData.getTax() > 0 && priceInfoData.getTax() != 0){ out.print(priceInfoData.getTax());} else {if(taxes.size() > 0){out.print(taxes.get(0).getTax());}}%>"/>
				                                    			</div>
				                                    			<div class="messageContainer"></div>
				                                    		</div>
			                                    		</div>
			                                    	</div>
			                                     </div>
			                                     <%}else{ %>
													<input type="hidden"  id="tax" name="tax" value="0"/>
												 <%} %>
												 <%if(taxLabel3.trim().length() != 0 && taxLabel3 != null){ %>
			                                	 <div class="col-sm-6">
			                                		<div class="form-group row">
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label"><%out.print(taxLabel3); %><span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input type="text" class="form-control" id="vat" name="vat" value="<% if(priceInfoData.getVat() > 0 && priceInfoData.getVat() != 0){ out.print(priceInfoData.getVat());} else {if(taxes.size() > 0){out.print(taxes.get(0).getVat());}}%>"/>
				                                    			</div>
				                                    			<div class="messageContainer"></div>
				                                    		</div>
			                                    		</div>
			                                    	</div>
			                                    </div>
			                                    <%}else{ %>
													<input type="hidden"  id="vat" name="vat" value="0"/>
												<%} %>
			                                </div>
			                                <div class="row">
			                                	<div class="col-sm-6">
			                                    	<div class="form-group row">	
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">Tech Fees<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
			                                        			<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(priceInfoData.getFee() > 0 && priceInfoData.getFee() != 0){ out.print(priceInfoData.getFee());}%>"/>
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
             		       		<div id="vimessages2" class="tab-pane" aria-expanded="false">        
                                 	<form id="updatepayment" name="updatepayment" method="post" action=""  enctype="multipart/form-data">
                                 	 	<input type="hidden" id="building_id" name="building_id" value="<% out.print(building_id);%>"/>
                                   		<input type="hidden" name="schedule_count" id="schedule_count" value="<%if(buildingPaymentInfos != null && buildingPaymentInfos.size() >0 ){ out.print(buildingPaymentInfos.size()+1000);}else{%>1000<%}%>"/>
                                   		<div id="payment_schedule">
	                                   	<% 	int i = 1;
	                                   	if(buildingPaymentInfos != null){
	                                   			for(PaymentInfoData projectPaymentInfo :buildingPaymentInfos) {  
												%>
												<input type="hidden"  name="payment_id[]" value="<%out.print(projectPaymentInfo.getId());%>"/>
												  <div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
													<hr/>
													<% } %>
														<div class="col-sm-6">
				                                			<div class="form-group row">
							                                    <label for="example-search-input" class="col-sm-4 control-label">Milestone<span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-6">
				                                    				<div>
				                                        				<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getName() != null) { out.print(projectPaymentInfo.getName());}%>"/>
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
										<div class="row">
			                                <div class="offset-sm-5 col-sm-7">
		                                        <button type="submit" id="paymentbtn" class="btn btn-submit waves-effect waves-light m-t-10">UPDATE</button>
		                                    </div>
	                                 	</div>
	                                </form>
	                 		</div>
                    	   <div id="vimessages3" class="tab-pane" aria-expanded="true">
                                <div id="offer" class="tab-pane fade active in">
										<form id="updateoffer" name="updateoffer" method="post" action=""  enctype="multipart/form-data">
										 	<input type="hidden" id="building_id" name="building_id" value="<% out.print(building_id);%>"/>
											<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(builderProjectOfferInfos.size()+10000); %>"/>
								 			<div class="row">
												<div class="col-lg-12">
															<div id="project_offer_area">
																<% int jj = 1;
																		for(BuilderProjectOfferInfo projectOfferInfo :builderProjectOfferInfos) { 
																%>
																<%if(jj > 1){
																%>
																<hr>
																<%} %>
																<div class="row" id="offer-<% out.print(projectOfferInfo.getId()); %>">
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-offer_title">
																			<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																			<div class="col-sm-8">
																				<div>
																					<input type="text" class="form-control" readonly="true" id="project_offer_title" name="project_offer_title[]" value="<% out.print(projectOfferInfo.getTitle()); %>">
																				</div>
																				<div class="messageContainer"></div>
																			</div>
																		</div>
																	</div>
																	<div class="col-lg-3 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-6">Offer Type </label>
																			<div class="col-sm-6">
																				<select class="form-control" id="project_offer_type<%out.print(jj); %>"  onchange="txtEnabaleDisable(<%out.print(jj); %>);" disabled name="project_offer_type[]">
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
																				<input type="text" class="form-control" readonly="true" <%if(projectOfferInfo.getType() == 3){ %>disabled<%} %> id="project_discount_amount<%out.print(jj); %>"   onkeyup=" javascript:validPerAmount(<%out.print(jj); %>);" name="project_discount_amount[]" value="<%if(projectOfferInfo.getAmount()!=null){ out.print(projectOfferInfo.getAmount());} %>"/>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-4">Description </label>
																			<div class="col-sm-8">
																				<textarea class="form-control" disabled id="project_description" name="project_description[]"><% if(projectOfferInfo.getDescription() != null) { out.print(projectOfferInfo.getDescription());} %></textarea>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	
																	<div class="col-lg-4 margin-bottom-5">
																		<div class="form-group" id="error-apply">
																			<label class="control-label col-sm-6">Status </label>
																			<div class="col-sm-6">
																				<select class="form-control" id="project_offer_status" name="project_offer_status[]" disabled>
																					<option value="1" <% if(projectOfferInfo.getStatus().toString() == "1") { %>selected<% } %>>Active</option>
																					<option value="0" <% if(projectOfferInfo.getStatus().toString() == "0") { %>selected<% } %>>Inactive</option>
																				</select>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																</div>
																<% jj++; } %>
															</div>
															<div id="offer_area">
																<% int j = 1;
																		for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { 
																%>
																<%if(j >1){ %>
																<hr>
																<%} %>
																<div class="row" id="offer-<% out.print(buildingOfferInfo.getId()); %>">
																<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:deleteOffer(<% out.print(buildingOfferInfo.getId()); %>);" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>
																	<input type="hidden" name="offer_id[]" value="<% out.print(buildingOfferInfo.getId()); %>" />
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-offer_title">
																			<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																			<div class="col-sm-8">
																				<div>
																					<input type="text" class="form-control"  id="offer_title<%out.print(j); %>" onfocusout="checkDuplicateEntry(<%out.print(j);%>);" name="offer_title[]" value="<% out.print(buildingOfferInfo.getTitle()); %>">
																				</div>
																				<div class="messageContainer"></div>
																			</div>
																		</div>
																	</div>
																	<div class="col-lg-3 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-6">Offer Type </label>
																			<div class="col-sm-6">
																				<select class="form-control" id="offer_type<%out.print(j); %>"  onchange="txtEnabaleDisable(<%out.print(j); %>);"  name="offer_type[]">
																					<option value="1" <% if(buildingOfferInfo.getType() == 1) { %>selected<% } %>>Percentage</option>
																					<option value="2" <% if(buildingOfferInfo.getType() == 2) { %>selected<% } %>>Flat Amount</option>
																					<option value="3" <% if(buildingOfferInfo.getType() == 3) { %>selected<% } %>>Other</option>
																				</select>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-4 margin-bottom-5">
																		<div class="form-group" id="error-discount_amount">
																			<label class="control-label col-sm-6">Discount Amount <span class='text-danger'>*</span></label>
																			<div class="col-sm-6">
																				<input type="text" class="form-control"  <%if(buildingOfferInfo.getType() == 3){ %>disabled<%} %> id="discount_amount<%out.print(j); %>"   onkeyup=" javascript:validPerAmount(<%out.print(j); %>);" name="discount_amount[]" value="<%if(buildingOfferInfo.getAmount()!=null){ out.print(buildingOfferInfo.getAmount());} %>"/>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	<div class="col-lg-5 margin-bottom-5">
																		<div class="form-group" id="error-applicable_on">
																			<label class="control-label col-sm-4">Description </label>
																			<div class="col-sm-8">
																				<textarea class="form-control"  id="description" name="description[]"><% if(buildingOfferInfo.getDescription() != null) { out.print(buildingOfferInfo.getDescription());} %></textarea>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																	
																	<div class="col-lg-4 margin-bottom-5">
																		<div class="form-group" id="error-apply">
																			<label class="control-label col-sm-6">Status </label>
																			<div class="col-sm-6">
																				<select class="form-control" id="offer_status" name="offer_status[]">
																					<option value="1" <% if(buildingOfferInfo.getStatus().toString() == "1") { %>selected<% } %>>Active</option>
																					<option value="0" <% if(buildingOfferInfo.getStatus().toString() == "0") { %>selected<% } %>>Inactive</option>
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
      		</div>
            <!-- /.container-fluid -->
 		<div id="sidebar1"> 
			<%@include file="../../partial/footer.jsp"%>
		</div> 
</body>
</html>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script type="text/javascript" src="../../js/selectize.min.js"></script>
<script type="text/javascript">
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() > 0 || $("#filter_building_id").val() != '' ){
			window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+value;
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_building_id :selected").text();
    	 if(textClear.trim() == "Enter Building Name"){
    		 obj[0].setValue("");
    	 }
     }
});
<%if(building_size_list > 0){%>
	select_building = $select_building[0].selectize;
<%}%>
$("#basicdetail").click(function(){

	$('.active').removeClass('active').next('li').addClass('active');
    $("#vimessages1").addClass('active');
});


var myarray = [];
<%if(buildingOfferInfos != null){ 
	for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { 
%>
 myarray.push("<%out.print(buildingOfferInfo.getTitle());%>");
 <%}}%>
function checkDuplicateEntry(id){
	
	var offers = $("#offer_title"+id).val();
	if($.inArray(offers,myarray) !== -1){
		if(myarray.indexOf(offers) != -1){
			alert("Duplicate Entery of offer");
			$("#offer_title"+id).val('');
		}else{
			myarray.push(offers);
		}
	}else{
		if(myarray.indexOf(offers) != -1){
			alert("Duplicate Entery of offer");
			$("#offer_title"+id).val('');
		}else{
			myarray.push(offers);
		}
	}
}

$("#project").click(function(){
	window.location.href="${baseUrl}/builder/project/edit.jsp?project_id=<%out.print(project_id);%>";
});

$("#floor").click(function(){
	window.location.href="${baseUrl}/builder/project/building/floor/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>";
});

$("#building").click(function(){
	window.location.href="${baseUrl}/builder/project/building/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>";
});
$("#flat").click(function(){
	window.location.href = "${baseUrl}/builder/project/building/floor/flat/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>&flat_id=<%out.print(flat_id); %>";
});

$('#launch_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updateoffer').data('bootstrapValidator').revalidateField('launch_date');
});

$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updateoffer').data('bootstrapValidator').revalidateField('possession_date');
});
function showDemand()
{
	 $("#demandfile").show(); 
}

function showOffers()
{
	$("#displayoffers").show(); 
}

var myarray = [];
<%if(buildingOfferInfos != null){ 
	for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { 
%>
 myarray.push("<%out.print(buildingOfferInfo.getTitle());%>");
 <%}}%>
function checkDuplicateEntry(id){
	
	var offers = $("#offer_title"+id).val();
	if($.inArray(offers,myarray) !== -1){
		if(myarray.indexOf(offers) != -1){
			alert("Duplicate Entery of offer");
			$("#offer_title"+id).val('');
		}else{
			myarray.push(offers);
		}
	}else{
		if(myarray.indexOf(offers) != -1){
			alert("Duplicate Entery of offer");
			$("#offer_title"+id).val('');
		}else{
			myarray.push(offers);
		}
	}
}

function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
			   
	 var html = '<div class="row" id="schedule-'+schedule_count+'">'
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

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title'+offers+'" onfocusout="checkDuplicateEntry('+offers+');" name="offer_title[]" value=""/>'
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

function updateBuildingImages() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddImageRequest,
	 		success :  showAddImageResponse,
	 		url : '${baseUrl}/webapi/project/building/images/update',
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
$("#updatepricing").bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	base_unit: {
            validators: {
                notEmpty: {
                    message: 'Area unit is required'
                }
            }
        },
        base_rate: {
            validators: {
                notEmpty: {
                    message: 'Base rate is required'
                },
        		numeric: {
        			message: 'Base rate is invalid'
        		}
            }
        },
        rise_rate: {
            validators: {
            	notEmpty: {
                    message: 'Rise rate is required'
                },
        		numeric: {
        			message: 'Rise rate is invalid'
        		}
            }
        },
        post: {
            validators: {
            	notEmpty: {
                    message: 'Applicable Post is required'
                },
        		integer: {
        			message: 'Applicable Post is invalid'
        		}
            }
        },
        maintenance: {
            validators: {
            	notEmpty: {
                    message: 'Maintenance is required'
                },
        		numeric: {
        			message: 'Maintenance is invalid'
        		}
            }
        },
        tenure: {
            validators: {
            	notEmpty: {
                    message: 'Tenure is required'
                },
            	numeric: {
        			message: 'Tenure is invalid'
        		}
            }
        },
        amenity_rate: {
            validators: {
            	notEmpty: {
                    message: 'Amenity facing rate is required'
                },
        		numeric: {
        			message: 'Amenity facing rate is invalid'
        		}
            }
        },
        parking: {
            validators: {
            	notEmpty: {
                    message: 'Parking rate is required'
                },
        		numeric: {
        			message: 'Parking rate is invalid'
        		}
            }
        },
        stamp_duty: {
            validators: {
            	notEmpty: {
                    message: 'Stamp duty is required'
                },
        		numeric: {
        			message: 'Stamp duty is invalid'
        		},
        		 between:{
                 	min:0,
                 	max:100,
                 	message: 'The percentage must be between 0 and 100'
                 }
            }
        },
        tax: {
            validators: {
            	notEmpty: {
                    message: 'Tax is required'
                },
        		numeric: {
        			message: 'Tax is invalid'
        		},
        		 between:{
                 	min:0,
                 	max:100,
                 	message: 'The percentage must be between 0 and 100'
                 }
            }
        },
        vat: {
            validators: {
            	notEmpty: {
                    message: 'Vat is required'
                },
        		numeric: {
        			message: 'Vat is invalid'
        		},
        		 between:{
                 	min:0,
                 	max:100,
                 	message: 'The percentage must be between 0 and 100'
                 }
            }
        },
        tech_fee : {
        	 validators: {
             	notEmpty: {
                     message: 'Tech fee is required'
                 },
         		numeric: {
         			message: 'Tech fee is invalid'
         		}
             }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuildingPricing();
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;
    return true;
} 
function validPercentage(id){
	 var x = $("#discount_amount"+id).val();
	 if(isNaN(x) || x<0 || x >100){
		 alert("The percentage must be between 0 and 100");
		 $("#discount_amount"+id).val('');
	 }
}
function updateBuildingPricing() {
	var options = {
	 		target : '#priceresponse', 
	 		beforeSubmit : showAddPriceRequest,
	 		success :  showAddPriceResponse,
	 		url : '${baseUrl}/webapi/project/building/pricing/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatepricing').ajaxSubmit(options);
}

function showAddPriceRequest(formData, jqForm, options){
	$("#priceresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddPriceResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#priceresponse").removeClass('alert-success');
       	$("#priceresponse").addClass('alert-danger');
		$("#priceresponse").html(resp.message);
		$("#priceresponse").show();
  	} else {
  		$("#priceresponse").removeClass('alert-danger');
        $("#priceresponse").addClass('alert-success');
        $("#priceresponse").html(resp.message);
        $("#priceresponse").show();
        alert(resp.message);
        $('.active').removeClass('active').next('li').addClass('active');
        $("#vimessages2").addClass('active');
  	}
}
$('#updatepayment').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
        'payable[]': {
            validators: {
            	between: {
                    min: 0,
                    max: 100,
                    message: 'The percentage must be between 0 and 100'
	        	},
                notEmpty: {
                    message: 'Payable is required and cannot be empty'
                }
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuildingPayments();
});
function deleteOffer(id){
	var flag = confirm("Are you sure ? You want to delete offers ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/offer/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#offer-"+id).remove();
			}
		},'json');
	}
}
function updateBuildingPayments() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddPaymentRequest,
	 		success :  showAddPaymentResponse,
	 		url : '${baseUrl}/webapi/project/building/payment/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatepayment').ajaxSubmit(options);
}

function showAddPaymentRequest(formData, jqForm, options){
	$("#paymentresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddPaymentResponse(resp, statusText, xhr, $form){
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
        $("#vimessages3").addClass('active');
  	}
}

// function updateBuildingOffers() {
// 	var amenityWeightage = "";
// 	$('input[name="amenity_type[]"]:checked').each(function() {
// 		amenity_id = $(this).val();
// 		$('input[name="stage_weightage'+amenity_id+'[]"]').each(function() {
// 			stage_id = $(this).attr("id");
// 			stage_weightage = $(this).val();
// 			$('input[name="substage'+stage_id+'[]"]').each(function() {
// 				if(amenityWeightage != "") {
// 					amenityWeightage = amenityWeightage + "," + amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
// 				} else {
// 					amenityWeightage = amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
// 				}
// 			});
// 		});
// 	});
// 	$("#amenity_wt").val(amenityWeightage);
// 	var options = {
// 	 		target : '#offerresponse', 
// 	 		beforeSubmit : showAddOfferRequest,
// 	 		success :  showAddOfferResponse,
// 	 		url : '${baseUrl}/webapi/builder/building/offer/update',
// 	 		semantic : true,
// 	 		dataType : 'json'
// 	 	};
//    	$('#updateoffer').ajaxSubmit(options);
// }

function updateBuildingOffers() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddOfferRequest,
	 		success :  showAddOfferResponse,
	 		url : '${baseUrl}/webapi/project/building/offer/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateoffer').ajaxSubmit(options);
}

function showAddOfferRequest(formData, jqForm, options){
	$("#offerresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddOfferResponse(resp, statusText, xhr, $form){
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

$('#updateoffer').bootstrapValidator({
    feedbackIcons: {
     //   valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
      //  validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
        'offer_title[]': {
            validators: {
                notEmpty: {
                    message: 'The offer title required and cannot be empty'
                }
            },
        },
        'discount[]':{
        	 validators: {
        		 between: {
                     min: 0,
                     max: 100,
                     message: 'The percentage must be between 0 and 100'
 	        	},
                 notEmpty: {
                     message: 'Discount required and cannot be empty'
                 }
             }
        },
        'discount_amount[]':{
        	validators: {
                notEmpty: {
                    message: 'Discount amount required and cannot be empty'
                }
            }
        }
    }
	}).on('success.form.bv', function(event,data) {
		// Prevent form submission
		event.preventDefault();
		updateBuildingOffers();
	});;
	
function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/image/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function deleteElvImage(id) {
	var flag = confirm("Are you sure ? You want to delete Elevation Image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/elevationimage/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_elv_image"+id).remove();
			}
		});
	}
}

function deletePayment(id) {
	var flag = confirm("Are you sure ? You want to delete payment slab ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/payment/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#schedule-"+id).remove();
			}
		},'json');
	}
}

function deleteOffer(id) {
	var flag = confirm("Are you sure ? You want to delete offer ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/offer/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#offer-"+id).remove();
			}
		});
	}
}

function addMoreImages() {
	var img_count = parseInt($("img_count").val());
	img_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="building_image" name="building_image[]" />'
					+'<a href="javascript:removeImage('+img_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#project_images").append(html);
	$("#img_count").val(img_count);
}

function removeImage(id) {
	$("#imgdiv-"+id).remove();
}

function addMoreElvImages() {
	var elvimg_count = parseInt($("elvimg_count").val());
	elvimg_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-'+elvimg_count+'"><input type="hidden" name="payment_id[]" value="0" />'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="elevation_image" name="elevation_image[]" />'
					+'<a href="javascript:removeElvImage('+elvimg_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#elevation_images").append(html);
	$("#elvimg_count").val(elvimg_count);
}

function removeElvImage(id) {
	$("#elvimgdiv-"+id).remove();
}

$("#building").click(function(){
	 var check = $("#building").hasClass('top-lue-box');
	 if(!check){
		 $("#building").removeClass('top-white-box');
		 $("#building").addClass('top-blue-box');
		 var isProject = $("#project").hasClass('top-blue-box');
		 if(isProject){
			 $("#project").removeClass('top-blue-box');
			 $('#project').addClass('top-white-box');
		 }
		 var isFloor = $('#floor').hasClass('top-blue-box');
		 if(isFloor){
			 $('#floor').removeClass('top-blue-box');
			 $('#floor').addClass('top-white-box');
		 }
		 var isFlat = $("#flat").hasClass('top-blue-box');
		 if(isFlat){
			 $('#flat').removeClass('top-blue-box');
			 $('#flat').addClass('top-white-box');
		 }
	 }
	
});

$('#updatebuilding').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	project_id: {
            validators: {
                notEmpty: {
                    message: 'Project ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Building Name is required and cannot be empty'
                }
            }
        },
        total_floor: {
            validators: {
                notEmpty: {
                    message: 'Total floor number is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuilding();
});

function updateBuilding() {

	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/builder/building/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatebuilding').ajaxSubmit(options);
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

</script>