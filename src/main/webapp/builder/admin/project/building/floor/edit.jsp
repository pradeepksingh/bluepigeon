<%@page import="org.bluepigeon.admin.model.FloorSubstage"%>
<%@page import="org.bluepigeon.admin.model.FloorWeightage"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.FloorStageDAO"%>
<%@page import="org.bluepigeon.admin.model.FloorStage"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FloorLayoutImage"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	int project_id = 0;
	int building_id = 0;
	int floor_id = 0;
	int flat_id = 0;
	int p_user_id = 0;
	int building_size_list =0;
	int floor_size_list = 0;
	List<BuilderFloor> floorList = null;
	BuilderFloor builderFloor = null;
	List<BuilderBuilding> builderBuildingList = null;
	List<BuilderBuilding> buildings = null;
	List<FloorAmenityInfo> floorAmenityInfos = null;
	List<FloorLayoutImage> floorLayoutImages = null;
	List<BuilderFloorStatus> builderFloorStatuses = null;
	List<BuilderFloorAmenity> builderFloorAmenities = null;
	List<ProjectData> builderProjects  = null;
	List<FloorStage> floorStages = null;
	List<BuilderFlat> builderFlats = null;
	List<FloorWeightage> floorWeightages = null;
	List<FloorAmenityWeightage> floorAmenityWeightages  = null;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	floor_id = Integer.parseInt(request.getParameter("floor_id"));
	session = request.getSession(false);
	BuilderEmployee adminuserproject = new BuilderEmployee();
	if(session!=null){
		if(session.getAttribute("ubname") != null){
			adminuserproject  = (BuilderEmployee)session.getAttribute("ubname");
			if(adminuserproject != null){
				p_user_id = adminuserproject.getBuilder().getId();
			}
			if(project_id > 0 && building_id > 0 && floor_id > 0){
			List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingActiveFloorById(floor_id);
			if(builderFloors.size() > 0) {
				builderFloor = builderFloors.get(0);
				buildings = new ProjectDAO().getBuilderActiveProjectBuildings(builderFloor.getBuilderBuilding().getBuilderProject().getId());
			}
			builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
			building_size_list = builderBuildingList.size();
			floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id);
			floor_size_list = floorList.size();
			try{
				flat_id = new ProjectDAO().getBuilderActiveFloorFlats(floor_id).get(0).getId();
			}catch(Exception e){
				
			}
			 floorAmenityInfos = new ProjectDAO().getBuildingFloorAmenityInfo(floor_id);
			 floorLayoutImages = new ProjectDAO().getBuildingFloorPlanInfo(floor_id);
			 builderFloorStatuses = new BuilderFloorStatusDAO().getActiveFloorStatus();
			 builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderActiveFloorAmenityList();
			 builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(p_user_id);
			floorAmenityWeightages = new ProjectDAO().getActiveFloorAmenityWeightages(floor_id);
			
			
			 floorStages = new FloorStageDAO().getActiveFloorStages();
			 floorWeightages = new ProjectDAO().getFloorWeightage(floor_id);
			 builderFlats = new ProjectDAO().getActiveFlatByFloorId(floor_id);
			
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
     <link rel="stylesheet" type="text/css" href="../../../../css/selectize.css" />
    <link rel="stylesheet" type="text/css" href="../../../css/updatefloor.css">
     <link rel="stylesheet" type="text/css" href="../../../css/topbutton.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    <!-- jQuery -->
    <script src="../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
      <script src="../../../js/jquery.form.js"></script>
    <script src="../../../js/bootstrap-datepicker.min.js"></script>
  <script src="../../../js/bootstrapValidator.min.js"></script>
  <script type="text/javascript" src="../../../js/selectize.min.js"></script>
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
        <div id="page-wrapper">
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
	              		<% if(building_id > 0 && floor_id > 0) %>
                    	<div  class="col-lg-3 col-sm-6 col-xs-12">
                    		<button type="submit" id="floor"  class="btn11 btn-submit waves-effect waves-light m-t-15">FLOOR</button>
                    	</div>
                    	<% if(building_id > 0 && floor_id > 0 && flat_id > 0){ %>
                    	<div  class="col-lg-3 col-sm-6 col-xs-12">
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
           		</div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                        	<div class="color-box">
                        	<div id="floorDetailsTab1"></div>
                        	<div  id="floorDetailsTab">
                        	 <ul class="nav  nav-tabs">
                                 <li class="active">
                                     <a data-toggle="tab"  href="#vimessages" > <span>Floor Details</span></a>
                                 </li>
                                 <li class="">
                                     <a data-toggle="tab"  href="#vimessages1" > <span>Floor Layout</span></a>
                                 </li>
                                 <li class="">
                                     <a data-toggle="tab"  href="#vimessages2" > <span>Floor Amenity</span></a>
                                 </li>
                             </ul>
                              <form id="updatefloor" name="updatefloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                            <div class="tab-content"> 
                              <div id="vimessages" class="tab-pane active" aria-expanded="false">
                              	<div class="col-12">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="project_id" id = "project_id" value="<%out.print(project_id);%>"/>
										<input type="hidden" name="building_id" id="building_id" value="<%out.print(building_id); %>"/>
										<input type="hidden" name="floor_id" id="floor_id" value="<% out.print(floor_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<input type="hidden" name="status_id" id="status_id" value="<%out.print(builderFloor.getStatus());%>"/>
										
										<input type="hidden" name="status" id="status" value="<%out.print(builderFloor.getBuilderFloorStatus().getId());%>"/>
 										<div class="row">
											<div class="col-sm-6">
		                                        <div class="form-group row">
		                                            <label for="example-text-input" class="col-sm-4 col-form-label">Floor No</label>
		                                            <div class="col-sm-6">
		                                                <input readonly type="text" class="form-control floor"id="floor_no" name="floor_no" value="<% out.print(builderFloor.getFloorNo()); %>" >
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-6">
		                                        <div class="form-group row">
		                                            <label for="example-search-input" class="col-sm-4 col-form-label">Floor Status</label>
		                                            <div class="col-sm-6">
			                                             <select id="status" name="status" class="form-control floor" disabled>
															<% for(BuilderFloorStatus builderFloorStatus :builderFloorStatuses) { %>
															<option value="<% out.print(builderFloorStatus.getId());%>" <% if(builderFloor.getBuilderFloorStatus().getId() == builderFloorStatus.getId()) { %>selected<% } %>><% out.print(builderFloorStatus.getName()); %></option>
															<% } %>
														</select>
		                                            </div>
		                                        </div>
		                                     </div>
		                                 </div>
		                                 <div class="row">
		                                 	<div class="col-sm-6">
		                                 		<div class="form-group row">
                                            		<label for="example-text-input" class="col-sm-4 col-form-label">Building Name</label>
                                            		<div class="col-sm-6">
														<input disabled type="text"  class="form-control floor"  id="building_name" name="building_name" value="<% out.print(builderFloor.getBuilderBuilding().getName()); %>" >
                                            		</div>
                                            	</div>
                                        	</div>
                                        	<div class="col-sm-6">
		                                        <div class="form-group row">
		                                            <label for="example-text-input" class="col-sm-4 col-form-label">Project Name</label>
		                                            <div class="col-sm-6">
		                                               <select id="project_id" name="project_id" class="form-control floor" disabled>
															<option value="0">Select Project</option>
															<% for(ProjectData builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderFloor.getBuilderBuilding().getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
		                                            </div>
		                                        </div>
                                        	</div>
                                       </div> 
                                       <div class="row">
                                       		<div class="col-sm-6">
		                                        <div class="form-group row">
		                                            <label for="example-text-input" class="col-sm-4 col-form-label">Floor Name</label>
		                                            <div class="col-sm-6">
		                                                <input  class="form-control floor"  type="text" readonly="true" id="name" name="name" value="<% out.print(builderFloor.getName()); %>">
		                                            </div>
		                                      	</div>
		                                   	</div>
		                                   	<div class="col-sm-6">
		                                        <div class="form-group row">
		                                            <label for="example-text-input" class="col-sm-4 col-form-label">Status</label>
		                                            <div class="col-sm-6">
		                                                 <select id="status_id" name="status_id" class="form-control floor" disabled>
															<option value="<% out.print(builderFloor.getStatus());%>" <% if(builderFloor.getStatus() ==1) { %>selected<% } %>><% out.print("Active"); %></option>
														</select>
		                                            </div>
		                                      	</div>
		                                   	</div>
                                      </div>
                                      <div class="row">
										<div class="offset-sm-5 col-sm-7">
	                                    	<button type="button" id="next" class="btn btn-submit waves-effect waves-light m-t-10">Next</button>
	                                   	</div>
		                            </div>
                                      <div class="row" id="hidefloor">
											<div class="col-lg-12">
												<hr/>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Floor Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderFloorAmenity builderFloorAmenity :builderFloorAmenities) { 
															String is_checked = "";
															for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
																if(floorAmenityInfo.getBuilderFloorAmenity().getId() == builderFloorAmenity.getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFloorAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderFloorAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Floor Amenities Weightage </label>
													<div class="col-sm-10">
														<% 	for(BuilderFloorAmenity builderFloorAmenity : builderFloorAmenities) { 
															String is_checked = "";
															if(floorAmenityInfos.size() > 0) { 
																for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
																	if(floorAmenityInfo.getBuilderFloorAmenity().getId() == builderFloorAmenity.getId()) {
																		is_checked = "checked";
																	}
																}
															}
															Double amenity_wt = 0.0;
															for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																if(builderFloorAmenity.getId() == floorAmenityWeightage.getBuilderFloorAmenity().getId()) {
																	amenity_wt = floorAmenityWeightage.getAmenityWeightage();
																}
															}
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderFloorAmenity.getId());%>" style="<% if(is_checked == "checked") {%>display:block;<% } else { %>display:none;<% } %>margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderFloorAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" onkeypress=" return isNumber(event, this);" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFloorAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
																</div>
															</div>
															<% 	for(BuilderFloorAmenityStages bpaStages :builderFloorAmenity.getBuilderFloorAmenityStageses()) { 
																Double stage_wt = 0.0;
																for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																	if(bpaStages.getId() == floorAmenityWeightage.getBuilderFloorAmenityStages().getId()) {
																		stage_wt = floorAmenityWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input onkeypress=" return isNumber(event, this);" name="stage_weightage<% out.print(builderFloorAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderFloorAmenitySubstages bpaSubstage :bpaStages.getBuilderFloorAmenitySubstageses()) { 
																		Double substage_wt = 0.0;
																		for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																			if(bpaSubstage.getId() == floorAmenityWeightage.getBuilderFloorAmenitySubstages().getId()) {
																				substage_wt = floorAmenityWeightage.getSubstageWeightage();
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
                               	 	</div>
                                </div>
                                <div id="vimessages1" class="tab-pane fade" aria-expanded="false">
                                	<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-default">
												<div class="panel-body">
													<h3>Upload Floor Image</h3>
													<br>
													<div class="row" id="project_images">
														<div class="col-lg-4 margin-bottom-5">
														<%if(builderFloor.getImage()!=null){ %>
															<div class="form-group" id="error-landmark">
																<div class="col-sm-12">
																	<img alt="Building Images" src="${baseUrl}/<% out.print(builderFloor.getImage()); %>" width="200px;">
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														<% } %>
														</div>
														<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
															<div class="form-group" id="error-landmark">
																<label class="control-label col-sm-4">Select Image </label>
																<div class="col-sm-8 input-group" style="padding:0px 12px;">
																	<input type="file"  class="form-control floor"  id="floor_image" name="floor_image[]" />
																</div>
																<div class="messageContainer col-sm-offset-3"></div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="offset-sm-5 col-sm-7">
	                                    	<button type="submit" name="flooradd" class="btn btn-submit waves-effect waves-light m-t-10">Submit</button>
	                                   	</div>
		                            </div>
                                </div>
                                <div id="vimessages2" class="tab-pane fade" aria-expanded="false">
                                <form id="subpfrm" name="subpfrm" method="post">
                                	<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-default">
												<div class="panel-body">
													<div id="offer_area">
														<div class="row">
<!-- 															<div class="col-lg-12 margin-bottom-5"> -->
<!-- 																<div class="row" id="error-amenity_type"> -->
																	<div class="col-sm-6">
																		<div class="form-group" id="error-amenity_weightage">
																			<label class="control-label col-sm-4">Amenity Weightage </label>
																			<div class="col-sm-6">
																				<input type="text"  class="form-control floor"  onkeypress=" return isNumber(event, this);" id="amenity_weightage" name="amenity_weightage" value="<%out.print(builderFloor.getAmenityWeightage());%>" placeholder="amenity weightage in %"/>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
<!-- 																</div> -->
<!-- 																<div class="row" id="error-amenity_type"> -->
																	<div class="col-sm-6">
																		<div class="form-group" id="error-discount_amount">
																			<label class="control-label col-sm-3">Flat Weightage</label>
																			<div class="col-sm-6">
																				<input type="text"  class="form-control floor"  onkeypress=" return isNumber(event, this);" id="flat_weightage" name="flat_weightage" value="<%out.print(builderFloor.getFlatWeightage());%>"/>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
<!-- 																</div> -->
																<div class="col-sm-12">
																	<label class="control-label">Flats</label>
																</div>
																<%
																  if(builderFlats != null){
																	  for(BuilderFlat builderFlat : builderFlats ){
																%>
																<input type="hidden" id="flat_ids" name="flat_ids[]" value="<%out.print(builderFlat.getId());%>">
																<div class="col-sm-4 margin-bottom-5">
																	<div class="form-group" id="error-discount_amount">
																		<label class="control-label col-sm-1"><%out.print(builderFlat.getFlatNo()); %></label>
																		<div class="col-sm-6">
																			<input type="text"  class="form-control floor" onkeypress=" return isNumber(event, this);" id="weightage[]" name="weightage[]" value="<%out.print(builderFlat.getWeightage());%>"/>
																		</div>
																		<div class="messageContainer"></div>
																	</div>
																</div>	  
																		<%	  }
																		  }
																		%>
															</div>
																		<div class="form-group" id="error-amenity_type">
																			<div class="col-sm-12">
																				<% 	for(FloorStage floorStage :floorStages) { 
																					Double stage_wt = 0.0;
																					for(FloorWeightage floorWeightage :floorWeightages) {
																						if(floorStage.getId() == floorWeightage.getFloorStage().getId()) {
																							stage_wt = floorWeightage.getStageWeightage();
																						}
																					}
																				%>
																				<fieldset class="scheduler-border">
																					<legend class="scheduler-border">Stages</legend>
																					<div class="col-sm-12">
																						<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(floorStage.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage[]" onkeypress=" return isNumber(event, this);" id="<% out.print(floorStage.getId());%>" type="text"  class="form-control floor"  placeholder="Project Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																						<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																							<legend class="scheduler-border">Sub Stages</legend>
																						<% 	for(FloorSubstage floorSubstage :floorStage.getFloorSubstages()) { 
																							Double substage_wt = 0.0;
																							for(FloorWeightage floorWeightage :floorWeightages) {
																								if(floorSubstage.getId() == floorWeightage.getFloorSubstage().getId()) {
																									substage_wt = floorWeightage.getSubstageWeightage();
																								}
																							}
																						%>
																							<div class="col-sm-3">
																								<% out.print(floorSubstage.getName()); %> (%)<br>
																								<input onkeypress=" return isNumber(event, this);" type="text" name="substage_weightage<% out.print(floorStage.getId());%>[]" id="<% out.print(floorSubstage.getId()); %>"  class="form-control floor"  placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
																							</div>
																						<% } %>
																						</fieldset>
																					</div>
																				</fieldset>
																				<% } %>
																			</div>
																			<div class="messageContainer"></div>
																		</div>
																	</div>
																</div>
															</div>
															<div>
																<div class="row">
													 				<div class="offset-sm-5 col-sm-7">
																		<button type="button" id="subpbtn" class="btn btn-submit waves-effect waves-light m-t-10" >UPDATE</button>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												</form>
											</div>
                                		</div>
                             		</div>
                          		</form>
                       		</div>
                    	</div>
                	</div>
            	</div>
        	</div>
		</div>
	
        <!-- /.container-fluid -->
 <div id="sidebar1"> 
     <%@include file="../../../../partial/footer.jsp"%>
</div> 
</body>

</html>
<script>

$("#next").click(function(){
	 $('.active').removeClass('active').next('li').addClass('active');
    $("#vimessages1").addClass('active in');
});
function showFloorAmenity(){
	$('.active').removeClass('active').next('li').addClass('active');
    $("#vimessages2").addClass('active in');
}

$("#hidefloor").hide();
$("#project").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/admin/project/edit.jsp?project_id=<%out.print(project_id);%>";
});

$("#floor").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/admin/project/building/floor/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>";
});

$("#building").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/admin/project/building/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>";
});
$("#flat").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href = "${baseUrl}/builder/admin/project/building/floor/flat/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id); %>&flat_id=<%out.print(flat_id); %>";
});

