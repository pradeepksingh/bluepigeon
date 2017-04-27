<%@page import="org.bluepigeon.admin.model.BuyerDocuments"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	int buyer_id = 0;
	BuyerDAO buyerDAO = new BuyerDAO();
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	List<BuilderProject> project_list = new ProjectDetailsDAO().getBuilderProjectList();
	int p_user_id = 0;
	buyer_id = Integer.parseInt(request.getParameter("buyer_id"));
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
   }
	List<Buyer> buyers = buyerDAO.getBuyerById(buyer_id);
	//List<BuyerDocuments> buyerDocuments = buyerDAO.getBuyerDocumentsByBuyerId(buyer_id);
	int builder_id = 1;
	List<BuilderEmployee> builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id);
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
					Update Buyer
				</h1>
			</div>
			<ul class="nav nav-tabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#buyingdetail">Buying Details</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#documents">Documents</a></li>
			</ul>
			<form id="addbuyer" name="addbuyer" action="" method="post" enctype="multipart/form-data">
				<input type="hidden" name="buyer_id" value="<% out.print(buyer_id); %>" />
				<div class="tab-content">
				  	<div id="basic" class="tab-pane fade in active">
						<div id="basic" class="tab-pane fade in active">
							<div class="row" id="buyer-1">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div id="buyer_area">
											<%
												int i = 0;
												if(buyers.size()>0){
													for(Buyer buyer:buyers){	
											%>
											<input type="hidden" name="buyer_count" id="buyer_count" value="<%out.print(i);%>"/>
												<div class="row" id="buyer-<%out.print(i);%>">
												<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeBuyer(<%out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span></div>
													<div class="row">
														<div class="col-lg-6 margin-bottom-5">
															<div class="form-group" id="error-buyer_name">
															<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" value="<%out.print(buyer.getName()); %>" id="buyer_name" name="buyer_name[]" value="" placeholder="Full name"/>
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
														<div class="col-lg-6 margin-bottom-6">
															<div class="form-group" id="error-contact">
																<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" value="<%out.print(buyer.getMobile()); %>" id="contact" name="contact[]" value="" placeholder="Mobile Number"/>
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
												    </div>
												    <div class="row">
														<div class="col-lg-6 margin-bottom-6">
															<div class="form-group" id="error-email">
																<label class="control-label col-sm-4">Email </label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" value="<%out.print(buyer.getEmail());%>" id="email" name="email[]" value="" placeholder="Email ID"/>
																</div>
																<div class="messageContainer col-sm-offset-4"></div><br/>
															</div>
														</div>
														<div class="col-lg-6 margin-bottom-6">
															<div class="form-group" id="error-email">
																<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" value="<%out.print(buyer.getPancard()); %>" id="pan" name="pan[]" value="" placeholder="Pancard number"/>
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-6 margin-bottom-5">
															<div class="form-group" id="error-applicable_on">
															<label class="control-label col-sm-4"> Premanent Address <span class="text-danger">*</span></label>
															<div class="col-sm-8">
															<textarea class="form-control" id="address" name="address[]" placeholder="Permanent Address"><%out.print(buyer.getAddress()); %></textarea>
															</div>
															<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
														<div class="col-lg-6 margin-bottom-6">
															<div class="form-group" id="error-state_id">
																<label class="control-label col-sm-4">Owner <span class='text-danger'>*</span></label>
																<div class="col-sm-8">
																	<select name="is_primary[]" id="is_primary" class="form-control">
													                    <option value="">Select Owner</option>
													                     <option value="0" <%if(buyer.getIsPrimary() == false) {%>selected<%} %>>Co-Owner</option>
													                      <option value="1" <%if(buyer.getIsPrimary() == true) {%>selected<%} %>>Owner</option>
														          	</select>
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-6 margin-bottom-5">
															<div class="form-group" id="error-applicable_on">
																<label class="control-label col-sm-4"> Upload Buyer Pic <span class="text-danger">*</span></label>
																<div class="col-sm-8">
																<img alt="Buyer pic" src="${baseUrl}/<% out.print(buyer.getPhoto()); %>" width="200px;">
																	<input type="file" name="photo[]" class="form-control" />
																</div>
																<div class="messageContainer col-sm-offset-4"></div>
															</div>
														</div>
													</div>
													<hr>
													<%
														if(buyer != null){
															List<BuyerDocuments> docList = buyerDAO.getBuyerDocumentsByBuyerId(buyer.getId());
															for(BuyerDocuments buyerDocuments : docList){
														
													%>
													<div class="col-lg-12 margin-bottom-6">
															<div class="form-group" id="error-project_type">
																<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
																<div class="col-sm-10">
																	<div class="col-sm-3">
																		<input type="checkbox" name="document_pan[]" value="1" <%if(buyerDocuments.getDocuments() == "1"){ %>checked<%} %> /> PAN Card
																	</div>
																	<div class="col-sm-3">
																		<input type="checkbox" name="document_aadhar[]" value="2" <%if(buyerDocuments.getDocuments() == "2"){ %>checked<%} %>/> Aadhar Card
																	</div>
																	<div class="col-sm-3">
																		<input type="checkbox" name="document_passport[]" value="3" <%if(buyerDocuments.getDocuments() == "3"){ %>checked<%} %>/> Passport 
																	</div>
																	<div class="col-sm-3">
																		<input type="checkbox" name="document_rra[]" value="4" <%if(buyerDocuments.getDocuments() == "4"){ %>checked<%} %>/> Registered Rent Agreement 
																	</div>
																	<div class="col-sm-3">
																		<input type="checkbox" name="document_voterid[]" value="5" <%if(buyerDocuments.getDocuments() == "5") {%>checked<%} %> /> Vote ID 
																	</div>
																	<div class="messageContainer col-sm-offset-2"></div>
																</div>
															</div>
														</div>
														<%
																	}
																}
															}
														}
														%>
													</div>
												</div>
											<hr>
											<div class="row">
												<div class="col-lg-12">
													<label class="control-label col-lg-8"><b>Project Details</b></label>
													<span class="pull-right">
														<a href="javascript:addMoreBuyers();" class="btn btn-info btn-xs">+ Add More Buyers</a>
													</span>
													<br><br>
												</div>
												<br>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-country_id">
														<label class="control-label col-sm-4">Project <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="project_id" id="project_id" class="form-control">
											                    <option value="">Select Project</option>
											                    <% for(BuilderProject builderProject : project_list){ %>
																<option value="<% out.print(builderProject.getId());%>" ><% out.print(builderProject.getName());%></option>
																<% } %>
												             </select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-state_id">
														<label class="control-label col-sm-4">Building <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="building_id" id="building_id" class="form-control">
											                    <option value="">Select Building</option>
												          	</select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-state_id">
														<label class="control-label col-sm-4">Flat <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="flat_id" id="flat_id" class="form-control">
											                    <option value="">Select Flat</option>
												          	</select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-state_id">
														<label class="control-label col-sm-4">Assign Manager <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="admin_id" id="admin_id" class="form-control">
																<% for(BuilderEmployee builderEmployee :builderEmployees) { %>
											                  	<option value="<% out.print(builderEmployee.getId());%>"><% out.print(builderEmployee.getName());%></option>
											                  	<% } %>
												          	</select>
														</div>
														<div class="messageContainer col-sm-offset-4"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<br> <br>
					</div>
					<div id="buyingdetail" class="tab-pane fade">
			 			<div class="row">
			 				<div id="pricingresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="row">
											<div class="col-lg-6">
												<div class="form-group" id="error-base_unit">
													<label class="control-label col-sm-4">Booking Date <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
															<input type="text" class="form-control" id="booking_date" name="booking_date" value=""/>
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-base_rate">
													<label class="control-label col-sm-4">Base Rate <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="base_rate" name="base_rate" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-rise_rate">
													<label class="control-label col-sm-4">Floor Rise Rate<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="rise_rate" name="rise_rate"/>
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Amenities Facing Rate<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-maintenance">
													<label class="control-label col-sm-4">Maintenance Charge <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="maintenance" name="maintenance" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tenure">
													<label class="control-label col-sm-4">Tenure <span class='text-danger'>*</span></label>
													<div class="col-sm-8 input-group" style="padding: 0px 12px;">
														<input type="text" class="form-control" id="tenure" name="tenure" />
														<span class="input-group-addon">Months</span>
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-amenity_rate">
													<label class="control-label col-sm-4">Registration<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="registration" name="registration" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Parking <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="parking" name="parking" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Stamp Duty <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-tax">
													<label class="control-label col-sm-4">Tax<span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="tax" name="tax" />
													</div> 
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-vat">
													<label class="control-label col-sm-4">VAT <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="vat" name="vat" />
													</div>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
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
											<div class="row" id="offer-1">
												<div class="col-lg-12" style="padding-bottom:5px;">
<!-- 													<span class="pull-right"><a href="javascript:removeOffer(1);" class="btn btn-danger btn-xs">x</a></span> -->
												</div>
												<div class="row">
												<div class="col-lg-6 margin-bottom-5" style="margin-bottom:5px;">
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
												</div>
												<div class="row">
												<div class="col-lg-6 margin-bottom-5" style="margin-bottom:5px;">
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
												</div>
												<div class="row">
												<div class="col-lg-6 margin-bottom-5" style="margin-bottom:5px;">
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
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="payment" class="tab-pane fade">
						<input type="hidden" name="schedule_count" id="schedule_count" value="1"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<div class="row" id="schedule-1">
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
													<span><a href="javascript:removeSchedule(1);" class="btn btn-danger btn-xs">x</a></span>
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
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="documents" class="tab-pane fade">
						<input type="hidden" name="doc_count" id="doc_count" value="1"/>
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
													<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;">
														<div class="form-group" id="error-offer_title">
															<input type="hidden" name="doc_name[]" value="Agreement" />
															<label class="control-label col-sm-5">Agreement <span class='text-danger'>*</span></label>
															<div class="col-sm-7">
																<input type="file" class="form-control" name="doc_url[]" />
															</div>
															<div class="messageContainer col-sm-offset-5"></div>
														</div>
													</div>
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
										<button type="submit" name="addemp" class="btn btn-success btn-sm" id="addemp">SAVE</button>
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
<%@include file="../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#booking_date').datepicker({
	format: "dd MM yyyy"
});

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/buildings/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/building/available/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
$('#addbuyer').bootstrapValidator({
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
                    message: 'Please select project'
                }
            }
        },
        building_id: {
            validators: {
                notEmpty: {
                    message: 'Please select building'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Please select flat'
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
                    message: 'Buyer mobile is required and cannot be empty'
                }
            }
        },
        'pan[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer pancard is required and cannot be empty'
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
        'photo[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer photo is required and cannot be empty'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Please select flat'
                }
            }
        },
        booking_date: {
            validators: {
                notEmpty: {
                    message: 'Please select booking date'
                }
            }
        },
        base_rate: {
            validators: {
                notEmpty: {
                    message: 'Base rate required and can not be empty'
                }
            }
        },
        rise_rate: {
            validators: {
                notEmpty: {
                    message: 'Floor rise rate required and can not be empty'
                }
            }
        },
        amenity_rate: {
            validators: {
                notEmpty: {
                    message: 'Amenity facing rate required and can not be empty'
                }
            }
        },
        maintenance: {
            validators: {
                notEmpty: {
                    message: 'Maintenance charge required and can not be empty'
                }
            }
        },
        tenure: {
            validators: {
                notEmpty: {
                    message: 'Tennure required and can not be empty'
                }
            }
        },
        registration: {
            validators: {
                notEmpty: {
                    message: 'Registration fee required and can not be empty'
                }
            }
        },
        parking: {
            validators: {
                notEmpty: {
                    message: 'Parking rate required and can not be empty'
                }
            }
        },
        stamp_duty: {
            validators: {
                notEmpty: {
                    message: 'Stamp duty charges required and can not be empty'
                }
            }
        },
        tax: {
            validators: {
                notEmpty: {
                    message: 'Tax required and can not be empty'
                }
            }
        },
        vat: {
            validators: {
                notEmpty: {
                    message: 'Vat required and can not be empty'
                }
            }
        },
        
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addBuyer();
});

