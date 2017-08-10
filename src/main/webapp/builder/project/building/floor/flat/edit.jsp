<%@page import="org.bluepigeon.admin.model.FlatOfferInfo"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectOfferInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectOfferInfo"%>
<%@page import="org.bluepigeon.admin.model.BuildingOfferInfo"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.data.PriceInfoData"%>
<%@page import="org.bluepigeon.admin.data.FlatData"%>
<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.FlatAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.FlatAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FlatPaymentSchedule"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	int flat_id = 0;
	int p_user_id = 0;
	int building_id = 0;
	int project_id = 0;
	int floor_id = 0;
	int building_size_list =0;
	int floor_size_list = 0;
	int flat_size_list = 0;
	List<BuilderFloor> floorList = null;
	List<FlatData> flatList = null;
	List<BuilderBuilding> builderBuildingList = null;
	List<ProjectData> builderProjects = null;
	List<BuilderFlatStatus> builderFlatStatuses = null;
	List<BuilderFlatAmenity> builderFlatAmenities = null;
	List<FlatAmenityInfo> flatAmenityInfos = null;
	List<PaymentInfoData> flatPaymentSchedules = null;
	List<BuilderBuildingFlatType> builderFlatTypes = null;
	List<FlatAmenityWeightage> flatAmenityWeightages = null;
	List<BuildingOfferInfo> buildingOfferInfos = null;
	List<BuilderProjectOfferInfo> builderProjectOfferInfos = null;
	List<FlatOfferInfo> flatOfferInfos = null;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	floor_id = 	Integer.parseInt(request.getParameter("floor_id"));
	flat_id = Integer.parseInt(request.getParameter("flat_id"));
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
			}
		}
	}
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> floors = null;
	BuilderFlat builderFlat = null;
	List<AreaUnit> areaUnits = null;
	int flat_type_id = 0;
	PriceInfoData priceInfoData = null;
	if(project_id > 0 && building_id > 0 && floor_id > 0 && flat_id > 0){
		List<BuilderFlat> builderFlats = new ProjectDAO().getBuildingActiveFlatById(flat_id);
		if(builderFlats.size() > 0) {
			areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
			builderFlat = builderFlats.get(0);
			floor_id = builderFlat.getBuilderFloor().getId();
			building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
			project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
			buildings = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
			floors = new ProjectDAO().getBuildingActiveFloors(building_id);
			builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
			builderProjectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
			building_size_list = builderBuildingList.size();
			floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id);
			floor_size_list = floorList.size();
			flatList = new ProjectDAO().getActiveFlatsByFloorId(floor_id);
			builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderActiveFlatStatus();
			builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderActiveFlatAmenityList();
			flatAmenityInfos= new ProjectDAO().getBuilderFlatAmenityInfos(flat_id);
			flatPaymentSchedules = new ProjectDAO().getFlatPaymentSchedules(flat_id);
			flatOfferInfos = new ProjectDAO().getFlatOffersByFlatId(flat_id);
			builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeByBuildingId(building_id);
			buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
			flatAmenityWeightages = new ProjectDAO().getActiveFlatAmenityWeightageByFlatId(flat_id);
			priceInfoData = new ProjectDAO().getFlatPriceData(flat_id);
			flat_type_id = builderFlat.getBuilderFlatType().getId();
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
    <link rel="icon" type="image/png" sizes="16x16" href="../../../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
   
    <!-- Menu CSS -->
    <link href="../../../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
   
    <!-- Custom CSS -->
    <link href="../../../../css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../../../css/custom.css">
     <link rel="stylesheet" type="text/css" href="../../../../css/topbutton.css">
     <link rel="stylesheet" type="text/css" href="../../../../css/selectize.css" />
    <script src="../../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../../../js/jquery.form.js"></script>
    <script src="../../../../js/bootstrap-datepicker.min.js"></script>
    <script src="../../../../js/bootstrapValidator.min.js"></script>
     <script type="text/javascript" src="../../../../js/selectize.min.js"></script>
    <script type="text/javascript">
    $('input[type=checkbox]').click(function() {
        if ($(this).is(':checked')) {
            var tb = $('<input type=text />');
            $(this).after(tb);
        } else if ($(this).siblings('input[type=text]').length > 0) {
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
        <%@include file="../../../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../../../partial/sidebar.jsp"%>
       </div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                  <div class="row">
                   		<div class="col-lg-3 col-sm-6 col-xs-12">
                    		 <button type="submit" id="project" class="btn11 top-white-box waves-effect waves-light m-t-15">PROJECT</button>
                   		 </div>
                   		 <%if(building_id > 0){ %>
	                	 <div  class="col-lg-3 col-sm-6 col-xs-12">
	                    	<button type="submit" id="building" class="btn11 top-white-box waves-effect waves-light m-t-15">BUILDING</button>
	               		</div>
	              		<%} %>
	              		<% if(building_id > 0 && floor_id > 0){ %>
                    	<div  class="col-lg-3 col-sm-6 col-xs-12">
                    		<button type="submit" id="floor"  class="btn11 top-white-box waves-effect waves-light m-t-15">FLOOR</button>
                    	</div>
                    	<%} %>
                    	<% if(building_id > 0 && floor_id > 0 && flat_id > 0){ %>
                    	<div  class="col-lg-3 col-sm-6 col-xs-12">
	                    	<button type="submit" id="flat"  class="btn11 btn-submit waves-effect waves-light m-t-15">FLAT</button>
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
                	<div class="col-md-4 col-sm-6 col-xs-12">
                		<select id="filter_floor_id" name="filter_floor_id">
                			<%
                			if(floorList != null){
                			for(BuilderFloor builderFloors : floorList){ %>
                			<option value="<%out.print(builderFloors.getId()); %>" <% if(builderFloors.getId() == floor_id) {%> selected<%} %>><%out.print(builderFloors.getName()); %></option>
                			<%}}else{ %>
                			<option value=""></option>
                			<%} %>
                		</select>
                	</div>
                	<div class="col-md-4 col-sm-6 col-xs-12">
                		<select id="filter_flat_id" name="filter_flat_id">
                			<%
                			if(flatList != null){
                			for(FlatData flatData : flatList){ %>
                			<option value="<%out.print(flatData.getId()); %>" <% if(flatData.getId() == flat_id) {%> selected<%} %>><%out.print(flatData.getName()); %></option>
                			<%}}else{ %>
                			<option value=""></option>
                			<%} %>
                		</select>
                	</div>
           		</div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
	                        <div class="color-box">
	                        <div id="flatDetailsTab1"></div>
                        	<div  id="flatDetailsTab">
	                           <ul class="nav nav-tabs">
	                               <li class="active" >
	                                   <a data-toggle="tab"  href="#vimessages" > <span>Flat Details</span></a>
	                               </li>
	                                <li>
	                                   <a  data-toggle="tab" href="#vimessages1"><span>Pricing Details</span></a>
	                               </li>
	                               <li>
	                                   <a  data-toggle="tab" href="#vimessages3"><span>Offers</span></a>
	                               </li>
	                               <li>
	                                   <a  data-toggle="tab" href="#vimessages2"><span>Payment Schedule</span></a>
	                               </li>
	                           </ul>
	                           <div class="tab-content"> 
                             	<div id="vimessages" class="tab-pane active" aria-expanded="false">
                              		<div class="col-12">
                                   		<form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
	                                   		 <input type="hidden" name="flat_id" id="flat_id" value="<% out.print(flat_id);%>"/>
	                                   		 <input type="hidden" name="flat_type_id" id="flat_type_id" value="<%out.print(flat_type_id); %>" /> 
	                                   		 <input type="hidden" name="admin_id" id="admin_id" value="1"/>
											 <input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
											 <input type="hidden" name="img_count" id="img_count" value="2"/>
											 <div class="row">
											 	<div class="col-sm-6">
	                                         		<div class="form-group row">
	                                             		<label for="example-text-input" class="col-sm-4 col-form-label">Flat No.</label>
	                                             		<div class="col-sm-6">
	                                                 		<input class="form-control" type="text" disabled id="flat_no" name="flat_no" value="<% out.print(builderFlat.getFlatNo()); %>" >
	                                             		</div>
	                                             		<div class="messageContainer col-sm-offset-3"></div>
	                                         		</div>
	                                         	</div>
	                                          	<div class="col-sm-6">
	                                         		<div class="form-group row">
	                                             		<label for="example-search-input" class="col-sm-4 col-form-label">Project Name</label>
	                                             		<div class="col-sm-6">
			                                                <select id="project_id" name="project_id" class="form-control" disabled>
																<option value="0">Select Project</option>
																<% for(ProjectData builderProject :builderProjects) { %>
																<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == project_id) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
																<% } %>
															</select>
			                                             </div>
	                                             		<div class="messageContainer col-sm-offset-3"></div>
	                                             	</div>
	                                         	</div>
                                       	 	</div>
	                                       	<div class="row">
		                                       	 <div class="col-sm-6">
			                                    	 <div class="form-group row">
			                                             <label for="example-search-input" class="col-sm-4 col-form-label">Building Name</label>
			                                             <div class="col-sm-6">
			                                                <select id="building_id" name="building_id" class="form-control" disabled>
																<% if(buildings != null) { %>
																<% for(BuilderBuilding builderBuilding2 :buildings) { %>
																<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
																<% } %>
																<% } else { %>
																<option value="0">Select Building</option>
																<% } %>
															</select>
			                                             </div>
			                                             <div class="messageContainer col-sm-offset-3"></div>
			                                         </div>
		                                         </div>
		                                         <div class="col-sm-6">
			                                          <div class="form-group row">
			                                             <label for="example-search-input" class="col-sm-4 col-form-label">Floor No.</label>
			                                             <div class="col-sm-6">
			                                                <select id="floor_id" name="floor_id" class="form-control" disabled>
																<% if(floors != null) { %>
																<% for(BuilderFloor builderFloor2 :floors) { %>
																<option value="<% out.print(builderFloor2.getId());%>" <% if(builderFloor2.getId() == floor_id) { %>selected<% } %>><% out.print(builderFloor2.getName());%></option>
																<% } %>
																<% } else { %>
																<option value="0">Select Floor</option>
																<% } %>
															</select>
			                                             </div>
			                                             <div class="messageContainer col-sm-offset-3"></div>
			                                         </div>
			                                      </div>
			                                  </div>
			                                  <div class="row">
			                                   		<div class="col-sm-6">
				                                         <div class="form-group row">
				                                             <label for="example-search-input" class="col-sm-4 col-form-label">Flat Type</label>
				                                             <div class="col-sm-6">
				                                               <select id="flat_type_id" name="flat_type_id" class="form-control" disabled>
																	<% if(builderFlatTypes != null) { %>
																	<% for(BuilderBuildingFlatType builderFlatType :builderFlatTypes) { %>
																	<option value="<% out.print(builderFlatType.getBuilderFlatType().getId());%>" <% if(builderFlat.getBuilderFlatType().getId() == builderFlatType.getBuilderFlatType().getId()) { %>selected<% } %>><% out.print(builderFlatType.getBuilderFlatType().getName());%></option>
																	<% } %>
																	<% } else { %>
																	<option value="0">Select Flat Type</option>
																	<% } %>
																</select>
				                                             </div>
				                                             <div class="messageContainer col-sm-offset-3"></div>
				                                        </div>
				                                   </div>
				                                   <div class="col-sm-6">
				                                        <div class="form-group row">
				                                             <label for="example-text-input" class="col-sm-4 col-form-label">Bedrooms</label>
				                                             <div class="col-sm-6">
				                                                 <input class="form-control" disabled type="text" id="bedroom" name="bedroom" value="<% out.print(builderFlat.getBedroom()); %>" >
				                                             </div>
				                                             <div class="messageContainer col-sm-offset-3"></div>
				                                       </div>
				                                  </div>
				                             </div>
				                             <div class="row">
				                             	<div class="col-sm-6">
			                                         <div class="form-group row">
			                                             <label for="example-text-input" class="col-sm-4 col-form-label">Bathrooms</label>
			                                             <div class="col-sm-6">
			                                                 <input class="form-control" type="text" disabled id="bathroom" name="bathroom" value="<% out.print(builderFlat.getBathroom()); %>" >
			                                             </div>
			                                             <div class="messageContainer col-sm-offset-3"></div>
			                                         </div>
			                                    </div>
			                                    <div class="col-sm-6">
			                                         <div class="form-group row">
			                                             <label for="example-text-input" class="col-sm-4 col-form-label">Balcony</label>
			                                             <div class="col-sm-6">
			                                                 <input class="form-control" disabled type="text" id="balcony" name="balcony" value="<% out.print(builderFlat.getBalcony()); %>" >
			                                             </div>
			                                             <div class="messageContainer col-sm-offset-3"></div>
			                                         </div>
			                                    </div>
			                                 </div>
                                         	<% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
	                                         <div class="row">
	                                         	<div class="col-sm-6">
			                                         <div class="form-group row">
			                                             <label for="example-text-input" class="col-sm-4 col-form-label">Possession Date </label>
			                                             <div class="col-sm-6">
			                                                 <input class="form-control" type="text" disabled id="possession_date" name="possession_date" value="<% if(builderFlat.getPossessionDate() != null) { out.print(dt1.format(builderFlat.getPossessionDate()));}%>" >
			                                             </div>
			                                             <div class="messageContainer col-sm-offset-3"></div>
			                                         </div>
			                                    </div>
			                                    <div class="col-sm-6">
			                                         <div class="form-group row">
			                                             <label for="example-text-input" class="col-sm-4 col-form-label">Status</label>
			                                             <div class="col-sm-6">
			                                                <select id="status" name="status" class="form-control" disabled>
																<% for(BuilderFlatStatus builderFlatStatus :builderFlatStatuses) { %>
																<option value="<% out.print(builderFlatStatus.getId());%>" <% if(builderFlat.getBuilderFlatStatus().getId() ==  builderFlatStatus.getId()) { %>selected<% } %>><% out.print(builderFlatStatus.getName()); %></option>
																<% } %>
															</select>
			                                             </div>
			                                         </div>
			                                   </div>
			                                </div>
			                                <div class="row">
			                                	<div class="offset-sm-5 col-sm-7">
                                   					<button type="button" id="viewFlatDetails" name="floorUpdate" class="btn btn-submit waves-effect waves-light m-r-10">NEXT</button>
                                   				</div>
                                   			</div>
                              	   	 	</form>
                              	  	</div>
                              	 </div>
                              	   	<div id="vimessages1" class="tab-pane" aria-expanded="false">
	                                 <div class="col-12">
	                                 	<form id="updateprice" name="updateprice" method="post"  class="form-horizontal" enctype="multipart/form-data">
		                                	 <input type="hidden" name="price_id" value="<% if(priceInfoData != null){ out.print(priceInfoData.getId()); } else {%>0<% }%>"/>
											<input type="hidden" name="flat_id" id="flat_id" value="<% out.print(flat_id);%>"/>
											<input type="hidden" name="flat_type_id" id="flat_type_id" value="<%out.print(flat_type_id);%>"/>
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
			                                	<div class="col-sm-6">
					                                <div class="form-group row">
			        		                            <label for="example-text-input" class="col-sm-4 col-form-label">Stamp Duty<span class='text-danger'>*</span></label>
			                		                    <div class="col-sm-6">
			                		                    	<div>
				                		                    	<div>
				                        		               		<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(priceInfoData.getStampDuty() > 0 && priceInfoData.getStampDuty() != 0){ out.print(priceInfoData.getStampDuty());} else {%>0<%}%>"/>
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
			                                   			<label for="example-text-input" class="col-sm-4 col-form-label">Tax<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input type="text" class="form-control" id="tax" name="tax" value="<% if(priceInfoData.getTax() > 0 && priceInfoData.getTax() != 0){ out.print(priceInfoData.getTax());} else {%>0<%}%>"/>
				                                    			</div>
				                                    			<div class="messageContainer"></div>
				                                    		</div>
			                                    		</div>
			                                    	</div>
			                                     </div>
			                                	 <div class="col-sm-6">
			                                		<div class="form-group row">
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">VAT<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
				                                    			<div>
				                                        			<input type="text" class="form-control" id="vat" name="vat" value="<% if(priceInfoData.getVat() > 0 && priceInfoData.getVat() != 0){ out.print(priceInfoData.getVat());} else {%>0<%}%>"/>
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
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">Tech Fees<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
			                                        			<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(priceInfoData.getFee() > 0 && priceInfoData.getFee() != 0){ out.print(priceInfoData.getFee());}%>"/>
			                                    			</div>
			                                    			<div class="messageContainer"></div>
			                                    		</div>	
			                                		</div>
			                                	</div>
			                                	<div class="col-sm-6">
			                                    	<div class="form-group row">	
			                                    		<label for="example-search-input" class="col-sm-4 col-form-label">Flat Sale value<span class='text-danger'>*</span></label>
			                                    		<div class="col-sm-6">
			                                    			<div>
			                                        			<input type="text" class="form-control" id="sale_value" name="sale_value" value="<% if(priceInfoData.getTotalCost() > 0 && priceInfoData.getTotalCost() != 0){ out.print(priceInfoData.getTotalCost());}%>" readonly/>
			                                    			</div>
			                                    			<div class="messageContainer"></div>
			                                    		</div>	
			                                		</div>
			                                	</div>
			                              </div>
			                              <div class="row">
				                              <div class="offset-sm-5 col-sm-7">
		        	                               	<button type="submit" id="pricebtn" class="btn btn-submit waves-effect waves-light m-t-10">UPDATE</button>
		            		                  </div>
		            		              </div>
	                    	            </form>
                                	</div>
             					</div>
                              	<div id="vimessages2" class="tab-pane" aria-expanded="false">        
                                 	<form id="updatePayment" name="updatepayment" method="post" action=""  enctype="multipart/form-data">
                                 	 	<input type="hidden" id="flat_id" name="flat_id" value="<% out.print(flat_id);%>"/>
                                 	 	<input type="hidden" name="h_sale_value" id="h_sale_value" value="<% if(priceInfoData.getTotalCost() > 0 && priceInfoData.getTotalCost() != 0){ out.print(priceInfoData.getTotalCost());}%>"/>
                                   		<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(flatPaymentSchedules.size() + 1);%>"/>
                                   		<div id="payment_schedule">
	                                   <% int ii=1;
											for(PaymentInfoData flatPaymentSchedule : flatPaymentSchedules) { %>
												<input type="hidden" name="payment_id[]" value="<% out.print(flatPaymentSchedule.getId()); %>" />
												 <div class="row" id="schedule-<% out.print(flatPaymentSchedule.getId());%>">
												<% if(ii > 1) { %>
													<hr/>
													<% } %>
														<div class="col-sm-4">
				                                			<div class="form-group row">
							                                    <label for="example-search-input" class="col-sm-4 control-label">Milestone<span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-6">
				                                    				<div>
				                                        				<input type="text" class="form-control" readonly id="schedule" name="schedule[]" value="<% out.print(flatPaymentSchedule.getName());%>"/>
					                                    			</div>
					                                    			<div class="messageContainer"></div>
					                                 			</div>
					                                 		</div>
					                                 	</div>
					                                 	<div class="col-sm-3">
					                                 		<div class="form-group row">
				                                    			<label for="example-search-input" class="col-sm-6 control-label">% of net payable<span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-4">
				                                    				<div>
				                                        				<input type="text" class="form-control" id="payable<%out.print(ii); %>" onkeyup="calculateAmount(<%out.print(ii); %>);" onkeypress=" return isNumber(event, this);" name="payable[]" value="<% out.print(flatPaymentSchedule.getPayable());%>"/>
					                                    			</div>
					                                    			<div class="messageContainer"></div>
					                                  			</div>
				                                			</div>
				                               			</div>
				                               			<div class="col-sm-4">
					                                 		<div class="form-group row">
				                                    			<label for="example-search-input" class="col-sm-4 control-label">Amount <span class='text-danger'>*</span></label>
				                                    			<div class="col-sm-6">
				                                    				<div>
				                                        				<input type="text" class="form-control" id="amount<%out.print(ii); %>" onkeyup="calcultatePercentage(<%out.print(ii); %>);"   name="amount[]" value="<% out.print(flatPaymentSchedule.getAmount());%>"/>
					                                    			</div>
					                                    			<div class="messageContainer"></div>
					                                  			</div>
				                                			</div>
				                               			</div>
	                               					</div>
	                               					<%ii++;}%>
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
													 	<input type="hidden" id="flat_id" name="flat_id" value="<% out.print(flat_id);%>"/>
													 	<input type="hidden" id="flat_type_id" name="flat_type_id" value="<%out.print(flat_type_id); %>" />
													 	<input type="hidden" name="base_sale_value" id="base_sale_value" value="<% if(priceInfoData.getTotalCost() > 0 && priceInfoData.getTotalCost() != 0){ out.print(priceInfoData.getTotalCost());}%>"/>
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
																			<div class="col-lg-4 margin-bottom-5">
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
																			<div class="col-lg-4 margin-bottom-5">
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
																					<label class="control-label col-sm-6">Discount <span class='text-danger'>*</span></label>
																					<div class="col-sm-6">
																						<input type="text" class="form-control" readonly id="project_discount_amount<%out.print(jj); %>"   onkeyup=" javascript:validPerAmount(<%out.print(jj); %>);" name="project_discount_amount[]" value="<%if(projectOfferInfo.getAmount()!=null){ out.print(projectOfferInfo.getAmount());} %>"/>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
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
																	<div id="building_offer_area">
																		<% int j = 1;
																				for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { 
																		%>
																		<%if(j >1){ %>
																		<hr>
																		<%} %>
																		<div class="row" id="building_offer-<% out.print(buildingOfferInfo.getId()); %>">
																			<input type="hidden" name="building_offer_id[]" value="<% out.print(buildingOfferInfo.getId()); %>" />
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-offer_title">
																					<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																					<div class="col-sm-8">
																						<div>
																							<input type="text" class="form-control" id="building_offer_title" readonly name="building_offer_title[]" value="<% out.print(buildingOfferInfo.getTitle()); %>">
																						</div>
																						<div class="messageContainer"></div>
																					</div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-applicable_on">
																					<label class="control-label col-sm-6">Offer Type </label>
																					<div class="col-sm-6">
																						<select class="form-control" id="building_offer_type<%out.print(j); %>" disabled  onchange="txtEnabaleDisable(<%out.print(j); %>);"  name="building_offer_type[]">
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
																					<label class="control-label col-sm-6">Discount <span class='text-danger'>*</span></label>
																					<div class="col-sm-6">
																						<input type="text" class="form-control" readonly <%if(buildingOfferInfo.getType() == 3){ %>disabled<%} %> id="building_discount_amount<%out.print(j); %>"   onkeyup=" javascript:validPerAmount(<%out.print(j); %>);" name="discount_amount[]" value="<%if(buildingOfferInfo.getAmount()!=null){ out.print(buildingOfferInfo.getAmount());} %>"/>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-applicable_on">
																					<label class="control-label col-sm-4">Description </label>
																					<div class="col-sm-8">
																						<textarea class="form-control" disabled id="building_description" name="building_description[]"><% if(buildingOfferInfo.getDescription() != null) { out.print(buildingOfferInfo.getDescription());} %></textarea>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-apply">
																					<label class="control-label col-sm-6">Status </label>
																					<div class="col-sm-6">
																						<select class="form-control" id="building_offer_status" name="offer_status[]" disabled>
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
																	<div id="offer_area">
																		<% int k = 1;
																				for(FlatOfferInfo flatOfferInfo :flatOfferInfos) { 
																		%>
																		<%if(k >1){ %>
																		<hr>
																		<%} %>
																		<div class="row" id="offer-<% out.print(flatOfferInfo.getId()); %>">
																			<input type="hidden" name="offer_id[]" value="<% out.print(flatOfferInfo.getId()); %>" />
																			<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:deleteOffer(<% out.print(flatOfferInfo.getId()); %>);" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-offer_title">
																					<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																					<div class="col-sm-8">
																						<div>
																							<input type="text" class="form-control" id="offer_title"  name="offer_title[]" value="<% out.print(flatOfferInfo.getTitle()); %>">
																						</div>
																						<div class="messageContainer"></div>
																					</div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-applicable_on">
																					<label class="control-label col-sm-6">Offer Type </label>
																					<div class="col-sm-6">
																						<select class="form-control" id="offer_type<%out.print(j); %>"   onchange="txtEnabaleDisable(<%out.print(k); %>);"  name="offer_type[]">
																							<option value="1" <% if(flatOfferInfo.getType() == 1) { %>selected<% } %>>Percentage</option>
																							<option value="2" <% if(flatOfferInfo.getType() == 2) { %>selected<% } %>>Flat Amount</option>
																							<option value="3" <% if(flatOfferInfo.getType() == 3) { %>selected<% } %>>Other</option>
																						</select>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-discount_amount">
																					<label class="control-label col-sm-6">Discount Amount <span class='text-danger'>*</span></label>
																					<div class="col-sm-6">
																						<input type="text" class="form-control"  <%if(flatOfferInfo.getType() == 3){ %>disabled<%} %> id="discount_amount<%out.print(k); %>"   onkeyup=" javascript:validPerAmount(<%out.print(k); %>);" name="discount_amount[]" value="<%if(flatOfferInfo.getAmount()!=null){ out.print(flatOfferInfo.getAmount());} %>"/>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-applicable_on">
																					<label class="control-label col-sm-4">Description </label>
																					<div class="col-sm-8">
																						<textarea class="form-control"  id="description" name="description[]"><% if(flatOfferInfo.getDescription() != null) { out.print(flatOfferInfo.getDescription());} %></textarea>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																			<div class="col-lg-4 margin-bottom-5">
																				<div class="form-group" id="error-apply">
																					<label class="control-label col-sm-6">Status </label>
																					<div class="col-sm-6">
																						<select class="form-control" id="offer_status" name="offer_status[]">
																							<option value="1" <% if(flatOfferInfo.getStatus().toString() == "1") { %>selected<% } %>>Active</option>
																							<option value="0" <% if(flatOfferInfo.getStatus().toString() == "0") { %>selected<% } %>>Inactive</option>
																						</select>
																					</div>
																					<div class="messageContainer"></div>
																				</div>
																			</div>
																		</div>
																		<% k++; } %>
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
            	</div>
        	</div>
	 	<div id="sidebar1"> 
	   	  <%@include file="../../../../partial/footer.jsp"%>
	 	</div> 
</body>
</html>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script>
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
$("#viewFlatDetails").click(function(){
	 $('.active').removeClass('active').next('li').addClass('active');
     $("#vimessages1").addClass('active');
});
function calculateAmount(id){
	if($("#payable"+id).val() <0 || $("#payable"+id).val() >100){
		alert("The percentage must be between 0 and 100");
		$("#payable"+id).val('');
	}else{
	var amount = $("#payable"+id).val()*$("#h_sale_value").val()/100;
		$("#amount"+id).val(amount.toFixed(0));
	}
}

function deleteOffer(id){
	var flag = confirm("Are you sure ? You want to delete offers ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/flat/offer/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#offer-"+id).remove();
			}
		},'json');
	}
}

function calcultatePercentage(id){
	var $th = $("#amount"+id);
	$th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
	if($("#amount"+id).val() <= $("#h_sale_value").val() ){
		var percentage = $("#amount"+id).val()/$("#h_sale_value").val()*100;
		$("#payable"+id).val(percentage.toFixed(1));
	}else{
		alert("Please Enter correct flat sale amount");
		$("#payable"+id).val("");
		$("#amount"+id).val("");
	}
}
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
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
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() > 0 || $("#filter_building_id").val() != '' ){
			$.get("${baseUrl}/webapi/project/building/floor/list/",{ building_id: value }, function(data){
				var html = '<option value="">Enter Floor Name</option>';
				if(data != ""){
					$(data).each(function(index){
						html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
					});
					$select_floor[0].selectize.destroy();
					$("#filter_floor_id").html(html);
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value1) {
							 if($("#filter_floor_id").val() > 0 || $("#filter_floor_id").val() != '' ){
								 $select_flat[0].selectize.destroy();
								 $.get("${baseUrl}/webapi/project/building/flat/list/",{ floor_id: $("#filter_floor_id").val() }, function(data){
										var html = '<option value="">Enter Flat Number</option>';
										if(data != ""){
											$(data).each(function(index){
												html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
											});
											
											$("#filter_flat_id").html(html);
											$select_flat = $("#filter_flat_id").selectize({
												persist: false,
												 onChange: function(value2) {
													 if(value2 > 0 || value2 != '' ){
															window.location.href = "${baseUrl}/builder/project/building/floor/flat/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+$("#filter_floor_id").val()+"&flat_id="+value2;
														}
												 },
												 onDropdownOpen: function(value){
											   	 var obj = $(this);
													var textClear =	 $("#filter_flat_id :selected").text();
											   	 if(textClear.trim() == "Enter Flat Name"){
											   		 obj[0].setValue("");
											   	 }
											    }
											});
										}else{
											$select_flat[0].selectize.destroy();
											$("#filter_flat_id").html("");
											$("#flatDetailsTab").hide();
											$("#flatDetailsTab1").html("Sorry No flat found..");
											$("#flatDetailstab1").show();
											$select_flat = $("#filter_flat_id").selectize({
												persist: false,
												 onChange: function(value) {

												 },
												 onDropdownOpen: function(value){
											   	 var obj = $(this);
													var textClear =	 $("#filter_flat_id :selected").text();
											   	 if(textClear.trim() == "Enter Flat Number"){
											   		 obj[0].setValue("");
											   	 }
											    }
											});
										}
									},'json');
								}
						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("");
					   	 }
					    }
					});
				}else{
					
					$select_floor[0].selectize.destroy();
					$select_flat[0].selectize.destroy();
					$("#filter_floor_id").html("");
					$("#filter_flat_id").html("");
					$("#flatDetailsTab").hide();
					$("#flatDetailsTab1").html("Sorry No floor found..");
					$("#flatDetailstab1").show();
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value) {

						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("");
					   	 }
					    }
					});
					$select_flat = $("#filter_flat_id").selectize({
						persist: false,
						 onChange: function(value) {

						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_flat_id :selected").text();
					   	 if(textClear.trim() == "Enter Flat Number"){
					   		 obj[0].setValue("");
					   	 }
					    }
					});
				}
				
			},'json');
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

