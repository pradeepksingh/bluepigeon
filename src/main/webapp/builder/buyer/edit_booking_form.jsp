<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
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
	int emp_id=0;
	BuilderFlat builderFlat = null;
	String taxLabel1 = "";
	String taxLabel2 = "";
	String taxLabel3 = "";
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
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
	int project_id = 0;
	int building_id = 0;
	
	String projectName = "";
	String buildingName = "";
	String flatNo = "";
	String localityName = "";
	BookingFlatList bookingFlatList = null;
	if (request.getParameterMap().containsKey("flat_id")) {
		flat_id = Integer.parseInt(request.getParameter("flat_id"));
		buyers = new BuyerDAO().getFlatBuyersByFlatId(flat_id);
		builderBuildings = new ProjectDAO().getBuilderProjectBuildings(buyers.get(0).getBuilderProject().getId());
		builderFlats = new ProjectDAO().getBuilderAllFlatsByBuildingId(buyers.get(0).getBuilderBuilding().getId());
		buyingDetails = new BuyerDAO().getBuyingDetailsByBuyerId(buyers.get(0).getId());
		buyerOffers = new BuyerDAO().getBuyerOffersByBuyerId(buyers.get(0).getId());
		builderFlat = new ProjectDAO().getBuilderFlatById(flat_id);
		bookingFlatList = new ProjectDAO().getFlatdetails(flat_id,emp_id);
		buyeroffersize = buyerOffers.size();
		buyerPayments = new BuyerDAO().getBuyerPaymentsByBuyerId(buyers.get(0).getId());
		buyerUploadDocuments = new BuyerDAO().getBuyerUploadDocumentsByBuyerId(buyers.get(0).getId());
		for(Buyer buyer :buyers) {
			if(buyer.getIsPrimary()) {
				primary_buyer_id = buyer.getId();
			}
		}
		if(builderFlat != null){
			 projectName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName();
			 buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
			 flatNo = builderFlat.getFlatNo();
			 localityName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getLocalityName();
			 project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
			 building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
			 taxLabel1 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel1();
			 taxLabel2 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel2();
			 taxLabel3 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel3();
			 
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
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
   <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/updatebuyer.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
      <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/bootstrap-datepicker.min.js"></script>
      <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
     <script type="text/javascript" src="../js/selectize.min.js"></script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
         <%@include file="../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1">
        <%@include file="../partial/sidebar.jsp"%>
         </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-submit waves-effect waves-light m-t-10">BOOKING</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">CANCELLATION</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit"  id="leads" class="btn11 btn-info waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">CAMPAIGN</button>
		                </div>
	                </div>
               <!-- row -->
               <div class="white-box">
                 <div class="row booking-form">
                    <div class="col-md-8 col-sm-6 col-xs-12  bg11">
                        <h2><%out.print(buildingName); %>, <% out.print(flatNo); %>, <%out.print(projectName); %>, <%out.print(localityName); %></h2>
                          <ul class="nav nav-tabs">
<!-- 							 <li class="active"><a data-toggle="pill" href="#home">Add New Buyer</a></li> -->
<!-- 							 <li><a data-toggle="pill" href="#menu1">Project Details</a></li> -->
<!-- 							 <li><a data-toggle="pill" href="#menu2">Buying Details</a></li> -->
<!-- 							 <li><a data-toggle="pill" href="#menu3">Payment Schedule</a></li> -->
<!-- 							 <li><a data-toggle="pill" href="#menu4">Document</a></li> -->
							  <li class="active"><a data-toggle="tab" href="#home">Add New Buyer</a></li>
							  <li><a data-toggle="tab" href="#menu1">Project Details</a></li>
							  <li><a data-toggle="tab" href="#menu2">Buying Details</a></li>
							  <li><a data-toggle="tab" href="#menu3">Payment Schedule</a></li>
							  <li><a data-toggle="tab" href="#menu4">Document</a></li>
						 </ul>
						  
						 <div class="tab-content tabcontent">
					 	    <div id="home" class="tab-pane active" aria-expanded="false">
					 	    <form id="addnewbuyer" name="addnewbuyer" action="" method="post" enctype="multipart/form-data">
					 	    <input type="hidden" name="employee_id" id="employee_id" value="<%out.print(buyers.get(0).getBuilderEmployee().getId());%>" />
							<input type="hidden" name="builder_id" id="builder_id" value="<%out.print(builder_id);%>" />
							<input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id);%>" />
							<input type="hidden" name="building_id" id="building_id" value="<%out.print(building_id);%>" />
							<input type="hidden" name="flat_id" id="flat_id" value="<%out.print(buyers.get(0).getBuilderFlat().getId());%>" />
							<% if(buyers.size() > 0) { %>
							<input type="hidden" name="buyer_count" id="buyer_count" value="<% out.print(buyers.size()); %>" />
							<% } else { %>
							<input type="hidden" name="buyer_count" id="buyer_count" value="1" />
							<% } %>
							<% int i = 1;
							for(Buyer buyer :buyers) { %>
					 	       <div class="col-sm-12" id="deleteb-<% out.print(buyer.getId()); %>">
					 	       <% if(i > 1) { %>
					 	       	<hr>
					 	       		<span class="pull-right">	<a href="javascript:deleteBuyer(<% out.print(buyer.getId()); %>);" class="btn btn-danger btn-xs">x</a></span>
					 	       		<% } %>
					 	       		<input type="hidden" name="buyer_id[]" id="buyer_id" value="<% out.print(buyer.getId());%>" />
								    <div class="form-group row">
								        <label for="example-text-input" class="col-sm-5 col-form-label"> Buyers Name*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="buyer_name" name="buyer_name[]" value="<% out.print(buyer.getName());%>" placeholder="owner name">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-text-input" class="col-sm-5 col-form-label"> Buyers Photo*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control"  autocomplete="off" id="photo"  type="file" name="photo[]"  placeholder="owner photo">
								        	</div>
								        	<% if(buyer.getPhoto() != null){%>
								        	<div>
								        		<img alt="Buyer Images" src="${baseUrl}/<% out.print(buyer.getPhoto()); %>" width="200px;">
								        	</div>
								        	<%} %>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Email*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" value="<% out.print(buyer.getEmail());%>" name="email[]" id="email" placeholder="owner emailid">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <%
									if(!buyer.getIsPrimary()){													
									%>
								    <input type="hidden" name="is_primary[]" id="is_primary" value="0" class="form-control">
								    <%}if(buyer.getIsPrimary()){ %>
								      <input type="hidden" name="is_primary[]" id="is_primary" value="1" class="form-control">
								    <%} %>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Permanent Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="address" name="address[]"  value="<% out.print(buyer.getPancard());%>" placeholder="Permanent address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Current Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="current_address" name="current_address[]"  value="<% if(buyer.getCurrentAddress() != null) out.print(buyer.getCurrentAddress());%>" placeholder="current address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Contact*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" value="<% out.print(buyer.getMobile());%>" id="contact" name="contact[]" placeholder="contact number">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Pan*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="pan" name="pan[]" value="<%out.print(buyer.getPancard()); %>" placeholder="PAN Card No.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Aadhaar No.*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="aadhaar_no" name="aadhaar_no[]" value="<%if(buyer.getAadhaarNumber() != null){ out.print(buyer.getAadhaarNumber());} %>" placeholder="Aadhaar Card No.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Refferal Id*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off"  id="refferal_id" name="refferal_id[]" value="<%if(buyer.getRefferalId() != null){out.print(buyer.getRefferalId());}%>">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
					 	        </div>
					 	        <%i++;} %>
					 	        <div id="co-buyer"></div>
					 	       	<div class="centerbutton">
					 	        	<a href="javascript:addMoreBuyers();">   <button type="button" class="add-co-buyer">+ Co-Buyer</button></a>
					 	           	<button  type="submit">UPDATE</button>
					 	       </div>
					 	       </form>
					        </div>
						    <div id="menu1" class="tab-pane" aria-expanded="false">
						    	<form id="addbuyerdetail" name="addbuyerdetail" action="" method="post" >
							     	<div class="col-sm-12">
									    <div class="form-group row">
									        <label for="example-text-input" class="col-5 col-form-label"> Project</label>
									        <div class="col-7">
									           <select name="search_project_id" id="search_project_id" class="form-control">
													<option value="">Select Project</option>
													<% for(BuilderProject builderProject : project_list){ %>
													<option value="<% out.print(builderProject.getId()); %>" <% if(buyers.get(0).getBuilderProject().getId() == builderProject.getId()) { %> selected <% } %>><% out.print(builderProject.getName()); %></option>
													<% } %>
												</select>
									        </div>
									    </div>
									    <div class="form-group row">
									        <label for="example-search-input" class="col-5 col-form-label">Building</label>
									        <div class="col-7">
									            <select name="search_building_id" id="search_building_id"	class="form-control">
													<option value="">Select Building</option>
													<% for(BuilderBuilding builderBuilding :builderBuildings) { %>
													<option value="<% out.print(builderBuilding.getId()); %>" <% if(builderBuilding.getId() == buyers.get(0).getBuilderBuilding().getId()) { %>selected<% } %> ><% out.print(builderBuilding.getName()); %></option>
													<% } %>
												</select>
									        </div>
									    </div>
									    <div class="form-group row">
									        <label for="example-search-input" class="col-5 col-form-label">Flat</label>
									        <div class="col-7">
									           <select name="search_flat_id" id="search_flat_id" class="form-control">
													<option value="">Select Flat</option>
													<% for(BuilderFlat builderFlatList :builderFlats) { %>
															<option value="<% out.print(builderFlatList.getId()); %>" <% if(builderFlatList.getId() == buyers.get(0).getBuilderFlat().getId()) { %>selected<% } %>><% out.print(builderFlatList.getFlatNo()); %></option>
													<% } %>
												</select>
									        </div>
									    </div>
									    <input type="hidden" id="admin_id" name="admin_id" value="<% out.print(builder.getId());%>"/>
									    <div class="form-group row">
									        <label for="example-search-input" class="col-5 col-form-label">Assign Manager</label>
									        <div class="col-7">
									            <input class="form-control" readonly="true" value="<% out.print(builder.getName());%>">
									        </div>
									    </div>
						 	     	</div>
						 	         <div class="centerbutton">
						 	           <button onclick="previous1();" type="button">Previous</button>
						 	           <button type="button" onclick="showNext();">Next</button>
						 	       </div>
					 	       </form>
						    </div>
						    <div id="menu2" class="tab-pane">
						    <form id="addbuyingdetail" name="addbuyingdetail" action="" method="post" enctype="multipart/form-data">
						    	<%
									SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
								%>
						    	<%
    								if(buyingDetails != null){
    							%>  
    							<input type="hidden" name="id" id="id" value="<%out.print(buyingDetails.getId());%>" />
								<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
						    	<div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label">Booking Date *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" class="form-control" id="booking_date" name="booking_date" autocomplete="off" value="<%if(buyingDetails.getBookingDate()!=null) {out.print(dt1.format(buyingDetails.getBookingDate())); }%>">
								            </div>
								            <div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Base Rate *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" value="<% out.print(buyingDetails.getBaseRate()); %>" class="form-control" id="base_rate" name="base_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Floor Rising Rate *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<% out.print(buyingDetails.getFloorRiseRate()); %>" id="rise_rate" name="rise_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Amenities Facing Rise Rates *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<% out.print(buyingDetails.getAmenityFacingRate()); %>" id="amenity_rate" name="amenity_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Parking Rates *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<% out.print(buyingDetails.getParkingRate()); %>" id="parking" name="parking">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Maintance *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<% out.print(buyingDetails.getMaintenance()); %>" id="maintenance" name="maintenance">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <%if(taxLabel1.trim().length() != 0 && taxLabel1 != null){ %>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label"><%out.print(taxLabel1); %> *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%if(buyingDetails.getStampDuty()!=null){if(buyingDetails.getStampDuty() > 0 && buyingDetails.getStampDuty() != 0){ out.print(buyingDetails.getStampDuty());}else{ %>0<%}} %>" id="stamp_duty" name="stamp_duty" >
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <%}else{ %>
								    <input type="hidden"  id="stamp_duty" name="stamp_duty" value="0"/>
								    <%} %>
								    <%if(taxLabel2.trim().length() != 0 && taxLabel2 != null){ %>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label"><%out.print(taxLabel2); %> *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" class="form-control" value="<%if(buyingDetails.getTaxes()!=null){ if(buyingDetails.getTaxes() > 0 && buyingDetails.getTaxes() != 0){ out.print(buyingDetails.getTaxes());}else{ %>0<%}} %>" id="tax" name="tax">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								   <%}else{ %>
								    <input type="hidden"  id="tax" name="tax" value="0"/>
								    <%} %>
								    <%if(taxLabel3.trim().length() != 0 && taxLabel3 != null){ %>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label"><%out.print(taxLabel3); %> *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%if(buyingDetails.getVat()!=null){if(buyingDetails.getVat() > 0 && buyingDetails.getVat() != 0){ out.print(buyingDetails.getVat());}else{ %>0<%}} %>" id="vat" name="vat" />
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <%} else{%>
								    <input type="hidden"  id="vat" name="vat" value="0"/>
								    <%} %>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Tenure *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control"  value="<% out.print(buyingDetails.getTenure()); %>" id="tenure" name="tenure" />
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">No. of Post *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input class="form-control" autocomplete="off" type="text" value="<%out.print(buyingDetails.getPost()); %>" id="post" name="post">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Total Sale Value</label>
								        <div class="col-7 custom-col">
								            <input class="form-control" readonly="true" type="text" value="<%out.print(buyingDetails.getTotalCost()); %>" id="toatl_sale_value" name="total_sale_value">
								        </div>
								    </div>
								 </div>
								 <input type="hidden" id="h_sale_value" name="h_sale_value" value="<%out.print(buyingDetails.getTotalCost());%>"/>
								 <%} %>
								  <div class="centerbutton">
						 	           <button onclick="showPrev();" type="button">Previous</button>
						 	           <button type="submit" onclick="showNext1();">UPDATE</button>
					 	       	  </div>
					 	       </form>
						    </div>
						    <div id="menu3" class="tab-pane">
						    <form id="updatebuyerpayment" name="updatebuyerpayment" action="" method="post" enctype="multipart/form-data">
								 <input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
								  <input type="hidden" id="h_sale_value" name="h_sale_value" value="<%if(buyingDetails.getTotalCost() != 0 && buyingDetails.getTotalCost() >0){out.print(buyingDetails.getTotalCost());}%>"/>
								<% if(buyerPayments.size() > 0) { %>
								<% int ii=0; for(BuyerPayment buyerPayment :buyerPayments) { %>
								<input type="hidden" name="payment_id[]" id="payment_id" value="<%out.print(buyerPayment.getId());%>" />
                                 <div class="col-sm-12">
								    <div class="form-group row"  id="schedule-<% out.print(buyerPayment.getId()); %>">
								        <label for="example-text-input" class="col-5 col-form-label">Milestone*</label>
								        <div class="col-7 custom-col">
								            <input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<% out.print(buyerPayment.getMilestone());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">% of net payable</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="payable<%out.print(ii); %>" onkeyup="calculateAmount(<%out.print(ii); %>);" onkeypress=" return isNumber(event, this);" name="payable[]" value="<% out.print(buyerPayment.getNetPayable());%>">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Amount</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="amount<%out.print(ii); %>" onkeyup="calcultatePercentage(<%out.print(ii); %>);"  name="amount[]" value="<% out.print(buyerPayment.getAmount());%>"/>
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								 </div>
                                <%ii++; } 
								 } %>
                                 <div class="centerbutton">
					 	           <button onclick="showPrev1();" type="button">Previous</button>
					 	           <button type="submit" onclick="showNext2();">UPDATE</button>
					 	       	 </div>
					 	       </form>
						    </div>
						    <div id="menu4" class="tab-pane">
							    <form id="addbuyerdocs" name="addbuyerdocs" action="" method="post" enctype="multipart/form-data">
							    	<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
							    	<div class="col-sm-12">
							    	<% for(BuyerUploadDocuments buyerUploadDocument :buyerUploadDocuments) { %>
									    <div class="form-group row">
									    	<input type="hidden" name="doc_id[]" value="<% out.print(buyerUploadDocument.getId()); %>" />
											<input type="hidden" name="doc_name[]" value="<% out.print(buyerUploadDocument.getName()); %>" />
											<label for="example-text-input" class="col-5 col-form-label"><% out.print(buyerUploadDocument.getName()); %></label>
									        <div class="col-2">
													<a href="${baseUrl}/<% out.print(buyerUploadDocument.getDocUrl().toString()); %>" target="_blank">View / Download</a>
											</div>
									    </div>
									    <% } %>
									    <div class="form-group row">
									        <label for="example-text-input" class="col-5 col-form-label"> Other Documents</label>
									        <div class="col-7">
										        <input type="hidden" name="doc_id[]" value="0" />
												<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name" />
										        <input type="file" class="form-control" name="doc_url[]" />
									        </div>
									    </div>
									    <div class="centerbutton">
							 	           <button onclick="showPrev2();" type="button">Previous</button>
							 	           <button type="button" onclick="uploadDocuments();" name="addbuyers">SAVE</button>
						 	       	 	</div>
									 </div>
								</form>
						    </div>
					 	 </div>
                  </div>
                  <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 tabcontent">
	                    <%if(bookingFlatList != null){ %>
	                     <div class="bg1">
	                     	<div class="user-profile">
					      	<%if(bookingFlatList.getBuyerPhoto()!="" && bookingFlatList.getBuyerPhoto() != null){ %>
						     	<img src="${baseUrl}/<%out.print(bookingFlatList.getBuyerPhoto()); %>" alt="Buyer image" class="custom-img">
						     	<img src="../images/camera_icon.PNG" alt="camera " class="camera"/>
						   	<%}%>	
					          	<p><b><%out.print(bookingFlatList.getBuyerName()); %></b></p>
					          	<p class="p-custom"><%out.print(bookingFlatList.getBuildingName()); %>-<%out.print(bookingFlatList.getFlatNo()); %>, <%out.print(bookingFlatList.getProjectName()); %></p>
					          	<hr>
					       	</div>
						   	<div class="row custom-row user-row">
						        <p class="p-custom">Mobile No.</p>
						        <p><b><%out.print(bookingFlatList.getBuyerMobile()); %></b></p>
						        <p class="p-custom">Email</p>
						        <p><b><%out.print(bookingFlatList.getBuyerEmail()); %></b></p>
						        <p class="p-custom">PAN</p>
						        <p><b><%out.print(bookingFlatList.getBuyerPanNo()); %></b></p>
						        <p class="p-custom">Aadhaar card no.</p>
						        <p><b><% if(bookingFlatList.getBuyerAadhaarNumber()!=null){out.print(bookingFlatList.getBuyerAadhaarNumber());} %></b></p>
						        <p class="p-custom">Permanent Address</p>
						        <p><b><%out.print(bookingFlatList.getBuyerPermanentAddress()); %></b></p>
						        <p class="p-custom">Current Address</p>
						        <p><b><%if(bookingFlatList.getBuyerCurrentAddress()!=null){out.print(bookingFlatList.getBuyerCurrentAddress());} %></b></p>
						        <hr>
						   	</div>
						 </div>
						 <%} %>
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
  </body>
</html>
<script>
$("#booking").click(function(){
	window.location.href="${baseUrl}/builder/buyer/salesman_bookingOpenForm.jsp?project_id="+$("#project_id").val();
});
$("#cancellation").click(function(){
	window.location.href="${baseUrl}/builder/cancellation/Salesman_booking_new2.jsp?project_id="+$("#project_id").val();
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+$("#project_id").val();
});
$("#leads").click(function(){
	window.location.href="${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+$("#project_id").val();
});
function calculateAmount(id){
	alert($("#h_sale_value").val());
	if($("#payable"+id).val() <0 || $("#payable"+id).val() >100){
		alert("The percentage must be between 0 and 100");
		$("#payable"+id).val('');
	}else{
	var amount = $("#payable"+id).val()*$("#h_sale_value").val()/100;
		$("#amount"+id).val(amount.toFixed(0));
	}
}

$("#search_project_id").change(
		function() {
			$.get("${baseUrl}/webapi/buyer/buildings/names/"
					+ $("#search_project_id").val(), {}, function(data) {
				var html = '<option value="0">Select Building</option>';
				$(data).each(
						function(index) {
							html = html
									+ '<option value="'+data[index].id+'">'
									+ data[index].name + '</option>';
						});
				$("#search_building_id").html(html);
			}, 'json');
		});
$("#search_building_id").change(
		function() {
			$.get("${baseUrl}/webapi/buyer/building/available/flat/names/"
					+ $("#search_building_id").val(), {}, function(data) {
				var html = '<option value="0">Select Flat</option>';
				$(data).each(
						function(index) {

							html = html
									+ '<option value="'+data[index].id+'">'
									+ data[index].name + '</option>';
						});
				$("#search_flat_id").html(html);
			}, 'json');
		});

function calcultatePercentage(id){
	var $th = $("#amount"+id);
	//alert($("#h_sale_value").val());
	$th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
	if($("#amount"+id).val() <= $("#h_sale_value").val() ){
		var percentage = $("#amount"+id).val()/$("#h_sale_value").val()*100;
		$("#payable"+id).val(percentage.toFixed(1));
	}else{
		alert("Please Enter correct flat sale amount");
		$("#payable"+id).val("");
		$("#amount"+id).val("");
	}
}
function addMoreBuyers(){
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html ="";
	
	html = '<div class="tab-content" id="buyer-'+buyers+'"><hr>'
		+'<span class="pull-right">	<a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span><br>'
		+'<div class="col-sm-12">'
	    +'<div class="form-group row">'
	    +'<label for="example-text-input" class="col-5 col-form-label"> Buyers Name*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value=""id="buyer_name" name="buyer_name[]" autocomplete="off" placeholder="Co-owner name">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
		+'<label for="example-text-input" class="col-5 col-form-label"> Buyers Photo*</label>'
		+'<div class="col-7 custom-col">'
		+'<div>'
	    +'<input class="form-control" type="file" value="" id="photo" name="photo[]" autocomplete="off" placeholder="Co-owner name">'
	    +'</div>'
	    +'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Email*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" name="email[]" id="email" autocomplete="off" placeholder="co-owner email id">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
    	+'</div>'
		+'</div>'
		+' <input type="hidden" name="is_primary[]" id="is_primary" value="0" class="form-control">'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Permanent Address*</label>'
	    +'<div class="col-7 custom-col">'
        +'<input class="form-control" type="text" value="" placeholder="permanent address" autocomplete="off" id="address" name="address[]">'
    	+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Current Address*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" placeholder="current address" autocomplete="off" id="current_address" name="current_address[]">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Contact*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text"  autocomplete="off" value="" id="contact" name="contact[]" placeholder="contact number">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Pan*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="pan" name="pan[]" placeholder="Pan card number">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
 		+'<div class="form-group row">'
    	+'<label for="example-tel-input" class="col-5 col-form-label">Aadhaar No.*</label>'
    	+'<div class="col-7 custom-col">'
    	+'<div>'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="aadhaar_no" name="aadhaar_no[]" placeholder="Aadhaar number">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Refferal Id*</label>'
	    +'<div class="col-7 custom-col">'
        +'<input class="form-control" type="text" autocomplete="off" value="" placeholder="" id="refferal_id" name="refferal_id[]">'
    	+'</div>'
		+'</div>'
		+'</div>'
		+'</div>';
	$("#co-buyer").append(html);
	$("#buyer_count").val(buyers);
}
function removeBuyer(id) {
	$("#buyer-"+id).remove();
}

function addMoreOffers(){
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html ="";
	
	html = '<div class="tab-content" id="offer-'+offers+'"><hr>'
		+'<span class="pull-right">	<a href="javascript:removeOffers('+offers+');" class="btn btn-danger btn-xs">x</a></span><br>'
		+'<div class="col-sm-12">'
	    +'<div class="form-group row">'
	    +'<label for="example-text-input" class="col-5 col-form-label"> Buyers Name*</label>'
	    +'<div class="col-7">'
        +'<input class="form-control" type="text" value="" id="" autocomplete="off" placeholder="Co-owner name">'
    	+'</div>'
		+'</div>';
		$("#more_offers").append(html);
		$("#offer_count").val(offers);

}

function removeOffers(id){
	$("#offer-"+id).remove();	
}

function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if ((charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
} 
$('#booking_date').datepicker({
	autoclose:true,
	format: "dd MM yyyy"
});
function previous1()
{
	$("#menu1").hide();
	//$("#home").show();
	 $('.active').removeClass('active').prev('li').addClass('active');
     $("#home").addClass('active');
     $("#home").show();
}
function show(){
	$("#home").hide();
	//$("#menu1").show();
	 $('.active').removeClass('active').next('li').addClass('active');
     $("#menu1").addClass('active');
     $("#menu1").show();
     
}
function showNext(){
	$("#menu1").hide();
	$('.active').removeClass('active').next('li').addClass('active');
    $("#menu2").addClass('active');
    $("#menu2").show();
}
function showPrev(){
	$("#menu2").hide();
	 $('.active').removeClass('active').prev('li').addClass('active');
     $("#menu1").addClass('active');
     $("#menu1").show();
}
function showNext1(){
	$("#menu2").hide();
	$('.active').removeClass('active').next('li').addClass('active');
    $("#menu3").addClass('active');
    $("#menu3").show();
}
function showPrev1(){
	$("#menu3").hide();
	 $('.active').removeClass('active').prev('li').addClass('active');
     $("#menu2").addClass('active');
     $("#menu2").show();
}
function showNext2(){
	$("#menu3").hide();
	$('.active').removeClass('active').next('li').addClass('active');
    $("#menu4").addClass('active');
    $("#menu4").show();
}
function showPrev2(){
	$("#menu4").hide();
	 $('.active').removeClass('active').prev('li').addClass('active');
     $("#menu3").addClass('active');
     $("#menu3").show();
}

$(document).ready(function() {
$('#addnewbuyer').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
   // excluded: ':disabled',
    fields: {
        'buyer_name[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer Name is required and cannot be empty'
                }
            }
        },
        'email[]':{
        	excluded: false,
            validators: {
           	 notEmpty: {
                    message: 'Email is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                    message: 'Invalid email address'
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
        'current_address[]':{
        	 validators: {
                 notEmpty: {
                     message: 'Current address is required and cannot be empty'
                 }
             }
        },
//         'photo[]': {
//             validators: {
//                 notEmpty: {
//                     message: 'Buyer photo is required and cannot be empty'
//                 }
//             }
//         },

        'aadhaar_no[]':{
        	validators: {
                notEmpty: {
                    message: 'Aadhaar Card number is required and cannot be empty'
                }
            },
            numeric: {
             	message: 'Aadhaar Card number is invalid',
                thousandsSeparator: '',
                decimalSeparator: '.'
          	}
        },
        'refferal_id[]':{
        	validators: {
                notEmpty: {
                    message: 'Refferal id is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	//alert("hello");
	event.preventDefault();
	updateBuyer();
}).on('error.form.bv', function(event,data) {
	// Prevent form submission
	//alert("hello You got an js error");
	event.preventDefault();
	//addBuyer1();
	 $('.active').removeClass('active').prev('li').prev('li').prev('li').prev('li').addClass('active');
	//$("#home").addClass('active');
	$("#home").show();
	
});
function updateBuyer(){
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/update/basic/new',
	 		semantic : true,
	 		dataType : 'json'
	 	};
	$('#addnewbuyer').ajaxSubmit(options);
	//show();
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
        $("#menu1").addClass('active');
       // window.location.href = "${baseUrl}/builder/buyer/booking.jsp?project_id="+$("project_id").val();
  	}
}
});
$('#addbuyingdetail').bootstrapValidator({
// 	container: function($field, validator) {
// 		return $field.parent().next('.messageContainer');
//    	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
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
                },
                numeric: {
                 	message: 'Base Rate is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        rise_rate: {
            validators: {
                notEmpty: {
                    message: 'Floor rise rate required and can not be empty'
                },
                numeric: {
                 	message: 'Floor rise rate  is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        amenity_rate: {
            validators: {
                notEmpty: {
                    message: 'Amenity facing rate required and can not be empty'
                },
                numeric: {
                 	message: 'Amenity facing rate  is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        maintenance: {
            validators: {
                notEmpty: {
                    message: 'Maintenance charge required and can not be empty'
                },
                numeric: {
                 	message: 'Maintenance  is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        tenure: {
            validators: {
                notEmpty: {
                    message: 'Tennure required and can not be empty'
                },
                numeric: {
                 	message: 'Tennure  is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        registration: {
            validators: {
                notEmpty: {
                    message: 'Registration fee required and can not be empty'
                },
                numeric: {
                 	message: 'Registration fee is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        parking: {
            validators: {
                notEmpty: {
                    message: 'Parking rate required and can not be empty'
                },
                numeric: {
                 	message: 'Parking rate  is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        stamp_duty: {
            validators: {
                notEmpty: {
                    message: 'Stamp duty charges required and can not be empty'
                },
                numeric: {
                 	message: 'Stamp duty charges is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        tax: {
            validators: {
                notEmpty: {
                    message: 'Tax required and can not be empty'
                },
                numeric: {
                 	message: 'Tax is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        },
        vat: {
            validators: {
                notEmpty: {
                    message: 'Vat required and can not be empty'
                },
                numeric: {
                 	message: 'Vat is invalid',
                    thousandsSeparator: '',
                    decimalSeparator: '.'
              	}
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProjectPrice();
	
});

function updateProjectPrice() {
	ajaxindicatorstart("Loading...");
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
		alert(resp.message);
        ajaxindicatorstop();
  	} else {
  		$("#pricingresponse").removeClass('alert-danger');
        $("#pricingresponse").addClass('alert-success');
        $("#pricingresponse").html(resp.message);
        $("#pricingresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
  	}
}
$('#updatebuyerpayment').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	'schedule[]': {
            validators: {
		    	notEmpty: {
		    		message: 'Schedule is required and cannot be empty'
		        },
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
		        },
            }
        },
        'amount[]':{
        	validators:{
        		notEmpty :{
        			message: 'amount is required and cannot be empty'
        		}
        	}
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	
	updateBuyerPayments();
}).on('error.form.bv', function(e,data){
	
});

function updateBuyerPayments() {
	  ajaxindicatorstart("Loading...");	
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddPaymentRequest,
	 		success :  showAddPaymentResponse,
	 		url : '${baseUrl}/webapi/buyer/payment/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatebuyerpayment').ajaxSubmit(options);
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
		alert(resp.message);
        ajaxindicatorstop();
  	} else {
  		$("#paymentresponse").removeClass('alert-danger');
        $("#paymentresponse").addClass('alert-success');
        $("#paymentresponse").html(resp.message);
        $("#paymentresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
  	}
}
function updateBuyerFlat() {
	ajaxindicatorstart("Loading...");
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
        ajaxindicatorstop();
  	}
}
function uploadDocuments(){
	ajaxindicatorstart("Loading...");
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
		alert(resp.message);
		ajaxindicatorstop();
  	} else {
  		$("#paymentresponse").removeClass('alert-danger');
        $("#paymentresponse").addClass('alert-success');
        $("#paymentresponse").html(resp.message);
        $("#paymentresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
        window.location.href = "$${baseUrl}/builder/buyer/salesman_bookingOpenForm.jsp?project_id="+<%out.print(project_id);%>;
  	}
}
function deleteBuyer(id) {
	ajaxindicatorstart("Loading...");
	$.get("${baseUrl}/webapi/buyer/delete/coowner/"+id,{},function(data){
		if(data.status == 0 ){
			alert(data.message);
		} else {
			ajaxindicatorstop();
			window.location.reload();
		}
	});
}
</script>
