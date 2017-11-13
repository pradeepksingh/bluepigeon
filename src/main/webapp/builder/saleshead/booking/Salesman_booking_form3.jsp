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
	int emp_id = 0;
	int building_id = 0;
	int project_id = 0;
	String projectName = "";
	String buildingName = "";
	String flatNo = "";
	String localityName = "";
	String taxLabel1 = "";
	String taxLabel2 = "";
	String taxLabel3 = "";
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			if(builder !=null){
				builder_id1 = builder.getBuilder().getId();
				if(builder.getBuilderEmployeeAccessType().getId()==5){
					emp_id = builder.getId();
					if(builder_id1> 0 ){
						project_list = new ProjectDetailsDAO().getBuilderActiveProjectList(builder_id1);
						if (request.getParameterMap().containsKey("flat_id")) {
							flat_id = Integer.parseInt(request.getParameter("flat_id"));
							flatPayments = new ProjectDAO().getFlatPaymentByFlatId(flat_id);
							builderFlat = new ProjectDAO().getBuilderFlatById(flat_id);
							flatPricingDetails = new ProjectDAO().getFlatPriceInfos(flat_id);
							building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
							project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
							 bookingFlatList = new ProjectDAO().getFlatdetails(flat_id,emp_id);
							 if(builderFlat != null){
								 projectName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName();
								 buildingName = builderFlat.getBuilderFloor().getBuilderBuilding().getName();
								 flatNo = builderFlat.getFlatNo();
								 localityName = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getLocalityName();
								 taxLabel1 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel1();
									taxLabel2 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel2();
									taxLabel3 = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getCountry().getTaxLabel3();
								 
							 }
						}
					}
					if(project_list != null){
					 	builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id1);	
					 	}
					}
				}else{
					response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
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
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
   <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/addbuyer.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../../js/bootstrap-datepicker.min.js"></script>
      <script src="../../js/jquery.form.js"></script>
    <script src="../../js/bootstrapValidator.min.js"></script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
         <%@include file="../../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1">
        <%@include file="../../partial/sidebar.jsp"%>
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
								            	<input class="form-control" type="text" autocomplete="off" id="buyer_name1" name="buyer_name[]" onkeyup="validateBuyername(1);" placeholder="owner name">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-text-input" class="col-sm-5 col-form-label"> Buyers Photo*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="file" autocomplete="off" id="photo1" name="photo[]" placeholder="owner picture">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Email*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" name="email[]" id="email1"  placeholder="owner emailid">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <input type="hidden" name="is_primary[]" id="is_primary" value="1" class="form-control">
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Permanent Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="address1" name="address[]" placeholder="Permanent address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-sm-5 col-form-label">Current Address*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="current_address1" name="current_address[]" placeholder="current address">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Contact*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="contact1" name="contact[]" placeholder="contact number">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Pan*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="pan1" name="pan[]" placeholder="PAN Card No.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Aadhaar No.*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off" id="aadhaar_no1" name="aadhaar_no[]" placeholder="enter aadhaar card no.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-sm-5 col-form-label">Refferal Id*</label>
								        <div class="col-sm-7 custom-col">
								        	<div>
								            	<input class="form-control" type="text" autocomplete="off"  id="refferal_id1" name="refferal_id[]"  placeholder="enter refferal id.">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
					 	        </div>
					 	        <div id="co-buyer"></div>
					 	       	<div class="centerbutton">
					 	        	<a href="javascript:addMoreBuyers();">   <button type="button" class="add-co-buyer">+ Co-Buyer</button></a>
					 	           	<button onclick="show();" id="newbuyer" type="button">Next</button>
					 	       </div>
					        </div>
						    <div id="menu1" class="tab-pane" aria-expanded="false">
						     	<div class="col-sm-12">
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label"> Project</label>
								        <div class="col-7 custom-col">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Building</label>
								        <div class="col-7 custom-col">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getName());%>">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Flat</label>
								        <div class="col-7 custom-col">
								            <input class="form-control" readonly="true" value="<%out.print(builderFlat.getFlatNo());%>">
								        </div>
								    </div>
								    <input type="hidden" id="admin_id" name="admin_id" value="<% out.print(builder.getId());%>"/>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Assign Manager</label>
								        <div class="col-7 custom-col">
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
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" class="form-control" id="booking_date" name="booking_date" autocomplete="off">
								            </div>
								            <div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Base Rate *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" value="<%out.print(flatPricingDetails.get(0).getBasePrice()); %>" class="form-control" id="base_rate" name="base_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Floor Rising Rate *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getRiseRate()); %>" id="rise_rate" name="rise_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Aminities Facing Rise Rates *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getAmenityRate()); %>" id="amenity_rate" name="amenity_rate">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Parking Rates *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getParking()); %>" id="parking" name="parking">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Maintance *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getMaintenance()); %>" id="maintenance" name="maintenance">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <%if(taxLabel1.trim().length() != 0 && taxLabel1 != null){ %>
								     <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label"><%out.print(taxLabel1); %> *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%if(flatPricingDetails.get(0).getStampDuty() > 0 && flatPricingDetails.get(0).getStampDuty() != 0){out.print(flatPricingDetails.get(0).getStampDuty());}else{ %>0<%} %>" id="stamp_duty" name="stamp_duty" >
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
								            	<input type="text" class="form-control" value="<%if(flatPricingDetails.get(0).getTax() > 0 && flatPricingDetails.get(0).getTax() != 0){out.print(flatPricingDetails.get(0).getTax());}else{ %>0<%} %>" id="tax" name="tax">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <%} else{ %>
									<input type="hidden"  id="tax" name="tax" value="0"/>
									<%} %>	
									<%if(taxLabel3.trim().length() != 0 && taxLabel3 != null){ %>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label"><%out.print(taxLabel3); %> *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" value="<%if(flatPricingDetails.get(0).getVat() > 0 && flatPricingDetails.get(0).getVat() !=0){out.print(flatPricingDetails.get(0).getVat());}else{ %>0<%} %>" id="vat" name="vat" />
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
								            	<input type="text" autocomplete="off" class="form-control" value="<%out.print(flatPricingDetails.get(0).getTenure()); %>" id="tenure" name="tenure" />
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">No. of Post *</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input class="form-control" autocomplete="off" type="text" value="<%out.print(flatPricingDetails.get(0).getPost()); %>" id="post" name="post">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Total Sale Value</label>
								        <div class="col-7 custom-col">
								            <input class="form-control" readonly="true" type="text" value="<%out.print(flatPricingDetails.get(0).getTotalCost()); %>" id="toatl_sale_value" name="total_sale_value">
								        </div>
								    </div>
								 </div>
<%-- 								 <input type="hidden" id="h_sale_vale" name="h_sale_value" value="<%out.print(flatPricingDetails.get(0).getTotalCost());%>"/> --%>
								 <%} %>
								  <div class="centerbutton">
					 	           <button onclick="showPrev();" type="button">Previous</button>
					 	           <button type="button" onclick="showNext1();">Next</button>
					 	       </div>
						    </div>
						    <div id="menu3" class="tab-pane">
						    <input type="hidden" name="h_sale_value" id="h_sale_value" value="<% if(flatPricingDetails.size() > 0 && flatPricingDetails.get(0).getTotalCost() != null){ out.print(flatPricingDetails.get(0).getTotalCost());}%>"/>
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
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="payable<%out.print(a); %>" onkeyup="calculateAmount(<%out.print(a); %>);" onkeypress=" return isNumber(event, this);" name="payable[]" value="<%out.print(Math.round(flatPayment.getPayable()));%>">
								        	</div>
								        	<div class="messageContainer"></div>
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Amount</label>
								        <div class="col-7 custom-col">
								        	<div>
								            	<input type="text" autocomplete="off" class="form-control" id="amount<%out.print(a); %>" onkeyup="calcultatePercentage(<%out.print(a); %>);"  name="amount[]" value="<%out.print(Math.round(flatPayment.getAmount()));%>"/>
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
								        <label for="example-text-input" class="col-5 col-form-label"> Aadhaar card*</label>
								        <div class="col-7">
								           <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								      <input type="hidden" name="doc_name[]" value="Index 2" />
								        <label for="example-text-input" class="col-5 col-form-label"> Pan card *</label>
								        <div class="col-7">
								            <input type="file" class="form-control" name="doc_url[]" />
								        </div>
								    </div>
								    <div class="form-group row">
								     <input type="hidden" name="doc_name[]" value="Receipts with Date and time and Name" />
								        <label for="example-text-input" class="col-5 col-form-label"> Voter Id card </label>
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
	     <%@include file="../../partial/footer.jsp"%>
	</div> 
  </body>
