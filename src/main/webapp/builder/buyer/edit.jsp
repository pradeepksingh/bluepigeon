<%@page import="java.util.ArrayList"%>
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
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<BuilderProject> project_list = null; 
	int builder_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
		}
   	}
	if(builder_id > 0 ){
		project_list = new ProjectDetailsDAO().getBuilderActiveProjectList(builder_id);
	}
	List<BuilderEmployee> builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id);
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
<link rel="icon" type="image/png" sizes="16x16"
	href="../plugins/images/favicon.png">
<title>Blue Piegon</title>
<!-- Bootstrap Core CSS -->
<link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
<!-- animation CSS -->
<link href="../css/animate.css" rel="stylesheet">
<!-- Menu CSS -->
<link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
<!-- animation CSS -->
<link href="../css/animate.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="../css/style.css" rel="stylesheet">
<link href="../css/custom.css" rel="stylesheet">
<link href="../css/custom1.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- jQuery -->
<script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
<script src="../js/bootstrap-datepicker.min.js"></script>
<script src="../js/jquery.form.js"></script>
<script src="../js/bootstrapValidator.min.js"></script>

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
		<div id="wrapper">
			<div id="header">
				<%@include file="../partial/header.jsp"%>
			</div>
			<div id="sidebar1">
				<%@include file="../partial/sidebar.jsp"%>
			</div>


			<!-- Left navbar-header end -->
			<!-- Page Content -->
			<div id="page-wrapper" style="min-height: 2038px;">
				<div class="container-fluid">
					<div class="row bg-title">
						<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
							<h4 class="page-title">Update Buyer</h4>
						</div>

						<!-- /.col-lg-12 -->
					</div>

					<div class="row">
						<div class="col-lg-12">
							<div class="white-box">
								<h4 class="page-title">Update Buyer</h4>
								<br>
