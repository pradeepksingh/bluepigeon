<%@page import="org.bluepigeon.admin.dao.ProjectStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.ProjectStage"%>
<%@page import="org.bluepigeon.admin.model.ProjectSubstage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int stage_id=0;
int project_stage_size=0;
List<ProjectSubstage> project_substage_list = null;//old name state_list
List<ProjectStage> project_stage_list = null;
int project_substage_size=0; //old name state_size
if (request.getParameterMap().containsKey("stage_id")) {
	stage_id = Integer.parseInt(request.getParameter("stage_id"));
	
	if (stage_id > 0) {
		project_substage_list = new ProjectSubstagesDAO().getProjectSubstageById(stage_id);
		project_substage_size = project_substage_list.size(); 
	}
} else {
	project_substage_list = new ProjectSubstagesDAO().getprojectSubstageList();
	project_substage_size = project_substage_list.size();
}
project_stage_list = new ProjectStageDAO().getProjectStageList();
project_stage_size = project_stage_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Project Substages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Substages 
					<a href="#addProjectSubstage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Project Substage</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                            	<div class="col-sm-6">
		                            <div class="form-group">
						                <label class="col-sm-6 control-label">Select Project Stage</label>
						                <div class="col-sm-6">
							                <select name="searchprojectstageId" id="searchprojectstageId" class="form-control">
							                    <option value="0">Select Project Stage</option>
							                    <% for(int i=0; i < project_stage_size ; i++){ %>
												<option value="<% out.print(project_stage_list.get(i).getId());%>" <% if(stage_id == project_stage_list.get(i).getId()) { %>selected<% } %>><% out.print(project_stage_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				              
                                <table class="table table-striped table-bordered" id="projectsubstagetable">
                                    <thead>
                                        <tr>
                                        	<th>Project Stage Name</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < project_substage_size; i++){
                                        %>
                                        <tr>
                                        	<td><% out.print(project_substage_list.get(i).getProjectStage().getName()); %></td>
                                            <td><% out.print(project_substage_list.get(i).getName()); %></td>
                                            <td><% if(project_substage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editProjectSubstages(<% out.print(project_substage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteBuildingAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
               </form>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="addProjectSubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Project Substage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Project Stage</label>
                       		<select name="stage_id" id="stage_id" class="form-control">
								<option value=""> Select Project Stage </option>
								<% for(int i=0; i < project_stage_size ; i++){ %>
								<option value="<% out.print(project_stage_list.get(i).getId());%>"><% out.print(project_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Substage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter project substage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="status" class="form-control">
								<option value="1"> Active </option>
								<option value="0"> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="addProjectSubstage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editProjectSubstages" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;" id="modalarea">
          	</div>
      	</div>
  	</div>
</div>
<%@include file="../../footer.jsp"%>
	</body>
</html>
<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#projectsubstagetable').DataTable({
        "aaSorting": []
    });
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
function addProjectSubstage() {
	$.post("${baseUrl}/webapi/create/project/substage/save/",{ stage_id: $("#stage_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchprojectstageId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/project-substages.jsp?stage_id="+$("#searchprojectstageId").val();
});

function editProjectSubstages(project_substage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editprojectsubstage.jsp?project_substage_id="+project_substage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editProjectSubstages").modal('show');
	},'html');
}

function updateProjectSubstages() {
	
	$.post("${baseUrl}/webapi/create/project/substage/update/",{ id: $("#uproject_substage_id").val(), stage_id: $("#ustage_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
</script>