<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.BuildingPriceInfo"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
<%@page import="org.bluepigeon.admin.model.BuildingPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenitySubstages"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../../head.jsp"%>
<%@include file="../../../../../leftnav.jsp"%>
<%
	int floor_id = 0;
	int p_user_id = 0;
	int building_id = 0;
	int project_id = 0;
	List<BuildingPaymentInfo> buildingPaymentInfos = null;
	floor_id = Integer.parseInt(request.getParameter("floor_id"));
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
	BuilderFloor builderFloor = null;
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> floors = null;
	List<PaymentInfoData> paymentInfoDatas = null;
	List<BuilderBuildingFlatType> builderFlatTypes = null;
	List<AreaUnit> areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingFloorById(floor_id);
	List<BuildingPriceInfo> buildingPriceInfo = new ArrayList<BuildingPriceInfo>();
	if(builderFloors.size() > 0) {
		builderFloor = builderFloors.get(0);
		building_id = builderFloor.getBuilderBuilding().getId();
		project_id = builderFloor.getBuilderBuilding().getBuilderProject().getId();
		buildings = new ProjectDAO().getBuilderProjectBuildings(builderFloor.getBuilderBuilding().getBuilderProject().getId());
		floors = new ProjectDAO().getBuildingFloors(builderFloor.getBuilderBuilding().getId());
		builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeByBuildingId(builderFloor.getBuilderBuilding().getId());
		buildingPaymentInfos = new ProjectDAO().getBuilderBuildingPaymentInfoById(building_id);
		buildingPriceInfo = new ProjectDAO().getBuildingPriceInfos(building_id);
	}
	if(floor_id > 0){
		paymentInfoDatas =  new ProjectDAO().getFlatPaymnetbyFloorId(floor_id);
	}
	List<BuilderFlatStatus> builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderFlatStatus();
	List<BuilderFlatAmenity> builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderActiveFlatAmenityList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
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
				<li class="active">Add</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Add 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Flat Details</a></li>
			  	<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Details</a></li>
			</ul>
			<form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="flat_no" name="flat_no" value="" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
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
													<div class="messageContainer col-sm-offset-4"></div>
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
													<div class="messageContainer col-sm-offset-4"></div>
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
															<option value="<% out.print(builderFlatType.getBuilderFlatType().getId());%>"><% out.print(builderFlatType.getBuilderFlatType().getName());%></option>
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
														<input type="text" class="form-control" id="bedroom" name="bedroom" value="" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bathrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bathroom" name="bathroom" value="" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="balcony" name="balcony" value="" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Possession Date <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="" />
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
															<option value="<% out.print(builderFlatStatus.getId());%>"><% out.print(builderFlatStatus.getName()); %></option>
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
															<option value="0">Inactive</option>
															<option value="1">Active</option>
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
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) {  %>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFlatAmenity.getId());%>" /> <% out.print(builderFlatAmenity.getName());%>
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
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) { 
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderFlatAmenity.getId());%>" style="display:none;margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderFlatAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" class="form-control errorMsg" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFlatAmenity.getId());%>" placeholder="Amenity Weightage" value="">
																</div>
															</div>
															<% 	for(BuilderFlatAmenityStages bpaStages :builderFlatAmenity.getBuilderFlatAmenityStageses()) { 
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(builderFlatAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value=""/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderFlatAmenitySubstages bpaSubstage :bpaStages.getBuilderFlatAmenitySubstageses()) { 
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="text" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control errorMsg" placeholder="Substage weightage" value=""/>
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
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<span class="pull-right">
										<button type="submit" name="flooradd" class="btn btn-success btn-sm">Submit</button>
									</span>
								</div>
							</div>
						</div>
					
						<div id="pricing" class="tab-pane fade">
					
			 			<div class="row">
			 				<div id="pricingresponse"></div>
							<div id="pricing_schedule">
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
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="flooradd" class="btn btn-success btn-sm" >Submit</button>
								</span>
							</div>
						</div>
					</div>
					<div id="payment" class="tab-pane fade">
					
						<input type="hidden" name="schedule_count" id="schedule_count" value="1"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div id="payment_schedule">
								<div class="panel panel-default">
									<div class="panel-body">
									<%
									if(buildingPaymentInfos != null){
										if(buildingPaymentInfos.size() > 0){
											for(BuildingPaymentInfo paymentInfoData: buildingPaymentInfos){ %>
										<div class="col-lg-12">
											<div class="row" id="schedule-1">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<%out.print(paymentInfoData.getMilestone());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control errorMsg" id="payable" name="payable[]" value="<%out.print(paymentInfoData.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<!-- div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control errorMsg" id="amount" name="amount[]" value="<%out.print(paymentInfoData.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div-->
											</div>
										</div>
										<%	
												}
											}
										}
										%>
										
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="flooradd" class="btn btn-success btn-sm" >Submit</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
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
	format: "dd MM yyyy"
});
/*$("#floor_id").change(function(){
	$("#payment_schedule").empty();
    var html = "";
	var floor_id = $("#floor_id").val();
	$.get("${baseUrl}/webapi/project/building/floor/flat/payments/"+floor_id, { }, function(data){
		$(data).each(function(index){
			console.log(data[index].name);
		
			
		html=+'<div class="col-lg-12">'
			+'<div class="panel panel-default">'
			+'<div class="panel-body">'
			+'<div id="payment_schedule">'
			+'<div class="row" id="schedule-1">'
			+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-schedule">'
			+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
			+'<div class="col-sm-8">'
			+'<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="'+data[index].name+'"/>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
			+'</div>'
			+'<div class="col-lg-3 margin-bottom-5">'
			+'<div class="form-group" id="error-payable">'
			+'<label class="control-label col-sm-8">% of Net Payable </label>'
			+'<div class="col-sm-4">'
			+'<input type="number" class="form-control" id="payable" name="payable[]" value="'+data[index].payable+'"/>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
			+'</div>'
			+'<div class="col-lg-3 margin-bottom-5">'
			+'<div class="form-group" id="error-amount">'
			+'<label class="control-label col-sm-6">Amount </label>'
			+'<div class="col-sm-6">'
			+'<input type="number" class="form-control" id="amount" name="amount[]" value="'+data[index].amount+'"/>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
			+'</div>'
			+'</div>'
			+'</div>'
			+'</div>'
			+'</div>';
		
		});
		html = html.replace("NaN","");
		$("#paymentresponse").html(html);
	});

});*/
$('#addfloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	building_id: {
            validators: {
                notEmpty: {
                    message: 'Building ID is required and cannot be empty'
                }
            }
        },
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
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/add',
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
        window.location.href = "${baseUrl}/admin/project/building/floor/flat/list.jsp?floor_id="+$("#floor_id").val();
  	}
}


function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	alert(schedule_count);
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
				+'<input type="number" class="form-control" id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="number" class="form-control" id="amount" name="amount[]" value=""/>'
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
</script>
</body>
</html>
