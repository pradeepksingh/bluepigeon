<%@page import="org.bluepigeon.admin.model.Campaign"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.NewLeadList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
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
	int emp_id =0 ;
	int access_id = 0;
 	//List<ProjectData> builderProjects =null;
 	List<BuilderEmployee> salesmanList = null;
 	List<Source> sourceList = null;
 	BuilderProject builderProject = null;
 	List<NewLeadList> newLeadLists = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
   	session = request.getSession(false);
    List<Campaign> campaigns = null;
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	List<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos =null;
   	projectId = Integer.parseInt(request.getParameter("project_id")); 
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder_id > 0){
				//builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
				sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
					 builderProject = new ProjectDAO().getBuilderActiveProjectById(projectId);
					 builderProjectPropertyConfigurationInfos = new ProjectDAO().getPropertyConfigByProjectId(projectId);
					 campaigns = new CampaignDAO().getCampaignList(projectId);
					 newLeadLists = new ProjectDAO().getNewLeadList(projectId,builder);
			}
			if(builderPropertyTypes != null){
			 	if(builderPropertyTypes.size()>0)
			 		type_size = builderPropertyTypes.size();
			}
			if(access_id ==5){
				salesmanList = new BuilderDetailsDAO().getBuilderSalesman(builder);
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

<link rel="stylesheet" type="text/css" href="../../css/jquery.multiselect.css" />
    <!-- Menu CSS -->

    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
 <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <!-- Custom CSS -->

    <link href="../../css/style.css" rel="stylesheet">

    <!-- color CSS -->

    <link rel="stylesheet" type="text/css" href="../../css/salemanaddleadpopup.css">
    
<!--       <link rel="stylesheet" type="text/css" href="../css/Salesman_leads.css"> -->

    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />

    <!-- jQuery -->

    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../../js/jquery.multiselect.js"></script>
     <script src="../../js/jquery.form.js"></script>
      <script type="text/javascript" src="../../js/selectize.min.js"></script>
  	<script type="text/javascript">
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-2').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-3').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-4').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-5').multiselect();
// 		    });
		</script>
		<style>
		.arrow{
color: #ccc;
    background-color: #ccc;
    display: inline-block;
    height: 1px;
    width: 12px;
    position: relative;
   
}     
.max_value{
    padding: 6px 6px 6px 12px;
}

            .price_Ranges {
                float: right;
                width: 50%;
            }
            .price_Ranges a {
                display: block;
                text-align: left;
                padding: 6px 0 6px 0;  
                color: #6f6e6e;
                font-weight: 500;
            }
            .price_Ranges a.max_value {
                padding-right: 12px;
                padding-left: 12px;
               margin-left: 30px;
            }
            .price_Ranges a.min_value {
                padding-right: 22px;
                    padding-left: 12px;
            }
            .price_Ranges a.disabled {
                pointer-events: none;
                cursor: default;
                color: #E5E4E2;
            }
            .price_Ranges a:hover {
               background: #00bfd6;
               color: #fff;
               cursor: pointer; 
    text-decoration: none;
            }
            .btnClear {
                clear: both;
                border-top: 1px solid #dadada;
                padding: 5px 0 0 0;
                text-align: center;
            }
            input.inputError,
            input.inputError:focus {
                border-color: #e2231a;
                background-color: white;
                color: #e2231a;
                box-shadow: inset 0 0 5px #F7BDBB;
                border-radius: 0;
            }
            .ms-options-wrap > .ms-options > ul li.selected label, .ms-options-wrap > .ms-options > ul label:hover {
    background-color: #00bfd6;
}
		</style>
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
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">BOOKING</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">CANCELLATION</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads" class="btn11 btn-lead waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">CAMPAIGN</button>
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
						        <button id="searchleads" class="btn btn-default" type="button"><img src="../../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                       <%if(access_id == 7){ %>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-lead waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal1">New Lead +</button>
                      </div>
                      <%} %>
                      <%if(access_id == 5){ %>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="button"  id="addnewleadbtn" class="btn11 btn-lead waves-effect waves-light m-t-10" >New Lead +</button>
                      </div>
                      <%} %>
                 </div>
                 <div class="white-box">
                   <div class="lead-bg">
                   <!-- buyer information end -->
	                 <div class="row blue-border">
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Name</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Phone no.</h2>
	                   </div>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Email Id</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Source</h2>
	                   </div>
	                   <%if(access_id == 7){ %>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Status</h2>
	                   </div>
	                   <%} %>
	                   <%if(access_id == 5){ %>
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Assign Salesman</h2>
	                   </div>
	                   <%} %>
	                 </div>
	                 <div id="newleads">
	                 <%
	                 if(newLeadLists != null && newLeadLists.size() > 0){
	                 for(NewLeadList newLeadList : newLeadLists){ %>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getLeadName()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getPhoneNo()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getEmail()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getSource()); %></h4>
	                    </div>
	                    <%if(access_id == 7){ %>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="javascript:changeLeadStatus(1,<%out.print(newLeadList.getId());%>)">No Response</a></li>
						      <li><a href="javascript:changeLeadStatus(2,<%out.print(newLeadList.getId());%>)">Call Again</a></li>
						      <li><a href="javascript:changeLeadStatus(3,<%out.print(newLeadList.getId());%>)">Email Sent</a></li>
						      <li><a href="javascript:changeLeadStatus(4,<%out.print(newLeadList.getId());%>)">Visit Again</a></li>
						      <li><a href="javascript:changeLeadStatus(5,<%out.print(newLeadList.getId());%>)">Visit Complete</a></li>
						      <li><a href="javascript:changeLeadStatus(6,<%out.print(newLeadList.getId());%>)">Follow up</a></li>
						      <li><a href="javascript:changeLeadStatus(7,<%out.print(newLeadList.getId());%>)">Booked</a></li>
						      <li><a href="javascript:changeLeadStatus(8,<%out.print(newLeadList.getId());%>)">Not interested</a></li>
						    </ul>
						  </div>
	                    </div>
	                    <%} %>
	                    <% if(access_id == 5){
	                    	
	                    		%>
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						  		<select id="select_salesman" class="select_salesman" name="select_salesman" data-style="form-control">
							   <% if(salesmanList != null){
	                    		for(BuilderEmployee salesman : salesmanList){%>
							        <option value="<%out.print(salesman.getId());%>"><%out.print(salesman.getName()); %></option>
							    <% }}%>
							  	</select>
						  </div>
	                    </div>
	                    <%} %>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                     <img src="../../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline laststatusnam">
	                      <h5>Last States: <b id="laststatusname<%out.print(newLeadList.getId());%>"><%
	                      if(newLeadList.getLeadStatus() == 1)
	                      	out.print("No Response");
	                      if(newLeadList.getLeadStatus() == 2)
	                    	  out.print("Call Again");
	                      if(newLeadList.getLeadStatus() == 3)
	                    	  out.print("Email Sent");
	                      if(newLeadList.getLeadStatus() == 4)
	                    	  out.print("Visit Schedule");
	                      if(newLeadList.getLeadStatus() == 5)
	                    	  out.print("Visit Complete");
	                      if(newLeadList.getLeadStatus() == 6)
	                    	  out.print("Follow Up");
	                      if(newLeadList.getLeadStatus() == 7)
	                    	  out.print("Booked");
	                      if(newLeadList.getLeadStatus() == 8)
	                    	  out.print("Not Interested");
	                      %></b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                     <h6><%out.print(newLeadList.getSalemanName()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6> <% if(newLeadList.getMin()>0 && newLeadList.getMax()==0 ){
	                    	 out.print("Greater than Rs"+newLeadList.getMin()+" Lakh");
	                     }else if(newLeadList.getMin() == 0 && newLeadList.getMax() >0){
	                    	 out.print("upto Rs"+newLeadList.getMax()+ "Lakh");
	                     }else{                    
		                     out.print("Rs "+newLeadList.getMin());%> -<%out.print(newLeadList.getMax()+" Lakh");
	                     } %> </h6>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                      <h6>
	                      <%out.print(newLeadList.getConfigName());
	                      %>
	                      </h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6><%out.print(newLeadList.getSource()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b><% if(newLeadList.getStrDate() != null){ out.print(newLeadList.getStrDate());} %></b></h6>
	                    </div>
	                 </div>
	               </div>
	               <%} }%>
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
							<img src="../../images/error.png" alt="cancle" data-dismiss="modal">
						  </div>
						</div>
						
				  		<div class="row bg12">
				  		 <form class="addlead1 addlead" id="addnewlead" name="addnewlead" action="" method="post"  enctype="multipart/form-data" >
				  		 <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
		                     <div class="col-md-6 col-sm-6 col-xs-12">
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Name <span class="text-danger">*</span></label>
									  <div class="col-7">
										  <div>
											 <input class="form-control" type="text"  id="leadname" name="leadname"  placeholder="Please enter lead name">
										  </div>
										  <div class="messageContainer"></div>
								  	 </div>
								 </div>
								 <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Email ID <span class="text-danger">*</span></label>
										<div class="col-7">
											<div>
										   		<input class="form-control" type="text" id="email" name="email" placeholder="Please enter email id">
										 	</div>
										   <div class="messageContainer"></div>
									   </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Configuration <span class="text-danger">*</span></label>
										  <div class="col-7">
										  	<div>
										      <select id="configuration" name="configuration[]"  multiple>
									           <% if(builderProjectPropertyConfigurationInfos != null){ 
									           	for(BuilderProjectPropertyConfigurationInfo builderProjectPropertyConfigurationInfo : builderProjectPropertyConfigurationInfos){
									           %>
									            <option value="<%out.print(builderProjectPropertyConfigurationInfo.getBuilderProjectPropertyConfiguration().getId());%>"><%out.print(builderProjectPropertyConfigurationInfo.getBuilderProjectPropertyConfiguration().getName()); %></option>
									           <%}} %>
										     </select>
										     </div>
										     <div class="messageContainer"></div>
										  </div>
									 </div>
		                            <div class="form-group row">
							           <label for="example-tel-input" class="col-5 col-form-label">Source <span class="text-danger">*</span></label>
								         <div class="col-7">
								         	<div>
										        <select id="select_source" name="select_source" data-style="form-control">
										        <%if(sourceList != null){
										        for(Source source: sourceList) {%>
						                          <option value="<%out.print(source.getId());%>"><%out.print(source.getName()); %></option>
						                          <%}} %>
						                        </select>
					                        </div>
					                         <div class="messageContainer"></div>
									     </div>
								    </div>
						       </div>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                       <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Phone No. <span class="text-danger">*</span></label>
									  <div class="col-7">
									  	<div>
										 <input class="form-control" type="text" id="mobile" name="mobile"  placeholder="Enter Phone number">
									  </div>
									   <div class="messageContainer"></div>
									  </div>
								  </div>
								  <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
 								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Interested Project</label>
										<div class="col-7">
										   <select id="multiple-checkboxes-2" class="select-bg" disabled>
									           <% if(builderProject != null){%>
									           <option value="<%out.print(builderProject.getId());%>" selected><%out.print(builderProject.getName()); %></option>
									           <%} %>
										     </select>
										 </div>
								    </div>
									<div class="span2 investRange">
									<label for="example-search-input" class="col-5 col-form-label">Budget</label>
						    			<div class="btn-group">
										      <button id="min-max-price-range" class="form-control selectpicker select-btn  dropdown-toggle searchParams" href="#" data-toggle="dropdown" tabindex="6">
										        <div class="filter-option pull-left span_price">
										          <span id="price_range1"> </span> - <span id="price_range2">Price Range</span> </div>
										        <span class="bs-caret" style="float: right;"><span class="caret"></span></span>
										      </button>
										      <div class="dropdown-menu ddRange" role="menu" style="width: 295px;padding-top: 12px;">
										        <div class="rangemenu">
										          <div class="freeformPrice">
										            <div class="col-md-5">
										              <input name="minprice" id="minprice" type="text" class="min_input form-control" placeholder="Min Price">
										            </div>
										            <div class="col-md-2 "><span class="arrow"></span></div>
										            <div class="col-md-5">
										              <input name="maxprice" id="maxprice" type="text" class="max_input form-control" placeholder="Max Price">
										            </div>
										          </div>
										          <div class="price_Ranges rangesMax col-md-5">
										            <a class="max_value" value="" href="javascript:void(0)">Any Max</a>
										            <a class="max_value" value="1000000" href="javascript:void(0)">10 lakhs</a>
										            <a class="max_value" value="2500000" href="javascript:void(0)">25 lakhs</a>
										            <a class="max_value" value="5000000" href="javascript:void(0)">50 lakhs</a>
										            <a class="max_value" value="10000000" href="javascript:void(0)">1 cr</a>
										            <a class="max_value" value="50000000" href="javascript:void(0)">5 cr</a>
										            <a class="max_value" value="100000000" href="javascript:void(0)">10 cr</a>
										            <a class="max_value" value="500000000" href="javascript:void(0)">50 cr</a>
										            <a class="max_value" value="1000000000" href="javascript:void(0)">100 cr</a>
										            <a class="max_value" value="2000000000" href="javascript:void(0)">200 cr</a>
										            <a class="max_value" value="5000000000" href="javascript:void(0)">500 cr</a>
										          </div>
										          <div class="col-md-2"> </div>
										          <div class="price_Ranges rangesMin col-md-5">
										            <a class="min_value" value="" href="javascript:void(0)">Any Min</a>
										            <a class="min_value" value="1000000" href="javascript:void(0)">10 lakhs</a>
										            <a class="min_value" value="2500000" href="javascript:void(0)">25 lakhs</a>
										            <a class="min_value" value="5000000" href="javascript:void(0)">50 lakhs</a>
										            <a class="min_value" value="10000000" href="javascript:void(0)">1 cr</a>
										            <a class="min_value" value="50000000" href="javascript:void(0)">5 cr</a>
										            <a class="min_value" value="100000000" href="javascript:void(0)">10 cr</a>
										            <a class="min_value" value="500000000" href="javascript:void(0)">50 cr</a>
										            <a class="min_value" value="1000000000" href="javascript:void(0)">100 cr</a>
										            <a class="min_value" value="2000000000" href="javascript:void(0)">200 cr</a>
										            <a class="min_value" value="5000000000" href="javascript:void(0)">500 cr</a>
										          </div>
										        </div>
										        <div class="btnClear">
										          <a href="javascript:void(0)" class="btn btn-link">Clear</a>
										        </div>
										      </div>
						    			</div>
						  			</div>
									<div class="form-group row">
										<label for="example-search-input" class="col-5 col-form-label">Campaign</label>
										<div class="col-7">
											<div>
										   		<select id="campaign_id" name="campaign_id">
											    <%if(campaigns != null){
										    	  for(Campaign  campaign: campaigns){%>
										      		<option value="<%out.print(campaign.getId());%>"><%out.print(campaign.getTitle()); %></option>
										      	 <%}} %>
											     </select>
										     </div>
										 </div>
								    </div>
						    	</div>
								<div class="center bcenter">
							  	   <button type="submit" class="button1">Save</button>
							  	</div>
		                     </form>
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
$("#booking").click(function(){
	 window.location.href="${baseUrl}/builder/salesman/booking/salesman_bookingOpenForm.jsp?project_id="+$("#project_id").val();
});
$("#cancellation").click(function(){
	 window.location.href="${baseUrl}/builder/salesman/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(projectId);%>
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/salesman/campaign/Salesman_campaign.jsp?project_id="+<%out.print(projectId);%>
});
$select_source = $("#select_source").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#select_source").val() > 0 || $("#select_source").val() != '' ){
			
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#select_source :selected").text();
    	 if(textClear.trim() == "Enter Source Name"){
    		 obj[0].setValue("0");
    	 }
     }
});

