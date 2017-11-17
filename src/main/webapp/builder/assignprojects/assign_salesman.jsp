<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
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
	int access_id =0;
	int city_size = 0;
	int emp_id =0 ;
	//use in multiselect drop down
 	List<ProjectData> builderProjects =null;
 	//use in displaying alredy assign project on load
 	List<ProjectData> assignProjects = null;
 	List<Source> sourceList = null;
 	List<BuilderEmployee> salesmanList = null;
 	List<EmployeeList> employeeLists = null;
 	List<BuilderEmployee> salesheadList = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	List<ProjectData> projectLists = null;
   	int builder_id = 0;
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			emp_id = builder.getId();
			if(builder_id > 0){
				builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
				sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
				if(access_id ==5){
					salesmanList = new BuilderDetailsDAO().getBuilderSalesman(builder);
					projectLists = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
					assignProjects = new ProjectDAO().getAssigProjects(builder);
				}
				if(access_id == 4){
 					employeeLists = new BuilderDetailsDAO().getSalesHeadByBuilderId(builder_id);
					salesheadList = new BuilderDetailsDAO().getBuilderSaleshead(builder);
					projectLists = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
					assignProjects = new ProjectDAO().getAssigProjects(builder);
				}
			}
			if(builderProjects.size()>0)
		    	project_size = builderProjects.size();
		 	if(builderPropertyTypes.size()>0)
		 		type_size = builderPropertyTypes.size();
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
    <link rel="stylesheet" type="text/css" href="../css/assignsalesman.css">
    <link rel="stylesheet" href="../css/jquery.multiselect.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
<!--      <script src="js/bootstrap-multiselect.js"></script> -->
<!--     <link rel="stylesheet" href="css/bootstrap-multiselect.css"> -->
	<script src="../js/jquery.multiselect.js"></script>
   
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
        <div id="page-wrapper" >
           <div class="container-fluid">
           <div class="row">
           <%if(access_id == 5){ %>
           <h1 class="uppercase">Assign Salesman</h1>
           <%} %>
            <%if(access_id == 4){ %>
           <h1 class="uppercase">Assign Saleshead</h1>
           <%} %>
           </div>
              <div class="white-box">
                   <div class="lead-bg">
	                 <div class="row blue-border">
	                 <%if(access_id == 5){ %>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Salesman name</h2>
	                   </div>
	                   <%} %>
	                   <%if(access_id == 4){ %>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Saleshead name</h2>
	                   </div>
	                   <%} %>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Phone no.</h2>
	                   </div>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Email Id</h2>
	                   </div>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Assign project</h2>
	                   </div>
	                 </div>
	                 <%if(access_id == 5){ %>
	                 <%if(salesmanList != null){
	                	 for(BuilderEmployee builderEmployee : salesmanList){
	                	 %>
	                 <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(builderEmployee.getId()); %>"/>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getName()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getMobile()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getEmail()); %></h4>
	                    </div>
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                    	<div id="selectprojects">
		                     	<select id="second" data-placeholder="Choose projects"  class="chosen-select" multiple style="width:350px;" tabindex="4">
	         						<%if(projectLists != null){ 
	         							for(ProjectData projectData : projectLists){
	         						%>
	         						<option value="<%out.print(projectData.getId());%>"><%out.print(projectData.getName()); %></option>
	         						<%}} %>
	        					</select>
        					</div>
	                    </div>
	                 </div>
	                 <div class="row">
	                  <h3 class="assign"><span class="assign1">Assign Projects : </span>
	                  <%if(assignProjects != null){
	                	  int i=1;
	                	  for(ProjectData assignProject : assignProjects){
	                		  if(i>1){
	                	  		out.print(" "+assignProject.getName()+" |");
	                	  		i--;
	                		  }else{
	                			  out.print(assignProject.getName()+" |");
	                		  }
 	                	i++;}}  %></h3> 
	                 </div>
	                
	               </div>
	               <%} }}%>
	               <%
	               	if(access_id==4){
						if(salesheadList != null){
	                	 for(BuilderEmployee builderEmployee : salesheadList){
	                	 %>
	                 <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(builderEmployee.getId()); %>"/>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getName()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getMobile()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(builderEmployee.getEmail()); %></h4>
	                    </div>
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                    	<div id="selectprojects">
		                     	<select id="second" data-placeholder="Choose projects"  class="chosen-select" multiple style="width:350px;" tabindex="4">
	         						<%if(projectLists != null){ 
	         							for(ProjectData projectData : projectLists){
	         						%>
	         						<option value="<%out.print(projectData.getId());%>"><%out.print(projectData.getName()); %></option>
	         						<%}} %>
	        					</select>
        					</div>
	                    </div>
	                 </div>
	                 <div class="row">
	                  <h3 class="assign"><span class="assign1">Assign Projects : </span>
	                  <%if(assignProjects != null){
	                	  int i=1;
	                	  for(ProjectData assignProject : assignProjects){
	                		  if(i>1){
	                	  		out.print(" "+assignProject.getName()+" |");
	                	  		i--;
	                		  }else{
	                			  out.print(assignProject.getName()+" |");
	                		  }
 	                	i++;}}  %></h3> 
	                 </div>
	                
	               </div>
	               <%} }}%>
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
$("#second").change(function(){
	var projectId = $(this).val();
	//ajaxindicatorstart("Loading...");
	
	
});

$('#second').multiselect({
    columns: 1,
    placeholder: 'assign projects',
    search: true,
    selectAll: true,
    onControlClose : function(element){getProjectList(element);}
});

function getProjectList(element){
	var ids = "";
	 $("#selectprojects .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	 });
	 if(ids !=""){
		 ajaxindicatorstart("Please wait, while loading...");
		$.post("${baseUrl}/webapi/builder/allot/projects",{project_ids:ids,emp_id : $("#emp_id").val()},function(data){
			var assign = "";
			var a1="";
				if(data.status==1){
					alert(data.message);
					assign = '<span class="assign1">Assign Projects : </span>';
					assign+=data.data.value; 
					$(".assign").empty();
					$(".assign").html(assign);
				}else{
					alert(data.message);
				}
		 		ajaxindicatorstop();
		},'json');
	 }
}
</script>