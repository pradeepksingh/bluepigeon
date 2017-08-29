<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.FlatPricingDetails"%>
<%@page import="org.bluepigeon.admin.model.FlatPaymentSchedule"%>
<%@page import="org.bluepigeon.admin.data.FlatPayment"%>
<%@page import="org.bluepigeon.admin.data.ProjectPriceInfoData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPriceInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPriceInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	List<BuilderEmployee> builderEmployees = null;
	List<BuilderFlat> builderFlatList  = null;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<BuilderProject> project_list = null; 
	List<FlatPaymentSchedule> flatPayments = null;
	List<FlatPricingDetails> flatPricingDetails = null; 
	 BookingFlatList bookingFlatList = null;
	ProjectPriceInfoData projectPriceInfoData = null;
	BuilderFlat builderFlat = null;
	int builder_id1 = 0;
	int flat_id = 0;
	int building_id = 0;
	int project_id = 0;
	String projectName = "";
	String buildingName = "";
	String flatNo = "";
	String localityName = "";
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id1 = builder.getBuilder().getId();
			
			if(builder_id1> 0 ){
				project_list = new ProjectDetailsDAO().getBuilderActiveProjectList(builder_id1);
			}
			if(project_list != null){
			 	builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id1);
			 		
			 	}
			}
			 
		}
   
	if (request.getParameterMap().containsKey("flat_id")) {
		flat_id = Integer.parseInt(request.getParameter("flat_id"));
		flatPayments = new ProjectDAO().getFlatPaymentByFlatId(flat_id);
		builderFlat = new ProjectDAO().getBuilderFlatById(flat_id);
		flatPricingDetails = new ProjectDAO().getFlatPriceInfos(flat_id);
		building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
		project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
		 bookingFlatList = new ProjectDAO().getFlatdetails(flat_id);
		 if(builderFlat != null){
			 projectName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName();
			 buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
			 flatNo = builderFlat.getFlatNo();
			 localityName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getLocalityName();
			 
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
    <link rel="stylesheet" type="text/css" href="../css/custom10.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/bootstrap-datepicker.min.js"></script>
      <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
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
		                    <button type="submit" class="btn11 btn-submit waves-effect waves-light m-t-10">Booking</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">Cancellation</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit"  id="leads" class="btn11 btn-info waves-effect waves-light m-t-10">Leads</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">Campain</button>
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
						  <form id="addnewbuyer" name="addnewbuyer" action="" method="post" enctype="multipart/form-data">
						  		<input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id1); %>" />
                              	<input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id);%>"/>
                              	<input type="hidden" name="building_id" id="building_id" value="<%out.print(building_id);%>"/>
                              	<input type="hidden" name="flat_id" id="flat_id" value="<%out.print(flat_id);%>"/>
						 <div class="tab-content tabcontent">
						 	<input type="hidden" name="buyer_count" id="buyer_count" value="1"/>
					 	    <div id="home" class="tab-pane active" aria-expanded="false">
					 	       <div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-sm-5 col-form-label"> Buyers Name*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="buyer_name" name="buyer_name[]" placeholder="owner name">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Email*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" name="email[]" id="email" placeholder="owner emailid">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <input type="hidden" name="is_primary[]" id="is_primary" value="1" class="form-control">
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Permanent Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="address" name="address[]" placeholder="Permanent address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Current Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="current_address" name="current_address[]" placeholder="current address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Contact*</label>
								        <div class="col-sm-7">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="contact" name="contact[]" placeholder="contact number">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Pan*</label>
								        <div class="col-sm-7">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="pan" name="pan[]" placeholder="PAN Card No.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Aadhaar No.*</label>
								        <div class="col-sm-7">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="aadhaar_no" name="aadhaar_no[]" placeholder="Aadhaar Card No.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Refferal Id*</label>
								        <div class="col-sm-7">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off"  id="refferal_id" name="refferal_id[]">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
					 	        </div>
					 	        <div id="co-buyer"></div>
					 	       	<div class="centerbutton">
					 	        	<a href="javascript:addMoreBuyers();">   <button type="button" class="add-co-buyer">+ Co-Buyer</button></a>
					 	           	<button onclick="show();" type="button">Next</button>
					 	       </div>
					        </div>
						    <div id="menu1" class="tab-pane" aria-expanded="false">
						     	<div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label"> Project</label>
								        <div class="col-7">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Building</label>
								        <div class="col-7">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getName());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Flat</label>
								        <div class="col-7">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getFlatNo());%>">
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
						    </div>
						    <div id="menu2" class="tab-pane">
						    	<%
    								if(flatPricingDetails != null){
    							%>  
    							<input type="hidden" id="project_id" name="project_id" value="<%out.print(project_list.get(0).getId());%>"/>  
						    	<div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label">Booking Date *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" class="form-control" id="booking_date" name="booking_date" autocomplete="off">
								            </div>
								            <div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Base Rate *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" value="<%out.print(flatPricingDetails.get(0).getBasePrice()); %>" class="form-control" id="base_rate" name="base_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Floor Rising Rate *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getRiseRate()); %>" id="rise_rate" name="rise_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Aminities Facing Rise Rates *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getAmenityRate()); %>" id="amenity_rate" name="amenity_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Parking Rates *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getParking()); %>" id="parking" name="parking">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Maintance *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getMaintenance()); %>" id="maintenance" name="maintenance">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Stamp Duty *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getStampDuty()); %>" id="stamp_duty" name="stamp_duty" >
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Taxes *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" class="form-control" value="<%out.print(flatPricingDetails.get(0).getTax()); %>" id="tax" name="tax">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">VAT *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getVat()); %>" id="vat" name="vat" />
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Tenure *</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getTenure()); %>" id="tenure" name="tenure" />
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">No. of Post *</label>
								        <div class="col-7">
								        	<div>
								            	<input class="form-control" autocomplete="off" type="text" value="<%out.print(flatPricingDetails.get(0).getPost()); %>" id="post" name="post">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Total Sale Value</label>
								        <div class="col-7">
								            <input class="form-control" readonly="true" type="text" value="<%out.print(flatPricingDetails.get(0).getTotalCost()); %>" id="toatl_sale_value" name="total_sale_value">
								        </div>
								    </div>
								 </div>
								 <input type="hidden" id="h_sale_vale" name="h_sale_value" value="<%out.print(flatPricingDetails.get(0).getTotalCost());%>"/>
								 <%} %>
								  <div class="centerbutton">
					 	           <button onclick="showPrev();" type="button">Previous</button>
					 	           <button type="button" onclick="showNext1();">Next</button>
					 	       </div>
						    </div>
						    <div id="menu3" class="tab-pane">
						     <% int a=1;
                                 for(FlatPaymentSchedule flatPayment: flatPayments ) {%> 
                                 <div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label">Milestone*</label>
								        <div class="col-7">
								            <input type="text" class="form-control" readonly="true" id="schedule" name="schedule[]" value="<%out.print(flatPayment.getMilestone());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">% of net payable</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="payable<%out.print(a); %>" onkeyup="calculateAmount(<%out.print(a); %>);" onkeypress=" return isNumber(event, this);" name="payable[]" value="<%out.print(flatPayment.getPayable());%>">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Amount</label>
								        <div class="col-7">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="amount<%out.print(a); %>" onkeyup="calculateAmount(<%out.print(a); %>);" onkeypress=" return isNumber(event, this);" name="amount[]" value="<%out.print(flatPayment.getAmount());%>"/>
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								 </div>
                                 <%} %>
                                 <div class="centerbutton">
					 	           <button onclick="showPrev1();" type="button">Previous</button>
					 	           <button type="button" onclick="showNext2();">Next</button>
					 	       	 </div>
						    </div>
						    <div id="menu4" class="tab-pane">
						     	<div class="col-sm-12">
								    <div class="form-group row">
								    	 <input type="hidden" name="doc_name[]" value="Agreement" />
								        <label for="example-text-input" class="col-5 col-form-label"> Agreement*</label>
								        <div class="col-7">
								           <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								      <input type="hidden" name="doc_name[]" value="Index 2" />
								        <label for="example-text-input" class="col-5 col-form-label"> Index 2*</label>
								        <div class="col-7">
								            <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								     <input type="hidden" name="doc_name[]" value="Receipts with Date and time and Name" />
								        <label for="example-text-input" class="col-5 col-form-label"> Receipts with Date & Time & Name</label>
								        <div class="col-7">
								            <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								     <input type="hidden" name="doc_name[]" value="Electrical and Plumbing lines map" />
								        <label for="example-text-input" class="col-5 col-form-label"> Electricals & Plumbing lines map</label>
								        <div class="col-7">
								           <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label"> Possession grant letter</label>
								        <div class="col-7">
								            <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label"> Other Documents</label>
								        <div class="col-7">
								            <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="centerbutton">
						 	           <button onclick="showPrev2();" type="button">Previous</button>
						 	           <button type="submit" name="addbuyers">SAVE</button>
					 	       	 	</div>
								 </div>
						    </div>
					 	 </div>
					 	 </form>
					  </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 tabcontent">
                    <%if(bookingFlatList != null){ %>
                     <div class="bg1">
                     <% if(bookingFlatList.getImage()!="" && bookingFlatList.getImage() != null){ %>
						     <img src="${baseUrl}/<%out.print(bookingFlatList.getImage()); %>" alt="Flat image" class="custom-img">
						     <%} %>
						      <hr>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Flat Type</p>
						          <span><b><%out.print(bookingFlatList.getFlatType()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Carpet Area</p>
						          <span><b><%out.print(bookingFlatList.getCarpetArea()+" "+bookingFlatList.getAreaUint()); %> </b></span>
						        </div>
						      </div>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bedrooms</p>
						          <span><b><%out.print(bookingFlatList.getBedroom()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bathroom</p>
						          <span><b><%out.print(bookingFlatList.getBathroom()); %></b></span>
						        </div>
						      </div>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Balcony</p>
						          <span><b><%out.print(bookingFlatList.getBalcony()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bedroom Size</p>
						          <span><b><%out.print(bookingFlatList.getLength()+" "+bookingFlatList.getAreaUint()+" * "+bookingFlatList.getBreadth()+" "+bookingFlatList.getAreaUint()); %></b></span>
						        </div>
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
$("#cancellation").click(function(){
	window.location.href="${baseUrl}/builder/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(project_id);%>
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+<% out.print(project_id);%>
});
$("#leads").click(function(){
	window.location.href="${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+<%out.print(project_id);%>
});
function addMoreBuyers(){
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html ="";
	
	html = '<div class="tab-content" id="buyer-'+buyers+'"><hr>'
	+'<span class="pull-right">	<a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span><br>'
	+'<div class="col-sm-12">'
    +'<div class="form-group row">'
    +'<label for="example-text-input" class="col-5 col-form-label"> Buyers Name*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" value="" id="" autocomplete="off" placeholder="Co-owner name">'
    +'</div>'
+'</div>'
+'<div class="form-group row">'
    +'<label for="example-search-input" class="col-5 col-form-label">Email*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" value="" id="" autocomplete="off" placeholder="co-owner email id">'
    +'</div>'
+'</div>'
+' <input type="hidden" name="is_primary[]" id="is_primary" value="0" class="form-control">'
+'<div class="form-group row">'
    +'<label for="example-search-input" class="col-5 col-form-label">Permanent Address*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" value="" placeholder="" autocomplete="off" id="">'
    +'</div>'
+'</div>'
+'<div class="form-group row">'
    +'<label for="example-search-input" class="col-5 col-form-label">Current Address*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" value="" autocomplete="off" id="">'
    +'</div>'
+'</div>'
+'<div class="form-group row">'
    +'<label for="example-tel-input" class="col-5 col-form-label">Contact*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text"  autocomplete="off" value="" id="" placeholder="9876547343">'
    +'</div>'
+'</div>'
+'<div class="form-group row">'
    +'<label for="example-tel-input" class="col-5 col-form-label">Pan*</label>'
    +'<div class="col-7">'
       +'<input class="form-control" type="text" autocomplete="off" value="" id="" placeholder="BARPS0276">'
    +'</div>'
+'</div>'
 +'<div class="form-group row">'
    +'<label for="example-tel-input" class="col-5 col-form-label">Adhar No.*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="" placeholder="BARPS0276">'
    +'</div>'
+'</div>'
+'<div class="form-group row">'
    +'<label for="example-tel-input" class="col-5 col-form-label">Refferal Id*</label>'
    +'<div class="col-7">'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="">'
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

function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
} 
$('#booking_date').datepicker({
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


$('#addnewbuyer').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
//     	project_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Please select project'
//                 }
//             }
//         },
//         building_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Please select building'
//                 }
//             }
//         },
//         flat_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Please select flat'
//                 }
//             }
//         },
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
//         flat_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Please select flat'
//                 }
//             }
//         },
        'aadhaar_no[]':{
        	validators: {
                notEmpty: {
                    message: 'Aadhaar Card number is required and cannot be empty'
                }
            }
        },
        'refferal_id[]':{
        	validators: {
                notEmpty: {
                    message: 'Refferal id is required and cannot be empty'
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
	//alert("hello");
	event.preventDefault();
	addBuyer1();
}).on('error.form.bv', function(event,data) {
	// Prevent form submission
	//alert("hello");
	event.preventDefault();
	//addBuyer1();
	 $('.active').removeClass('active').prev('li').prev('li').prev('li').prev('li').addClass('active');
	//$("#home").addClass('active');
	$("#home").show();
	
});

function addBuyer1() {
	//alert("inside add");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/save/new',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addnewbuyer').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/buyer/booking.jsp?project_id="+$("project_id").val();
  	}
}

</script>