select_source = $select_source[0].selectize;

$select_campaign = $("#campaign_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#campaign_id").val() > 0 || $("#campaign_id").val() != '' ){
			
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#campaign_id :selected").text();
    	 if(textClear.trim() == "Enter campaign Name"){
    		 obj[0].setValue("0");
    	 }
     }
});

select_campaign = $select_campaign[0].selectize;

$('#configuration').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true
});

$('#min-max-price-range').click(function (event) {
    setTimeout(function(){ $('.price-label').first().focus();	},0);    
});
var priceLabelObj;
$('.price-label').focus(function (event) {
    priceLabelObj=$(this);
    $('.price-range').addClass('hide');
    $('#'+$(this).data('dropdownId')).removeClass('hide');
});

$(".price-range li").click(function(){    
    priceLabelObj.attr('value', $(this).attr('data-value'));
    var curElmIndex=$( ".price-label" ).index( priceLabelObj );
    var nextElm=$( ".price-label" ).eq(curElmIndex+1);

    if(nextElm.length){
        $( ".price-label" ).eq(curElmIndex+1).focus();
    }else{
        $('#min-max-price-range').dropdown('toggle');
    }
});

$('#addnewlead').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	leadname: {
            validators: {
                notEmpty: {
                    message: 'Lead name is required and cannot be empty'
                }
            }
        },
        mobile: {
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
        email: {
        	validators: {
            	notEmpty: {
                    message: 'The Email is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                    message: 'The value is not a valid email address'
                }
            }
        },
        select_source:{
        	validators: {
            	notEmpty: {
                    message: 'The source is required and cannot be empty'
                }
        	}
        },
        'configuration[]':{
        	validators: {
            	notEmpty: {
                    message: 'The configurations are required and cannot be empty'
                }
        	}
        },

        pricemin:{
            validators: {
                notEmpty: {
                    message: 'min price is required and cannot be empty'
                }
            }
        } ,
        pricemax:{
            validators: {
                notEmpty: {
                    message: 'max price is required and cannot be empty'
                }
            }
        } 
    }
    
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	//alert("success...Find solution on google..");
	event.preventDefault();
	addLead();
}).on('error.form.bv',function(event,data){
	//alert("error...Find solution on google..");
});