<!-- 								<ul class="nav tabs-horizontal"> -->
<!-- 									<li class="tab nav-item" aria-expanded="false"> -->
<!-- 										<a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"><span>Update Buyer</span></a> -->
<!-- 									</li> -->
<!-- 									<li class="tab nav-item"> -->
<!-- 										<a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages1"><span>Project Details</span></a> -->
<!-- 									</li> -->
<!-- 									<li class="tab nav-item"><a aria-expanded="false" -->
<!-- 										class="nav-link space1" data-toggle="tab" href="#vimessages2"><span>Buying -->
<!-- 												Details</span></a></li> -->
<!-- 									<li class="tab nav-item"><a aria-expanded="true" -->
<!-- 										class="nav-link space1" data-toggle="tab" href="#vimessages3"><span>Payment -->
<!-- 												Schedule</span></a></li> -->
<!-- 									<li class="tab nav-item"><a aria-expanded="true" -->
<!-- 										class="nav-link space1" data-toggle="tab" href="#vimessages4"><span>Documents</span></a> -->
<!-- 									</li> -->
<!-- 									  <li class="tab nav-item">
<!--                                         <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages5"><span>Pricing Rate</span></a> -->
<!--                                     </li>--> 
<!-- 								</ul> -->
								<ul class="nav nav-tabs">
									<li class="active">
										<a data-toggle="tab" href="#vimessages"><span>Update Buyer</span></a>
									</li>
									<li >
										<a  data-toggle="tab" href="#vimessages1"><span>Project Details</span></a>
									</li>
									<li >
									<a  data-toggle="tab" href="#vimessages2"><span>Buying Details</span></a></li>
									<li><a  data-toggle="tab" href="#vimessages3"><span>Payment	Schedule</span></a></li>
									<li><a  data-toggle="tab" href="#vimessages4"><span>Documents</span></a>
									</li>
									<!--   <li class="tab nav-item">
                                        <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages5"><span>Pricing Rate</span></a>
                                    </li>-->
								</ul>

									<div class="tab-content">
										<div class="tab-pane active" id="vimessages" aria-expanded="false">
										<form id="addbuyer" name="addbuyer" action="" method="post" enctype="multipart/form-data">
											<input type="hidden" name="employee_id" id="employee_id" value="<%out.print(buyers.get(0).getBuilderEmployee().getId());%>" />
											<input type="hidden" name="builder_id" id="builder_id" value="<%out.print(builder_id);%>" />
											<input type="hidden" name="project_id" id="project_id" value="<%out.print(buyers.get(0).getBuilderProject().getId());%>" />
											<input type="hidden" name="building_id" id="building_id" value="<%out.print(buyers.get(0).getBuilderBuilding().getId());%>" />
											<input type="hidden" name="flat_id" id="flat_id" value="<%out.print(buyers.get(0).getBuilderFlat().getId());%>" />
											<input type="file" name="photo[]" value="" style="display:none;" />
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
											<% int i = 1;
											for(Buyer buyer :buyers) { %>
											<div class="col-12" id="deleteb-<% out.print(buyer.getId()); %>">
												<% if(i > 1) { %>
												<hr>
												<span class="pull-right"><a href="javascript:deleteBuyer(<% out.print(buyer.getId()); %>);" class="btn btn-danger btn-xs">x</a></span><br>
												<% } %>
												<input type="hidden" name="buyer_id[]" id="buyer_id" value="<% out.print(buyer.getId());%>" />
												<div class="form-group row">
													<label for="example-text-input" class="col-3 col-form-label">Buyer Name*</label>
													<div class="col-3">
														<input class="form-control" type="text" id="buyer_name" name="buyer_name[]" value="<% out.print(buyer.getName());%>">
													</div>
													<label for="example-text-input" class="col-3 col-form-label">Contact*</label>
													<div class="col-3">
														<input class="form-control" type="text" id="contact" name="contact[]" value="<% out.print(buyer.getMobile());%>" maxlength="10">
													</div>
												</div>

												<div class="form-group row">
													<label for="example-search-input"
														class="col-3 col-form-label">Email*</label>
													<div class="col-3">
														<input class="form-control" type="text" id="email" name="email[]" value="<% out.print(buyer.getEmail());%>">
													</div>
													<label for="example-search-input"
														class="col-3 col-form-label">Pan*</label>
													<div class="col-3">
														<input class="form-control" type="text" id="pan" name="pan[]" value="<% out.print(buyer.getPancard());%>">
													</div>
												</div>

												<div class="form-group row">
													<label for="example-tel-input" class="col-3 col-form-label">Permanent Address*</label>
													<div class="col-3">
														<textarea class="form-control" rows="" cols="" id="address" name="address[]"><% out.print(buyer.getAddress());%></textarea>
													</div>
													<label for="example-tel-input" class="col-3 col-form-label">Owner*</label>
													<div class="col-3">
														<select name="is_primary[]" id="is_primary" class="form-control">
<!-- 															<option value="">Select Owner</option> -->
															<%
																if(!buyer.getIsPrimary()){													
															%>
															<option value="0" selected>Co-Owner</option>
															<%} %>
															<% if(buyer.getIsPrimary()){ %>
															<option value="1" selected>Owner</option>
															<%} %>
														</select>
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
												<div class="form-group row" id="error-project_type">
													<label class="col-12 col-form-label">Documents <span class='text-danger'>*</span></label>
													<div class="col-3">
														<input type="checkbox" name="document_pan[]" value="1" <% if(buyer_pan > 0) { %>checked<% } %>/>
														PAN Card
													</div>
													<div class="col-3">
														<input type="checkbox" name="document_aadhar[]" value="2" <% if(buyer_aadhar > 0) { %>checked<% } %>/>
														Aadhar Card
													</div>
													<div class="col-3">
														<input type="checkbox" name="document_passport[]" value="3" <% if(buyer_passport > 0) { %>checked<% } %>/> Passport
													</div>
													<div class="col-3">
														<input type="checkbox" name="document_rra[]" value="4" <% if(buyer_rra > 0) { %>checked<% } %>/>
														Registered Rent Agreement
													</div>
													<div class="col-3">
														<input type="checkbox" name="document_voterid[]" value="5" <% if(buyer_voterid > 0) { %>checked<% } %>/>
														Vote ID
													</div>
													<div class="messageContainer col-sm-offset-2"></div>
												</div>
											</div>
											<% 
												i++;
											} 
											%>
											<div id="more_buyer_area">
											
											</div>
											<div class="offset-sm-9 col-sm-7">
												<button type="submit" class="btn btn-info waves-effect waves-light m-t-10" >SAVE</button>
												<a href="javascript:addMoreBuyers();">
													<button type="button" class="btn btn-info waves-effect waves-light m-t-10">+ Add New Buyer</button>
												</a>
											</div>
										</form>
										</div>

										<div id="vimessages1" class="tab-pane" aria-expanded="false">
										<form id="addbuyerdetail" name="addbuyerdetail" action="" method="post" >
											<input type="hidden" name="old_flat_id" id="old_flat_id" value="<%out.print(buyers.get(0).getBuilderFlat().getId());%>" />
											<div class="form-group row">
												<label for="example-text-input" class="col-3 col-form-label">Project Name</label>
												<div class="col-6">
													<select name="project_id" id="project_id" class="form-control">
														<option value="">Select Project</option>
														<% for(BuilderProject builderProject : project_list){ %>
														<option value="<% out.print(builderProject.getId()); %>" <% if(buyers.get(0).getBuilderProject().getId() == builderProject.getId()) { %> selected <% } %>>
															<% out.print(builderProject.getName()); %>
														</option>
														<% } %>
													</select>
												</div>
											</div>

											<div class="form-group row">
												<label for="example-text-input" class="col-3 col-form-label">Building</label>
												<div class="col-6">
													<select name="building_id" id="building_id"	class="form-control">
														<option value="">Select Building</option>
														<% for(BuilderBuilding builderBuilding :builderBuildings) { %>
														<option value="<% out.print(builderBuilding.getId()); %>" <% if(builderBuilding.getId() == buyers.get(0).getBuilderBuilding().getId()) { %>selected<% } %> ><% out.print(builderBuilding.getName()); %></option>
														<% } %>
													</select>
												</div>
											</div>
			
											<div class="form-group row">
												<label for="example-text-input" class="col-3 col-form-label">Flat</label>
												<div class="col-6">
													<select name="flat_id" id="flat_id" class="form-control">
														<option value="">Select Flat</option>
														<% for(BuilderFlat builderFlat :builderFlats) { %>
															<option value="<% out.print(builderFlat.getId()); %>" <% if(builderFlat.getId() == buyers.get(0).getBuilderFlat().getId()) { %>selected<% } %>><% out.print(builderFlat.getFlatNo()); %></option>
														<% } %>
													</select>
												</div>
											</div>

											<div class="form-group row">
												<label for="example-text-input" class="col-3 col-form-label">Assign
													Manager</label>
												<div class="col-6">
													<select name="employee_id" id="admin_id" class="form-control">
														<%
															for(BuilderEmployee builderEmployee :builderEmployees) {
														%>
														<option value="<%out.print(builderEmployee.getId());%>" <% if(buyers.get(0).getBuilderEmployee().getId() == builderEmployee.getId()) { %>selected<% } %>>
															<%
																out.print(builderEmployee.getName());
															%>
														</option>
														<%
															}
														%>
													</select>
												</div>
											</div>

											<div class="offset-sm-10 col-sm-7">
												<button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="updateBuyerFlat();" >SAVE</button>
											</div>
										</form>
										</div>

										<div id="vimessages2" class="tab-pane" aria-expanded="false">
										<form id="addbuyingdetail" name="addbuyingdetail" action="" method="post" enctype="multipart/form-data">
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<input type="hidden" name="id" id="id" value="<%out.print(buyingDetails.getId());%>" />
											<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
											<div class="col-12">

												<div class="form-group row">
													<label for="example-text-input" class="col-3 col-form-label">Booking Date</label>
													<div class="col-3">
														<input type="text" class="form-control" id="booking_date" name="booking_date" value="<%if(buyingDetails.getBookingDate()!=null) {out.print(dt1.format(buyingDetails.getBookingDate())); }%>" />
													</div>
													<label for="example-text-input" class="col-3 col-form-label">Base Rate</label>
													<div class="col-3">
														<input type="text" class="form-control" id="base_rate" name="base_rate" value="<% out.print(buyingDetails.getBaseRate()); %>"/>
													</div>
												</div>

												<div class="form-group row">
													<label for="example-search-input" class="col-3 col-form-label">Floor Rising Rate</label>
													<div class="col-3">
														<input type="text" class="form-control" id="rise_rate" name="rise_rate" value="<% out.print(buyingDetails.getFloorRiseRate()); %>"/>
													</div>
													<label for="example-search-input"
														class="col-3 col-form-label">Amenities Facing Rise Rates</label>
													<div class="col-3">
														<input type="text" class="form-control" id="amenity_rate" name="amenity_rate" value="<% out.print(buyingDetails.getAmenityFacingRate()); %>"/>
													</div>
												</div>

												<div class="form-group row">
													<label for="example-tel-input" class="col-3 col-form-label">Parking Rates</label>
													<div class="col-3">
														<input type="text" class="form-control" id="parking" name="parking" value="<% out.print(buyingDetails.getParkingRate()); %>" />
													</div>
													<label for="example-tel-input" class="col-3 col-form-label">Maintance</label>
													<div class="col-3">
														<input type="text" class="form-control" id="maintenance" name="maintenance" value="<% out.print(buyingDetails.getMaintenance()); %>" />
													</div>
												</div>

												<div class="form-group row">
													<label for="example-tel-input" class="col-3 col-form-label">Stamp Duty</label>
													<div class="col-3">
														<input type="text" class="form-control" id="stamp_duty" name="stamp_duty" value="<% out.print(buyingDetails.getStampDuty()); %>" />
													</div>
													<label for="example-tel-input" class="col-3 col-form-label">Taxes</label>
													<div class="col-3">
														<input type="text" class="form-control" id="tax" name="tax" value="<% out.print(buyingDetails.getTaxes()); %>"/>
													</div>
												</div>

												<div class="form-group row">
													<label for="example-search-input"
														class="col-3 col-form-label">VAT</label>
													<div class="col-3">
														<input type="text" class="form-control" id="vat" name="vat" value="<% out.print(buyingDetails.getVat()); %>" />
													</div>
													<label for="example-search-input"
														class="col-3 col-form-label">Tenure</label>
													<div class="col-3 input-group">
														<input type="text" class="form-control" id="tenure" name="tenure" value="<% out.print(buyingDetails.getTenure()); %>"/> <span class="input-group-addon">Months</span>
													</div>
												</div>
												<div class="form-group row">
													<label for="example-search-input"
														class="col-3 col-form-label">Registration Charges</label>
													<div class="col-3">
														<input class="form-control" type="text" id="registration" name="registration" value="<% out.print(buyingDetails.getRegistration()); %>" />
													</div>
												</div>
												
												<% if(buyeroffersize <= 0) {%>
												<div class="form-group row">
													<button type="button" class="col-2" onclick="showOffers()">+ADD offers</button>
												</div>
												<% } else { %>
												<hr>
												<% } %>
												<input type="hidden" name="offer_id[]" id="offer_id" value="<% if(buyeroffersize > 0) { out.print(buyerOffers.get(0).getId()); } else { %>0<% } %>" />
												<div id="displayoffers" style="display: <% if(buyeroffersize > 0) {%>block<% } else { %>none<% } %>;">
													<div class="offset-sm-11 col-sm-7">
														<i class="fa fa-times"></i>
													</div>
													<div class="form-group row">
														<label for="example-search-input"
															class="col-2 col-form-label">Offer Title*</label>
														<div class="col-2">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% if(buyeroffersize > 0) { out.print(buyerOffers.get(0).getTitle()); }%>" />
														</div>
														<label for="example-search-input" class="col-2 col-form-label">Discount(%)*</label>
														<div class="col-2">
															<input type="text" class="form-control" id="discount" name="discount[]" value="<% if(buyeroffersize > 0) { out.print(buyerOffers.get(0).getOfferPercentage()); }%>" />
														</div>
														<label for="example-search-input"
															class="col-2 col-form-label">Discount Amount</label>
														<div class="col-2">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% if(buyeroffersize > 0) { out.print(buyerOffers.get(0).getOfferAmount()); }%>" />
														</div>
													</div>
													<div class="form-group row">
														<label for="example-search-input" class="col-2 col-form-label">Description</label>
														<div class="col-2">
															<textarea class="form-control" id="description" name="description[]"><% if(buyeroffersize > 0) { out.print(buyerOffers.get(0).getDescription()); }%></textarea>
														</div>
														<label for="example-search-input" class="col-2 col-form-label">Offer Type</label>
														<div class="col-2">
															<select class="form-control" id="applicable" name="applicable_on[]">
																<option value="1" <% if(buyeroffersize > 0) { if(buyerOffers.get(0).getApplicable() == 1) { out.print("selected"); }}%>>Percentage</option>
																<option value="2" <% if(buyeroffersize > 0) { if(buyerOffers.get(0).getApplicable() == 2) { out.print("selected"); }}%>>Discount</option>
															</select>
														</div>
														<label for="example-search-input" class="col-2 col-form-label">Status</label>
														<div class="col-2">
															<select class="form-control" id="status" name="apply[]">
																<option value="1" <% if(buyeroffersize > 0) { if(buyerOffers.get(0).getStatus() == 1) { out.print("selected"); }}%>>Active</option>
																<option value="0" <% if(buyeroffersize > 0) { if(buyerOffers.get(0).getStatus() == 0) { out.print("selected"); }}%>>Inactive</option>
															</select>
														</div>
													</div>
												</div>
												<div class="offset-sm-10 col-sm-7">
													<button type="submit" class="btn btn-info waves-effect waves-light m-t-10" >SAVE</button>
												</div>
											</div>
										</form>
										</div>

										<div id="vimessages3" class="tab-pane" aria-expanded="true">
										<form id="addbuyerpayment" name="addbuyerpayment" action="" method="post" enctype="multipart/form-data">
											<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
											<% if(buyerPayments.size() > 0) { %>
											<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(buyerPayments.size()); %>" />
											<% int ii=0; for(BuyerPayment buyerPayment :buyerPayments) { %>
											<div class="form-group row" id="schedule-<% out.print(buyerPayment.getId()); %>">
												<input type="hidden" name="payment_id[]" id="payment_id" value="<%out.print(buyerPayment.getId());%>" />
												<label for="example-search-input" class="col-2 col-form-label">Milestone*</label>
												<div class="col-2">
													<input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<% out.print(buyerPayment.getMilestone());%>" />
												</div>
												<label for="example-search-input" class="col-2 col-form-label">% of net payable</label>
												<div class="col-2">
													<input type="text" class="form-control" id="payable<%out.print(ii); %>"  onkeypress=" return isNumber(event, this);"  name="payable[]" value="<% out.print(buyerPayment.getNetPayable());%>" />
												</div>
												<label for="example-search-input" class="col-1 col-form-label">Amount</label>
												<div class="col-2">
													<input type="text" class="form-control" id="amount<%out.print(ii); %>"  onkeypress=" return isNumber(event, this);" name="amount[]" value="<% out.print(buyerPayment.getAmount());%>" />
												</div>
<%-- 												<a href="javascript:deleteSchedule(<%out.print(buyerPayment.getId());%>);" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></a> --%>
											</div>
											<%ii++; } %>
											<% } 
											//else { %>
