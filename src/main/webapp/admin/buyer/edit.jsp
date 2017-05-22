<%@page import="org.bluepigeon.admin.data.BuyerDocList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
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
	int lead_id = 0;
	int type_size = 0;
	int flat_size =	0;
	int building_size = 0;
	int city_size = 0;
	int buyer_id = 0;
	int projectId = 0;
	int buildingId = 0;
	//int floorId = 0;
	int flatId = 0;
	int p_user_id = 0;
	List<BuildingData> building_list = null;
	//List<FloorData> floor_list = null;
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
	
	int project_size = 0;
	int builder_id = 1;
	List<BuilderBuilding> builderBuildings = null;
	List<BuilderFlat> builderFlats = null;
	BuyerDAO buyerDAO = new BuyerDAO();
 	Buyer updateBuyer = buyerDAO.getBuyerById(buyer_id);
 	List<BuilderProject> builderProjects = new ProjectLeadDAO().getProjectList();
 	if(builderProjects.size()>0){
    	project_size = builderProjects.size();
 		builderBuildings = new ProjectLeadDAO().getBuildingByProjectId(updateBuyer.getBuilderProject().getId());
 	}
 	if(builderBuildings.size()>0){
 		building_size =	builderBuildings.size();
 		builderFlats = new ProjectDAO().getBuilderProjectBuildingFlats(builderBuildings.get(0).getId());
 	}
 	List<BuyerDocList> buyers = buyerDAO.getBuyerDocListById(buyer_id);
 	BuyingDetails buyingDetails = buyerDAO.getBuyingDetailsByBuyerId(buyer_id);
 	List<BuyerOffer> buyerOffersList = buyerDAO.getBuyerOffersByBuyerId(buyer_id);
 	List<BuyerPayment> buyerPaymentsList = buyerDAO.getBuyerPaymentsByBuyerId(buyer_id);
 	List<BuyerUploadDocuments> buyerUploadDocumentsList = buyerDAO.getBuyerUploadDocumentsByBuyerId(buyer_id);
