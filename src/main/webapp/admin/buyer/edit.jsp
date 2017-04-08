<%@page import="org.bluepigeon.admin.data.FlatData"%>
<%@page import="org.bluepigeon.admin.data.FloorData"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.data.ProjectDetails"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%@page import="org.bluepigeon.admin.model.BuyerOffer"%>
<%@page import="org.bluepigeon.admin.model.BuyingDetails"%>
<%@page import="org.bluepigeon.admin.model.BuyerUploadDocuments"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuyerDocuments"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	int buyer_id = 0;
	int projectId = 0;
	int buildingId = 0;
	int floorId = 0;
	int flatId = 0;
	int p_user_id = 0;
	List<BuildingData> building_list = null;
	List<FloorData> floor_list = null;
	List<FlatData> flat_list = null;
	buyer_id = Integer.parseInt(request.getParameter("buyer_id"));
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
	Buyer buyer =  new BuyerDAO().getBuyerById(buyer_id);
	BuyerDocuments buyerDocuments = new BuyerDAO().getBuyerDocumentsByBuyerId(buyer_id);
	BuyingDetails buyingDetails = new BuyerDAO().getBuyingDetailsByBuyerId(buyer_id);
	List<BuyerOffer> buyerOffersList = new BuyerDAO().getBuyerOffersByBuyerId(buyer_id);
	List<BuyerPayment> buyerPaymentsList = new BuyerDAO().getBuyerPaymentsByBuyerId(buyer_id);
	List<BuyerUploadDocuments> buyerUploadDocumentsList = new BuyerDAO().getBuyerUploadDocumentsByBuyerId(buyer_id);
	List<BuilderProject> project_list = new ProjectDetailsDAO().getBuilderProjectList();
	if(project_list.size()>0){
		for(BuilderProject builderProject: project_list){
	    projectId = builderProject.getId();
	    System.out.println("Project Size :: "+project_list.size());
	    building_list = new BuyerDAO().getBuildingByProjectId(projectId);
		    if(building_list.size()>0){
		    	for(BuildingData buildingData : building_list){
		    		System.out.println("Building Size :: "+building_list.size());
			    	buildingId = buildingData.getId();
			    	floor_list = new BuyerDAO().getBuilderFloorByBuildingId(buildingId);
			    	if(floor_list.size()>0){
			    		floorId = floor_list.get(0).getId();
			    		flat_list = new BuyerDAO().getBuilderFlatTypeByFloorId(floorId);
			    	}
		    	}	
		    }  	
		}
	}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Buyer</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Buyer Update 
				</h1>
			</div>
			<ul class="nav nav-tabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#buyingdetail">Buying Details</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#documents">Documents</a></li>
			</ul>
			<div class="tab-content">
			  	<div id="basic" class="tab-pane fade in active">
			  		<form id="basicfrm" name="basicfrm" method="post" enctype="multipart/form-data" action="">
			  			<div id="basicresponse"></div>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="id" id="id" value="<% out.print(buyer_id);%>"/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Buyer Name <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="name" value="<%out.print(buyer.getName()); %>" name="name" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-contact">
													<label class="control-label col-sm-4">Contact <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="contact" value="<%out.print(buyer.getContact()); %>" name="contact" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-email">
													<label class="control-label col-sm-4">Email <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="email" value="<%out.print(buyer.getEmail()); %>" name="email" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-pan">
													<label class="control-label col-sm-4">PAN Card </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="pan" value="<%out.print(buyer.getPan()); %>" name="pan" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-address">
												<label class="control-label col-sm-4">Prem. Address<span class='text-danger'>*</span></label>
												<div class="col-sm-8">
													<textarea rows="" cols="" class="form-control" id="address" name="address"><%out.print(buyer.getAddress()); %></textarea>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
											</div>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(buyer.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(buyer.getPhoto()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(buyer.getId()); %>);" class="btn btn-danger btn-sm">x Delete Plan</a> </label>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id="building_image" name="building_image[]" />
														<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a></span>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
												<div class="col-sm-12">
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="1" <%if(buyerDocuments.getDocuments().equals("1")){ %>checked<%} %> />PAN 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="2" <%if(buyerDocuments.getDocuments()=="2"){ %>checked<%} %>/>Aadhar 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="3" <%if(buyerDocuments.getDocuments()=="3"){ %>checked<%} %>/>Passport 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="4" <%if(buyerDocuments.getDocuments()=="4"){ %>checked<%} %>/>Registered Rent Agreement 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="5" <%if(buyerDocuments.getDocuments()=="5"){ %>checked<%} %>/>Vote ID 
													</div>
												</div>
												<div class="messageContainer"></div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-12 margin-bottom-5">
													<div class="form-group" id="error-country_id">
														<label class="control-label col-sm-3"><b>Project Details</b><span class='text-danger'>*</span></label>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-locality_id">
													<label class="control-label col-sm-4">Project <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="project_id" id="project_id" class="form-control">
										                	<option value="">Select Project</option>
										                	<% 	for(BuilderProject builderProjectList : project_list) { %>
															<option value="<% out.print(builderProjectList.getId());%>" <% if(builderProjectList.getId() == buyer.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProjectList.getName()); %></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-4">Building <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="building_id" id="building_id" class="form-control">
										                    <option value="">Select Building</option>
										                   <% 	for(BuildingData buildingDataList : building_list) { %>
															<option value="<% out.print(buildingDataList.getId());%>" <% if(buildingDataList.getId() == buyer.getBuilderBuilding().getId()) { %>selected<% } %>><% out.print(buildingDataList.getName()); %></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-4">Floor <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="floor_id" id="floor_id" class="form-control">
										                    <option value="">Select Floor</option>
										                   <% 	for(FloorData FloorDataList : floor_list) { %>
															<option value="<% out.print(FloorDataList.getId());%>" <% if(FloorDataList.getId() == buyer.getBuilderFloor().getId()) { %>selected<% } %>><% out.print(FloorDataList.getName()); %></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Flat <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="flat_id" id="flat_id" class="form-control">
										                	<option value="">Select Flat</option>
										                    <% 	for(FlatData FlatDataList : flat_list) { %>
															<option value="<% out.print(FlatDataList.getId());%>" <% if(FlatDataList.getId() == buyer.getBuilderFlat().getId()) { %>selected<% } %>><% out.print(FlatDataList.getName()); %></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-highlight">
													<label class="control-label col-sm-4">Agreement </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<option value="0" <% if(buyer.getAgreement() == 0) { %>selected<% } %>>No</option>
															<option value="1" <% if(buyer.getAgreement() == 1) { %>selected<% } %>>Yes</option>
														</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-highlight">
													<label class="control-label col-sm-4">Possession </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<option value="0" <% if(buyer.getPossession() == 0) { %>selected<% } %>>No</option>
															<option value="1" <% if(buyer.getPossession() == 1) { %>selected<% } %>>Yes</option>
														</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-highlight">
													<label class="control-label col-sm-4">Status </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<option value="0" <% if(buyer.getStatus() == 0) { %>selected<% } %>>Inactive</option>
															<option value="1" <% if(buyer.getStatus() == 1) { %>selected<% } %>>Active</option>
														</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6">
												<div class="col-sm-12">
													<button type="submit" name="basicbtn" class="btn btn-success btn-sm">Submit</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="buyingdetail" class="tab-pane fade">
					<form id="pricingfrm" name="pricingfrm" method="post">
						<input type="hidden" name="id" />
						<input type="hidden" name="project_id" />
			 			<div class="row">
			 				<div id="pricingresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="row">
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<div class="col-lg-6">
												<div class="form-group" id="error-base_unit">
													<label class="control-label col-sm-4">Booking Date <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
															<input type="text" class="form-control" id="booking_date" name="booking_date" value="<% //if(builderProject.getLaunchDate() != null) { out.print(dt1.format(builderProject.getLaunchDate()));} %>"/>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-base_rate">
													<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="base_rate" name="base_rate" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-rise_rate">
													<label class="control-label col-sm-4">Floor Rise Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="rise_rate" name="rise_rate"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-maintenance">
													<label class="control-label col-sm-4">Maintenance Charge </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="maintenance" name="maintenance" "/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure </label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="tenure" name="tenure" "/>
														<span class="input-group-addon">Months</span>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Registration</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="registration" name="registration" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="parking" name="parking" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Stamp Duty </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tax" name="tax" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-vat">
													<label class="control-label col-sm-4">VAT </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="vat" name="vat" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="col-sm-12">
													<button type="submit" class="btn btn-success btn-sm" id="pricebtn">SAVE</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div id="payment" class="tab-pane fade">
					<form id="paymentfrm" name="paymentfrm" method="post">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(buyerPaymentsList.size()+1);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% 	int i = 1;
												for(BuyerPayment buyerPayment :buyerPaymentsList) { 
											%>
											<div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% if(buyerPayment.getMilestone() != null) { out.print(buyerPayment.getMilestone());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value="<% if(buyerPayment.getNetPayable() != null) { out.print(buyerPayment.getNetPayable());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value="<% if(buyerPayment.getAmount() != null) { out.print(buyerPayment.getAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% i++; } %>
											<div class="row" id="schedule-<% out.print(i);%>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a>
												</span>
											</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" class="btn btn-success btn-sm" id="paymentbtn">SAVE</button>
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
					<form id="offerfrm" name="offerfrm" method="post">
						<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(buyerOffersList.size()+1); %>"/>
			 			<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<% 	int j = 1;
												for(BuyerOffer buyerOffer :buyerOffersList) { 
											%>
											<div class="row" id="offer-<% out.print(j);%>">
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:removeOffer(<% out.print(j);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% if(buyerOffer.getTitle() != null) { out.print(buyerOffer.getTitle());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value="<% if(buyerOffer.getOfferPercentage() != null) { out.print(buyerOffer.getOfferPercentage());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Offer Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% if(buyerOffer.getOfferPercentage() != null) { out.print(buyerOffer.getOfferAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value="<% if(buyerOffer.getApplicable() != null) { out.print(buyerOffer.getApplicable());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-4">Apply </label>
														<div class="col-sm-8">
															<select class="form-control" id="apply" name="apply[]">
																<option value="1" <% if(buyerOffer.getApplicable() == 1) { %>selected<% } %>>Yes</option>
																<option value="0" <% if(buyerOffer.getApplicable() == 0) { %>selected<% } %>>No</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<% j++; } %>
											<div class="row" id="offer-<% out.print(j);%>">
												<% if(j > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:removeOffer(<% out.print(j);%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Offer Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-4">Apply </label>
														<div class="col-sm-8">
															<select class="form-control" id="apply" name="apply[]">
																<option value="1" >Yes</option>
																<option value="0" >No</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
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
														<button type="button" class="btn btn-success btn-sm" id="offerbtn">SAVE</button>
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
			<br> <br>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
	.margin-bottom-5 {
		padding-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#launch_date').datepicker({
	format: "dd MM yyyy"
});
$("#project_id").change(function(){
	if($("#project_id").val() != "") {
		$.get("${baseUrl}/webapi/buyer/building/list/",{ project_id: $("#project_id").val() }, function(data){
			var html = '<option value="">Select Building</option>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			});
			$("#building_id").html(html);
		},'json');
	}
});

$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/floor/list/",{ building_id: $("#building_id").val() }, function(data){
		var html = '<option value="">Select Floor</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#floor_id").html(html);
	},'json');
});
$("#floor_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/flat/list/",{ floor_id: $("#floor_id").val() }, function(data){
		var html = '<option value="">Select Flat</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
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
                },
                integer: {
                    message: 'Invalid pin code.'
           		}
            }
        },
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

$("#detailbtn").click(function(){
	var projectType = [];
	var propertyType = [];
	var configuration = [];
	var amenityType = [];
	var approvalType = [];
	var homeLoanInfo = [];
	var project = {id:$("#id").val(),projectArea:$("#project_area").val(),areaUnit:{id:$("#area_unit").val()},launchDate:new Date($("#launch_date").val())};
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
	var final_data = {builderProject:project,builderProjectProjectTypes:projectType,builderProjectPropertyTypes:propertyType,builderProjectPropertyConfigurationInfos:configuration,builderProjectAmenityInfos:amenityType,builderProjectApprovalInfos:approvalType,builderProjectBankInfos:homeLoanInfo}
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
});

$("#paymentbtn").click(function(){
	var paymentInfo = [];
	var payable = [];
	var amount = [];
	$('input[name="payable[]"]').each(function(index) {
		payable.push($(this).val());
	});
	$('input[name="amount[]"]').each(function(index) {
		amount.push($(this).val());
	});
	$('input[name="schedule[]"]').each(function(index) {
		if($(this).val() != "") {
			paymentInfo.push({schedule:$(this).val(),payable:payable[index],amount:amount[index],status:1,builderProject:{id:$("#id").val()}});
		}
	});
	var project = {id:$("#id").val()};
	var final_data = {builderProjectPaymentInfos:paymentInfo,builderProject:project}
	if(paymentInfo.length > 0) {
		$.ajax({
		    url: '${baseUrl}/webapi/project/payment/update',
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
	} else {
		alert("Please enter payment schedule details");
	}
});

$("#offerbtn").click(function(){
	var offerInfo = [];
	var discount = [];
	var amount = [];
	var applicable = [];
	var apply = [];
	$('input[name="discount[]"]').each(function(index) {
		discount.push($(this).val());
	});
	$('input[name="discount_amount[]"]').each(function(index) {
		amount.push($(this).val());
	});
	$('input[name="applicable_on[]"]').each(function(index) {
		applicable.push($(this).val());
	});
	$('select[name="apply[]"] option:selected').each(function(index) {
		apply.push($(this).val());
	});
	$('input[name="offer_title[]"]').each(function(index) {
		if($(this).val() != "") {
			offerInfo.push({title:$(this).val(),per:discount[index],amount:amount[index],applicable:applicable[index],apply:apply[index],builderProject:{id:$("#id").val()}});
		}
	});
	var project = {id:$("#id").val()};
	var final_data = {builderProjectOfferInfos:offerInfo,builderProject:project}
	if(offerInfo.length > 0) {
		$.ajax({
		    url: '${baseUrl}/webapi/project/offer/update',
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
	} else {
		alert("Please enter offer details");
	}
});

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-discount">'
				+'<label class="control-label col-sm-4">Offer Discount(%) <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="discount" name="discount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-4">Offer Discount Amount </label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4">Applicable on </label>'
			+'<div class="col-sm-8">'
			+'<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value=""/>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-apply">'
			+'<label class="control-label col-sm-4">Apply </label>'
			+'<div class="col-sm-8">'
			+'<select class="form-control" id="apply" name="apply[]">'
			+'<option value="1">Yes</option>'
			+'<option value="0">No</option>'
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
function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete plan ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/buyer/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
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

</script>
</body>
</html>
