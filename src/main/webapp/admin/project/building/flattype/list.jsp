<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatType"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int project_id = 0;
	int p_user_id = 0;
	List<BuilderFlatType> builderFlatTypes = null;
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
	if (request.getParameterMap().containsKey("project_id")) {
		project_id = Integer.parseInt(request.getParameter("project_id"));
		if(project_id > 0) {
			builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypes(project_id);
		}
	} else {
		builderFlatTypes = new ProjectDAO().getBuilderAllFlatTypes();
	}
	System.out.println("Flat Types: "+builderFlatTypes.size());
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Falt Type</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Type List 
					<a href="${baseUrl}/admin/project/building/flattype/new.jsp?project_id=<% out.print(project_id); %>" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Flat Type</a>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblProjects">
								<thead class="bg-info">
									<tr>
										<th>Flat Type</th>
										<th>Project Name</th>
										<th>Configuration</th>
										<th>Carpet Area</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(BuilderFlatType builderFlatType :builderFlatTypes) { %>
									<tr>
										<th><% out.print(builderFlatType.getName()); %></th>
										<th><% out.print(builderFlatType.getBuilderProject().getName()); %></th>
										<th><% out.print(builderFlatType.getBuilderProjectPropertyConfiguration().getName()); %></th>
										<th><% out.print(builderFlatType.getSuperBuiltupArea()); %></th>
										<th><% if(builderFlatType.getStatus() == 1) { %>Active<% } else { %>Inactive<% } %></th>
										<th>
											<a href="${baseUrl}/admin/project/building/flattype/edit.jsp?flat_type_id=<% out.print(builderFlatType.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
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
