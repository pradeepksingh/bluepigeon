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
	List<DemandLetters> demand_letter_list = new DemandLettersDAO().getAllDemandLetters();
	int demand_letter_size = demand_letter_list.size();
	List<BuilderProject> builderProjects = new ProjectDetailsDAO().getBuilderProjectList();
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Demand Letter</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Demand Letter List 
					<a href="${baseUrl}/builder/buyer/demandletter/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Demand Letter</a>
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
		                   	</div>
		               	</div>
	              	</div>
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
								<% for(DemandLetters demandLetters : demand_letter_list) { %>
									<tr>
										<td>
											<% 
  												int project_id = demandLetters.getBuilderProject().getId(); 
  												BuilderProject builderProject = new BuilderProject(); 
  												builderProject.setId(project_id);  
 												out.print(builderProject.getName()); %> 
										</td>
										<td>
											<% 
  												int buildingId = demandLetters.getBuilderBuilding().getId(); 
 											    BuilderBuilding builderBuilding = new BuilderBuilding();
 											    builderBuilding.setId(buildingId) ; 
 												out.print(builderBuilding.getName()); %>
 										</td> 
 										<td> 
 											<%  
 												int flatId = demandLetters.getBuilderFlat().getId(); 
 											    BuilderFlat builderFlat = new BuilderFlat(); 
											    builderFlat.setId(flatId); 
 												out.print(builderFlat.getFlatNo()); %> 
 										</td> 
 										<td> 
 											<%  
												int buyerId = demandLetters.getBuyer().getId(); 
 											    Buyer buyer = new Buyer(); 
											    buyer.setId(buyerId);
												out.print(buyer.getName()); %> 
										</td>
										<td>
<%--  											<a href="${baseUrl}/admin/project/edit.jsp?project_id=<% out.print(project.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a> --%>
<%--  											<a href="${baseUrl}/admin/project/building/list.jsp?project_id=<% out.print(project.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Buildings</a>  --%>
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
		var html = '<option value="">Select Builder Comapny</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#company_id").html(html);
	},'json');
});
$("#country_id").change(function(){
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
		var html = '<option value="">Select State</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#state_id").html(html);
	},'json');
});

$("#state_id").change(function(){
	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
		var html = '<option value="">Select City</optio>';
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
