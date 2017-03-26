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
	List<ProjectList> project_list = new ProjectDAO().getBuilderProjects();
	int builder_size = project_list.size();
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getCountryList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Project</a></li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project List 
					<a href="${baseUrl}/admin/project/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" ><i class="fa fa-plus"></i> New Project</a>
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
		                           		<select name="country_id" id="country_id" class="form-control">
						                    <option value="0">Select Country</option>
						                    <% for(Country country : listCountry){ %>
											<option value="<% out.print(country.getId());%>" ><% out.print(country.getName());%></option>
											<% } %>
							             </select>
		                            </div>
		                     	</div>
		                     	<div class="row">
		                            <div class="col-sm-3">
	                          			<select name="state_id" id="state_id" class="form-control">
						                    <option value="0">Select State</option>
							             </select>
	                          		</div>
	                          		<div class="col-sm-3">
	                          			<select name="city_id" id="city_id" class="form-control">
						                    <option value="0">Select City</option>
							             </select>
	                          		</div>
	                          		<div class="col-sm-6">
	                          			<input type="button" name="search" id="search" class="btn btn-primary btn-sm" value="Search" onclick="searchProjects();"/>
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
										<th>Builder</th>
										<th>City</th>
										<th>Locality</th>
										<th>Status</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody class="project_table">
								<% for(ProjectList project : project_list) { %>
									<tr>
										<td>
											<% out.print(project.getName()); %>
										</td>
										<td>
											<% out.print(project.getBuilderName()); %>
										</td>
										<td>
											<% out.print(project.getCityName()); %>
										</td>
										<td>
											<% out.print(project.getLocalityName()); %>
										</td>
										<td>
											<% if(project.getStatus() == 0) { %>
											<span class='label label-warning'>Inactive</span>
											<% } else { %>
											<span class='label label-success'>Active</span>
											<% } %>
										</td>
										<td>
											<a href="${baseUrl}/admin/project/edit.jsp?project_id=<% out.print(project.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
											<a href="${baseUrl}/admin/project/building/list.jsp?project_id=<% out.print(project.getId());%>" class="btn btn-info icon-btn btn-xs"><i class="fa fa-list"></i> Buildings</a>
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
