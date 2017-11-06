<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<ProjectData> project_list = null;
	int builder_id = 0;
	int empId = 0;
	int access_id =0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			access_id=builder.getBuilderEmployeeAccessType().getId();
			empId = builder.getId();
			if(builder_id > 0 && access_id == 6){
				project_list = new ProjectDAO().getAssigProjects(empId);
			}else{
				response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
			}
		}
		
   }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>Postsale_Generate demand letter</title>

    <!-- Favicon-->
    <link rel="icon" href="../../favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

    <!-- Bootstrap Core Css -->
    <link href="../css/postsaleDocbootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
      <link href="../css/jquery.multiselect.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/postsaleagreement.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-datetimepicker.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../js/selectize.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
      <script src="../js/Moment.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <!-- Custom Css -->
    <link href="../css/PostalSale_Aggrement.css" rel="stylesheet">

    <!-- Custom Css -->
<!--     <link href="../../css/Postsale_Generate_demand_letter.css" rel="stylesheet"> -->

    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
<!--     <link href="../../css/themes/all-themes.css" rel="stylesheet" /> -->
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
        <div id="page-wrapper">
    		<section class="content" style="margin-top:60px;">
        <div class="container-fluid">
                <h2>GENERATE DEMAND LETTER</h2>
            		<div class="row clearfix">
            			<form id="add_demand" name="add_demand" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	                    		<div class="card">
	                        		<div class="header">
	                            		<h2 style="color: #24bcd3;margin-left: 8px;"></h2>
	                    					<div class="row clearfix" >
					               				<div class="col-md-6">
	                                    			<div class="input-group input-group-lg">
	                                        			<span class="input-group-addon">
	                                            			<label for="ig_checkbox">DEMAND NAME</label>
	                                        			</span>
	                                        			<div class="form-line">
	                                            			<input class="form-control form-control1" value="" id="demand_name" name="demand_name" type="text">
	                                        			</div>
	                                    			</div>
	                                			</div>
					                			<div class="col-md-6">
	                                    			<div class="input-group input-group-lg">
				                                        <span class="input-group-addon">
		                                            		<label for="ig_checkbox">LAST DATE</label>
		                                        		</span>
		                                        		<div class="form-line">
		                                           			<input class="form-control form-control1" value="" id="last_date" name="last_date" type="text">
		                                        		</div>
		                                    		</div>
	                                			</div>
										 		<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                       			<span class="input-group-addon">
		                                            		<label for="ig_checkbox">REMIND EVERY</label>
		                                        		</span>
		                                        		<div class="form-line">
		                                      				<input class="form-control form-control1" value="" id="remind" name="remind" type="text">
		                                        		</div>
		                                    		</div>
		                                		</div>
										 		<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                        		<span class="input-group-addon">
		                                            		<label for="ig_checkbox">PREVIOUS DEMAND</label>
		                                        		</span>
		                                        		<div class="form-line">
		                                           			<input class="form-control form-control1" value="" id="previous_dedmand" name="previous_demand" type="text">
		                                        		</div>
		                                    		</div>
		                                		</div>
										    	<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                        		<span class="input-group-addon">
		                                            		<label for="ig_checkbox">Project </label>
		                                        		</span>
		                                        		<div class="form-line">
		                                           			<select name="project_id" id="project_id" class="form-control form-control1">
											                    <option value="">Select Project</option>
											                    <%
											                    if(project_list != null){
											                    for(ProjectData builderProject : project_list){ %>
																<option value="<% out.print(builderProject.getId());%>" ><% out.print(builderProject.getName());%></option>
																<% } 
																}%>
												             </select>
		                                        		</div>
		                                    		</div>
		                                		</div>
						      					<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                        		<span class="input-group-addon">
		                                            		<label for="ig_checkbox">Building</label>
		                                        		</span>
		                                         		<div >
		                                           			<select name="building_id" id="building_id" class="form-control show-tick form-control1" ></select>
		                                        		</div>
		                                    		</div>
		                                		</div>
										    	<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                        		<span class="input-group-addon">
		                                            		<label for="ig_checkbox">FLAT</label>
		                                        		</span>
		                                        		<div class="form-line">
		                                           			<select name="flat_id" id="flat_id" class="form-control show-tick form-control1" ></select>
		                                        		</div>
		                                    		</div>
		                                		</div>
						      					<div class="col-md-6">
		                                   			<div class="input-group input-group-lg">
		                                       			<span class="input-group-addon">
		                                           			<label for="ig_checkbox">RECIPIENT NAME</label>
		                                       			</span>
	                                        			<div class="form-line">
	                                          				<select id="buyer_id" name="buyer_id" class="form-control show-tick form-control1" ></select>
	                                       				</div>
		                                   			</div>
		                                		</div>
										    	<div class="col-md-6">
		                                    		<div class="input-group input-group-lg">
		                                        		<span class="input-group-addon">
		                                            		<label for="ig_checkbox" style="font-size: 13px;">PAYMENT SCHEDULE</label>
		                                        		</span>
		                                        		<div class="form-line">
		                                           			<select class="form-control show-tick form-control1" ></select>
		                                        		</div>
		                                    		</div>
		                                		</div>
								 			</div>
								 			<div class="row clearfix" style="margin-top:20px">
								 				<div class="col-md-3"></div>
									 			<div class="col-md-6">
	                                   				<div class="row clearfix" >
									   					<div class="col-md-6">
											 				<div class="button-demo">
	                                							<button type="submit" class="btn btn-success  waves-effect" style="font-size:20px">Upload</button><span style="margin-left: 37px;">or</span>
	                                 						</div>
									 					</div>
									  					<div class="col-md-6">
									  						<div class="button-demo">
	                                							<button type="submit" class="btn btn-success  waves-effect" style="font-size:20px">Generate</button> 
	                                 						</div>
									 					</div>
	                                 				</div>
	                                			</div>
									 			<div class="col-md-3"></div>
								 			</div>
	                      				</div>
	                				</div>
					   			</div>
					   		</form>
         				</div>
        			</div>
    		</section>
		</div>
	</div>
<div id="sidebar1"> 
	<%@include file="../partial/footer.jsp"%>
</div> 
</body>
</html>