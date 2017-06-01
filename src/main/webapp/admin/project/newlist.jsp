<%@page import="org.bluepigeon.admin.data.NewProjectList"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	List<NewProjectList> project_list = new ProjectDAO().getNewProjectList();
	
	
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>New Project</li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					New Project List 
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblNewProjects">
								<thead class="bg-info">
									<tr>
										<th>Project Name</th>
										<th>Area</th>
										<th>Builder Name</th>
										<th>Email</th>
										<th>Contact Number</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(NewProjectList project : project_list) { %>
									<tr>
										<td>
											<% out.print(project.getProjectName()); %>
										</td>
										<td><%out.print(project.getLocalityName()); %></td>
										<td>
											<% out.print(project.getBuilderName()); %>
										</td>
										<td>
											<% out.print(project.getEmail()); %>
										</td>
										<td>
											<% out.print(project.getContactNumber()); %>
										</td>
									</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
<!-- inline scripts related to this page -->
<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#tblNewProjects').DataTable({
        "aaSorting": []
    });
});
</script>
</body>
</html>
