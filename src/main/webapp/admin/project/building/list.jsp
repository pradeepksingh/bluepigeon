<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="java.util.List"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	int project_id = 0;
	int p_user_id = 0;
	project_id = Integer.parseInt(request.getParameter("project_id"));
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
	List<BuilderBuilding> builderBuildings = new ProjectDAO().getBuilderProjectBuildings(project_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Building</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building List 
					<a href="${baseUrl}/admin/project/building/new.jsp?project_id=<% out.print(project_id); %>" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Building</a>
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
										<th>Project Name</th>
										<th>Builder</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(BuilderBuilding builderBuilding :builderBuildings) { %>
									<tr>
										<th><% out.print(builderBuilding.getName()); %></th>
										<th><% out.print(builderBuilding.getBuilderProject().getName()); %></th>
										<th><% out.print(builderBuilding.getBuilderProject().getBuilder().getName()); %></th>
										<th><% out.print(builderBuilding.getBuilderBuildingStatus().getName()); %></th>
										<th>
											<a href="${baseUrl}/admin/project/building/edit.jsp?building_id=<% out.print(builderBuilding.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
											<a href="${baseUrl}/admin/project/building/floor/list.jsp?building_id=<% out.print(builderBuilding.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Floors</a>
											<a href="${baseUrl}/admin/project/building/flattype/list.jsp?building_id=<% out.print(builderBuilding.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Flat Types</a>
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
<%@include file="../../../footer.jsp"%>
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
