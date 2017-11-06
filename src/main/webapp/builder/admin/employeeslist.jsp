<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployeeAccessType"%>
<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="java.util.Date"%>
<%@page import="org.bluepigeon.admin.data.InboxMessageData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.InboxMessage"%>
<%@page import="org.bluepigeon.admin.data.InboxBuyerData"%>
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
	List<BuilderEmployeeAccessType> builderEmployeeAccessTypes = null;
 	List<EmployeeList> employeeLists = null;
 	int empId = 0;
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	Date date = new Date();
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			empId = builder.getId();
			if(empId > 0){
				employeeLists = new ProjectDAO().getBuilderEmployeeList(builder);
				builderEmployeeAccessTypes = new BuilderDetailsDAO().getBuilderAccessType();
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
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/newstyle.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/CEO-Employees.css">
     <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
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
        <div id="page-wrapper" style="min-height: 1038px;">
           <div class="container-fluid">
               <!-- row -->
                  <div class="row">
                  <h2 class="heading-text">Employees</h2>
                     <div class="col-md-8 col-lg-8 col-sm-8 col-xs-12">
                         <form class="navbar-form lead-search" method="post" role="search">
						    <div class="input-group add-on wdth100">
						      <input class="form-control textinput" placeholder="Search by Name or Number" autocomplete="off" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn wdth10">
						        <button class="btn btn-default btn231" id="search_buyer" type="button"><img src="../images/search.png"></button>
						      </div>
						    </div>
					     </form>
                       </div>
                       <div class="col-md-4 col-lg-4 col-sm-4 col-xs-12">
	                        <select id="filter_role_id" name="filter_role_id" data-style="form-control" class="custom-selectize">
	                         <option value="0">All Roles</option>
	                        <% if(builderEmployeeAccessTypes != null){
	                        	for(BuilderEmployeeAccessType builderEmployeeAccessType : builderEmployeeAccessTypes){%>
	                        <option value="<%out.print(builderEmployeeAccessType.getId());%>"><%out.print(builderEmployeeAccessType.getName()); %></option>
	                        <%}} %>
	                          
	                        </select>
                       </div>
                  </div>
               <!-- row -->
               <div class="white-box">
                 <!-- row -->
                
                   <div class="row">
	                   <div id ="emplist">
	                    <%if(employeeLists != null){
	                	 
	                	 for(EmployeeList employeeList : employeeLists){
	                	 %>
	                       <div class="col-md-4">
	                         <div class="white-box1">
	                           <div class="user-profile center">
						            <img src="../plugins/images/Untitled-1.png" alt="User Image" class="custom-img">
						            <p><b><%out.print(employeeList.getName()); %></b></p>
						            <p class="p-custom"><%out.print(employeeList.getAccess()); %></p>
						            <br>
						          </div>
						             <div class="row custom-row user-row">
								        <p class="p-custom">Mobile No.</p>
								        <p><b><%out.print(employeeList.getMobileNo()); %></b></p>
								        <p class="p-custom">Email</p>
								        <p><b><%out.print(employeeList.getEmail()); %></b></p>
								    </div>
						       </div>
						  </div>
						   <%}} %>
					
		              </div>
	             </div>
                <!-- row -->
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
$("#search_buyer").click(function(){
	searchEmployees();
});
$('#filter_role_id').change(function(){
	searchEmployees();
});
$("#srch-term").keydown(function(e){
	if(e.keyCode == 13){
		e.preventDefault();
		searchEmployees();
	}
});
function searchEmployees(){
	ajaxindicatorstart("Please wait while.. we search ...");
    $.get("${baseUrl}/builder/admin/partialemployeeslist.jsp?builder_id=<%out.print(builder_id);%>&role_id="+$('#filter_role_id').val()+"&keyword="+$('#srch-term').val(),{},function(data) {
    	$("#emplist").html(data);
    	ajaxindicatorstop();
    },'html');
}
</script>