function addBuyer() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addbuyer').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/buyer/list.jsp";
  	}
}

function addMoreBuyers() {
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html = '<div class="row" id="buyer-'+buyers+'"><hr>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span></div>'
			+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-buyer_name">'
			+'<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
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
		+'<div class="col-lg-6 margin-bottom-6">'
			+'<div class="form-group" id="error-email">'
				+'<label class="control-label col-sm-4">Email </label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="email" name="email[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div><br/>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
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
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4"> Prem. Address <span class="text-danger">*</span></label>'
			+'<div class="col-sm-8">'
			+'<textarea class="form-control" id="address" name="address[]" ></textarea>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
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
	+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
				+'<label class="control-label col-sm-4"> Upload Buyer Pic <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="file" name="photo[]" class="form-control" />'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<hr>'
	+'<div class="col-lg-12 margin-bottom-6">'
			+'<div class="form-group" id="error-project_type">'
				+'<label class="control-label col-sm-2">Documents <span class="text-danger">*</span></label>'
				+'<div class="col-sm-10">'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_pan[]" value="1" /> PAN Card'
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_aadhar[]" value="2" /> Aadhar Card' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_passport[]" value="3" /> Passport' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_rra[]" value="4" /> Registered Rent Agreement' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_voterid[]" value="5" /> Vote ID' 
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

function addMoreDoc() {
	var doc_count = parseInt($("#doc_count").val());
	doc_count++;
	var html = '<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;" id="doc-'+doc_count+'">'
			  +'<div class="form-group" id="error-offer_title">'
			  +'<label class="control-label col-sm-5">Other Documents </label>'
			  +'<div class="col-sm-3">'
			  +'<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/>'
			  +'</div>'
			  +'<div class="col-sm-3">'
			  +'<input type="file" class="form-control" name="doc_url[]" />'
			  +'</div>'
			  +'<div class="col-sm-1"><a href="javascript:removeDoc('+doc_count+');" class="btn btn-danger btn-sm">X</a></div>'
			  +'<div class="messageContainer col-sm-offset-5"></div>'
			  +'</div>'
			  +'</div>';
	$("#doc_area").append(html);
	$("#doc_count").val(doc_count);
}

function removeDoc(id) {
	$("#doc-"+id).remove();
}

</script>
</body>
</html>