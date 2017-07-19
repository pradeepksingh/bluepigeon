<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
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
	List<Buyer> buyer_list = new BuyerDAO().getPrimaryBuyerList();
	int buyer_size = buyer_list.size();
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Buyer</li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Buyer List 
<%-- 					<a href="${baseUrl}/admin/buyer/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Buyer</a> --%>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblBuyer">
								<thead class="bg-info">
									<tr>
										<th>Project Name</th>
										<th>Buyer</th>
										<th>Phone</th>
										<th>Email</th>
										<th>Property Bought</th>
										<th>Agreement</th>
										<th>Possession</th>
<!-- 										<th>Status</th> -->
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(Buyer buyer : buyer_list) { %>
									<tr>
										<td>
											<%	out.print(buyer.getBuilderProject().getName());	%>
										</td>
										<td>
											<% out.print(buyer.getName()); %>
										</td>
										<td>
											<% out.print(buyer.getMobile()); %>
										</td>
										<td>
											<% out.print(buyer.getEmail()); %>
										</td>
										<td>
											<% out.print(buyer.getBuilderBuilding().getName()+" "+buyer.getBuilderFlat().getFlatNo()); %>
										</td>
										<td>
											<% if(buyer.getAgreement() == 0) { %>
											<span class='label label-warning'>No</span>
											<% } else { %>
											<span class='label label-success'>Yes</span>
											<% } %>
										</td>
										<td>
											<% if(buyer.getPossession() == 0) { %>
											<span class='label label-warning'>No</span>
											<% } else { %>
											<span class='label label-success'>Yes</span>
											<% } %>
										</td>
<!-- 										<td> -->
<%-- 											<% if(buyer.getStatus() == 0) { %> --%>
<!-- 											<span class='label label-warning'>Inactive</span> -->
<%-- 											<% } else { %> --%>
<!-- 											<span class='label label-success'>Active</span> -->
<%-- 											<% } %> --%>
<!-- 										</td> -->
										<td>
											<a href="${baseUrl}/admin/buyer/edit.jsp?flat_id=<% out.print(buyer.getBuilderFlat().getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
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
</body>
</html>
<script>
$(document).ready(function(){
    $('#tblBuyer').DataTable({
        "aaSorting": []
    });
});
</script>