// 	List<BuilderProject> project_list = new ProjectDetailsDAO().getBuilderProjectList();
// 	if(project_list.size()>0){
// 		for(BuilderProject builderProject: project_list){
// 	    projectId = builderProject.getId();
// 	    building_list = new BuyerDAO().getBuildingByProjectId(projectId);
// 		    if(building_list.size()>0){
// 		    	for(BuildingData buildingData : building_list){
// 		    		System.out.println("Building Size :: "+building_list.size());
// 			    	buildingId = buildingData.getId();
// 			    	floor_list = new BuyerDAO().getBuilderFloorByBuildingId(buildingId);
// 			    	if(floor_list.size()>0){
// 			    		floorId = floor_list.get(0).getId();
// 			    		flat_list = new BuyerDAO().getBuilderFlatTypeByFloorId(floorId);
// 			    	}
// 		    	}	
// 		    }  	
// 		}
// 	}
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
						<div class="row" id="buyer-1">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id);%>"/>
										<input type="hidden" name="employee_id" id="employee_id" value="<% out.print(updateBuyer.getBuilderEmployee().getId());%>"/>
										<input type="hidden" name="doc_pan" id="doc_pan" value="" />
										<input type="hidden" name="doc_aadhar" id="doc_aadhar" value="" />
										<input type="hidden" name="doc_passport" id="doc_passport" value="" />
										<input type="hidden" name="doc_rra" id="doc_rra" value="" />
										<input type="hidden" name="doc_voterid" id="doc_voterid" value="" />
										<div id="buyer_area">
										<%
											if(buyers.size()>0){
												int i = 0;
												for(BuyerDocList buyer:buyers){	
										%>
										<input type="hidden" name="buyer_count" id="buyer_count" value="<%out.print(i+1);%>"/>
										<input type="hidden" name="buyer_id[]" id="buyer_id" value="<%out.print(buyer.getId());%>"/>
											<div class="row" id="buyer-<%out.print(i);%>">
											<div class="col-lg-12" style="padding-bottom:5px;"><% if(!buyer.isPrimary()) { %><span class="pull-right"><a href="javascript:deleteBuyer(<%out.print(buyer.getId()); %>);" class="btn btn-danger btn-xs">x</a></span><% } %></div>
												<div class="row">
													<div class="col-lg-5 margin-bottom-5">
														<div class="form-group" id="error-buyer_name">
														<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value="<%out.print(buyer.getName()); %>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-contact">
															<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="contact" name="contact[]" value="<%out.print(buyer.getMobile());%>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
											    </div>
											    <div class="row">
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-email">
															<label class="control-label col-sm-4">Email <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="email" name="email[]" value="<%out.print(buyer.getEmail());%>"/>
															</div>
															<div class="messageContainer"></div><br/>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-email">
															<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="pan" name="pan[]" value="<%out.print(buyer.getPanCard());%>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-5 margin-bottom-5">
														<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4"> Prem. Address <span class="text-danger">*</span></label>
														<div class="col-sm-8">
														<textarea class="form-control" id="address" name="address[]" ><%out.print(buyer.getAddress()); %></textarea>
														</div>
														<div class="messageContainer"></div>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-state_id">
															<label class="col-sm-4">Owner <span class='text-danger'>*</span></label>
															<div class="col-sm-8">
																<select name="is_primary[]" id="is_primary" class="form-control">
												                    <option value="">Select Owner</option>
												                     <option value="0" <%if(buyer.isPrimary() == false){ %>selected<%} %>>Co-Owner</option>
												                      <option value="1"<% if(buyer.isPrimary() == true){%>selected<%} %>>Owner</option>
													          	</select>
															</div>
															<div class="messageContainer col-sm-4"></div>
														</div>
													</div>
												</div>
												<hr>
												<%
													if(buyer != null){
														if(buyer.getDocResult() != null){
															boolean is_pan = false;
															boolean is_aadhar = false;
															boolean is_passport = false;
															boolean is_rra = false;
															boolean is_voterid = false;
															for(String bd :buyer.getDocResult()) {
																if(Integer.parseInt(bd) == 1) {
																	is_pan = true;
																}
																if(Integer.parseInt(bd) == 2) {
																	is_aadhar = true;
																}
																if(Integer.parseInt(bd) == 3) {
																	is_passport = true;
																}
																if(Integer.parseInt(bd) == 4) {
																	is_rra = true;
																}
																if(Integer.parseInt(bd) == 5) {
																	is_voterid = true;
																}
															}
												%>
												<div class="col-lg-12 margin-bottom-6">
														<div class="form-group" id="error-project_type">
															<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
															<div class="col-sm-10">
															<div class="col-sm-4">
																<input type="checkbox" name="document_pan[]" value="1" <%if(is_pan) { %> checked <% } %> />PAN Card
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_aadhar[]" value="2" <%if(is_aadhar) {%>checked<%} %>/>Aadhar Card
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_passport[]" value="3" <% if(is_passport) {%>checked<%} %>/>Passport 
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_rra[]" value="4" <% if(is_rra) {%>checked<%} %> />Registered Rent Agreement 
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_voterid[]" value="5" <% if(is_voterid) {%>checked<%} %> />Vote ID 
															</div>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												
											</div>
											<hr>
											<%   			}
														}
													}
												}
												%>
										</div>
										
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreBuyers();" class="btn btn-info btn-xs">+ Add More Buyers</a>
												</span>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-country_id">
													<label class="control-label col-sm-3"><b>Project Details</b><span class='text-danger'>*</span></label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-country_id">
													<label class="control-label col-sm-3">Project <span class='text-danger'>*</span></label>
													<div class="col-sm-5">
														<select name="project_id" id="project_id" class="form-control">
										                    <option value="">Select Project</option>
										                    <% for(BuilderProject builderProject : builderProjects){ %>
															<option value="<% out.print(builderProject.getId());%>" <%if(builderProject.getId() == buyers.get(0).getProjectId()){ %> selected <% } %>><% out.print(builderProject.getName());%></option>
															<% } %>
											             </select>
													</div>
													<div class="messageContainer col-sm-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-3">Building <span class='text-danger'>*</span></label>
													<div class="col-sm-5">
														<select name="building_id" id="building_id" class="form-control">
										                    <option value="">Select Building</option>
										                    <% for(BuilderBuilding builderBuilding : builderBuildings){ %>
															<option value="<% out.print(builderBuilding.getId());%>" <%if(builderBuilding.getId() == buyers.get(0).getBuildingId()){ %> selected <% } %>><% out.print(builderBuilding.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer col-sm-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-3">Flat <span class='text-danger'>*</span></label>
													<div class="col-sm-5">
														<select name="flat_id" id="flat_id" class="form-control">
										                    <option value="">Select Flat</option>
										                    <% for(BuilderFlat builderFlat : builderFlats){ %>
															<option value="<% out.print(builderFlat.getId());%>" <%if(builderFlat.getId() == buyers.get(0).getFlatId()){ %> selected <% } %>><% out.print(builderFlat.getFlatNo());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer col-sm-4"></div>
												</div>
											</div>
	<!-- 										<div class="col-lg-6 margin-bottom-5"> -->
	<!-- 											<div class="form-group" id="error-state_id"> -->
	<!-- 												<label class="control-label col-sm-3">Agreement <span class='text-danger'>*</span></label> -->
	<!-- 												<div class="col-sm-5"> -->
	<!-- 													<select name="agreement" id="agreement" class="form-control"> -->
	<!-- 									                    <option value="">Select Agreement</option> -->
	<!-- 									                     <option value="0">No</option> -->
	<!-- 									                      <option value="1">Yes</option> -->
	<!-- 										          	</select> -->
	<!-- 												</div> -->
	<!-- 												<div class="messageContainer col-sm-4"></div> -->
	<!-- 											</div> -->
	<!-- 										</div> -->
	<!-- 									</div> -->
	<!-- 									<div class="row"> -->
	<!-- 										<div class="col-lg-6 margin-bottom-5"> -->
	<!-- 											<div class="form-group" id="error-state_id"> -->
	<!-- 												<label class="control-label col-sm-3">Possession <span class='text-danger'>*</span></label> -->
	<!-- 												<div class="col-sm-5"> -->
	<!-- 													<select name="possession" id="possession" class="form-control"> -->
	<!-- 									                    <option value="">Select Possession</option> -->
	<!-- 									                     <option value="0">No</option> -->
	<!-- 									                      <option value="1">Yes</option> -->
	<!-- 										          	</select> -->
	<!-- 												</div> -->
	<!-- 												<div class="messageContainer col-sm-4"></div> -->
	<!-- 											</div> -->
	<!-- 										</div> -->
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-3">Status <span class='text-danger'>*</span></label>
													<div class="col-sm-5">
														<select name="status" id="status" class="form-control">
										                    <option value="">Select Status</option>
										                     <option value="0" <%if(updateBuyer.getStatus() == 0) { %> selected <% } %>>Inactive</option>
										                      <option value="1" <%if(updateBuyer.getStatus() == 1) { %> selected <% } %>>Active</option>
											          	</select>
													</div>
													<div class="messageContainer col-sm-4"></div>
												</div>
											</div>
										</div>
										<div class="col-lg-12 margin-bottom-5">
											<div class="clearfix form-actions">
												<div class="pull-right">
													<button type="submit" class="btn btn-success">Update</button>
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
						<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(buyer_id); %>" />
						<input type="hidden" name="id" id="id" value="<%out.print(buyingDetails.getId()); %>" />
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
															<input type="text" class="form-control" id="booking_date" name="booking_date" value="<% if(buyingDetails.getBookingDate() != null) { out.print(dt1.format(buyingDetails.getBookingDate()));} %>"/>
													</div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-base_rate">
													<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="base_rate" name="base_rate" value="<%if(buyingDetails.getBaseRate() != null)out.print(buyingDetails.getBaseRate()); %>" />
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
														<input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<%if(buyingDetails.getFloorRiseRate()!=null)out.print(buyingDetails.getFloorRiseRate());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<%if(buyingDetails.getAmenityFacingRate()!=null)out.print(buyingDetails.getAmenityFacingRate()); %>" />
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
														<input type="text" class="form-control" id="maintenance" name="maintenance" value="<%if(buyingDetails.getMaintenance()!=null)out.print(buyingDetails.getMaintenance());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure </label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="tenure" name="tenure" value="<%if(buyingDetails.getTenure()!=null)out.print(buyingDetails.getTenure());%>"/>
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
														<input type="text" class="form-control" id="registration" name="registration" value="<%if(buyingDetails.getRegistration()!=null)out.print(buyingDetails.getRegistration());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="parking" name="parking" value="<%if(buyingDetails.getParkingRate()!=null)out.print(buyingDetails.getParkingRate());%>"/>
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
														<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<%if(buyingDetails.getStampDuty()!=null)out.print(buyingDetails.getStampDuty());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tax" name="tax" value="<%if(buyingDetails.getTaxes()!=null)out.print(buyingDetails.getTaxes());%>"/>
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
														<input type="text" class="form-control" id="vat" name="vat" value="<%if(buyingDetails.getVat()!=null)out.print(buyingDetails.getVat());%>"/>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="col-sm-12">
													<button type="submit" class="btn btn-success btn-sm" id="pricebtn">Update</button>
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
														<button type="button" class="btn btn-success btn-sm" id="paymentbtn">Update</button>
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
														<button type="button" class="btn btn-success btn-sm" id="offerbtn">Update</button>
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
				<div id="documents" class="tab-pane fade">
					<form id="buyerdoc" name="buyerdoc" method="post" enctype="multipart/form-data">
						<input type="hidden" name="doc_count" id="doc_count" value="1"/>
						<input type="hidden" id="buyer_id" name="buyer_id" value="<%out.print(updateBuyer.getId());%>"/>
			 			<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div>
											<div class="row">
												<div class="col-lg-12" style="padding-bottom:5px;">
<!-- 													<span class="pull-right"><a href="javascript:removeOffer(1);" class="btn btn-danger btn-xs">x</a></span> -->
												</div>
												<div class="row" id="doc_area">
												<%
													if(buyerUploadDocumentsList !=null){
													for(BuyerUploadDocuments buyerUploadDocuments :buyerUploadDocumentsList){
												%>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" id="id" name="id" value="<%out.print(buyerUploadDocuments.getId());%>"/>
															<input type="hidden" name="doc_name[]" value="<%out.print(buyerUploadDocuments.getName()); %>" />
															<label class="control-label col-sm-5">Agreement <span class='text-danger'>*</span></label>
															<div class="col-sm-7">
															<a href="${baseUrl}/<%out.print(buyerUploadDocuments.getDocUrl()); %>" target=""></a>
																<input type="file" class="form-control" name="doc_url[]"/>
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<%}} %>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" name="doc_name[]" value="Index 2" />
															<label class="control-label col-sm-5">Index 2 <span class='text-danger'>*</span></label>
															<div class="col-sm-7">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" name="doc_name[]" value="Receipts with Date and time and Name" />
															<label class="control-label col-sm-5">Receipts with Date and time and Name </label>
															<div class="col-sm-7">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" name="doc_name[]" value="Electrical and Plumbing lines map" />
															<label class="control-label col-sm-5">Electrical and Plumbing lines map </label>
															<div class="col-sm-7">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" name="doc_name[]" value="Possession grant letter" />
															<label class="control-label col-sm-5">Possession grant letter </label>
															<div class="col-sm-7">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;" id="doc-1">
														<div class="form-group" id="error-offer_title">
															<label class="control-label col-sm-5">Other Documents </label>
															<div class="col-sm-3">
																<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/>
															</div>
															<div class="col-sm-3">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													
												</div>
											</div>
											<div>
												<div class="col-lg-12">
													<span class="pull-right">
														<a href="javascript:addMoreDoc();" class="btn btn-info btn-xs">+ Add More Document</a>
													</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div>
							<div class="row">
								<div class="col-lg-12">
									<div class="col-sm-12">
										<button type="submit" name="updatedoc" class="btn btn-success btn-sm" id="updatedoc">Update</button>
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
		var html = '<option value="">Select Flat</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
// $("#floor_id").change(function(){
// 	$.get("${baseUrl}/webapi/buyer/flat/list/",{ floor_id: $("#floor_id").val() }, function(data){
// 		var html = '<option value="">Select Flat</option>';
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
// 		});
// 		$("#flat_id").html(html);
// 	},'json');
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
    	project_id: {
            validators: {
                notEmpty: {
                    message: 'Project Name is required and cannot be empty'
                }
            }
        },
    	building_id: {
            validators: {
                notEmpty: {
                    message: 'Building Name is required and cannot be empty'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Flat Name is required and cannot be empty'
                }
            }
        },
        'buyer_name[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer Name is required and cannot be empty'
                }
            }
        },
        'contact[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer contact is required and cannot be empty'
                }
            }
        },
        'email[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer Email is required and cannot be empty'
                }
            }
        },
        'pancard[]': {
            validators: {
                notEmpty: {
                    message: 'Pancard is required and cannot be empty'
                }
            }
        },
        'address[]': {
            validators: {
                notEmpty: {
                    message: 'Permanent address is required and cannot be empty'
                }
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuyer();
});

