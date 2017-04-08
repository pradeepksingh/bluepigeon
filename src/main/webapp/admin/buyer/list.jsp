<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.data.BuyerList"%>
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
	List<BuyerList> buyer_list = new BuyerDAO().getBuyerList();
	int buyer_size = buyer_list.size();
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Buyer</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Buyer List 
					<a href="${baseUrl}/admin/buyer/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Buyer</a>
				</h1>
			</div>
			<div class="">
				<div class="panel panel-default" style="padding: 5px;">
				  	<div>
	              		<div class="panel panel-default">
		                   	<div class="panel-body">
	                            <div class="row" style="padding-bottom:10px;">
		                            <div class="col-sm-3">
		                            	<select id="builder_id" name="builder_id" class="form-control">
											<option value="0">Select Builder Group</option>
											<% for (Builder builder : builders) { %>
											<option value="<%out.print(builder.getId());%>"> <% out.print(builder.getName()); %> </option>
											<% } %>
										</select>
		                            </div>
		                            <div class="col-sm-3">
		                            	<select id="company_id" name="company_id" class="form-control">
											<option value="0">Select Builder Company</option>
										</select>
		                            </div>
		                            <div class="col-sm-3">
		                            	<input type="text" id="project_name" name="project_name" class="form-control" placeholder="Project Name"/>
		                            </div>
		                            <div class="col-sm-3">
	                          			<input type="button" name="search" id="search" class="btn btn-primary btn-sm" value="Search" onclick="searchBuyers();"/>
	                          		</div>
		                     	</div>
		                   	</div>
		               	</div>
		            </div>
	               	<div class="panel-body">
	                	<div class="dataTable_wrapper" style="overflow:auto;">
	                       	<table class="table table-striped table-bordered table-hover" id="tblProjects">
								<thead class="bg-info">
									<tr>
										<th>Project Name</th>
										<th>Buyer</th>
										<th>Phone</th>
										<th>Email</th>
										<th>Property Bought</th>
										<th>Agreement</th>
										<th>Possession</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(BuyerList buyer : buyer_list) { %>
									<tr>
										<td>
											<%	out.print(buyer.getProjectName());	%>
										</td>
										<td>
											<% out.print(buyer.getName()); %>
										</td>
										<td>
											<% out.print(buyer.getPhone()); %>
										</td>
										<td>
											<% out.print(buyer.getEmail()); %>
										</td>
										<td>
											<% out.print(buyer.getBuildingName()+" "+buyer.getFlatNumber()); %>
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
										<td>
											<% if(buyer.getStatus() == 0) { %>
											<span class='label label-warning'>Inactive</span>
											<% } else { %>
											<span class='label label-success'>Active</span>
											<% } %>
										</td>
										<td>
											<a href="${baseUrl}/admin/buyer/edit.jsp?buyer_id=<% out.print(buyer.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
<%-- 											<a href="${baseUrl}/admin/project/building/list.jsp?project_id=<% out.print(project.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Buildings</a> --%>
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
    $('#tblProjects').DataTable({
        "aaSorting": []
    });
});
$("#builder_id").change(function(){
	$.get("${baseUrl}/webapi/create/project/list/",{ builder_id: $("#builder_id").val() }, function(data){
		var html = '<option value="">Select Builder Company</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#company_id").html(html);
	},'json');
});

function searchBuyers() {
	$.post("${baseUrl}/webapi/buyer/list",{company_id: $("#company_id").val(), project_name: $("#project_name").val()},function(data){
		var oTable = $("#tblProjects").dataTable();
	    oTable.fnClearTable();
	    $(data).each(function(index){
		    var vieworder = '<a href="${baseUrl}/admin/buyer/edit.jsp?buyer_id='+data[index].id+'" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>';
		    var status = '';
		    var agreement = '';
		    var possession = '';
		    if(data[index].status == 1) {
		    	status = '<span class="label label-success">Active</span>';
		    } else {
		    	status = '<span class="label label-warning">Inactive</span>';
		    }
		    if(data[index].agreement == 1) {
		    	agreement = '<span class="label label-success">Yes</span>';
		    } else {
		    	agreement = '<span class="label label-warning">No</span>';
		    }
		    if(data[index].possession == 1) {
		    	possession = '<span class="label label-success">Yes</span>';
		    } else {
		    	possession = '<span class="label label-warning">No</span>';
		    }
	    	var row = [];
	    	
	    	row.push(data[index].projectName);
	    	row.push(data[index].name);
	    	row.push(data[index].phone);
		    row.push(data[index].email);
		    row.push(data[index].buildingName+' '+data[index].flatNumber);
		    row.push(agreement);
		    row.push(possession);
		    row.push(status);
	    	row.push(vieworder);
	    	oTable.fnAddData(row);
	    });
	    
	},'json');
}
</script>
</body>
</html>