function addLead() {
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/new1',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addnewlead').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+$("#project_id").val();
        ajaxindicatorstop();
  	}
}
<%if(access_id == 7){%>
function changeLeadStatus(value,id){
	ajaxindicatorstart("Loading...");
	$("#laststatusname"+id).val('');
	$.post("${baseUrl}/webapi/builder/changeleadAuthority",{value:value,id:id},function(data){
		if(data != ""){
			if(data.status==1){
				alert(data.message);
				if(data.data.value == 1){  
					 $("#laststatusname"+data.id).html("No Response");
				}
				if(data.data.value == 2){ 
					
					$("#laststatusname"+data.id).html("Call Again");
				}
				if(data.data.value == 3){ 
					$("#laststatusname"+data.id).html("Email Sent");
				}
				if(data.data.value == 4){
					$("#laststatusname"+data.id).html("Visit Schedule");
				}
				if(data.data.value == 5){
					$("#laststatusname"+data.id).html("Visit Complete");
					
				}
				if(data.data.value == 6){ 
					$("#laststatusname"+data.id).html("Follow up");
				}
				
				if(data.data.value == 7){
					$("#laststatusname"+data.id).html("Booked");
				}
				if(data.data.value == 8){
					$("#laststatusname"+data.id).html("Not Interested");
				}
				else{ 
					$("#leadstatusname"+data.id).html("");
				}
						
			}
		}
		//}
		 ajaxindicatorstop();
		
	});
}
<%}%>
$("searchleads").click(function(){
	//alert("hello");

	var searchResult = "";
	var i=1;
	
	ajaxindicatorstart("Loading...");
$("#newleads").empty();
<%if(access_id == 7){%>
getLeadsdetailList();
	<%}%>
	<%if(access_id == 5){%>
	
	
	<%}%>
});