function updateBuyer() {
	var doc_pan = "";
	$('input[name="document_pan[]"]').each(function(index) {
		if(doc_pan == "") {
			if($(this).is(':checked')) {
				doc_pan = $(this).val();
			} else {
				doc_pan = "0";
			}
		} else {
			if($(this).is(':checked')) {
				doc_pan = doc_pan + ","+$(this).val();
			} else {
				doc_pan = doc_pan + ",0";
			}
		}
	});
	$("#doc_pan").val(doc_pan);
	var doc_aadhar = "";
	$('input[name="document_aadhar[]"]').each(function(index) {
		if(doc_aadhar == "") {
			if($(this).is(':checked')) {
				doc_aadhar = $(this).val();
			} else {
				doc_aadhar = "0";
			}
		} else {
			if($(this).is(':checked')) {
				doc_aadhar = doc_aadhar + ","+$(this).val();
			} else {
				doc_aadhar = doc_aadhar + ",0";
			}
		}
	});
	$("#doc_aadhar").val(doc_aadhar);
	
	var doc_passport = "";
	$('input[name="document_passport[]"]').each(function(index) {
		if(doc_passport == "") {
			if($(this).is(':checked')) {
				doc_passport = $(this).val();
			} else {
				doc_passport = "0";
			}
		} else {
			if($(this).is(':checked')) {
				doc_passport = doc_passport + ","+$(this).val();
			} else {
				doc_passport = doc_passport + ",0";
			}
		}
	});
	$("#doc_passport").val(doc_passport);
	
	var doc_rra = "";
	$('input[name="document_rra[]"]').each(function(index) {
		if(doc_rra == "") {
			if($(this).is(':checked')) {
				doc_rra = $(this).val();
			} else {
				doc_rra = "0";
			}
		} else {
			if($(this).is(':checked')) {
				doc_rra = doc_rra + ","+$(this).val();
			} else {
				doc_rra = doc_rra + ",0";
			}
		}
	});
	$("#doc_rra").val(doc_rra);
	
	var doc_voterid = "";
	$('input[name="document_voterid[]"]').each(function(index) {
		if(doc_voterid == "") {
			if($(this).is(':checked')) {
				doc_voterid = $(this).val();
			} else {
				doc_voterid = "0";
			}
		} else {
			if($(this).is(':checked')) {
				doc_voterid = doc_voterid + ","+$(this).val();
			} else {
				doc_voterid = doc_voterid + ",0";
			}
		}
	});
	$("#doc_voterid").val(doc_voterid);
	
	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/update/basic',
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
        location.reload(true);
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
	 		url : '${baseUrl}/webapi/buyer/update/price',
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

// $("#detailbtn").click(function(){
// 	var projectType = [];
// 	var propertyType = [];
// 	var configuration = [];
// 	var amenityType = [];
// 	var approvalType = [];
// 	var homeLoanInfo = [];
// 	var project = {id:$("#id").val(),projectArea:$("#project_area").val(),areaUnit:{id:$("#area_unit").val()},launchDate:new Date($("#launch_date").val())};
// 	$('input[name="project_type[]"]:checked').each(function() {
// 		projectType.push({builderProjectType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	$('input[name="property_type[]"]:checked').each(function() {
// 		val = $("#property_type"+$(this).val()).val();
// 		propertyType.push({value:val,builderPropertyType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	$('input[name="configuration[]"]:checked').each(function() {
// 		configuration.push({builderProjectPropertyConfiguration:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	$('input[name="amenity_type[]"]:checked').each(function() {
// 		amenityType.push({builderProjectAmenity:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	$('input[name="approval_type[]"]:checked').each(function() {
// 		approvalType.push({builderProjectApprovalType:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	$('input[name="homeloan_bank[]"]:checked').each(function() {
// 		homeLoanInfo.push({homeLoanBanks:{id:$(this).val()},builderProject:{id:$("#id").val()}});
// 	});
// 	var final_data = {builderProject:project,builderProjectProjectTypes:projectType,builderProjectPropertyTypes:propertyType,builderProjectPropertyConfigurationInfos:configuration,builderProjectAmenityInfos:amenityType,builderProjectApprovalInfos:approvalType,builderProjectBankInfos:homeLoanInfo}
// 	$.ajax({
// 	    url: '${baseUrl}/webapi/project/detail/update',
// 	    type: 'POST',
// 	    data: JSON.stringify(final_data),
// 	    contentType: 'application/json; charset=utf-8',
// 	    dataType: 'json',
// 	    async: false,
// 	    success: function(data) {
// 			if (data.status == 0) {
// 				alert(data.message);
// 			} else {
// 				alert(data.message);
// 			}
// 		},
// 		error : function(data)
// 		{
// 			alert("Fail to save data");
// 		}
		
// 	});
// });

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
		    url: '${baseUrl}/webapi/buyer/payment/update',
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
	var final_data = {buyerOffer:offerInfo,builderProject:project}
	if(offerInfo.length > 0) {
		$.ajax({
		    url: '${baseUrl}/webapi/buyer/offer/update',
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
function addMoreBuyers() {
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html = '<div class="row" id="buyer-'+buyers+'"><hr>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span></div>'
			+'<div class="row"><input type="hidden" name="buyer_id[]" value="0" />'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-buyer_name">'
			+'<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-5 margin-bottom-6">'
			+'<div class="form-group" id="error-contact">'
				+'<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="contact" name="contact[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<div class="row">'
		+'<div class="col-lg-5 margin-bottom-6">'
			+'<div class="form-group" id="error-email">'
				+'<label class="control-label col-sm-4">Email <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="email" name="email[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div><br/>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-5 margin-bottom-6">'
			+'<div class="form-group" id="error-email">'
				+'<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="pan" name="pan[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<div class="row">'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4"> Prem. Address <span class="text-danger">*</span></label>'
			+'<div class="col-sm-8">'
			+'<textarea class="form-control" id="address" name="address[]" ></textarea>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-5 margin-bottom-6">'
			+'<div class="form-group" id="error-state_id">'
				+'<label class="control-label col-sm-4">Owner <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<select name="is_primary[]" id="is_primary" class="form-control">'
	                    +'<option value="">Select Owner</option>'
	                     +'<option value="0" selected>Co-Owner</option>'
	                      +'<option value="1">Owner</option>'
		          	+'</select>'
				+'</div>'
				+'<div class="messageContainer col-sm-4"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<hr>'
	+'<div class="col-lg-12 margin-bottom-6">'
			+'<div class="form-group" id="error-project_type">'
				+'<label class="control-label col-sm-2">Documents <span class="text-danger">*</span></label>'
				+'<div class="col-sm-10">'
					+'<div class="col-sm-4">'
						+'<input type="checkbox" name="document_pan[]" value="1" />PAN Card'
					+'</div>'
					+'<div class="col-sm-4">'
						+'<input type="checkbox" name="document_aadhar[]" value="2" />Aadhar Card' 
					+'</div>'
					+'<div class="col-sm-4">'
						+'<input type="checkbox" name="document_passport[]" value="3" />Passport' 
					+'</div>'
					+'<div class="col-sm-4">'
						+'<input type="checkbox" name="document_rra[]" value="4" />Registered Rent Agreement' 
					+'</div>'
					+'<div class="col-sm-4">'
						+'<input type="checkbox" name="document_voterid[]" value="5" />Vote ID' 
					+'</div>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'</div>'
	+'</div>';
	$("#buyer_area").append(html);
	$("#buyer_count").val(buyers);
}
function removeBuyer(id) {
	$("#buyer-"+id).remove();
}
// function deleteImage(id) {
// 	var flag = confirm("Are you sure ? You want to delete plan ?");
// 	if(flag) {
// 		$.get("${baseUrl}/webapi/project/buyer/"+id, { }, function(data){
// 			alert(data.message);
// 			if(data.status == 1) {
// 				$("#b_image"+id).remove();
// 			}
// 		},'json');
// 	}
// }

function deleteBuyer(id){
	var flag = confirm("Are you sure? You want to delete buyer ?");
	if(flag){
		$.get("${baseUrl}/webapi/project/buyer/delete/"+id,{ }, function(data){
			if(data.status == 1){
				alert(data.message);
				 location.reload(true);
			}
		});
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