$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() > 0 || $("#filter_building_id").val() != '' ){
			ajaxindicatorstart("Loading...");
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
						 onChange: function(value) {
							 if(value > 0 || value != '' ){
									window.location.href = "${baseUrl}/builder/admin/project/building/floor/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+value;
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
					$("#filter_floor_id").html("");
					$("#floorDetailsTab").hide();
					$("#floorDetailsTab1").html("<span class='text-danger'>Sorry No floor found..</span>");
					$("#floorDetailstab1").show();
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
				}
				 ajaxindicatorstop();
			},'json');
			//window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+value;
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
		 ajaxindicatorstart("Loading...");
		if(($("#filter_building_id").val() > 0 && $("#filter_building_id").val() != '') && ($("#filter_floor_id").val() > 0 && $("#filter_floor_id").val() != '' )){
			window.location.href = "${baseUrl}/builder/admin/project/building/floor/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+value;
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


$('#updatefloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	floor_id: {
            validators: {
                notEmpty: {
                    message: 'Floor ID is required and cannot be empty'
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
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addFloor();
});

function addFloor() {
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
	ajaxindicatorstart("Loading...");	
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/floor/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatefloor').ajaxSubmit(options);
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
		alert(resp.message);
		 ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        ajaxindicatorstop();
        $('.active').removeClass('active').next('li').addClass('active');
        $("#vimessages2").addClass('active in');
      //  window.location.href = "${baseUrl}/builder/project/building/floor/list.jsp?building_id="+$("#building_id").val();
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete plan ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/plan/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
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


function showDetailTab() {
	$('#buildingTabs a[href="#floorimages"]').tab('show');
}

$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

$("#subpbtn").click(function(){
	var amenityWeightage = [];
	var flats = [];
	var flat_id = [];
	$('input[name="stage_weightage[]"]').each(function() {
		stage_id = $(this).attr("id");
		stage_weightage = $(this).val();
		$('input[name="substage_weightage'+stage_id+'[]"]').each(function() {
			amenityWeightage.push({builderFloor:{id:$("#floor_id").val()},floorStage:{id:stage_id},stageWeightage:stage_weightage,floorSubstage:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
		});
	});
	
	$('input[name="flat_ids[]"]').each(function(index){
		flat_id.push($(this).val());
	});
	
	$('input[name="weightage[]"]').each(function(index){
		flats.push({id:flat_id[index],weightage:$(this).val()});
	});
	var floors = {id:$("#floor_id").val(),amenityWeightage : $("#amenity_weightage").val(),flatWeightage:$("#flat_weightage").val()};
	var final_data = {floorId: $("#floor_id").val(),floorWeightages:amenityWeightage, builderFloor:floors,builderFlats : flats};
	$.ajax({
	    url: '${baseUrl}/webapi/project/floor/substage/update',
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
				ajaxindicatorstart("Loading...");
				 window.location.href="${baseUrl}/builder/project/admin/building/floor/flat/edit.jsp?project_id=<%out.print(project_id); %>&building_id=<%out.print(building_id);%>&floor_id=<%out.print(floor_id);%>&flat_id=<%out.print(flat_id);%>";
			}
		},
		error : function(data)
		{
			alert("Fail to save data");
		}
		
	});
});
</script>