function disableDropDownRangeOptions(max_values, minValue) {
if (max_values) {
  max_values.each(function() {
    var maxValue = $(this).attr("value");

    if (parseInt(maxValue) < parseInt(minValue)) {
      $(this).addClass('disabled');
    } else {
      $(this).removeClass('disabled');
    }
  });
}
}

function setuinvestRangeDropDownList(min_values, max_values, min_input, max_input, clearLink, dropDownControl) {
min_values.click(function() {
  var minValue = $(this).attr('value');
  min_input.val(minValue);
  document.getElementById('price_range1').innerHTML = minValue;

  disableDropDownRangeOptions(max_values, minValue);

  validateDropDownInputs();
});

max_values.click(function() {
  var maxValue = $(this).attr('value');
  max_input.val(maxValue);
  document.getElementById('price_range2').innerHTML = maxValue;

  toggleDropDown();
});

clearLink.click(function() {
  min_input.val('');
  max_input.val('');

  disableDropDownRangeOptions(max_values);

  validateDropDownInputs();
});

min_input.on('input',
  function() {
    var minValue = min_input.val();

    disableDropDownRangeOptions(max_values, minValue);
    validateDropDownInputs();
  });

max_input.on('input', validateDropDownInputs);

max_input.blur('input',
  function() {
    toggleDropDown();
  });

function validateDropDownInputs() {
  var minValue = parseInt(min_input.val());
  var maxValue = parseInt(max_input.val());

  if (maxValue > 0 && minValue > 0 && maxValue < minValue) {
    min_input.addClass('inputError');
    max_input.addClass('inputError');

    return false;
  } else {
    min_input.removeClass('inputError');
    max_input.removeClass('inputError');

    return true;
  }
}

<%if(access_id == 5){%>
$("#addnewleadbtn").click(function(){
//	alert("a");
	openAddLead(<%out.print(projectId);%>);
});

function openAddLead(id){
	window.location.href="${baseUrl}/builder/leads/Saleshead_add_lead.jsp?project_id="+<%out.print(projectId);%>
}
<%}%>
function getLeadsdetailList(){
	$.post("${baseUrl}/webapi/builder/filter/newlead",{emp_id : $("#emp_id").val(), project_id:$("#project_id").val(),name:$("#srch-term").val()},function(data){
		$(data).each(function(index){
			searchResult += '<div class="border-lead">'
			    +'<div class="row">'
			      +'<div class="col-md-2 col-sm-2 col-xs-6">'
			       +'<h4>'+data[index].leadName+'</h4>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6">'
			       +'<h4>'+data[index].phoneNo+'</h4>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6">'
			       +'<h4>'+data[index].email+'</h4>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6">'
			       +'<h4>'+data[index].source+'</h4>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6">'
			       +' <div class="dropdown">'
					    +'<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up'
					    +'<span class="caret"></span></button>'
					    +'<ul class="dropdown-menu">'
					      +'<li><a href="javascript:changeLeadStatus(1,'+data[index].id+')">No Response</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(2,'+data[index].id+')">Call Again</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(3,'+data[index].id+')">Email Sent</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(4,'+data[index].id+')">Visit Again</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(5,'+data[index].id+')">Visit Complete</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(6,'+data[index].id+')">Follow up</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(7,'+data[index].id+')">Booked</a></li>'
					      +'<li><a href="javascript:changeLeadStatus(8,'+data[index].id+')">Not interested</a></li>'
					    +'</ul>'
					  +'</div>'
			      +'</div>'
			   +'</div>'
			   +'<hr>'
			   +'<div class="row">'
			      +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			       +'<img src="../images/Saleshead-added.PNG" />'
			       +'<h5>Added By :</h5>'
			     +' </div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			        +'<img src="../images/Baget.PNG" />'
			       +'<h5>Budget:</h5>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			        +'<img src="../images/Configuration.PNG" />'
			        +'<h5>Configuration :</h5>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			        +'<h5>Source :</h5>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline laststatusnam">'
			        +'<h5>Last States: <b id="laststatusname'+data[index].id+'">'+data[index].leadStatusName+'</b></h5>'
			      +'</div>'
			   +'</div>'
			  +'<div class="row">'
			      +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			       +'<h6>'+data[index].salemanName+'</h6>'
			      +'</div>'
			      +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			       +'<h6>Rs '+data[index].min+' - '+data[index].max+' Lakh</h6>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			       +'<h6>';
			       $(data[index].configDatas).each(function(index1){
			    	   if(i>1){
			    		   searchResult +=''+data[index].configDatas[index1].name+',';
			    		   i--;
			    	   }else{
			    		   searchresult +=''+data[index].configDatas[index1].name+'';
			    	   }
			    	   i++;
			       });
			       searchresult +='</h6>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			        +'<h6>'+data[index].source+'</h6>'
			      +'</div>'
			       +'<div class="col-md-2 col-sm-2 col-xs-6 inline">'
			        +'<h6>Date: <b>'+data[index].lDate+'</b></h6>'
			      +'</div>'
			   +'</div>'
			 +'</div>';
			});
		 	$("#newleads").append(searchresult);
		 	 ajaxindicatorstop();
		},'json');
}
function toggleDropDown() {
  if (validateDropDownInputs() &&
    parseInt(min_input.val()) > 0 &&
    parseInt(max_input.val()) > 0) {

    // auto close if two values are valid
    dropDownControl.dropdown('toggle');
  }
}
}
$("#srch-term").keydown(function (e) {
	if (e.keyCode == 13) {
		alert("Hello");
		getLeadsdetailList();
		//return false;
	}
});

setuinvestRangeDropDownList(
$('.investRange .min_value'),
$('.investRange .max_value'),
$('.investRange .freeformPrice .min_input'),
$('.investRange .freeformPrice .max_input'),
$('.investRange .btnClear'),
$('.investRange .dropdown-toggle'));

</script>
