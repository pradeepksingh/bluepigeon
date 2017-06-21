<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuyerOffer"%>
<%@page import="org.bluepigeon.admin.model.BuyingDetails"%>
<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%@page import="org.bluepigeon.admin.model.BuyerDocuments"%>
<%@page import="org.bluepigeon.admin.model.BuyerUploadDocuments"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int p_user_id = 0;
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
List<BuilderProject> project_list = null; 
int flat_id = 0;
List<Buyer> buyers = new ArrayList<Buyer>();
List<BuilderBuilding> builderBuildings = new ArrayList<BuilderBuilding>(); 
List<BuilderFlat> builderFlats = new ArrayList<BuilderFlat>();
BuyingDetails buyingDetails = new BuyingDetails();
List<BuyerOffer> buyerOffers = new ArrayList<BuyerOffer>();
List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
int buyeroffersize = 0;
int primary_buyer_id = 0;
int builder_id = 0;
if (request.getParameterMap().containsKey("flat_id")) {
	flat_id = Integer.parseInt(request.getParameter("flat_id"));
	buyers = new BuyerDAO().getFlatBuyersByFlatId(flat_id);
	builderBuildings = new ProjectDAO().getBuilderProjectBuildings(buyers.get(0).getBuilderProject().getId());
	builderFlats = new ProjectDAO().getBuilderAllFlatsByBuildingId(buyers.get(0).getBuilderBuilding().getId());
	buyingDetails = new BuyerDAO().getBuyingDetailsByBuyerId(buyers.get(0).getId());
	buyerOffers = new BuyerDAO().getBuyerOffersByBuyerId(buyers.get(0).getId());
	buyeroffersize = buyerOffers.size();
	buyerPayments = new BuyerDAO().getBuyerPaymentsByBuyerId(buyers.get(0).getId());
	buyerUploadDocuments = new BuyerDAO().getBuyerUploadDocumentsByBuyerId(buyers.get(0).getId());
	for(Buyer buyer :buyers) {
		if(buyer.getIsPrimary()) {
			primary_buyer_id = buyer.getId();
		}
	}
	builder_id = buyers.get(0).getBuilder().getId();
	if(builder_id > 0 ){
		project_list = new ProjectDetailsDAO().getBuilderActiveProjectList(builder_id);
	}
	List<BuilderEmployee> builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id);
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
						<div class="row" id="buyer-1">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="employee_id" id="employee_id" value="<%out.print(buyers.get(0).getBuilderEmployee().getId());%>" />
										<input type="hidden" name="builder_id" id="builder_id" value="<%out.print(builder_id);%>" />
										<input type="hidden" name="doc_pan" id="doc_pan" value="" />
										<input type="hidden" name="doc_aadhar" id="doc_aadhar" value="" />
										<input type="hidden" name="doc_passport" id="doc_passport" value="" />
										<input type="hidden" name="doc_rra" id="doc_rra" value="" />
										<input type="hidden" name="doc_voterid" id="doc_voterid" value="" />
										<% if(buyers.size() > 0) { %>
											<input type="hidden" name="buyer_count" id="buyer_count" value="<% out.print(buyers.size()); %>" />
										<% } else { %>
										<input type="hidden" name="buyer_count" id="buyer_count" value="1" />
										<% } %>
										<div id="buyer_area">
										<% int i = 1; 
										for(Buyer buyer :buyers) { %>
											<div class="row" id="buyer-<% out.print(buyer.getId()); %>">
											<input type="hidden" name="buyer_id[]" id="buyer_id" value="<%out.print(buyer.getId());%>"/>
											<% if(i > 1) { %>
											<hr>
											<span class="pull-right"><a href="javascript:deleteBuyer(<% out.print(buyer.getId()); %>);" class="btn btn-danger btn-xs">x</a></span><br>
											<% } %>
											<div class="col-lg-12" style="padding-bottom:5px;"></div>
												<div class="row">
													<div class="col-lg-5 margin-bottom-5">
														<div class="form-group" id="error-buyer_name">
														<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value="<%out.print(buyer.getName()); %>"/>
															</div>
															<div class="messageContainer col-sm-8"></div>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-contact">
															<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="contact" name="contact[]" value="<%out.print(buyer.getMobile());%>" maxlength="10"/>
															</div>
															<div class="messageContainer col-sm-8"></div>
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
															<div class="messageContainer col-sm-8"></div><br/>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-email">
															<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>
															<div class="col-sm-8">
																<input type="text" class="form-control" id="pan" name="pan[]" value="<%out.print(buyer.getPancard());%>"/>
															</div>
															<div class="messageContainer col-sm-8"></div>
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
														<div class="messageContainer col-sm-8"></div>
														</div>
													</div>
													<div class="col-lg-5 margin-bottom-6">
														<div class="form-group" id="error-state_id">
															<label class="col-sm-4">Owner <span class='text-danger'>*</span></label>
															<div class="col-sm-8">
																<select name="is_primary[]" id="is_primary" class="form-control">
												                    <option value="">Select Owner</option>
												                     <option value="0" <%if(buyer.getIsPrimary() == false){ %>selected<%} %>>Co-Owner</option>
												                      <option value="1"<% if(buyer.getIsPrimary() == true){%>selected<%} %>>Owner</option>
													          	</select>
															</div>
															<div class="messageContainer col-sm-8"></div>
														</div>
													</div>
												</div>
												<%
													int buyer_pan = 0;
													int buyer_aadhar = 0;
													int buyer_passport = 0;
													int buyer_rra = 0;
													int buyer_voterid = 0;
													for(BuyerDocuments buyerDocument :buyer.getBuyerDocuments()) {
														if(buyerDocument.getDocuments().equals("1")) {
															buyer_pan = 1;
														}
														if(buyerDocument.getDocuments().equals("2")) {
															buyer_aadhar = 2;
														}
														if(buyerDocument.getDocuments().equals("3")) {
															buyer_passport = 3;
														}
														if(buyerDocument.getDocuments().equals("4")) {
															buyer_rra = 4;
														}
														if(buyerDocument.getDocuments().equals("5")) {
															buyer_voterid = 5;
														}
													}
												%>
												<div class="col-lg-12 margin-bottom-6">
														<div class="form-group" id="error-project_type">
															<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
															<div class="col-sm-10">
															<div class="col-sm-4">
																<input type="checkbox" name="document_pan[]" value="1" <% if(buyer_pan > 0) { %>checked<% } %> />PAN Card
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_aadhar[]" value="2" <% if(buyer_aadhar > 0) { %>checked<% } %>/>Aadhar Card
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_passport[]" value="3" <% if(buyer_passport > 0) { %>checked<% } %>/>Passport 
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_rra[]" value="4" e="checkbox" name="document_rra[]" value="4" <% if(buyer_rra > 0) { %>checked<% } %> />Registered Rent Agreement 
															</div>
															<div class="col-sm-4">
																<input type="checkbox" name="document_voterid[]" value="5" <% if(buyer_voterid > 0) { %>checked<% } %> />Vote ID 
															</div>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												
											</div>
											<% 
												i++;
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
										<hr>
										<div class="row">
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-country_id">
													<label class="control-label col-sm-8"><b>Project Details</b><span class='text-danger'>*</span></label>
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
										                    <% for(BuilderProject builderProject : project_list){ %>
															<option value="<% out.print(builderProject.getId());%>" <%if(builderProject.getId() == buyers.get(0).getBuilderProject().getId()){ %> selected <% } %>><% out.print(builderProject.getName());%></option>
															<% } %>
											             </select>
													</div>
													<div class="messageContainer col-sm-8"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-state_id">
													<label class="control-label col-sm-3">Building <span class='text-danger'>*</span></label>
													<div class="col-sm-5">
														<select name="building_id" id="building_id" class="form-control">
										                    <option value="">Select Building</option>
										                    <% for(BuilderBuilding builderBuilding : builderBuildings){ %>
															<option value="<% out.print(builderBuilding.getId());%>" <%if(builderBuilding.getId() == buyers.get(0).getBuilderBuilding().getId()){ %> selected <% } %>><% out.print(builderBuilding.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer col-sm-8"></div>
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
															<option value="<% out.print(builderFlat.getId());%>" <%if(builderFlat.getId() == buyers.get(0).getBuilderFlat().getId()){ %> selected <% } %>><% out.print(builderFlat.getFlatNo());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer col-sm-8"></div>
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
<!-- 											<div class="col-lg-6 margin-bottom-5"> -->
<!-- 												<div class="form-group" id="error-state_id"> -->
<!-- 													<label class="control-label col-sm-3">Status <span class='text-danger'>*</span></label> -->
<!-- 													<div class="col-sm-5"> -->
<!-- 														<select name="status" id="status" class="form-control"> -->
<!-- 										                    <option value="">Select Status</option> -->
<%-- 										                     <option value="0" <%if(updateBuyer.getStatus() == 0) { %> selected <% } %>>Inactive</option> --%>
<%-- 										                      <option value="1" <%if(updateBuyer.getStatus() == 1) { %> selected <% } %>>Active</option> --%>
<!-- 											          	</select> -->
<!-- 													</div> -->
<!-- 													<div class="messageContainer col-sm-8"></div> -->
<!-- 												</div> -->
<!-- 											</div> -->
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
						<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id); %>" />
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
													<div class="messageContainer col-sm-8"></div>
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
													<div class="messageContainer col-sm-8"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<%if(buyingDetails.getAmenityFacingRate()!=null)out.print(buyingDetails.getAmenityFacingRate()); %>" />
													</div>
													<div class="messageContainer col-sm-8"></div>
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
													<div class="messageContainer col-sm-8"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure </label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="tenure" name="tenure" value="<%if(buyingDetails.getTenure()!=null)out.print(buyingDetails.getTenure());%>"/>
														<span class="input-group-addon">Months</span>
													</div>
													<div class="messageContainer col-sm-8"></div>
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
													<div class="messageContainer col-sm-8"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="parking" name="parking" value="<%if(buyingDetails.getParkingRate()!=null)out.print(buyingDetails.getParkingRate());%>"/>
													</div>
													<div class="messageContainer col-sm-8"></div>
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
													<div class="messageContainer col-sm-8"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tax" name="tax" value="<%if(buyingDetails.getTaxes()!=null)out.print(buyingDetails.getTaxes());%>"/>
													</div>
													<div class="messageContainer col-sm-8"></div>
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
					<form id="paymentfrm" name="paymentfrm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(buyerPayments.size()+1);%>"/>
						<input type="hidden" id="buyer_id" name="buyer_id" value="<%out.print(primary_buyer_id);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% 	i = 1;
												for(BuyerPayment buyerPayment :buyerPayments) { 
											%>
											<input type="hidden"  name="payment_id[]" value="<%out.print(buyerPayment.getId());%>"/>
											<div class="row" id="schedule-<% out.print(buyerPayment.getId()); %>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" readonly="true" value="<% if(buyerPayment.getMilestone() != null) { out.print(buyerPayment.getMilestone());}%>"/>
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
<!-- 												<div class="col-lg-1"> -->
<%-- 													<span><a href="javascript:deleteSchedule(<% out.print(buyerPayment.getId()); %>);" class="btn btn-danger btn-xs">x</a></span> --%>
<!-- 												</div> -->
											</div>
											<% i++; } %>
<%-- 											<div class="row" id="schedule-<% out.print(i);%>"> --%>
<!-- 											<input type="hidden"  name="payment_id[]" value="0"/> -->
<%-- 												<% if(i > 1) { %> --%>
<!-- 												<hr/> -->
<%-- 												<% } %> --%>
<!-- 												<div class="col-lg-5 margin-bottom-5"> -->
<!-- 													<div class="form-group" id="error-schedule"> -->
<!-- 														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label> -->
<!-- 														<div class="col-sm-8"> -->
<!-- 															<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/> -->
<!-- 														</div> -->
<!-- 														<div class="messageContainer"></div> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 												<div class="col-lg-3 margin-bottom-5"> -->
<!-- 													<div class="form-group" id="error-payable"> -->
<!-- 														<label class="control-label col-sm-8">% of Net Payable </label> -->
<!-- 														<div class="col-sm-4"> -->
<!-- 															<input type="text" class="form-control" id="payable" name="payable[]" value=""/> -->
<!-- 														</div> -->
<!-- 														<div class="messageContainer"></div> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 												<div class="col-lg-3 margin-bottom-5"> -->
<!-- 													<div class="form-group" id="error-amount"> -->
<!-- 														<label class="control-label col-sm-6">Amount </label> -->
<!-- 														<div class="col-sm-6"> -->
<!-- 															<input type="text" class="form-control" id="amount" name="amount[]" value=""/> -->
<!-- 														</div> -->
<!-- 														<div class="messageContainer"></div> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 												<div class="col-lg-1"> -->
<%-- 													<span><a href="javascript:removeSchedule(<% out.print(i);%>);" class="btn btn-danger btn-xs">x</a></span> --%>
<!-- 												</div> -->
<!-- 											</div> -->
										</div>
<!-- 										<div> -->
<!-- 											<div class="col-lg-12"> -->
<!-- 												<span class="pull-right"> -->
<!-- 													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a> -->
<!-- 												</span> -->
<!-- 											</div> -->
<!-- 										</div> -->
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" class="btn btn-success btn-sm" id="paymentbtn" onclick="updateBuyerPayments();">Update</button>
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
					<form id="offerfrm" name="offerfrm" method="post"  enctype="multipart/form-data">
						<input type="hidden" name="offer_count" id="offer_count" value="<%out.print(buyerOffers.size()+1); %>"/>
						<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>"/>
			 			<div class="row">
			 			<div id="offerresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<% 	
											if(buyerOffers.size() > 0) {
												int j = 1;
												for(BuyerOffer buyerOffer :buyerOffers) { 
											%>
											<input type="hidden"  name="offer_id[]" value="<%out.print(buyerOffer.getId());%>"/>
											<div class="row" id="offer-<% out.print(buyerOffer.getId());%>">
												<div class="col-lg-12" style="padding-bottom:5px;">
<%-- 													<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(buyerOffer.getId());%>);" class="btn btn-danger btn-xs">x</a></span> --%>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% if(buyerOffer.getTitle() != null) { out.print(buyerOffer.getTitle());}%>"/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value="<% if(buyerOffer.getOfferPercentage() != null) { out.print(buyerOffer.getOfferPercentage());}%>"/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% if(buyerOffer.getOfferPercentage() != null) { out.print(buyerOffer.getOfferAmount());}%>"/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value="<% if(buyerOffer.getApplicable() != null) { out.print(buyerOffer.getApplicable());}%>"/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Description </label>
														<div class="col-sm-8">
															<textarea class="form-control" id="description" name="description[]"><% if(buyerOffer.getDescription() != null) { out.print(buyerOffer.getDescription());}%></textarea>
														</div>
														<div class="messageContainer col-sm-3"></div>
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
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
											</div>
											<% 
												j++; 
												} 
											} else {
											%>
											<div class="row" id="offer-1">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-4">Offer Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount" name="discount[]" value=""/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Offer Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Applicable on </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="applicable_on" name="applicable_on[]" value=""/>
														</div>
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-4">Discount Amount </label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>
														</div>
														<div class="messageContainer col-sm-3"></div>
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
														<div class="messageContainer col-sm-3"></div>
													</div>
												</div>
											</div>
											<% } %>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" class="btn btn-success btn-sm" id="offerbtn" onclick="updateBuyerOffer();">Update</button>
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
						<input type="hidden" id="buyer_id" name="buyer_id" value="<%out.print(primary_buyer_id);%>"/>
			 			<div class="row">
			 				<div id="docresponse"></div>
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
													if(buyerUploadDocuments.size() > 0){
														for(BuyerUploadDocuments buyerUploadDocument :buyerUploadDocuments) {
												%>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" id="id" name="doc_id[]" value="<%out.print(buyerUploadDocument.getId());%>"/>
															<input type="hidden" name="doc_name[]" value="<%out.print(buyerUploadDocument.getName()); %>" />
															<label class="control-label col-sm-5"><%out.print(buyerUploadDocument.getName()); %> <span class='text-danger'>*</span></label>
															<div class="col-sm-3">
																<a href="${baseUrl}/<% out.print(buyerUploadDocument.getDocUrl().toString()); %>" target="_blank">View / Download</a>
															</div>
															<div class="col-sm-4">
																<input type="file" class="form-control" name="doc_url[]"/>
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													<% }
													} %>
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;" id="doc-1">
														<div class="form-group" id="error-offer_title">
															<label class="control-label col-sm-5">Other Documents </label>
															<div class="col-sm-3">
																<input type="hidden" name="doc_id[]" value="0" />
																<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/>
															</div>
															<div class="col-sm-4">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
													
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
										<button type="button" name="updatedoc" class="btn btn-success btn-sm" id="updatedoc" onclick="uploadDocuments();">Update</button>
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
        'pan[]': {
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
function updateBuyerOffer(){
	var options = {
	 		target : '#offerresponse', 
	 		beforeSubmit : showAddOfferRequest,
	 		success :  showAddOfferResponse,
	 		url : '${baseUrl}/webapi/buyer/offer/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#offerfrm').ajaxSubmit(options);
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


function updateBuyerPayments() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddPaymentRequest,
	 		success :  showAddPaymentResponse,
	 		url : '${baseUrl}/webapi/buyer/payment/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#paymentfrm').ajaxSubmit(options);
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
function addMoreBuyers() {
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html = '<input type="hidden" name="buyer_id[]" id="buyer_id" value="0"/><div class="row" id="buyer-'+buyers+'"><hr>'
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
					+'<input type="text" class="form-control" id="contact" name="contact[]" value="" maxlength="10"/>'
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

function removeOffer(id) {
	$("#offer-"+id).remove();
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
				+'<hr/><input type="hidden" name="payment_id[]" value="0" />'
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
function deleteSchedule(id){
	var flag = confirm("Are you sure ? You want to delete offer ?");
	if(flag) {
		$.get("${baseUrl}/webapi/buyer/payment/delete/"+id, { }, function(data){
			
			if(data.status == 1) {
				alert(data.message);
				$("#schedule-"+id).remove();
			}
		});
	}
}
function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
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
		+'<div class="form-group" id="error-applicable_on">'
		+'<label class="control-label col-sm-4">Apply </label>'
		+'<div class="col-sm-8">'
		+'<select class="form-control" id="apply" name="apply[]">'
		+'<option value="1">Yes</option>'
		+'<option value="0">No</option>'
		+'</select>'
		+'</div>'
		+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>';
		
	$("#offer_area").append(html);
	$("#offer_count").val(offers);
}
function removeOffer(id) {
	$("#offer-"+id).remove();
}

function deleteOffer(id) {
	var flag = confirm("Are you sure ? You want to delete offer ?");
	if(flag) {
		$.get("${baseUrl}/webapi/buyer/offer/delete/"+id, { }, function(data){
			
			if(data.status == 1) {
				alert(data.message);
				$("#offer-"+id).remove();
			}
		});
	}
}

function uploadDocuments(){
	var options = {
	 		target : '#docresponse', 
	 		beforeSubmit : showAddDocumentRequest,
	 		success :  showAddDocumentResponse,
	 		url : '${baseUrl}/webapi/buyer/update/doc',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#buyerdoc').ajaxSubmit(options);
}

function showAddDocumentRequest(formData, jqForm, options){
	$("#docresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddDocumentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#docresponse").removeClass('alert-success');
       	$("#docresponse").addClass('alert-danger');
		$("#docresponse").html(resp.message);
		$("#docresponse").show();
  	} else {
  		$("#docresponse").removeClass('alert-danger');
        $("#docresponse").addClass('alert-success');
        $("#docresponse").html(resp.message);
        $("#docresponse").show();
        alert(resp.message);
  	}
}

</script>
</body>
</html>