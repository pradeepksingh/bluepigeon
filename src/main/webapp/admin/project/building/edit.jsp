<%@page import="org.bluepigeon.admin.dao.BuilderProjectOfferInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectOfferInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPaymentInfo"%>
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
<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="org.bluepigeon.admin.model.BuildingSubstage"%>
<%@page import="org.bluepigeon.admin.model.BuildingWeightage"%>
<%@page import="org.bluepigeon.admin.data.BuildingPriceInfoData"%>
<%@page import="org.bluepigeon.admin.model.Tax"%>
<%@page import="org.bluepigeon.admin.dao.BuildingStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuildingSubstagesDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	ServletContext webcontext = pageContext.getServletContext();
	int building_id = 0;
	int project_id = 0;
	int p_user_id = 0;
	List<BuilderProjectOfferInfo> builderProjectOfferInfos = null;
	building_id = Integer.parseInt(request.getParameter("building_id"));
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
	}
	BuilderBuilding builderBuilding = null;
	List<BuildingPriceInfoData> buildingPriceInfo = new ArrayList<BuildingPriceInfoData>();
	List<Tax> taxes = null;
	List<BuilderBuilding> builderBuildings = new ProjectDAO().getBuilderProjectBuildingById(building_id);
	if(builderBuildings.size() > 0) {
		builderBuilding = builderBuildings.get(0);
	}
	List<AreaUnit> areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
	List<BuilderBuildingStatus> builderBuildingStatusList = new BuilderBuildingStatusDAO().getBuilderBuildingStatus();
	List<BuilderBuildingAmenity> builderBuildingAmenities = new BuilderBuildingAmenityDAO().getBuilderActiveBuildingAmenityList();
	List<BuildingImageGallery> buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
	List<BuildingPanoramicImage> buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
	List<BuildingAmenityInfo> buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
	List<PaymentInfoData> buildingPaymentInfos = new ProjectDAO().getBuildingPaymentInfoById(building_id);
	List<BuildingOfferInfo> buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
	List<BuildingAmenityWeightage> buildingAmenityWeightages = new ProjectDAO().getBuilderBuildingAmenityWeightageById(building_id);
	List<BuildingStage> buildingStages = new BuildingStageDAO().getActiveBuildingStages();
	List<BuildingWeightage> buildingWeightages = new ProjectDAO().getBuildingWeightage(building_id);
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingFloors(builderBuilding.getId());
	if(building_id > 0){
		 project_id = builderBuildings.get(0).getBuilderProject().getId();
		buildingPriceInfo = new ProjectDAO().getBuilderBuildingPriceInfo(building_id);
		BuilderProject builderProject = new ProjectDAO().getBuilderProjectById(project_id);
		builderProjectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
		if(builderProject.getPincode() != "" && builderProject.getPincode() != null) {
			taxes = new ProjectDAO().getProjectTaxByPincode(builderProject.getPincode());
		}
	}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li class="active">Update</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp"> << Project List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#buildingdetail">Building Images</a></li>
			  	<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			  	<li><a data-toggle="tab" href="#productsubstage">Building Weightage</a></li>
			</ul>
			<div class="tab-content">
				<div id="basic" class="tab-pane fade in active">
					<form id="updatebuilding" name="updatebuilding" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div id="basicresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
										<input type="hidden" name="project_id" id ="project_id" value="<%out.print(project_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Project Name <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select id="project_id" name="project_id" class="form-control" disabled>
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderBuilding.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Building Name </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderBuilding.getName()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Total Floors </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="total_floor" name="total_floor" value="<% out.print(builderBuilding.getTotalFloor());%>"/>
													</div>
													<div class="messageContainer col-sm-offset-5"></div>
												</div>
											</div>
											<% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Launch Date <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="launch_date" name="launch_date" value="<% if(builderBuilding.getLaunchDate() != null) { out.print(dt1.format(builderBuilding.getLaunchDate()));}%>"/>
													</div>
													<div class="messageContainer col-sm-offset-5"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Possession Date </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="<% if(builderBuilding.getPossessionDate() != null) { out.print(dt1.format(builderBuilding.getPossessionDate()));}%>"/>
													</div>
													<div class="messageContainer col-sm-offset-5"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Building Status </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<% 	for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
															<option value="<% out.print(builderBuildingStatus.getId());%>" <% if(builderBuildingStatus.getId() == builderBuilding.getBuilderBuildingStatus().getId()) { %>selected<% } %>><% out.print(builderBuildingStatus.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Status </label>
													<div class="col-sm-4">
														<select id="status_id" name="status_id" class="form-control">
															<option value="0"<%if(builderBuilding.getStatus()==0){ %>selected<%} %>>Inactive</option>
															<option value="1"<%if(builderBuilding.getStatus()==1){ %>selected<%} %>>Active</option>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-12">
												<hr/>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Building Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderBuildingAmenity builderBuildingAmenity :builderBuildingAmenities) {  
															String is_selected = "";
															if(buildingAmenityInfos.size() > 0) { 
																for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
																	if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
																		is_selected = "checked";
																	}
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderBuildingAmenity.getId());%>" <% out.print(is_selected); %>/> <% out.print(builderBuildingAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Building Amenities Weightage </label>
													<div class="col-sm-10">
														<% 	for(BuilderBuildingAmenity builderBuildingAmenity : builderBuildingAmenities) { 
															String is_checked = "";
															if(buildingAmenityInfos.size() > 0) { 
																for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
																	if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
																		is_checked = "checked";
																	}
																}
															}
															Double amenity_wt = 0.0;
															for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
																if(builderBuildingAmenity.getId() == buildingAmenityWeightage.getBuilderBuildingAmenity().getId()) {
																	amenity_wt = buildingAmenityWeightage.getAmenityWeightage();
																}
															}
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderBuildingAmenity.getId());%>" style="<% if(is_checked == "checked") {%>display:block;<% } else { %>display:none;<% } %>margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderBuildingAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" class="form-control errorMsg" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderBuildingAmenity.getId());%>" placeholder="Amenity Weightage" onkeypress=" return isNumber(event, this);" value="<% out.print(amenity_wt);%>">
																</div>
															</div>
															<% 	for(BuilderBuildingAmenityStages bpaStages :builderBuildingAmenity.getBuilderBuildingAmenityStageses()) { 
																Double stage_wt = 0.0;
																for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
																	if(bpaStages.getId() == buildingAmenityWeightage.getBuilderBuildingAmenityStages().getId()) {
																		stage_wt = buildingAmenityWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input onkeypress=" return isNumber(event, this);" name="stage_weightage<% out.print(builderBuildingAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderBuildingAmenitySubstages bpaSubstage :bpaStages.getBuilderBuildingAmenitySubstageses()) { 
																		Double substage_wt = 0.0;
																		for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
																			if(bpaSubstage.getId() == buildingAmenityWeightage.getBuilderBuildingAmenitySubstages().getId()) {
																				substage_wt = buildingAmenityWeightage.getSubstageWeightage();
																			}
																		}
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="text" onkeypress=" return isNumber(event, this);" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control errorMsg" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
																		</div>
																	<% } %>
																	</fieldset>
																</div>
															</fieldset>
															<% } %>
														</div>
														<% } %>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="basicdetail" class="btn btn-success btn-sm" >SAVE</button>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div id="buildingdetail" class="tab-pane fade">
					<form id="updateimage" name="updateimage" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div id="imageresponse"></div>
							<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
							<input type="hidden" name="img_count" id="img_count" value="2"/>
							<input type="hidden" name="elvimg_count" id="elvimg_count" value="2"/>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Building Images</h3>
										<br>
										<div class="row" id="project_images">
											<div class="col-lg-4 margin-bottom-5">
											<% if(builderBuilding != null) { %>
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(builderBuilding.getImage()); %>" width="200px;">
													</div>
												</div>
											
											<% } %>
											</div>
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id="building_image" name="building_image[]" />
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
									<button type="button" name="imagebtn" class="btn btn-success btn-sm" onclick="updateBuildingImages();">SAVE</button>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div id="pricing" class="tab-pane fade">
					<form id="updatepricing" name="updatepricing" action="" method="post" class="form-horizontal" >
						<input type="hidden" name="building_id" value="<% out.print(building_id);%>"/>
			 			<div class="row">
			 				<div id="pricingresponse"></div>
			 				<div id="price_schedule">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row">
												<div class="col-lg-6">
												   <input type="hidden" name="id" value="<% if(buildingPriceInfo.size() > 0){ out.print(buildingPriceInfo.get(0).getId()); } else {%>0<% }%>"/>
													<div class="form-group" id="error-base_unit">
														<label class="control-label col-sm-4">Pricing Unit <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="base_unit" id="base_unit" class="form-control">
																<%	if(areaUnits.size() > 0){ 
																for(AreaUnit areaUnit :areaUnits) { %>
																<option value="<% out.print(areaUnit.getId()); %>" <% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getUnitId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
																<% }} %>
															</select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-base_rate">
														<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getBaseRate() != null){ out.print(buildingPriceInfo.get(0).getBaseRate());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-rise_rate">
														<label class="control-label col-sm-4">Floor Rise Rate</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getRiseRate() != null){ out.print(buildingPriceInfo.get(0).getRiseRate());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-post">
														<label class="control-label col-sm-4">Applicable Post </label>
														<div class="col-sm-8 input-group" style="padding: 0px 12px;">
															<input type="text" class="form-control" id="post" name="post" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getPost() != 0){ out.print(buildingPriceInfo.get(0).getPost());}%>"/>
															<span class="input-group-addon">floor</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-maintenance">
														<label class="control-label col-sm-4">Maintenance Charge </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getMaintainance() != null){ out.print(buildingPriceInfo.get(0).getMaintainance());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tenure">
														<label class="control-label col-sm-4">Tenure </label>
														<div class="col-sm-8 input-group" style="padding: 0px 12px;">
															<input type="text" class="form-control" id="tenure" name="tenure" value="<%if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getTenure() != 0){ out.print(buildingPriceInfo.get(0).getTenure()); } %>"/>
															<span class="input-group-addon">Months</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-amenity_rate">
														<label class="control-label col-sm-4">Amenities Facing Rate</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getAmenityRate() != null){ out.print(buildingPriceInfo.get(0).getAmenityRate());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-landmark">
														<label class="control-label col-sm-4">Parking Type </label>
														<div class="col-sm-8">
															<select id="parking_id" name="parking_id" class="form-control">
																<option value="0">Select Parking Type</option>
																<option value="1">Open Parking</option>
																<option value="2">Shed Parking</option>
															</select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-landmark">
														<label class="control-label col-sm-4">Parking</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="parking" name="parking" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getParking() != null){ out.print(buildingPriceInfo.get(0).getParking());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-landmark">
														<label class="control-label col-sm-4">Stamp Duty </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getStampDuty() != null){ out.print(buildingPriceInfo.get(0).getStampDuty());} else {if(taxes.size() > 0){out.print(taxes.get(0).getStampDuty());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tax">
														<label class="control-label col-sm-4">Tax</label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="tax" name="tax" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getTax() != null){ out.print(buildingPriceInfo.get(0).getTax());} else {if(taxes.size() > 0){out.print(taxes.get(0).getTax());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-vat">
														<label class="control-label col-sm-4">VAT </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="vat" name="vat" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getVat() != null){ out.print(buildingPriceInfo.get(0).getVat());} else {if(taxes.size() > 0){out.print(taxes.get(0).getVat());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tech_fee">
														<label class="control-label col-sm-4">Tech Fees</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getFee() != null){ out.print(buildingPriceInfo.get(0).getFee());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-6 margin-bottom-5">
								<div class="col-sm-12">
									<button type="submit" class="btn btn-success btn-sm" id="pricebtn">SAVE</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="payment" class="tab-pane fade">
					<form id="updatepayment" name="updatepayment" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="schedule_count" id="schedule_count" value="100000000000"/>
						<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% for(PaymentInfoData buildingPaymentInfo : buildingPaymentInfos) { %>
											<div class="row" id="schedule-<% out.print(buildingPaymentInfo.getId());%>">
												<input type="hidden" name="payment_id[]" value="<% out.print(buildingPaymentInfo.getId()); %>" />
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<% out.print(buildingPaymentInfo.getName());%>"/>
														</div>
														<div class="messageContainer col-sm-offset-6"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" onkeypress=" return isNumber(event, this);"  id="payable" name="payable[]" value="<% out.print(buildingPaymentInfo.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<!-- <div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" onkeypress=" return isNumber(event, this);" name="amount[]" value="<% out.print(buildingPaymentInfo.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>-->
											</div>
											<% } %>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="submit" name="paymentbtn" class="btn btn-success btn-sm" id="paymentbtn" >SAVE</button>
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
					<form id="updateoffer" name="updateoffer" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="offer_count" id="offer_count" value="1000000000000"/>
						<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
			 			<div class="row">
			 				<div id="offerresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="project_offer_area">
											<%  if(builderProjectOfferInfos != null){
												for(BuilderProjectOfferInfo projectOfferInfo :builderProjectOfferInfos) { 
											%>
											<div class="row" id="offer-<% out.print(projectOfferInfo.getId()); %>">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="project_offer_title" readonly="true" name="project_offer_title[]" value="<% out.print(projectOfferInfo.getTitle()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
	 													<label class="control-label col-sm-6">Offer Type </label>
														<div class="col-sm-6">
															<select class="form-control" id="project_offer_type"  disabled  name="proejct_offer_type[]">
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
														<label class="control-label col-sm-6">Discount Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" readonly="true" id="project_discount_amount"  name="project_discount_amount[]" value="<%if(projectOfferInfo.getAmount()!=null){ out.print(projectOfferInfo.getAmount());} %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Description </label>
														<div class="col-sm-8">
															<textarea class="form-control" id="project_description" readonly="true" name="proejct_description[]" ><% if(projectOfferInfo.getDescription() != null) { out.print(projectOfferInfo.getDescription());} %></textarea>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
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
											<% } }%>
										</div>
										<div id="offer_area">
											<% int j=0; 
											for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { %>
											<div class="row" id="offer-<% out.print(buildingOfferInfo.getId()); %>">
												<input type="hidden" id="offer_id" name="offer_id[]" value="<% out.print(buildingOfferInfo.getId()); %>" />
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(buildingOfferInfo.getId()); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="row">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="offer_title<%out.print(j); %>" name="offer_title[]" value="<% out.print(buildingOfferInfo.getTitle()); %>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-6">Offer Type </label>
														<div class="col-sm-6">
															<select class="form-control" id="offer_type<%out.print(j); %>" onchange="txtEnabaleDisable(<%out.print(j); %>);" name="offer_type[]">
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
														<label class="control-label col-sm-6">Discount Amount </label>
														<div class="col-sm-6">
															<div>
																<input type="text" class="form-control"   <%if(buildingOfferInfo.getType() == 3){ %> disabled <%} %>id="discount_amount<%out.print(j); %>" onkeyup=" javascript:onlyNumber(<%out.print(j); %>);" name="discount_amount[]" value="<% out.print(buildingOfferInfo.getAmount()); %>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Description </label>
														<div class="col-sm-8">
															<textarea class="form-control" id="description" name="description[]" ><% out.print(buildingOfferInfo.getDescription()); %></textarea>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
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
														<button type="button" class="btn btn-success btn-sm" id="offerbtn" onclick="updateBuildingOffers();">SAVE</button>
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
																		<input type="text" class="form-control" id="amenity_weightage" name="amenity_weightage" value="<%out.print(builderBuilding.getAmenityWeightage());%>" placeholder="amenity weightage in %"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="row" id="error-amenity_type">
															<div class="col-sm-6">
																<div class="form-group" id="error-discount_amount">
																	<label class="control-label col-sm-6">Floor Weightage</label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control"  id="floor_weightage" name="floor_weightage" value="<%out.print(builderBuilding.getFloorWeightage());%>"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="col-sm-12">
															<label class="control-label col-sm-6">Floors</label>
														</div>
														<%
														  if(builderFloors != null){
															  for(BuilderFloor builderFloorList : builderFloors ){
														%>
														<input type="hidden" id="floor_ids" name="floor_ids[]" value="<%out.print(builderFloorList.getId());%>">
														<div class="col-sm-4 margin-bottom-5">
															<div class="form-group" id="error-discount_amount">
																<label class="control-label col-sm-6"><%out.print(builderFloorList.getName()); %></label>
																<div class="col-sm-6">
																	<input type="text"  onkeypress=" return isNumber(event, this);" class="form-control errorMsg" id="weightage[]" name="weightage[]" value="<%out.print(builderFloorList.getWeightage());%>"/>
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
															<% 	for(BuildingStage buildingStage :buildingStages) { 
																Double stage_wt = 0.0;
																for(BuildingWeightage buildingWeightage :buildingWeightages) {
																	if(buildingStage.getId() == buildingWeightage.getBuildingStage().getId()) {
																		stage_wt = buildingWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(buildingStage.getName()); %> (%)</b> - </label><div class="col-sm-4"><input  onkeypress=" return isNumber(event, this);" name="stage_weightage[]" id="<% out.print(buildingStage.getId());%>" type="text" class="form-control" placeholder="Project Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuildingSubstage buildingSubstage :buildingStage.getBuildingSubstages()) { 
																		Double substage_wt = 0.0;
																		for(BuildingWeightage buildingWeightage :buildingWeightages) {
																			if(buildingSubstage.getId() == buildingWeightage.getBuildingSubstage().getId()) {
																				substage_wt = buildingWeightage.getSubstageWeightage();
																			}
																		}
																	%>
																		<div class="col-sm-3">
																			<% out.print(buildingSubstage.getName()); %> (%)<br>
																			<input type="text" onkeypress=" return isNumber(event, this);"  name="substage_weightage<% out.print(buildingStage.getId());%>[]" id="<% out.print(buildingSubstage.getId()); %>" class="form-control" onkeypress="alert(hi);" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
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
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<script src="../../../js/bootstrapValidator.min.js"></script>
<script src="../../../js/bootstrap-datepicker.min.js"></script>
<script src="../../../js/jquery.form.js"></script>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<style>
.messageContainer {
	padding-left:15px;
}
	.row {
		margin-bottom:5px;
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
<script>
$('#launch_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updatebuilding').data('bootstrapValidator').revalidateField('launch_date');
});
$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updatebuilding').data('bootstrapValidator').revalidateField('possession_date');
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9- ]/g, function(str) { alert('Please use only letters and numbers.'); return ''; } ) );
});
$('#total_floor').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
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
$('#amenity_weightage').keypress(function (event) {
    return isNumber(event, this)
});
$('#floor_weightage').keypress(function (event) {
    return isNumber(event, this)
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
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode
//    	if($(element).hasClass('errorMsg')){
//    		alert("Hello");
//    	}
    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
}   


function onlyNumber(id){
	
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only letters and numbers.'); return ''; } ) );
}

function notEmpty(){
	alert($(this).val());
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
        		numeric: {
        			message: 'Maintenance is invalid'
        		}
            }
        },
        tenure: {
            validators: {
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
        		}
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuildingPricing();
});

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
        total_floor:{
        	 validators: {
                 notEmpty: {
                     message: 'Total number of floors is required and cannot be empty'
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
	updateProjectBuilding();
});

function updateProjectBuilding() {
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
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/info/update',
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
function txtEnabaleDisable(id){
	$th = $("#offer_type"+id).val();
	alert
	 if($th == 3){
	  	$('#discount_amount'+id).attr('disabled', true);
	 }else{
		$('#discount_amount'+id).attr('disabled', false); 
	 }
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


function updateBuildingImages() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddImageRequest,
	 		success :  showAddImageResponse,
	 		url : '${baseUrl}/webapi/project/building/image/update',
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
  	}
}

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

function showDetailTab() {
	$('#buildingTabs a[href="#buildingdetail"]').tab('show');
}

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
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
					+'<input type="text" class="form-control errorMsg" id="discount_amount'+offers+'" onkeyup="javascript:onlyNumber('+offers+');" name="discount_amount[]" value=""/>'
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
				+'<input type="text" class="form-control errorMsg" id="payable" name="payable[]"  value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="text" class="form-control errorMsg" id="amount" name="amount[]" value=""/>'
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

$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

$("#subpbtn").click(function(){
	var amenityWeightage = [];
	$('input[name="stage_weightage[]"]').each(function() {
		stage_id = $(this).attr("id");
		stage_weightage = $(this).val();
		$('input[name="substage_weightage'+stage_id+'[]"]').each(function() {
			amenityWeightage.push({builderBuilding:{id:$("#building_id").val()},buildingStage:{id:stage_id},stageWeightage:stage_weightage,buildingSubstage:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
		});
	});
	var floors = [];
	var floor_id = [];
	$('input[name="floor_ids[]"]').each(function(index){
		floor_id.push($(this).val());
	});
	$('input[name="weightage[]"]').each(function(index){
		floors.push({id:floor_id[index],weightage:$(this).val()});
	});
	var buildings = {id:$("#building_id").val(), amenityWeightage : $("#amenity_weightage").val(),floorWeightage:$("#floor_weightage").val()};
	var final_data = {buildingId: $("#building_id").val(),buildingWeightages:amenityWeightage, builderBuilding : buildings, builderFloors : floors}
	$.ajax({
	    url: '${baseUrl}/webapi/project/building/substage/update',
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
//});

</script>
</body>
</html>
