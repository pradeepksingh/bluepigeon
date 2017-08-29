<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.model.Source"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
 	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
	int projectId = 0;
 	List<ProjectData> builderProjects =null;
 	List<Source> sourceList = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	projectId = Integer.parseInt(request.getParameter("project_id"));
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
		}
		if(builder_id > 0){
			builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
			sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
		}
		if(builderProjects.size()>0)
	    	project_size = builderProjects.size();
	 	if(builderPropertyTypes.size()>0)
	 		type_size = builderPropertyTypes.size();
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
    <link rel="stylesheet" type="text/css" href="../css/custom8.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-multiselect.css">
    <script>
    $(function() {
        $("#sidebar1").load("../partial/sidebar.jsp");
        $("#header").load("../partial/header.jsp");
   	    $("#footer").load("../partial/footer.jsp");
    });
    </script>
  	<script type="text/javascript">
		    $(document).ready(function() {
		        $('#multiple-checkboxes').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-2').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-3').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-4').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-5').multiselect();
		    });
		</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">Booking</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">Cancellation</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads" class="btn11 btn-lead waves-effect waves-light m-t-10">Leads</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">Campain</button>
		                </div>
	                </div>
               <!-- row -->
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12">
                         <form class="navbar-form lead-search" role="search">
                          <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn">
						        <button class="btn btn-default" type="submit"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-lead waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal1">New Lead +</button>
                      </div>
                 </div>
                 <div class="white-box">
                   <div class="lead-bg">
                   <!-- buyer information end -->
	                 <div class="row blue-border">
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Name</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Phone no.</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Email Id</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Source</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Status</h2>
	                   </div>
	                 </div>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Satish Rajvade</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>0000-000-000</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>info@gmail.com</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Google Source</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="#">HTML</a></li>
						      <li><a href="#">CSS</a></li>
						      <li><a href="#">JavaScript</a></li>
						      <li><a href="#">About Us</a></li>
						    </ul>
						  </div>
	                    </div>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <img src="../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Last States: <b>Call</b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Salesman name</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Rs 50 -70 Lakh</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>2BHK, 3BHK</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Google Source</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b>23 July 2017</b></h6>
	                    </div>
	                 </div>
	               </div>
	               <!-- buyer information end -->
	                <!-- buyer information -->
	               <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Satish Rajvade</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>0000-000-000</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>info@gmail.com</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Google Source</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="#">HTML</a></li>
						      <li><a href="#">CSS</a></li>
						      <li><a href="#">JavaScript</a></li>
						      <li><a href="#">About Us</a></li>
						    </ul>
						  </div>
	                    </div>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <img src="../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Last States: <b>Call</b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Salesman name</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Rs 50 -70 Lakh</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>2BHK, 3BHK</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Google Source</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b>23 July 2017</b></h6>
	                    </div>
	                 </div>
	               </div>
	                <!-- buyer information end -->
                  </div>
               </div>
            </div>
       </div>
        <!-- Modal -->
		  <div class="modal fade" id="myModal1" role="dialog">
		   <div class="modal-dialog lead">
		      <div class="modal-content">
		        <div class="modal-body">
		           	  <div class="row">
						  <div class="col-md-10 col-sm-10 col-xs-10">
							<h3>Add Lead</h3>
						  </div>
						  <div class="col-md-2 col-sm-2 col-xs-2">
							<img src="../images/error.png" alt="cancle" data-dismiss="modal">
						  </div>
						</div>
				  		<div class="row bg12">
				  		 <form class="addlead1 addlead">
		                     <div class="col-md-6 col-sm-6 col-xs-12">
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Name</label>
									  <div class="col-7">
										 <input class="form-control" type="text" value="" id=""  placeholder="">
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Email ID</label>
										<div class="col-7">
										   <input class="form-control" type="text" value="" id="" placeholder="">
										 </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Configuration</label>
										  <div class="col-7">
										      <select id="multiple-checkboxes-3"  multiple="multiple">
									            <option value="php">Select All</option>
										        <option value="php">PHP</option>
										        <option value="javascript">JavaScript</option>
										        <option value="java">Java</option>
										        <option value="sql">SQL</option>
										        <option value="jquery">Jquery</option>
										        <option value=".net">.Net</option>
										     </select>
										  </div>
									 </div>
		                            <div class="form-group row">
							           <label for="example-tel-input" class="col-5 col-form-label">Source</label>
								         <div class="col-7">
									        <select class="selectpicker" data-style="form-control">
					                          <option>All Floor</option>
					                          <option>Floor No-1</option>
					                          <option>Floor No-2</option>
					                          <option>Floor No-3</option>
					                          <option>Floor No-4</option>
					                        </select>
									     </div>
								    </div>
						       </div>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                       <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Phone No.</label>
									  <div class="col-7">
										 <input class="form-control" type="text" value="" id=""  placeholder="">
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Interested Project</label>
										<div class="col-7">
										   <select id="multiple-checkboxes-2"  multiple="multiple">
									            <option value="php">Select All</option>
										        <option value="php">PHP</option>
										        <option value="javascript">JavaScript</option>
										        <option value="java">Java</option>
										        <option value="sql">SQL</option>
										        <option value="jquery">Jquery</option>
										        <option value=".net">.Net</option>
										     </select>
										 </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Budget</label>
										  <div class="col-7">
										    <select class="selectpicker" data-style="form-control">
					                          <option>All Floor</option>
					                          <option>Floor No-1</option>
					                          <option>Floor No-2</option>
					                          <option>Floor No-3</option>
					                          <option>Floor No-4</option>
					                        </select>
										   </div>
									 </div>
								</div>
								<div class="center bcenter">
							  	   <button type="button" class="button1">Save</button>
							  	</div>
		                     </form>
				  		</div>
			  	</div>
		 	  </div>
            </div>
		  </div>
    </div>
    <!-- /.container-fluid -->
    <footer id="footer"> </footer>
  </body>
</html>
<script>
$("#booking").click(function(){
	 window.location.href="${baseUrl}/builder/buyer/booking.jsp?project_id="+$("#project_id").val();
});
$("#cancellation").click(function(){
	 window.location.href="${baseUrl}/builder/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(projectId);%>
});
</script>
