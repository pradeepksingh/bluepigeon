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
    <link rel="stylesheet" type="text/css" href="../css/custom5.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
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
                          <ul class="nav nav-pills navpills">
							 <li class="active"><a data-toggle="pill" href="#home">Add New Buyer</a></li>
							 <li><a data-toggle="pill" href="#menu1">Project Details</a></li>
							 <li><a data-toggle="pill" href="#menu2">Buying Details</a></li>
							 <li><a data-toggle="pill" href="#menu3">Payment Schedule</a></li>
							 <li><a data-toggle="pill" href="#menu4">Document</a></li>
						 </ul>
						 <div class="tab-content tabcontent">
					 	    <div id="home" class="tab-pane fade in active">
					 	       <div class="row">
						 	     <form class="" >
								    <div class="form-group row">
								        <label for="example-text-input" class="col-5 col-form-label"> Buyers Name*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id=""  placeholder="Pradeep Singh">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Email*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id="" placeholder="Pradeep@gmail.com">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-search-input" class="col-5 col-form-label">Permanent Address*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id="">
								        </div>
								    </div>
								   
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Contact*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id="" placeholder="9876547343">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Pan*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id="" placeholder="BARPS0276">
								        </div>
								    </div>
								    <div class="form-group row">
								        <label for="example-tel-input" class="col-5 col-form-label">Refferal Id*</label>
								        <div class="col-7">
								            <input class="form-control" type="text" value="" id="">
								        </div>
								    </div>
								</form>
					 	        </div>
					 	       <div class="centerbutton">
					 	           <button type="button">Privious</button>
					 	           <button type="button">Next</button>
					 	       </div>
					        </div>
						    <div id="menu1" class="tab-pane fade">
						    </div>
						    <div id="menu2" class="tab-pane fade">
						    </div>
						    <div id="menu3" class="tab-pane fade">
						    </div>
						     <div id="menu3" class="tab-pane fade">
						    </div>
					 	 </div>
					  </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 tabcontent">
                    <%if(bookingFlatList != null){ %>
                     <div class="bg1">
                       <img src="plugins/images/Untitled-1.png" alt="Project image" class="custom-img">
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
	window.location.href="${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+<%out.print(project_id);%>
});
</script>
