<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="java.util.List"%>
<%@include file="../../../../../head.jsp"%>
<%@include file="../../../../../leftnav.jsp"%>
<%
	int floor_id = 0;
	int p_user_id = 0;
	List<BuilderFlat> builderFlats = null;
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
	if (request.getParameterMap().containsKey("floor_id")) {
		floor_id = Integer.parseInt(request.getParameter("floor_id"));
		if(floor_id > 0) {
			builderFlats = new ProjectDAO().getBuilderFloorFlats(floor_id);
		}
	} else {
		builderFlats = new ProjectDAO().getBuilderAllFlats();
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
				<li><a href="${baseUrl}/admin/project/building/floor/flat/list.jsp">Flat</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat List 
					<a href="${baseUrl}/admin/project/building/floor/flat/new.jsp?floor_id=<% out.print(floor_id); %>" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Flat</a>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblProjects">
								<thead class="bg-info">
									<tr>
										<th>Flat No</th>
										<th>Floor No</th>
										<th>Building Name</th>
										<th>Project Name</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(BuilderFlat builderFlat :builderFlats) { %>
									<tr>
										<th><% out.print(builderFlat.getFlatNo()); %></th>
										<th><% out.print(builderFlat.getBuilderFloor().getName()); %></th>
										<th><% out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getName()); %></th>
										<th><% out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName()); %></th>
										<th><% out.print(builderFlat.getBuilderFlatStatus().getName()); %></th>
										<th>
											<a href="${baseUrl}/admin/project/building/floor/flat/edit.jsp?flat_id=<% out.print(builderFlat.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
											<a href="${baseUrl}/admin/project/building/floor/flat/updates.jsp?flat_id=<% out.print(builderFlat.getId());%>" class="btn btn-warning icon-btn btn-xs"><i class="fa fa-pencil"></i> Updates</a>
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
<%@include file="../../../../../footer.jsp"%>
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
