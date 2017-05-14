<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int building_id = 0;
	int p_user_id = 0;
	List<BuilderFloor> builderFloors = null;
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
	}
	if (request.getParameterMap().containsKey("building_id")) {
		building_id = Integer.parseInt(request.getParameter("building_id"));
		if(building_id > 0) {
			builderFloors = new ProjectDAO().getBuildingFloors(building_id);
		}
	} else {
		builderFloors = new ProjectDAO().getAllFloors();
	}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>
				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/list.jsp">Floor</a></li>
				<li class="active">List</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp"> << Project List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Floor List 
					<a href="${baseUrl}/admin/project/building/floor/new.jsp?building_id=<% out.print(building_id); %>" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Floor</a>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblProjects">
								<thead class="bg-info">
									<tr>
										<th>Building Name</th>
										<th>Building Name</th>
										<th>Project Name</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(BuilderFloor builderFloor :builderFloors) { %>
									<tr>
										<th><% out.print(builderFloor.getName()); %></th>
										<th><% out.print(builderFloor.getBuilderBuilding().getName()); %></th>
										<th><% out.print(builderFloor.getBuilderBuilding().getBuilderProject().getName()); %></th>
										<th><% out.print(builderFloor.getBuilderFloorStatus().getName()); %></th>
										<th>
											<a href="${baseUrl}/admin/project/building/floor/edit.jsp?floor_id=<% out.print(builderFloor.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
											<a href="${baseUrl}/admin/project/building/floor/updates.jsp?floor_id=<% out.print(builderFloor.getId());%>" class="btn btn-warning icon-btn btn-xs"><i class="fa fa-pencil"></i> Updates</a>
											<a href="${baseUrl}/admin/project/building/floor/flat/list.jsp?floor_id=<% out.print(builderFloor.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Flats</a>
										</th>
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
<%@include file="../../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#tblProjects').DataTable({
        "aaSorting": []
    });
});
</script>
</body>
</html>