$select_floor = $("#filter_floor_id").selectize({
	persist: false,
	 onChange: function(value) {

		if($("#filter_floor_id").val() > 0 || $("#filter_floor_id").val() != '' ){
			
			$.get("${baseUrl}/webapi/project/building/flat/list/",{ floor_id: value }, function(data){
				var html = '<option value="">Enter Flat Number</option>';
				if(data != ""){
					$(data).each(function(index){
						html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
					});
					$select_flat[0].selectize.destroy();
					$("#filter_flat_id").html(html);
					$select_flat = $("#filter_flat_id").selectize({
						persist: false,
						 onChange: function(value2) {
							 if(($("#filter_building_id").val() > 0 && $("#filter_building_id").val() != '' ) && ($("#filter_floor_id").val() > 0 && $("#filter_building_id").val() != '') && (value > 0 && value != '')){
									window.location.href = "${baseUrl}/builder/project/building/floor/flat/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+$("#filter_floor_id").val()+"&flat_id="+value2;
									
								}
						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_flat_id :selected").text();
					   	 if(textClear.trim() == "Enter Flat Name"){
					   		 obj[0].setValue("");
					   	 }
					    }
					});
		}else{
			$select_flat[0].selectize.destroy();
			$("#filter_flat_id").html("");
			$("#flatDetailsTab").hide();
			$("#flatDetailsTab1").html("Sorry No flat found..");
			$("#flatDetailstab1").show();
			$select_flat = $("#filter_flat_id").selectize({
				persist: false,
				 onChange: function(value) {

				 },
				 onDropdownOpen: function(value){
			   	 var obj = $(this);
					var textClear =	 $("#filter_flat_id :selected").text();
			   	 if(textClear.trim() == "Enter Flat Number"){
			   		 obj[0].setValue("");
			   	 }
			    }
			});
		}
		
	 },'json');
	}
	 },
	 onDropdownOpen: function(value){
   	 var obj = $(this);
		var textClear =	 $("#filter_floor_id :selected").text();
   	 if(textClear.trim() == "Enter Floor Name"){
   		 obj[0].setValue("");
   	 }
    }
});

