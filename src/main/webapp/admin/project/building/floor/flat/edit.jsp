<%@page import="org.bluepigeon.admin.model.FlatPricingDetails"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
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
<%@page import="org.bluepigeon.admin.model.FlatStage"%>
<%@page import="org.bluepigeon.admin.model.FlatSubstage"%>
<%@page import="org.bluepigeon.admin.model.FlatWeightage"%>
<%@page import="org.bluepigeon.admin.dao.FlatStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.FlatSubstagesDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../../../../../head.jsp"%>
<%@include file="../../../../../leftnav.jsp"%>
<%
	int flat_id = 0;
	int p_user_id = 0;
	int building_id = 0;
	int project_id = 0;
	int floor_id = 0;
	flat_id = Integer.parseInt(request.getParameter("flat_id"));
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
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> floors = null;
	BuilderFlat builderFlat = null;
	List<AreaUnit> areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
	List<BuilderFlat> builderFlats = new ProjectDAO().getBuildingFlatById(flat_id);
	if(builderFlats.size() > 0) {
		builderFlat = builderFlats.get(0);
		floor_id = builderFlat.getBuilderFloor().getId();
		building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
		project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
		buildings = new ProjectDAO().getBuilderProjectBuildings(project_id);
		floors = new ProjectDAO().getBuildingFloors(building_id);
		
	}
	List<BuilderFlatStatus> builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderFlatStatus();
	List<BuilderFlatAmenity> builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderActiveFlatAmenityList();
	List<FlatAmenityInfo> flatAmenityInfos = new ProjectDAO().getBuilderFlatAmenityInfos(flat_id);
	List<PaymentInfoData> flatPaymentSchedules = new ProjectDAO().getFlatPaymentSchedules(flat_id);
	List<BuilderBuildingFlatType> builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeByBuildingId(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
	List<FlatAmenityWeightage> flatAmenityWeightages = new ProjectDAO().getFlatAmenityWeightageByFlatId(flat_id);
	List<FlatStage> flatStages = new FlatStageDAO().getActiveFlatStages();
	List<FlatWeightage> flatWeightages = new ProjectDAO().getFlatWeightage(flat_id);
	List<FlatPricingDetails> buildingPriceInfo = new ProjectDAO().getFlatPriceInfos(flat_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/list.jsp">Floor</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/flat/list.jsp">Flat</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Flat Details</a></li>
			  	<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Details</a></li>
			  	<li><a data-toggle="tab" href="#productsubstage">Flat Weightage</a></li>
			</ul>
			
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
					<form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="flat_id" id="flat_id" value="<% out.print(flat_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="flat_no" name="flat_no" value="<% out.print(builderFlat.getFlatNo()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Project Name </label>
													<div class="col-sm-6">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == project_id) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<select id="building_id" name="building_id" class="form-control">
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
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Floor No. </label>
													<div class="col-sm-7">
														<select id="floor_id" name="floor_id" class="form-control">
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
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat Type <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select id="flat_type_id" name="flat_type_id" class="form-control">
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
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bedrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bedroom" name="bedroom" value="<% out.print(builderFlat.getBedroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bathrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bathroom" name="bathroom" value="<% out.print(builderFlat.getBathroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="balcony" name="balcony" value="<% out.print(builderFlat.getBalcony()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Possession Date <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="<% if(builderFlat.getPossessionDate() != null) { out.print(dt1.format(builderFlat.getPossessionDate()));}%>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Flat Status </label>
													<div class="col-sm-7">
														<select id="status" name="status" class="form-control">
															<% for(BuilderFlatStatus builderFlatStatus :builderFlatStatuses) { %>
															<option value="<% out.print(builderFlatStatus.getId());%>" <% if(builderFlat.getBuilderFlatStatus().getId() ==  builderFlatStatus.getId()) { %>selected<% } %>><% out.print(builderFlatStatus.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Status </label>
													<div class="col-sm-7">
														<select id="status_id" name="status_id" class="form-control">
															<option value="0"<%if(builderFlat.getStatus() == 0){ %>selected<%} %>>Inactive</option>
															<option value="1"<%if(builderFlat.getStatus()==1){ %>selected<%} %>>Active</option>
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
													<label class="control-label col-sm-2">Flat Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) {  
															String is_checked = "";
															for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
																if(flatAmenityInfo.getBuilderFlatAmenity().getId() == builderFlatAmenity.getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFlatAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderFlatAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Flat Amenities Weightage </label>
													<div class="col-sm-10">
													<script type="text/javascript">
														var count=1;
													</script>
														<%  int count=1;
															for(BuilderFlatAmenity builderFlatAmenity : builderFlatAmenities) { 
															String is_checked = "";
															if(flatAmenityInfos.size() > 0) { 
																for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
																	if(flatAmenityInfo.getBuilderFlatAmenity().getId() == builderFlatAmenity.getId()) {
																		is_checked = "checked";
																	}
																}
															}
															Double amenity_wt = 0.0;
															for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
																if(builderFlatAmenity.getId() == flatAmenityWeightage.getBuilderFlatAmenity().getId()) {
																	amenity_wt = flatAmenityWeightage.getAmenityWeightage();
																}
															}
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderFlatAmenity.getId());%>" style="<% if(is_checked == "checked") {%>display:block;<% } else { %>display:none;<% } %>margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderFlatAmenity.getName());%>  (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" class="form-control errorMsg" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFlatAmenity.getId());%>" placeholder="Amenity Weightage %" value="<% out.print(amenity_wt);%>">
																</div>
															</div>
															<% 	for(BuilderFlatAmenityStages bpaStages :builderFlatAmenity.getBuilderFlatAmenityStageses()) { 
																Double stage_wt = 0.0;
																for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
																	if(bpaStages.getId() == flatAmenityWeightage.getBuilderFlatAmenityStages().getId()) {
																		stage_wt = flatAmenityWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %>  (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(builderFlatAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" onkeypress=" return isNumber(event, this);" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderFlatAmenitySubstages bpaSubstage :bpaStages.getBuilderFlatAmenitySubstageses()) { 
																		Double substage_wt = 0.0;
																		for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
																			if(bpaSubstage.getId() == flatAmenityWeightage.getBuilderFlatAmenitySubstages().getId()) {
																				substage_wt = flatAmenityWeightage.getSubstageWeightage();
																			}
																		}
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="text" onkeypress=" return isNumber(event, this);" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control errorMsg" placeholder="Substage weightage  %" value="<% out.print(substage_wt);%>"/>
																		</div>
																	<% } %>
																	</fieldset>
																</div>
															</fieldset>
															<% } %>
														</div>
														<script>
															count++;
														</script>
														<% count++;} %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<span class="pull-right">
										<button type="submit" name="flooradd" class="btn btn-success btn-sm">Update</button>
									</span>
								</div>
							</div>
						</form>
					</div>
					<div id="pricing" class="tab-pane fade">
						<form id="updateprice" name="updateprice" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
			 			<div class="row">
			 				<div id="pricingresponse"></div>
							<div id="pricing_schedule">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row">
												<div class="col-lg-6">
													<input type="hidden" name="flat_id" value="<% out.print(flat_id);%>"/>
												   	<input type="hidden" name="price_id" value="<% if(buildingPriceInfo.size() > 0){ out.print(buildingPriceInfo.get(0).getId()); } else {%>0<% }%>"/>
													<div class="form-group" id="error-base_unit">
														<label class="control-label col-sm-4">Pricing Unit <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="base_unit" id="base_unit" class="form-control">
																<% if(areaUnits.size() > 0){ 
																for(AreaUnit areaUnit :areaUnits) { %>
																<option value="<% out.print(areaUnit.getId()); %>" <% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
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
															<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getBasePrice() != null){ out.print(buildingPriceInfo.get(0).getBasePrice());}%>"/>
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
															<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getMaintenance() != null){ out.print(buildingPriceInfo.get(0).getMaintenance());}%>"/>
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
																<option value="1" <% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getParkingId() == 1){ %>selected<%} %>>Open Parking</option>
																<option value="2" <% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getParkingId() == 2){ %>selected<%} %>>Shed Parking</option>
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
															<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getStampDuty() != null){ out.print(buildingPriceInfo.get(0).getStampDuty());} else {%>0<% } %>"/>
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
															<input type="text" class="form-control" id="tax" name="tax" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getTax() != null){ out.print(buildingPriceInfo.get(0).getTax());} else { %>0<% } %>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-vat">
														<label class="control-label col-sm-4">VAT </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="vat" name="vat" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getVat() != null){ out.print(buildingPriceInfo.get(0).getVat());} else { %>0<% } %>"/>
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
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tech_fee">
														<label class="control-label col-sm-4">Flat Sale value</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="sale_value" name="sale_value" value="<% if(buildingPriceInfo.size() > 0 && buildingPriceInfo.get(0).getTotalCost() != null){ out.print(buildingPriceInfo.get(0).getTotalCost());}%>" readonly/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" name="priceUpdate" id="priceupdatebtn" class="btn btn-success btn-sm" >Update</button>
								</span>
							</div>
						</div>
						</form>
					</div>
					<div id="payment" class="tab-pane fade">
						<form id="updatePayment" name="updatePayment" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(flatPaymentSchedules.size() + 1);%>"/>
						<input type="hidden" name="flat_id" value="<% out.print(flat_id);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
										
											<% for(PaymentInfoData flatPaymentSchedule : flatPaymentSchedules) { %>
											<div class="row" id="schedule-<% out.print(flatPaymentSchedule.getId());%>">
												<input type="hidden" name="payment_id[]" value="<% out.print(flatPaymentSchedule.getId()); %>" />
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" readonly id="schedule" name="schedule[]" value="<% out.print(flatPaymentSchedule.getName());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" onkeypress=" return isNumber(event, this);" name="payable[]" value="<% out.print(flatPaymentSchedule.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="amount" name="amount[]" value="<% out.print(flatPaymentSchedule.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<% } %>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" name="updatePaymentbtn" id="updatePaymentbtn" class="btn btn-success btn-sm" >Update</button>
								</span>
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
																			<input type="text" class="form-control" id="flat_amenity_weightage" name="flat_amenity_weightage" value="<%out.print(builderFlat.getAmenityWeightage());%>" onkeypress=" return isNumber(event, this);" placeholder="amenity weightage in %"/>
																		</div>
																		<div class="messageContainer"></div>
																	</div>
																</div>
															</div>
														</div>
														<div class="form-group" id="error-amenity_type">
															<div class="col-sm-12">
																<% 	for(FlatStage flatStage :flatStages) { 
																	Double stage_wt = 0.0;
																	for(FlatWeightage flatWeightage :flatWeightages) {
																		if(flatStage.getId() == flatWeightage.getFlatStage().getId()) {
																			stage_wt = flatWeightage.getStageWeightage();
																		}
																	}
																%>
																<fieldset class="scheduler-border">
																	<legend class="scheduler-border">Stages</legend>
																	<div class="col-sm-12">
																		<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(flatStage.getName()); %> (%)</b> - </label><div class="col-sm-4"><input onkeypress=" return isNumber(event, this);" name="stage_weightage[]" id="<% out.print(flatStage.getId());%>" type="text" class="form-control errorMsg" placeholder="Project Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																		<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																			<legend class="scheduler-border">Sub Stages</legend>
																		<% 	for(FlatSubstage flatSubstage :flatStage.getFlatSubstages()) { 
																			Double substage_wt = 0.0;
																			for(FlatWeightage flatWeightage :flatWeightages) {
																				if(flatSubstage.getId() == flatWeightage.getFlatSubstage().getId()) {
																					substage_wt = flatWeightage.getSubstageWeightage();
																				}
																			}
																		%>
																			<div class="col-sm-3">
																				<% out.print(flatSubstage.getName()); %> (%)<br>
																				<input type="text" onkeypress=" return isNumber(event, this);" name="substage_weightage<% out.print(flatStage.getId());%>[]" id="<% out.print(flatSubstage.getId()); %>" class="form-control errorMsg" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
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
															<button type="button" class="btn btn-success btn-sm" id="subpbtn">UPDATE</button>
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
<%@include file="../../../../../footer.jsp"%>

<!-- inline scripts related to this page -->
<style>
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
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script src="${baseUrl}/js/bootstrap-datepicker.min.js"></script>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script>
$(".errorMsg").keypress(function(event){
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
$('input[name="stage_weightage[]"]').keyup(function(){
	//alert("Value :: "+$(this).val());
// 	  var $th = $(this);
// 	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#flat_no').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#bedroom').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#bathroom').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#balcony').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#floor_no').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
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
    	flat_no: {
            validators: {
                notEmpty: {
                    message: 'Flat ID is required and cannot be empty'
                }
            }
        },
        floor_id: {
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
        bedroom:{
        	validators: {
                notEmpty: {
                    message: 'Number of bedroom is required and cannot be empty'
                }
            }
        },
        bathroom:{
        	validators: {
                notEmpty: {
                    message: 'Number of bathroom is required and cannot be empty'
                }
            }
        },
        balcony:{
        	validators: {
                notEmpty: {
                    message: 'Number of balcony is required and cannot be empty'
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
        window.location.reload();
  	}
}

$("#priceupdatebtn").click(function(){
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showPriceAddRequest,
	 		success :  showPriceAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update/price',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateprice').ajaxSubmit(options);
});
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

$("#updatePaymentbtn").click(function(){
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showPaymentSlabRequest,
	 		success :  showPaymentSlabResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update/payment',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatePayment').ajaxSubmit(options);
});
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

// function addMoreSchedule() {
// 	var schedule_count = parseInt($("#schedule_count").val());
// 	schedule_count++;
// 	var html = '<div class="row" id="schedule-'+schedule_count+'"><input type="hidden" name="payment_id[]" value="0" />'
// 				+'<hr/>'
// 				+'<div class="col-lg-5 margin-bottom-5">'
// 				+'<div class="form-group" id="error-schedule">'
// 				+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
// 				+'<div class="col-sm-8">'
// 				+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
// 				+'</div>'
// 				+'<div class="messageContainer"></div>'
// 				+'</div>'
// 				+'</div>'
// 				+'<div class="col-lg-3 margin-bottom-5">'
// 				+'<div class="form-group" id="error-payable">'
// 				+'<label class="control-label col-sm-8">% of Net Payable </label>'
// 				+'<div class="col-sm-4">'
// 				+'<input type="number" class="form-control" id="payable" name="payable[]" value=""/>'
// 				+'</div>'
// 				+'<div class="messageContainer"></div>'
// 				+'</div>'
// 				+'</div>'
// 				+'<div class="col-lg-3 margin-bottom-5">'
// 				+'<div class="form-group" id="error-amount">'
// 				+'<label class="control-label col-sm-6">Amount </label>'
// 				+'<div class="col-sm-6">'
// 				+'<input type="number" class="form-control" id="amount" name="amount[]" value=""/>'
// 				+'</div>'
// 				+'<div class="messageContainer"></div>'
// 				+'</div>'
// 				+'</div>'
// 				+'<div class="col-lg-1">'
// 				+'<span><a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs">x</a></span>'
// 				+'</div>'
// 			+'</div>';
// 	$("#payment_schedule").append(html);
// 	$("#schedule_count").val(schedule_count);
// }
// function removeSchedule(id) {
// 	$("#schedule-"+id).remove();
// }


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

$("#subpbtn").click(function(){
	var amenityWeightage = [];
	var flatAmenityWeightage = [];
	$('input[name="stage_weightage[]"]').each(function() {
		stage_id = $(this).attr("id");
		stage_weightage = $(this).val();
		$('input[name="substage_weightage'+stage_id+'[]"]').each(function() {
			amenityWeightage.push({builderFlat:{id:$("#flat_id").val()},flatStage:{id:stage_id},stageWeightage:stage_weightage,flatSubstage:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
		});
	});
	
	var final_data = {flatId: $("#flat_id").val(),amenityWeightage : $("#flat_amenity_weightage").val(),flatWeightages:amenityWeightage}
	$.ajax({
	    url: '${baseUrl}/webapi/project/flat/substage/update',
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

</script>
</body>
</html>
