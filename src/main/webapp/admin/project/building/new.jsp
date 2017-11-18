<%@page import="org.bluepigeon.admin.dao.BuilderProjectOfferInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectOfferInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPaymentInfo"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPaymentInfoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.Tax"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPriceInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPriceInfo"%>
<%@page import="org.bluepigeon.admin.data.PaymentInfoData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	int project_id = 0;
	int p_user_id = 0;
	List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = null;
	BuilderProjectPriceInfo projectPriceInfo = null;
	List<BuilderProjectOfferInfo> builderProjectOfferInfos = null;
	List<Tax> taxes = new ArrayList<Tax>();
	project_id = Integer.parseInt(request.getParameter("project_id"));
	session = request.getSession(false);
	String taxLabel1 = "";
	String taxLabel2 = "";
	String taxLabel3 = "";
	AdminUser adminuserproject = new AdminUser();
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
	}
	List<AreaUnit> areaUnits = new AreaUnitDAO().getActiveAreaUnitList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
	List<BuilderBuildingStatus> builderBuildingStatusList = new BuilderBuildingStatusDAO().getBuilderBuildingStatus();
	List<BuilderBuildingAmenity> builderBuildingAmenities = new BuilderBuildingAmenityDAO().getBuilderActiveBuildingAmenityList();
	if(project_id > 0){
	    builderProjectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(project_id);
		projectPriceInfo = new BuilderProjectPriceInfoDAO().getBuilderProjectPriceInfo(project_id);
		BuilderProject builderProject = new ProjectDAO().getBuilderProjectById(project_id);
		builderProjectOfferInfos = new BuilderProjectOfferInfoDAO().getBuilderProjectOfferInfo(project_id);
		if(builderProject.getPincode() != "" && builderProject.getPincode() != null) {
			taxes = new ProjectDAO().getProjectTaxByPincode(builderProject.getPincode());
		}
		taxLabel1 = builderProject.getCountry().getTaxLabel1();
		taxLabel2 = builderProject.getCountry().getTaxLabel2();
		taxLabel3 = builderProject.getCountry().getTaxLabel3();
	}
	
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li class="active">Add</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp"> << Project List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Add 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#buildingdetail">Building Images</a></li>
		  		<li><a data-toggle="tab" href="#pricing">Pricing Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			</ul>
			<form id="addbuilding" name="addbuilding" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<input type="hidden" name="elvimg_count" id="elvimg_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Project Name <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select id="project_id" name="project_id" class="form-control" disabled>
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == project_id) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
														<input type="hidden" id="project_id" name="project_id" value="<%out.print(project_id);%>"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<div>
															<input type="text" class="form-control" id="name" name="name" />
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Total Floors </label>
													<div class="col-sm-6">
														<div>
															<input type="text" class="form-control" id="total_floor" name="total_floor" />
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Launch Date <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<div>
															<input type="text" class="form-control" id="launch_date" name="launch_date"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Possession Date </label>
													<div class="col-sm-7">
														<div>
															<input type="text" class="form-control" id="possession_date" name="possession_date" />
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Building Status </label>
													<div class="col-sm-6">
														<select id="status" name="status" class="form-control">
															<% for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
															<option value="<% out.print(builderBuildingStatus.getId());%>"><% out.print(builderBuildingStatus.getName()); %></option>
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
													<label class="control-label col-sm-2">Building Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderBuildingAmenity builderBuildingAmenity :builderBuildingAmenities) {  %>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderBuildingAmenity.getId());%>" /> <% out.print(builderBuildingAmenity.getName());%>
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
														<% 	for(BuilderBuildingAmenity builderBuildingAmenity :builderBuildingAmenities) { 
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderBuildingAmenity.getId());%>" style="display:none;margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderBuildingAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" class="form-control errorMsg" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderBuildingAmenity.getId());%>" placeholder="Amenity Weightage" value="">
																</div>
															</div>
															<% 	for(BuilderBuildingAmenityStages bpaStages :builderBuildingAmenity.getBuilderBuildingAmenityStageses()) { 
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(builderBuildingAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value=""/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderBuildingAmenitySubstages bpaSubstage :bpaStages.getBuilderBuildingAmenitySubstageses()) { 
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
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" class="btn btn-success btn-sm" onclick="showDetailTab();">Next</button>
								</span>
							</div>
						</div>
					</div>
					<div id="buildingdetail" class="tab-pane fade">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Building Image</h3>
										<br>
										<div class="row" id="project_images">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8">
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
									<button type="button" class="btn btn-success btn-sm" onclick="show2();">Next</button>
								</span>
							</div>
						</div>
					</div>
					<div id="pricing" class="tab-pane fade">
			 			<div class="row">
			 				<div id="pricingresponse"></div>
			 				<div id="ajaxpricing"></div>
			 				<%if(projectPriceInfo != null){ %>
			 				<div id="price_schedule">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row">
												<div class="col-lg-6">
												   <input type="hidden" name="id" value="<% out.print(projectPriceInfo.getId());%>"/>
													<div class="form-group" id="error-base_unit">
														<label class="control-label col-sm-4">Pricing Unit <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="base_unit" id="base_unit" class="form-control">
																<%	if(projectPriceInfo.getAreaUnit() != null){ 
																for(AreaUnit areaUnit :areaUnits) { %>
																<option value="<% out.print(areaUnit.getId()); %>" <% if(projectPriceInfo.getAreaUnit().getId() == areaUnit.getId()) { %>selected<% } %>><% out.print(areaUnit.getName()); %></option>
																<% }} %>
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
														<div class="messageContainer col-sm-offset-4"></div>
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
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-post">
														<label class="control-label col-sm-4">Applicable Post </label>
														<div class="col-sm-8 input-group" style="padding: 0px 12px;">
															<input type="text" class="form-control" id="post" name="post" value="<% if(projectPriceInfo.getPost() != null){ out.print(projectPriceInfo.getPost());}%>"/>
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
															<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% if(projectPriceInfo.getMaintenance() != null){ out.print(projectPriceInfo.getMaintenance());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tenure">
														<label class="control-label col-sm-4">Tenure </label>
														<div class="col-sm-8 input-group" style="padding: 0px 12px;">
															<input type="text" class="form-control" id="tenure" name="tenure" value="<% out.print(projectPriceInfo.getTenure());%>"/>
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
															<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% if(projectPriceInfo.getAmenityRate() != null){ out.print(projectPriceInfo.getAmenityRate());}%>"/>
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
															<input type="text" class="form-control" id="parking" name="parking" value="<% if(projectPriceInfo.getParking() != null){ out.print(projectPriceInfo.getParking());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<%if(taxLabel1.trim().length() != 0 && taxLabel1 != null){ %>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-landmark">
														<label class="control-label col-sm-4"><%out.print(taxLabel1); %>  </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% if(projectPriceInfo.getStampDuty() != null){ out.print(projectPriceInfo.getStampDuty());} else {if(taxes.size() > 0){out.print(taxes.get(0).getStampDuty());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<%}else{ %>
													<input type="hidden"  id="stamp_duty" name="stamp_duty" value="0"/>
												<%} %>
											</div>
											<div class="row">
											<%if(taxLabel2.trim().length() != 0 && taxLabel2 != null){ %>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tax">
														<label class="control-label col-sm-4"><%out.print(taxLabel2); %> </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="tax" name="tax" value="<% if(projectPriceInfo.getTax() != null){ out.print(projectPriceInfo.getTax());} else {if(taxes.size() > 0){out.print(taxes.get(0).getTax());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<%}else{ %>
													<input type="hidden"  id="tax" name="tax" value="0"/>
												<%} %>
												<%if(taxLabel3.trim().length() != 0 && taxLabel3 != null){ %>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-vat">
														<label class="control-label col-sm-4"><%out.print(taxLabel3); %>  </label>
														<div class="col-sm-8 input-group"  style="padding: 0px 12px;">
															<input type="text" class="form-control" id="vat" name="vat" value="<% if(projectPriceInfo.getVat() != null){ out.print(projectPriceInfo.getVat());} else {if(taxes.size() > 0){out.print(taxes.get(0).getVat());}}%>"/>
															<span class="input-group-addon">%</span>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<%}else{ %>
													<input type="hidden"  id="vat" name="vat" value="0"/>
												<%} %>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-tech_fee">
														<label class="control-label col-sm-4">Tech Fees</label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="tech_fee" name="tech_fee" value="<% if(projectPriceInfo.getFee() != null){ out.print(projectPriceInfo.getFee());}%>"/>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<%} %>
							<div class="col-lg-6 margin-bottom-5">
								<div class="col-sm-12">
									<button type="button" class="btn btn-success btn-sm" onclick="show3();" id="pricebtn">Next</button>
								</div>
							</div>
						</div>
					</div>
					<div id="payment" class="tab-pane fade">
						<input type="hidden" name="schedule_count" id="schedule_count" value="1"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
			 				<% if(builderProjectPaymentInfos != null){
								for(BuilderProjectPaymentInfo builderProjectPaymentInfo: builderProjectPaymentInfos){%>
			 				<div id="payment_schedule">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row" id="schedule-1">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<%out.print(builderProjectPaymentInfo.getSchedule());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control errorMsg" id="payable" name="payable[]" value="<%out.print(builderProjectPaymentInfo.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
										<div>
<!-- 											<div class="col-lg-12"> -->
<!-- 												<span class="pull-right"> -->
<!-- 													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a> -->
<!-- 												</span> -->
<!-- 											</div> -->
										</div>
									</div>
								</div>
							</div>
							<%	
									}
								}
							%>
							<div>
								<div class="row">
									<div class="col-lg-12">
										<div class="col-sm-12">
											<button type="button" class="btn btn-success btn-sm" onclick="show4();" id="paymentbtn">Next</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="offer" class="tab-pane fade">
						<input type="hidden" name="offer_count" id="offer_count" value="1"/>
			 			<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
									<div id="offer_area">
											<% 	int j = 1;
											     if(builderProjectOfferInfos != null){
												for(BuilderProjectOfferInfo projectOfferInfo :builderProjectOfferInfos) { 
											%>
											<div class="row" id="offer-<% out.print(projectOfferInfo.getId()); %>">
											<hr>
<%-- 												<input type="hidden" name="offer_id[]" value="<% out.print(projectOfferInfo.getId()); %>" /> --%>
<!-- 												<div class="col-lg-12" style="padding-bottom:5px;"> -->
<%-- 													<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(projectOfferInfo.getId()); %>);" class="btn btn-danger btn-xs">x</a></span> --%>
<!-- 												</div> -->
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
															<select class="form-control" id="offer_type<%out.print(j); %>" onchange="txtEnabaleDisable(<%out.print(j); %>);" disabled  name="proejct_offer_type[]">
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
											<% j++; } }%>
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
														<button type="submit" class="btn btn-success btn-sm" id="offerbtn">SAVE</button>
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
			</form>
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
$(".errorMsg").keypress(function(event){
	return isNumber(event, this);
});
var myarray=[];
function checkDuplicateEntry(id){
	var offers = $("#offer_title"+id).val();
		if($.inArray(offers,myarray) !== -1 && offers != ''){
			if(myarray.indexOf(offers) != -1){
				alert("Duplicate Entery of offer");
				$("#offer_title"+id).val('');
			}else{
				myarray.push(offers);
			}
		}else{
			if(myarray.indexOf(offers) != -1 && offers != ''){
				alert("Duplicate Entery of offer");
				$("#offer_title"+id).val('');
			}else{
				if(offers != ''){
					myarray.push(offers);
				}
			}
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
function onlyNumbers(){
	 var $th = $(this);
	    $th.val( $th.val().replace(/[^a-zA-Z0-9- ]/g, function(str) { alert('Please use only letters and numbers.'); return ''; } ) );
}
function onlyNumber(id){
	
	 var $th = $("#discount_amount"+id);
	    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease enter only numbers.'); return ''; } ) );
}

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
// $('#discount').keypress(function (event) {
//     return isNumber(event, this)
// });

// $('#discount_amount').keypress(function (event) {
//     return isNumber(event, this)
// });

$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#addbuilding').data('bootstrapValidator').revalidateField('possession_date');
});
$('#launch_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#addbuilding').data('bootstrapValidator').revalidateField('launch_date');
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
function validPer(id){
	var x = $("#discount"+id).val();
	if( x<0 || x >100){
		alert("The percentage must be between 0 and 100");
		$("#discount"+id).val('');
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

$('#addbuilding').bootstrapValidator({
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
        },
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
         		}//,
//         		 between:{
//                  	min:0,
//                  	max:100,
//                  	message: 'The percentage must be between 0 and 100'
//                  }
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
        		}
//         		 between:{
//                  	min:0,
//                  	max:100,
//                  	message: 'The percentage must be between 0 and 100'
//                  }
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
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addBuilding();
});

function addBuilding() {
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
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/newadd',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addbuilding').ajaxSubmit(options);
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
		ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project/building/list.jsp?project_id="+$("#project_id").val();
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
	var html = '<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-'+elvimg_count+'">'
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
	var html = '<div class="row" id="offer-'+offers+'"><hr/>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" autocomplete="off" id="offer_title'+offers+'" onfocusout="checkDuplicateEntry('+offers+');" name="offer_title[]" value=""/>'
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
					+'<input type="text" class="form-control errorMsg" autocomplete="off" id="discount_amount'+offers+'" onkeyup=" javascript:validPerAmount('+offers+');" name="discount_amount[]" value=""/>'
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
	$("#addbuilding").formValidation('addField', 'discount_amount' + offers, {
        validators: {
            // Here, add your field validators.
            notEmpty: {message: 'Please enter value for this field' }
        }
    });
}
function removeOffer(id) {
	$("#offer-"+id).remove();
}

function txtEnabaleDisable(id){
	$th = $("#offer_type"+id).val();
	alert
	 if($th == 3){
	  	$('#discount_amount'+id).attr('disabled', true);
	  	 $("#discount_amount"+id).val('');
	 }else{
		$('#discount_amount'+id).attr('disabled', false); 
		 $("#discount_amount"+id).val('');
	 }
}

$("#project_id").change(function(){
	//alert("ProjectId :: "+$("#project_id").val());
	getPriceDetails();
	getProjectShedule();
});
function getPriceDetails(){
	$("#price_schedule").empty();
	$("#ajaxpricing").empty();
	var html ="";
	var project_id = $("#project_id").val();
	$.get("${baseUrl}/webapi/project/building/prices/"+project_id, { }, function(data){
	 html=+'<div id="price_schedule">'
		  +'<div class="col-lg-12">'
		  +'<div class="panel panel-default">'
		  +'<div class="panel-body">'
		  +'<div class="row">'
		  +'<div class="col-lg-6">'
		  +'<div class="form-group" id="error-base_unit">'
		  +'<label class="control-label col-sm-4">Pricing Unit <span class="text-danger">*</span></label>'
		  +'<div class="col-sm-8">'
		  +'<select name="base_unit" id="base_unit" class="form-control">'
		  +'<option >Test</option>'	
		  +'</select>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-base_rate">'
		  +'<label class="control-label col-sm-4">Base Rate <span class="text-danger">*</span></label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control" id="base_rate" onkeypress=" onlyNumbers();" name="base_rate" value="'+data.baseRate+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-rise_rate">'
		  +'<label class="control-label col-sm-4">Floor Rise Rate</label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control" id="rise_rate" onkeypress=" onlyNumbers();" name="rise_rate" value="'+data.riseRate+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-post">'
		  +'<label class="control-label col-sm-4">Applicable Post </label>'
		  +'<div class="col-sm-8 input-group" style="padding: 0px 12px;">'
		  +'<input type="text" class="form-control" id="post" onkeypress=" onlyNumbers();" name="post" value="'+data.post+'"/>'
		  +'<span class="input-group-addon">floor</span>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-maintenance">'
		  +'<label class="control-label col-sm-4">Maintenance Charge </label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control" onkeypress=" onlyNumbers();" id="maintenance" name="maintenance" value="'+data.maintainance+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-tenure">'
		  +'<label class="control-label col-sm-4">Tenure </label>'
		  +'<div class="col-sm-8 input-group" style="padding: 0px 12px;">'
		  +'<input type="text" class="form-control" id="tenure" onkeypress=" onlyNumbers();" name="tenure" value="'+data.tenure+'"/>'
		  +'<span class="input-group-addon">Months</span>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-amenity_rate">'
		  +'<label class="control-label col-sm-4">Amenities Facing Rate</label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control"  onkeypress=" onlyNumbers();" id="amenity_rate" name="amenity_rate" value="'+data.amenityRate+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-landmark">'
		  +'<label class="control-label col-sm-4">Parking Type </label>'
		  +'<div class="col-sm-8">'
		  +'<select id="parking_id" name="parking_id" class="form-control">'
		  +'<option value="0">Select Parking Type</option>'
		  +'<option value="1">Open Parking</option>'
		  +'<option value="2">Shed Parking</option>'
		  +'</select>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-landmark">'
		  +'<label class="control-label col-sm-4">Parking</label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control" onkeypress=" onlyNumbers();" id="parking" name="parking" value="'+data.parking+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-landmark">'
		  +'<label class="control-label col-sm-4">Stamp Duty </label>'
	      +'<div class="col-sm-8 input-group"  style="padding: 0px 12px;">'
		  +'<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="stamp_duty" name="stamp_duty" value="'+data.stampDuty+'"/>'
		  +'<span class="input-group-addon">%</span>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-tax">'
		  +'<label class="control-label col-sm-4">Tax</label>'
		  +'<div class="col-sm-8 input-group"  style="padding: 0px 12px;">'
		  +'<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="tax" name="tax" value="'+data.tax+'"/>'
		  +'<span class="input-group-addon">%</span>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-vat">'
		  +'<label class="control-label col-sm-4">VAT </label>'
		  +'<div class="col-sm-8 input-group"  style="padding: 0px 12px;">'
		  +'<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="vat" name="vat" value="'+data.vat+'"/>'
		  +'<span class="input-group-addon">%</span>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'<div class="row">'
		  +'<div class="col-lg-6 margin-bottom-5">'
		  +'<div class="form-group" id="error-tech_fee">'
		  +'<label class="control-label col-sm-4">Tech Fees</label>'
		  +'<div class="col-sm-8">'
		  +'<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="tech_fee" name="tech_fee" value="'+data.fee+'"/>'
		  +'</div>'
		  +'<div class="messageContainer"></div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
		  +'</div>'
	      +'</div>';
	  	html = html.replace("NaN","");
	$("#ajaxpricing").append(html);
	});
}
function getProjectShedule(){
	$("#payment_schedule").empty();
    var html = "";
	var project_id = $("#project_id").val();
	ajaxindicatorstart("Please wait while.. we load ...");
	$.get("${baseUrl}/webapi/project/building/payments/"+project_id, { }, function(data){
		$(data).each(function(index){
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
// 			+'<div class="col-lg-3 margin-bottom-5">'
// 			+'<div class="form-group" id="error-amount">'
// 			+'<label class="control-label col-sm-6">Amount </label>'
// 			+'<div class="col-sm-6">'
// 			+'<input type="number" class="form-control" id="amount" name="amount[]" value="'+data[index].amount+'"/>'
// 			+'</div>'
// 			+'<div class="messageContainer"></div>'
// 			+'</div>'
// 			+'</div>'
// 			+'</div>'
			+'</div>'
			+'</div>'
			+'</div>';
		
		});
		html = html.replace("NaN","");
		$("#paymentresponse").html(html);
		ajaxindicatorstop();
	});
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
				+'<input type="text" class="form-control errorMsg" id="payable" name="payable[]" value=""/>'
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
function show2()
{
	$('#buildingTabs a[href="#pricing"]').tab('show');
	
}

function show3(){
	$('#buildingTabs a[href="#payment"]').tab('show');
}

function show4(){
	$('#buildingTabs a[href="#offer"]').tab('show');
}
</script>
</body>
</html>