<% if(floor_size_list > 0){%>
  select_floor = $select_floor[0].selectize;
<%}%>

$select_flat = $("#filter_flat_id").selectize({
	persist: false,
	 onChange: function(value) {
		 if(($("#filter_building_id").val() > 0 && $("#filter_building_id").val() != '' ) && ($("#filter_floor_id").val() > 0 && $("#filter_building_id").val() != '') && (value > 0 && value != '')){
			 window.location.href = "${baseUrl}/builder/project/building/floor/flat/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+$("#filter_floor_id").val()+"&flat_id="+value;
		 }
	 },
	 onDropdownOpen: function(value){
	   	 var obj = $(this);
			var textClear =	 $("#filter_flat_id :selected").text();
	   	 if(textClear.trim() == "Enter Flat Number"){
	   		 obj[0].setValue("");
	   	 }
	    }
	});

$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#addfloor').data('bootstrapValidator').revalidateField('possession_date');
});
$('#addfloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	flat_id: {
            validators: {
                notEmpty: {
                    message: 'Flat ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Floor Name is required and cannot be empty'
                }
            }
        },
        floor_no: {
            validators: {
                notEmpty: {
                    message: 'Floor Number is required and cannot be empty'
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
        },
        'amenity_type[]': {
        	validators: {
                notEmpty: {
                    message: 'Please select amenity'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateFlat();
});

function updateFlat() {
	var amenityWeightage = "";
	$('input[name="amenity_type[]"]:checked').each(function() {
		amenity_id = $(this).val();
		$('input[name="stage_weightage'+amenity_id+'[]"]').each(function() {
			stage_id = $(this).attr("id");
			stage_weightage = $(this).val();
			$('input[name="substage'+stage_id+'[]"]').each(function() {
				if(amenityWeightage != "") {
					amenityWeightage = amenityWeightage + "," + amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				} else {
					amenityWeightage = amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				}
			});
		});
	});
	$("#amenity_wt").val(amenityWeightage);
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addfloor').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
  	}
}

function deletePayment(id) {
	var flag = confirm("Are you sure ? You want to delete payment slab ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/flat/payment/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#schedule-"+id).remove();
			}
		},'json');
	}
}