</html>
<script>
$("#cancellation").click(function(){
	window.location.href="${baseUrl}/builder/saleshead/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(project_id);%>
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/saleshead/campaign/Salesman_campaign.jsp?project_id="+<% out.print(project_id);%>
});
$("#leads").click(function(){
	window.location.href="${baseUrl}/builder/saleshead/leads/Salesman_leads.jsp?project_id="+<%out.print(project_id);%>
});
$("#booking").click(function(){
	window.location.href="${baseUrl}/builder/saleshead/salesman_bookingOpenForm.jsp?project_id="+<%out.print(project_id);%>;
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
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" id="buyer_name'+buyers+'" name="buyer_name[]" autocomplete="off" placeholder="Co-owner name">'
    	+'</div>'
    	+'<div id="ename'+buyers+'"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-text-input" class="col-5 col-form-label"> Buyers Photo*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="file" value="" id="photo'+buyers+'" name="photo[]" autocomplete="off" placeholder="Co-owner name">'
    	+'</div>'
    	+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Email*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" name="email[]" id="email'+buyers+'" autocomplete="off" placeholder="co-owner email id">'
    	+'</div>'
    	+'<div id="eemail'+buyers+'"></div>'
		+'</div>'
		+'</div>'
		+'<input type="hidden" name="is_primary[]" id="is_primary" value="0" class="form-control">'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Permanent Address*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" placeholder="" autocomplete="off" id="address'+buyers+'" name="address[]">'
    	+'</div>'
    	+'<div id="eaddress'+buyers+'"></div>'
    	+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-search-input" class="col-5 col-form-label">Current Address*</label>'
	    +'<div class="col-7">'
	    +'<div>'
        +'<input class="form-control" type="text" value="" id="current_address'+buyers+'" name="current_address[]" autocomplete="off" >'
    	+'</div>'
    	+'<div id="ecaddress'+buyers+'"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Contact*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text"  autocomplete="off" value="" maxlength="10" id="contact'+buyers+'" name="contact[]" placeholder="contact number">'
    	+'</div>'
    	+'<div id="econtact'+buyers+'"></div>'
    	+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Pan*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" autocomplete="off" value="" maxlength="10" id="pan'+buyers+'" name="pan[]"  placeholder="Pan card number">'
    	+'</div>'
    	+'<div id="epan'+buyers+'"></div>'
    	+'</div>'
		+'</div>'
 		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Aadhaar No.*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="aadhaar_no'+buyers+'" name="aadhaar_no[]" placeholder="Aadhaar card number">'
    	+'</div>'
    	+'<div id="eaadhaar'+buyers+'"></div>'
		+'</div>'
		+'</div>'
		+'<div class="form-group row">'
	    +'<label for="example-tel-input" class="col-5 col-form-label">Refferal Id*</label>'
	    +'<div class="col-7 custom-col">'
	    +'<div>'
        +'<input class="form-control" type="text" autocomplete="off" value="" id="refferal_id'+buyers+'" name="refferal_id[]">'
    	+'</div>'
    	+'<div id="erefferal'+buyers+'"></div>'
    	+'</div>'
		+'</div>'
		+'</div>'
		+'</div>';
	$("#co-buyer").append(html);
	$("#buyer_count").val(buyers);
	$("#email"+buyers).keyup(function () {	
	    var email = $(this).val();
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/igm;
	    if($("#email"+buyers).val() == ""){
	    	$("#eemail"+buyers).html("<p><font color='#A9442;'>Email required and cannot be empty</font></p>");
	    	$("#newbuyer").attr('disable',true);
	    }else if($("#email"+buyers).val()!=""){			
			$("#eemail"+buyers).html("");
			if (re.test(email)) {
				$("#eemail"+buyers).html("");
				$("#newbuyer").attr('disabled',false);
			} else {
				$("#eemail"+buyers).html("<p><font color='#A9442;'>invalid email id</font></p>");
				$("#newbuyer").attr('disabled',true);
			}
		}
	});
	$("#buyer_name"+buyers).keyup(function(){
		var patt = new RegExp("/[^a-zA-Z ]/g");
	    var res = patt.test($("#buyer_name"+buyers).val());
		
		if($("#buyer_name"+buyers).val() == "" || $("#buyer_name"+buyers).val().length == 0){
			$("#ename"+buyers).html("<p><font color='#A9442;'>Buyer Name required and cannot be empty</font></p>");
			$("#newbuyer").attr('disabled',true);
		}
		$("#buyer_name"+buyers).val( $("#buyer_name"+buyers).val().replace(/[^a-zA-Z ]/g, function(str) { $("#newbuyer").attr('disabled',true); return ''; } ) );
	});	
	$("#contact"+buyers).keyup(function(e){
		
		var patt = new RegExp("^[7-9][0-9]{9}$");
	    var res = patt.test($("#contact"+buyers).val());
		if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	        //display error message
	        $("#econtact"+buyers).html("<p><font color='#A94442;'>Invalid contact number.</font></p>");
	        $("#newbuyer").attr('disabled',true);
	               return '';
	    }else{
	    	//$("#econtact"+buyers).html("<p>J "+res+"</p>");
	    	if(res==true){
	    		var len = $("#contact"+buyers).val();
	    		if($("#contact"+buyers).val().length == 10){
	    			$("#econtact"+buyers).html("");
	    			$("#newbuyer").attr('disabled',false);
	    		}else{
	    			$("#econtact"+buyers).html("<p><font color='#A94442;'>Invalid contact number</font></p>");
	    			$("#newbuyer").attr('disabled',true);
	    		}
	    	}else{
	    		$("#econtact"+buyers).html("<p><font color='#A94442;'>Invalid contact number.</font></p>");
	    		$("#newbuyer").attr('disabled',true);
	    	}
	    }
		if($("#contact"+buyers).val().length==0){
			 $("#econtact"+buyers).html("<p><font color='#A94442;'>Contact number required and cannot be empty.</font></p>");
			 $("#newbuyer").attr('disabled',true);
		}
	});
	$("#address"+buyers).keyup(function(){
		if($("#address"+buyers).val()==""){
			$("#eaddress"+buyers).html("<p><font color='#A94442;'>Permanent address required and cannot be empty.</font></p>");
			$("#newbuyer").attr('disabled',true);
		}else{
			$("#eaddress"+buyers).html("");
			$("#newbuyer").attr('disabled',false);
		}
	});
	$("#current_address"+buyers).keyup(function(){
		if($("#current_address"+buyers).val()==""){
			$("#ecaddress"+buyers).html("<p><font color='#A94442;'>Current address required and cannot be empty.</font></p>");
			$("#newbuyer").attr('disabled',true);
		}else{
			$("#ecaddress"+buyers).html("");
			$("#newbuyer").attr('disabled',false);
		}
	});
	
	$("#pan"+buyers).keyup(function(){
		var patt = new RegExp("^[A-Z]{5}[0-9]{4}[A-Z]{1}$");
	    var res = patt.test($("#pan"+buyers).val());
		if($("#pan"+buyers).val() ==""){
			$("#epan"+buyers).html("<p><font color='#A94442;'>Pan card required and cannot be empty.</font></p>");
			$("#newbuyer").attr('disabled',true);
		}else{
			if(res==true){
				if($("#pan"+buyers).val().length==10){
					$("#epan"+buyers).html("");
					$("#newbuyer").attr('disabled',false);
				}else{
					$("#epan"+buyers).html("<p><font color='#A94442;'>Invalid pan card number</font></p>");
					$("#newbuyer").attr('disabled',true);
				}
			}else{
				$("#epan"+buyers).html("<p><font color='#A94442;'>Invalid pan card number</font></p>");
				$("#newbuyer").attr('disabled',true);
			}
		}
	});
	$("#aadhaar_no"+buyers).keyup(function(){
		var patt = new RegExp("^[0-9]{12}$");
	    var res = patt.test($("#aadhaar_no"+buyers).val());
		if($("#aadhaar_no"+buyers).val() ==""){
			$("#eaadhaar"+buyers).html("<p><font color='#A94442;'>Adhaar number required and cannot be empty</font></p>");
			$("#newbuyer").attr('disabled',true);
		}else{
			if($("#aadhaar_no"+buyers).val().length ==12){
				$("#eaadhaar"+buyers).html("");
				$("#newbuyer").attr('disabled',false);
			}else{
				$("#eaadhaar"+buyers).html("<p><font color='#A94442;'>Invalid aadhaar number</font></p>");
				$("#newbuyer").attr('disabled',true);
			}
		}
	});
	$("#refferal_id"+buyers).keyup(function(){
		if($("#refferal_id"+buyers).val() == ""){
			$("erefferal"+buyers).html("<p><font color='#A94442'>Refferal id required and cannot be empty</font></p>");
			$("#newbuyer").attr('disabled',true);
		}else{
			if($("#refferal_id"+buyers).val().length == 0){
				$("erefferal"+buyers).html("<p><font color='#A94442'>Refferal id required and cannot be empty</font></p>");
				$("#newbuyer").attr('disabled',true);
			}else{
				$("#erefferal"+buyers).html("");
				$("#newbuyer").attr('disabled',false);
			}
			
		}
	});
}
function removeBuyer(id) {
	$("#buyer-"+id).remove();
}

