<%@page import="org.bluepigeon.admin.dao.BuildingStageDAO"%>
<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="org.bluepigeon.admin.dao.BuildingSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuildingSubstage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int stage_id=0;
int building_stage_size=0;
List<BuildingSubstage> building_substage_list = null;
List<BuildingStage> building_stage_list = null;
int building_substage_size=0; 
if (request.getParameterMap().containsKey("stage_id")) {
	stage_id = Integer.parseInt(request.getParameter("stage_id"));
	
	if (stage_id > 0) {
		building_substage_list = new BuildingSubstagesDAO().getBuildingSubstagesByStageId(stage_id);
		building_substage_size = building_substage_list.size(); 
	}
} else {
	building_substage_list = new BuildingSubstagesDAO().getBuildingSubstageList();
	building_substage_size = building_substage_list.size();
}
building_stage_list = new BuildingStageDAO().getBuildingStageList();
building_stage_size = building_stage_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Building Substages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Substages 
					<a href="#addBuildingSubstage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Building Substage</a>
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
						                <label class="col-sm-6 control-label">Select Building Stage</label>
						                <div class="col-sm-6">
							                <select name="searchbuildingstageId" id="searchbuildingstageId" class="form-control">
							                    <option value="0">Select Building Stage</option>
							                    <% for(int i=0; i < building_stage_size ; i++){ %>
												<option value="<% out.print(building_stage_list.get(i).getId());%>" <% if(stage_id == building_stage_list.get(i).getId()) { %>selected<% } %>><% out.print(building_stage_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				              
                                <table class="table table-striped table-bordered" id="buildingsubstagetable">
                                    <thead>
                                        <tr>
                                        	<th>Building Stage Name</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < building_substage_size; i++){
                                        %>
                                        <tr>
                                        	<td><% out.print(building_substage_list.get(i).getBuildingStage().getName()); %></td>
                                            <td><% out.print(building_substage_list.get(i).getName()); %></td>
                                            <td><% if(building_substage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editBuildingSubstages(<% out.print(building_substage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addBuildingSubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Building Substage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Building Stage</label>
                       		<select name="stage_id" id="stage_id" class="form-control">
								<option value=""> Select Building Stage </option>
								<% for(int i=0; i < building_stage_size ; i++){ %>
								<option value="<% out.print(building_stage_list.get(i).getId());%>"><% out.print(building_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Substage Name</label>
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
             			<button type="submit" class="btn btn-primary" onclick="addBuildingSubstage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editBuildingSubstages" class="modal fade" style="">
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
    $('#buildingsubstagetable').DataTable({
        "aaSorting": []
    });
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
function addBuildingSubstage() {
	$.post("${baseUrl}/webapi/create/building/substage/save/",{ stage_id: $("#stage_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchbuildingstageId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/building-substages.jsp?stage_id="+$("#searchbuildingstageId").val();
});

function editBuildingSubstages(building_substage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editbuildingsubstage.jsp?building_substage_id="+building_substage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editBuildingSubstages").modal('show');
	},'html');
}

function updateBuildingSubstages() {
	
	$.post("${baseUrl}/webapi/create/building/substage/update/",{ id: $("#ubuilding_substage_id").val(), stage_id: $("#ustage_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
</script>