$("#updateprice").bootstrapValidator({
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
         }
     }
 }).on('success.form.bv', function(event,data) {
 	// Prevent form submission
 	event.preventDefault();
 	updateFlatPricing();
 });

function updateFlatPricing(){
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showPriceAddRequest,
	 		success :  showPriceAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update/price',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateprice').ajaxSubmit(options);
}
function showPriceAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showPriceAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.reload();
  	}
}

$('#updatePayment').bootstrapValidator({
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
        'amount[]':{
        	validators:{
        		notEmpty :{
        			message: 'amount is required and cannot be empty'
        		}
        	}
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updatePaymentSchudle();
});

function updatePaymentSchudle(){
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showPaymentSlabRequest,
	 		success :  showPaymentSlabResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update/payment',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatePayment').ajaxSubmit(options);
}
function showPaymentSlabRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showPaymentSlabResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.reload();
  	}
}
function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	var html = '<div class="row" id="schedule-'+schedule_count+'"><input type="hidden" name="payment_id[]" value="0" />'
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


function showDetailTab() {
	$('#buildingTabs a[href="#payment"]').tab('show');
}

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
	
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/floor/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Floor</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#floor_id").html(html);
	},'json');
	$.get("${baseUrl}/webapi/project/building/flattype/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Flat Type</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#flat_type_id").html(html);
	},'json');
	
});
$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});
function validateDiscountPer(id){
	var x = $("#discount"+id).val();
	if( x<0 || x >100){
		alert("The percentage must be between 0 and 100");
		$("#discount"+id).val('');
	}
}

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title'+offers+'" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
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
				+'<label class="control-label col-sm-6">Discount </label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control errorMsg" id="discount_amount'+offers+'" onkeyup=" javascript:validPerAmount('+offers+');" name="discount_amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
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

function updateBuildingOffers() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddOfferRequest,
	 		success :  showAddOfferResponse,
	 		url : '${baseUrl}/webapi/project/building/flat/offer/update',
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
        window.location.reload();
  	}
}

$('#updateoffer').bootstrapValidator({
    feedbackIcons: {
        invalid: 'glyphicon glyphicon-remove',
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
	});
</script>