function validateBuyername(id){
	  $("#buyer_name"+id).val( $("#buyer_name"+id).val().replace(/[^a-zA-Z ]/g, function(str) { return ''; } ) );
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
	var buyercount = false;
	var photos = false;
	var email=false;
	var address=false;
	var current_address = false;
	var contact = false;
	var pan = false;
	var aadhaar = false;
	var refferal = false;
	
	var buyers = parseInt($("#buyer_count").val());
	for(var i=1;i<=buyers;i++){
		if($("#buyer_name"+i).val() == ""){
			buyercount = true;
		}
		if($("#photo"+i).val() == "")
			photos = true;
		if($("#email"+i).val() == "")
			email = true;
		if($("#address"+i).val() == "")
			address = true;
		if($("#current_address"+i).val() == "")
			current_address = true;
		if($("#contact"+i).val() == "")
			contact = true;
		if($("#pan"+i).val() == "")
			pan = true;
		if($("#aadhaar_no"+i).val() == "")
			aadhaar = true;
		if($("#refferal_id"+i).val() == "")
			refferal = true;
	}
	if(buyercount && photos && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("All fields are mendetory");
	}else if(buyercount && photos && email && address && current_address && contact && pan && aadhaar){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, contact number, pan card number and aadhaar number");
	}
	else if(buyercount && photos && email && address && current_address && contact && pan && refferal){
		alert("Please select photo and enter Buyer Name, email id,permanent address, current address, contact number, pan card number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact && aadhaar && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, contact number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && pan && aadhaar && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, pan card number, aadhaar number and refferal id ")
	}else if(buyercount && photos && email && address && contact && pan && aadhaar && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && current_address && contact && pan && aadhaar && refferal){
		alert("Plase  select photo and enter buyer name,  email id, current address, contact number, pan card number, aadhaar number and refferal id ")
	}else if(buyercount && photos && address && current_address && contact && pan && aadhaar && refferal){
		alert("Please select photo and enter buyer name, permanent address, current address, contact number, pan card number, aadhaar number and refferal id")
	}else if(buyercount && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase enter buyer name, email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(photos && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact && pan){
		alert("Plase select photo and enter buyer name, email, permanent address, current address, contact number and pan card number");
	}else if(buyercount && photos && email && address && current_address && contact &&  aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, permanent address, current address, contact number, aadhaar number and refferal id");
	}
	else if(buyercount && photos && email && address && current_address && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, permanent address, current address, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, permanent address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase enter buyer name, email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(photos && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact && pan && aadhaar && refferal){
		alert("Plase select photo and enter buyer name, email, permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact && pan){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, contact number and pan card number");
	}else if(buyercount && photos && email && address && current_address && contact && refferal){
		alert("Please slect photo and enter buyer name, email id, permanent address, current address and refferal id")
	}else if(buyercount && photos && email && address && current_address && aadhaar && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && pan && aadhaar && refferal){
		alert("Please select photos and enter buyer name, email, permanent address, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address && contact){
		alert("Please select photo and enter buyer name, email id, permanent address, current address, contact number");
	}else if(buyercount && photos && email && address && current_address && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, current address and refferal id");
	}else if(buyercount && photos && email && address && aadhaar && refferal){
		alert("Please select photo and enter buyer name, email id, permanent address, aadhaar number and refferal id");
	}else if(buyercount && photos && email && pan && aadhaar && refferal){
		alert("Please select buyer photo and enter buyer name, email id, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && contact && pan && aadhaar && refferal){
		alert("Please select buyer photo and enter buyer name, contact number");
	}else if(buyercount && current_address && contact && pan && aadhaar && refferal){
		alert("Please enter buyer name, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(address && current_address && contact && pan && aadhaar && refferal){
		alert("Please enter permanent address, current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address && current_address){
		alert("Please select buyer photo and enter buyer name, email id, permanent address, current address");
	}else if(buyercount && photos && email && address  && refferal){
		alert("Plase select buyer photo and enter buyer name, email id, permanent address and refferal id");
	}else if(buyercount && photos && email && aadhaar && refferal){
		alert("Please select buyer photo and enter buyer name, email id, aadhaar number and refferal id");
	}else if(buyercount && photos && pan && aadhaar && refferal){
		alert("Please select buyer photo and enter buyer name, pan card number, aadhaar number and refferal id");
	}else if(buyercount && contact && pan && aadhaar && refferal){
		alert("Please enter buyer name, contact number, pan card number and refferal id");
	}else if(current_address && contact && pan && aadhaar && refferal){
		alert("Please enter current address, contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email && address){
		alert("Please select buyer photo and enter buyer name, email id, permanent address");
	}else if(buyercount && photos && email && refferal){
		alert("Please select buyer photo and enter buyer name, email id, refferal id");
	}else if(buyercount && photos && aadhaar && refferal){
		alert("Please select buyer photo and enter buyer name, aadhaar number, refferal id");
	}else if(buyercount && pan && aadhaar && refferal){
		alert("Please enter buyer name, pan card number, aadhaar number and refferal id");
	}else if(contact && pan && aadhaar && refferal){
		alert("Please enter contact number, pan card number, aadhaar number and refferal id");
	}else if(buyercount && photos && email){
		alert("Please select buyer photo and enter buyer name, email id");
	}else if(buyercount && photos && refferal){
		alert("Please select buyer photo and enter buyer name and refferal id");
	}else if(buyercount && aadhaar && refferal){
		alert("Please enter buyer name, aadhaar number and refferal id");
	}else if(pan && aadhaar && refferal){
		alert("Please enter pan card number and refferal id");
	}else if(buyercount && photos){
		alert("Please select buyer photo and enter buyer name");
	}else if(buyercount && email){
		alert("please enter buyer name and email id");
	}else if(buyercount && address){
		alert("Please enter buyer name and permanent address");
	}else if(buyercount && current_address){
		alert("Please enter buyer name and current address");
	}else if(buyercount && contact){
		alert("Please enter buyer name and contact number");
	}else if(buyercount && pan ){
		alert("Please buyer name and pan card number");
	}else if(buyercount && aadhaar){
		alert("Please buyer name and aadhaar number");
	}else if(buyercount && refferal){
		alert("Please enter buyer name and refferal id");
	}else if(photos && email ){
		alert("Please select buyer photo and enter email id");
	}else if(photos && address){
		alert("Please select buyer photo and enter permanent address");
	}else if(photos && current_address){
		alert("Please select buyuer photo and enter current address");
	}else if(photos && contact){
		alert("Please select buyer photo and enter contact number");
	}else if(photos && pan){
		alert("Please select buyer photo and enter pan card number");
	}else if(photos && aadhaar){
		alert("Please select buyer photo and enter aadhaar number");
	}else if(photos && refferal){
		alert("Please select buyer photo and enter refferal id");
	}else if(email && address ){
		alert("Please enter email id and permanent address");
	}else if(email  && current_address){
		alert("Please enter email id and current address");
	}else if(email && contact){
		alert("Plase enter email id and contact number");
	}else if( email && pan ){
		alert("Please enter email id and pan card number");
	}else if(email && aadhaar){
		alert("Please enter email id and aadhaar number");
	}else if(email && refferal){
		alert("Please enter email id and refferal");
	}else if(address && current_address){
		alert("Please enter permanent address and current address");
	}else if(address && contact){
		alert("Please enter permanent address and contact number");
	}else if(address && pan){
		alert("Please enter permanent address and pan card number");
	}else if(address && aadhaar){
		alert("Please enter permanent address and aadhaar number");
	}else if(address && refferal){
		alert("Please enter permanent address and refferal id");
	}else if(current_address && contact){
		alert("Please enter current address and contact number");
	}else if(current_address && pan){
		alert("Please enter current address and pan card number");
	}else if(current_address && aadhaar ){
		alert("please enter current address and aadhaar number");
	}else if(current_address && refferal){
		alert("Please enter current address and refferal id");
	}else if(contact && pan){
		alert("Please enter contact number and pan card number");
	}else if(contact  && aadhaar ){
		alert("Please enter conatct number and aadhaar number");
	}else if(contact && refferal){
		alert("Please enter contact number and refferal id");
	}else if(pan && aadhaar){
		alert("Please enter pan card number and aadhaar number");
	}else if(pan && refferal){
		alert("Please enter pan card number and refferal id");
	}else if(aadhaar && refferal){
		alert("Please enter aadhaar number and refferal id");
	}else if(buyercount){
		alert("Please enter buyer name");
	}else if(photos){
		alert("Please select buyer photo");
	}else if(email){
		alert("Please enter email id");
	}else if(address){
		alert("Please enter permanent address");
	}else if(current_address){
		alert("Please enter current address");
	}else if(contact){
		alert("Please enter contact number");
	}else if( pan ){
		alert("Please enter pan card number");
	}else if(aadhaar){
		alert("Please enter aadhaar number");
	}else if(refferal){
		alert("Please enter refferal id");
	}
// 	$("#home").hide();
// 	//$("#menu1").show();
// 	 $('.active').removeClass('active').next('li').addClass('active');
//      $("#menu1").addClass('active');
//      $("#menu1").show();
     
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
        'buyer_name[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer Name required and cannot be empty'
                }
            }
        },
        'email[]':{
        	excluded: false,
            validators: {
           	 notEmpty: {
                    message: 'Email required and cannot be empty'
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
                    message: 'Contact no. required and cannot be empty'
                },
                regexp: {
                    regexp: '^[7-9][0-9]{9}$',
                    message: 'Invalid contact number',
                    maxlength:10,
                    minlength:10
                }
            }
        },
        'pan[]': {
            validators: {
                notEmpty: {
                    message: 'PAN card number required and cannot be empty'
                },
                regexp:{
                	regexp:'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
                	message:'Invalid PAN card number',
                	maxlength:10,
                	minlength:10
                }
            }
        },
        'address[]': {
            validators: {
                notEmpty: {
                    message: 'Permanent address required and cannot be empty'
                }
            }
        },
        'current_address[]':{
        	 validators: {
                 notEmpty: {
                     message: 'Current address required and cannot be empty'
                 }
             }
        },
        'photo[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer photo required and cannot be empty'
                }
            }
        },
        'aadhaar_no[]':{
        	validators: {
                notEmpty: {
                    message: 'Aadhaar Card number required and cannot be empty'
                },
                numeric: {
                 	message: 'Invalid Aadhaar Card number',
                    thousandsSeparator: '',
                    decimalSeparator: '.',
                    maxlength:12,
                    minlength:12
              	}
            },
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
		    		message: 'Payable required and cannot be empty'
		        },
            }
        },
        'amount[]':{
        	validators:{
        		notEmpty :{
        			message: 'amount required and cannot be empty'
        		}
        	}
        }
        
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
	ajaxindicatorstart("Loading...");
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
        ajaxindicatorstop();
        window.location.href = "${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id="+<%out.print(project_id);%>
  	}
}
function calculateAmount(id){
	alert("Per :: "+$("#payable"+id).val()+" Amt :: "+$("#amount"+id).val()+" Sale value "+$("#h_sale_value").val());
	if($("#payable"+id).val() <0 || $("#payable"+id).val() >100){
		alert("The percentage must be between 0 and 100");
		$("#payable"+id).val('');
	}else{
	var amount = $("#payable"+id).val()*$("#h_sale_value").val()/100;
		$("#amount"+id).val(amount.toFixed(0));
	}
}
function calcultatePercentage(id){
	alert("Per :: "+$("#payable"+id).val()+"Amt :: "+$("#amount"+id).val()+"Sale value "+$("#h_sale_value").val());
	var $th = $("#amount"+id);
	$th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
	var percentage = $("#amount"+id).val()/$("#h_sale_value").val()*100;
	$("#payable"+id).val(percentage.toFixed(1));
}
</script>
