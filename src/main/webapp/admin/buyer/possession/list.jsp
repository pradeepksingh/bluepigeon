<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	List<PossessionList> agreement_list = new PossessionDAO().getAllAgreement();
	int agreement_size = agreement_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Possession</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Possesssion 
<%-- 					<a href="${baseUrl}/builder/buyer/agreement/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Agreement</a> --%>
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
										<th>Building Name</th>
										<th>Flat No</th>
										<th>Buyer Name</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(PossessionList agreementList : agreement_list) { %>
									<tr>
										<td>
											<% out.print(agreementList.getProjectName()); %> 
										</td>
										<td>
											<% out.print(agreementList.getBuildingName()); %>
 										</td> 
 										<td> 
 											<% out.print(agreementList.getFlatNo()); %> 
										</td>
										<td> 
 											<% out.print(agreementList.getBuyerName()); %> 
										</td>
										<td>
 											<a href="${baseUrl}/admin/buyer/possession/edit.jsp?possession_id=<% out.print(agreementList.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
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
$("#builder_id").change(function(){
	$.get("${baseUrl}/webapi/create/project/list/",{ builder_id: $("#builder_id").val() }, function(data){
		var html = '<option value="">Select Builder Comapny</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#company_id").html(html);
	},'json');
});
$("#country_id").change(function(){
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
		var html = '<option value="">Select State</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#state_id").html(html);
	},'json');
});

$("#state_id").change(function(){
	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
		var html = '<option value="">Select City</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#city_id").html(html);
	},'json');
});
function searchProjects() {
	$.post("${baseUrl}/webapi/project/list",{builder_id: $("#builder_id").val(), company_id: $("#company_id").val(), country_id: $("#country_id").val(), city_id: $("#city_id").val(), state_id: $("#state_id").val(),project_name: $("#project_name").val()},function(data){
		var oTable = $("#tblProjects").dataTable();
	    oTable.fnClearTable();
	    $(data).each(function(index){
		    var vieworder = '<a href="${baseUrl}/admin/project/edit.jsp?project_id='+data[index].id+'" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>';
		    var status = '';
		    if(data[index].status == 1) {
		    	status = '<span class="label label-success">Active</span>';
		    } else {
		    	status = '<span class="label label-warning">Inactive</span>';
		    }
	    	var row = [];
	    	row.push(data[index].name);
	    	row.push(data[index].builderName);
	    	row.push(data[index].cityName);
		    row.push(data[index].localityName);
	    	row.push(status);
	    	row.push(vieworder);
	    	oTable.fnAddData(row);
	    });
	},'json');
}
</script>
</body>
</html>