<!-- 											<input type="hidden" name="schedule_count" id="schedule_count" value="1" /> -->
<!-- 											<div class="form-group row"> -->
<!-- 												<input type="hidden" name="payment_id[]" id="payment_id" value="0" /> -->
<!-- 												<label for="example-search-input" class="col-2 col-form-label">Milestone*</label> -->
<!-- 												<div class="col-2"> -->
<!-- 													<input type="text" class="form-control" id="schedule" name="schedule[]" value="" /> -->
<!-- 												</div> -->
<!-- 												<label for="example-search-input" class="col-2 col-form-label">% of net payable</label> -->
<!-- 												<div class="col-2"> -->
<!-- 													<input type="text" class="form-control" id="payable" name="payable[]" value="" /> -->
<!-- 												</div> -->
<!-- 												<label for="example-search-input" class="col-1 col-form-label">Amount</label> -->
<!-- 												<div class="col-2"> -->
<!-- 													<input type="text" class="form-control" id="amount" name="amount[]" value="" /> -->
<!-- 												</div> -->
<!-- 												<i class="fa fa-times"></i> -->
<!-- 											</div> -->
<%-- 											<% } %> --%>
<!-- 											<div id="more_schedules"></div> -->
<!-- 											<div class="offset-sm-9 col-sm-7"> -->
<!-- 												<a href="javascript:addMoreSchedule();"> -->
<!-- 													<button type="button" class="">+ Add More Schedules</button> -->
<!-- 												</a> -->
<!-- 											</div> -->
											<div class="offset-sm-10 col-sm-7">
												<button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="updateBuyerPayments();">SAVE</button>
											</div>
										</form>
										</div>
										<div id="vimessages4" class="tab-pane" aria-expanded="true">
										<form id="addbuyerdocs" name="addbuyerdocs" action="" method="post" enctype="multipart/form-data">
											<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
											<% for(BuyerUploadDocuments buyerUploadDocument :buyerUploadDocuments) { %>
											<div class="form-group row">
												<input type="hidden" name="doc_id[]" value="<% out.print(buyerUploadDocument.getId()); %>" />
												<input type="hidden" name="doc_name[]" value="<% out.print(buyerUploadDocument.getName()); %>" />
												<label for="example-text-input" class="col-6 col-form-label"><% out.print(buyerUploadDocument.getName()); %></label>
												<div class="col-2">
													<a href="${baseUrl}/<% out.print(buyerUploadDocument.getDocUrl().toString()); %>" target="_blank">View / Download</a>
												</div>
												<div class="col-2">
													<input type="file" class="form-control" name="doc_url[]" />
												</div>
											</div>
											<% } %>
											<div class="form-group row">
												<label for="example-text-input" class="col-6 col-form-label">Other Documents</label>
												<div class="col-2">
													<input type="hidden" name="doc_id[]" value="0" />
													<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name" />
												</div>
												<div class="col-2">
													<input type="file" class="form-control" name="doc_url[]" />
												</div>
											</div>
											<div class="offset-sm-9 col-sm-7">
												<button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="uploadDocuments();">SAVE</button>
											</div>
										</form>
										</div>
									</div>
							</div>

						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
			<div id="sidebar1">
				<%@include file="../partial/footer.jsp"%>
			</div>

		</div>
		<!-- /#page-wrapper -->

		<!-- /#wrapper -->
	</div>
