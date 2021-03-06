<%@page import="org.bluepigeon.admin.dao.BuyerProjectUpdateDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectUpdateList"%>
<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.bluepigeon.admin.dao.AgreementDAO"%>
<%@page import="org.bluepigeon.admin.data.AgreementList"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.DemandLettersDAO"%>
<%@page import="org.bluepigeon.admin.model.DemandLetters"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	List<ProjectUpdateList> agreement_list = new BuyerProjectUpdateDAO().getAllProjectUpdate();
	int agreement_size = agreement_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Project Update</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Update 
					<a href="${baseUrl}/admin/buyer/update-buyers/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Project Update</a>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblProjects">
								<thead class="bg-info">
									<tr>
										<th>Project Name</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(ProjectUpdateList agreementList : agreement_list) { %>
									<tr>
										<td>
											<% out.print(agreementList.getProjectName()); %> 
										</td>
										<td>
											<% out.print(agreementList.getStatus()); %>
 										</td> 
										<td>
<%--  											<a href="${baseUrl}/admin/buyer/possession/edit.jsp?possession_id=<% out.print(agreementList.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a> --%>
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