</body>
</html>
<script type="text/javascript">
function calculateAmount(id){

	var amount = $("#payable"+id).val()*$("#h_sale_value").val()/100;
		$("#amount"+id).val(amount.toFixed(1));
	}

	function calcultatePercentage(id){
		var percentage = $("#amount"+id).val()/$("#h_sale_value").val()*100;
		$("#payable"+id).val(percentage.toFixed(1));
	}
	function showOffers() {
		$("#displayoffers").show();
	}
	function isNumber(evt, element) {

	    var charCode = (evt.which) ? evt.which : event.keyCode

	    if (
	        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
	        (charCode < 48 || charCode > 57))
	        return false;

	    return true;
	} 
	
	$('#booking_date').datepicker({
		format : "dd MM yyyy"
	});

	$("#project_id").change(
			function() {
				$.get("${baseUrl}/webapi/buyer/buildings/names/"
						+ $("#project_id").val(), {}, function(data) {
					var html = '<option value="0">Select Building</option>';
					$(data).each(
							function(index) {
								html = html
										+ '<option value="'+data[index].id+'">'
										+ data[index].name + '</option>';
							});
					$("#building_id").html(html);
				}, 'json');
			});
	$("#building_id").change(
			function() {
				$.get("${baseUrl}/webapi/buyer/building/available/flat/names/"
						+ $("#building_id").val(), {}, function(data) {
					var html = '<option value="0">Select Flat</option>';
					$(data).each(
							function(index) {

								html = html
										+ '<option value="'+data[index].id+'">'
										+ data[index].name + '</option>';
							});
					$("#flat_id").html(html);
				}, 'json');
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
	                    message: 'The Mobile is required and cannot be empty'
	                },
	                regexp: {
	                    regexp: '^[7-9][0-9]{9}$',
	                    message: 'Invalid Mobile Number'
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
	   	$('#addbuyer').ajaxSubmit(options);
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
	
	function updateBuyerFlat() {
		var options = {
		 		target : '#flatresponse', 
		 		beforeSubmit : showAddFlatRequest,
		 		success :  showAddFlatResponse,
		 		url : '${baseUrl}/webapi/buyer/update/flat',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#addbuyerdetail').ajaxSubmit(options);
	}
	function showAddFlatRequest(formData, jqForm, options){
		$("#flatresponse").hide();
	   	var queryString = $.param(formData);
		return true;
	}
	   	
	function showAddFlatResponse(resp, statusText, xhr, $form){
		if(resp.status == '0') {
			$("#flatresponse").removeClass('alert-success');
	       	$("#flatresponse").addClass('alert-danger');
			$("#flatresponse").html(resp.message);
			$("#flatresponse").show();
	  	} else {
	  		$("#flatresponse").removeClass('alert-danger');
	        $("#flatresponse").addClass('alert-success');
	        $("#flatresponse").html(resp.message);
	        $("#flatresponse").show();
	        alert(resp.message);
	  	}
	}
	
	$('#addbuyingdetail').bootstrapValidator({
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
		 		url : '${baseUrl}/webapi/buyer/update/pricenoffer',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#addbuyingdetail').ajaxSubmit(options);
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
	   	$('#addbuyerpayment').ajaxSubmit(options);
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
	
	function uploadDocuments(){
		var options = {
		 		target : '#imageresponse', 
		 		beforeSubmit : showAddDocumentRequest,
		 		success :  showAddDocumentResponse,
		 		url : '${baseUrl}/webapi/buyer/update/doc',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#addbuyerdocs').ajaxSubmit(options);
	}
	
	function showAddDocumentRequest(formData, jqForm, options){
		$("#paymentresponse").hide();
	   	var queryString = $.param(formData);
		return true;
	}
	   	
	function showAddDocumentResponse(resp, statusText, xhr, $form){
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

		var html = '<input type="hidden" name="buyer_id[]" value="0"/><div class="tab-content" id="buyer-'+buyers+'"><hr>'
				+ '<span class="pull-right"><a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span><br>'
				+ '<div class="col-12">'
				+ '<div class="form-group row">'
				+ '<label for="example-text-input" class="col-3 col-form-label">Buyer Name</label>'
				+ '<div class="col-3">'
				+ ' <input class="form-control" type="text" id="buyer_name" name="buyer_name[]" value="">'
				+ '</div>'
				+ '<label for="example-text-input" class="col-3 col-form-label">Contact</label>'
				+ '<div class="col-3">'
				+ '<input class="form-control" type="text" id="contact" name="contact[]" value="" maxlength="10">'
				+ '</div>'
				+ '</div>'
				+ '<div class="form-group row">'
				+ '<label for="example-text-input" class="col-3 col-form-label">Email</label>'
				+ '<div class="col-3">'
				+ ' <input class="form-control" type="text" id="email" name="email[]" value="">'
				+ '</div>'
				+ '<label for="example-text-input" class="col-3 col-form-label">PAN</label>'
				+ '<div class="col-3">'
				+ '<input class="form-control" type="text" id="pan" name="pan[]" value="">'
				+ '</div>'
				+ '</div>'
				+ '<div class="form-group row">'
				+ '<label for="example-text-input" class="col-3 col-form-label"> Perm. Address</label>'
				+ '<div class="col-3">'
				+ ' <input class="form-control" type="text" id="address" name="address[]" value="">'
				+ '</div>'
				+ '<label for="example-text-input" class="col-3 col-form-label">Owner *</label>'
				+ '<div class="col-3">'
				+ '<select name="is_primary[]" id="is_primary" class="form-control">'
				//+ '<option value="">Select Owner</option>'
				+ '<option value="0" selected>Co-Owner</option>'
				//+ '<option value="1">Owner</option>'
				+ '</select>'
				+ '</div>'
				+ '</div>'
				+ '<div class="form-group row" id="error-project_type">'
				+ '<label class="col-12 col-form-label">Documents <span class="text-danger">*</span></label>'
				+ '<div class="col-3">'
				+ '<input type="checkbox" name="document_pan[]" value="1" /> PAN Card'
				+ '</div>'
				+ '<div class="col-3">'
				+ '<input type="checkbox" name="document_aadhar[]" value="2" /> Aadhar Card'
				+ '</div>'
				+ '<div class="col-3">'
				+ '<input type="checkbox" name="document_passport[]" value="3" /> Passport'
				+ '</div>'
				+ '<div class="col-3">'
				+ '<input type="checkbox" name="document_rra[]" value="4" /> Registered Rent Agreement'
				+ '</div>'
				+ '<div class="col-3">'
				+ '<input type="checkbox" name="document_voterid[]" value="5" /> Vote ID'
				+ '</div>'
				+ '<div class="messageContainer"></div>' + '</div>'
				+ '</div>'
				+ '</div>';

		$("#more_buyer_area").append(html);
		$("#buyer_count").val(buyers);
	}
	function removeBuyer(id) {
		$("#buyer-" + id).remove();
	}
	function deleteBuyer(id) {
		$.get("${baseUrl}/webapi/buyer/delete/coowner/"+id,{},function(data){
			if(data.status == 0 ){
				alert(data.message);
			} else {
				window.location.reload();
			}
		});
	}
	function addMoreSchedule() {
		var schedule_count = parseInt($("#schedule_count").val());
		schedule_count++;
		var html = '<input type="hidden" name="payment_id[]" id="payment_id" value="0" /><div class="tab-content" id="schedule-'+schedule_count+'">'
				+ '<hr/>'
				+ '<span class="pull-right">	<a href="javascript:removeSchedule('
				+ schedule_count
				+ ');" class="btn btn-danger btn-xs">x</a></span><br>'
				+ '<div class="col-12">'
				+ '<div class="form-group row">'
				+ '<label for="example-search-input" class="col-2 col-form-label">Milestone</label>'
				+ '<div class="col-2">'
				+ '<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
				+ '</div>'
				+ '<label for="example-search-input" class="col-2 col-form-label">% of Net Payable</label>'
				+ '<div class="col-2">'
				+ '<input type="text" class="form-control"  id="payable" name="payable[]" value=""/>'
				+ '</div>'
				+ '<label for="example-search-input" class="col-1 col-form-label">Amount</label>'
				+ '<div class="col-2">'
				+ '<input type="text" class="form-control" id="amount" name="amount[]" value=""/>'
				+ '</div>' + '</div>' + '</div>'

				+ '</div>';
		$("#more_schedules").append(html);
		$("#schedule_count").val(schedule_count);
	}
	function removeSchedule(id) {
		$("#schedule-" + id).remove();
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

	function addMoreDoc() {
		var doc_count = parseInt($("#doc_count").val());
		doc_count++;
		var html = '<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;" id="doc-'+doc_count+'">'
				+ '<div class="form-group" id="error-offer_title">'
				+ '<label class="control-label col-sm-5">Other Documents </label>'
				+ '<div class="col-sm-3">'
				+ '<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/>'
				+ '</div>'
				+ '<div class="col-sm-3">'
				+ '<input type="file" class="form-control" name="doc_url[]" />'
				+ '</div>'
				+ '<div class="col-sm-1"><a href="javascript:removeDoc('
				+ doc_count
				+ ');" class="btn btn-danger btn-sm">X</a></div>'
				+ '<div class="messageContainer col-sm-offset-5"></div>'
				+ '</div>' + '</div>';
		$("#doc_area").append(html);
		$("#doc_count").val(doc_count);
	}

	function removeDoc(id) {
		$("#doc-" + id).remove();
	}

	function show() {
		$("#vimessages1").show();
		$("#111").hide();

	}

	function show1() {
		$("#vimessages2").show();
		$("#vimessages1").hide();

	}

	function previous1() {
		$("#vimessages1").hide();
		$("#111").show();
	}

	function show2() {
		$("#vimessages3").show();
		$("#vimessages2").hide();

	}
	function previous2() {
		$("#vimessages2").hide();
		$("#vimessages1").show();

	}

	function show3() {
		$("#vimessages4").show();
		$("#vimessages3").hide();

	}
	function previous3() {
		$("#vimessages3").hide();
		$("#vimessages2").show();

	}
	function previous4() {
		$("#vimessages4").hide();
		$("#vimessages3").show();

	}
</script>