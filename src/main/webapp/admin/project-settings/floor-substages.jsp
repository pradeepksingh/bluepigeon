<%@page import="org.bluepigeon.admin.dao.FloorStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.FloorSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.FloorStage"%>
<%@page import="org.bluepigeon.admin.model.FloorSubstage"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int stage_id=0;
int floor_stage_size=0;
List<FloorSubstage> floor_substage_list = null;//old name state_list
List<FloorStage> floor_stage_list = null;
int floor_substage_size=0; //old name state_size
if (request.getParameterMap().containsKey("stage_id")) {
	stage_id = Integer.parseInt(request.getParameter("stage_id"));
	
	if (stage_id > 0) {
		floor_substage_list = new FloorSubstagesDAO().getFloorSubstagesByStageId(stage_id);
		floor_substage_size = floor_substage_list.size(); 
	}
} else {
	floor_substage_list = new FloorSubstagesDAO().getFloorSubstageList();
	floor_substage_size = floor_substage_list.size();
}
floor_stage_list = new FloorStageDAO().getFloorStageList();
floor_stage_size = floor_stage_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Floor Substages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Floor Substages 
					<a href="#addFloorSubstage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Floor Substage</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
<!--                             	<div class="col-sm-6"> -->
<!-- 		                            <div class="form-group"> -->
<!-- 						                <label class="col-sm-6 control-label">Select Project Stage</label> -->
<!-- 						                <div class="col-sm-6"> -->
<!-- 							                <select name="searchfloorstageId" id="searchfloorstageId" class="form-control"> -->
<!-- 							                    <option value="0">Select Floor Stage</option> -->
<%-- 							                    <% for(int i=0; i < floor_stage_size ; i++){ %> --%>
<%-- 												<option value="<% out.print(floor_stage_list.get(i).getId());%>" <% if(stage_id == floor_stage_list.get(i).getId()) { %>selected<% } %>><% out.print(floor_stage_list.get(i).getName());%></option> --%>
<%-- 												<% } %> --%>
<!-- 							                </select> -->
<!-- 						                </div> -->
<!-- 					                </div> -->
<!-- 				                </div> -->
				              
                                <table class="table table-striped table-bordered" id="floorsubstagetable">
                                    <thead>
                                        <tr>
                                        	<th>Floor Stage Name</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < floor_substage_size; i++){
                                        %>
                                        <tr>
                                        	<td><% out.print(floor_substage_list.get(i).getFloorStage().getName()); %></td>
                                            <td><% out.print(floor_substage_list.get(i).getName()); %></td>
                                            <td><% if(floor_substage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editFloorSubstages(<% out.print(floor_substage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addFloorSubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Floor Substage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Stage</label>
                       		<select name="stage_id" id="stage_id" class="form-control">
								<option value=""> Select Floor Stage </option>
								<% for(int i=0; i < floor_stage_size ; i++){ %>
								<option value="<% out.print(floor_stage_list.get(i).getId());%>"><% out.print(floor_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Substage Name</label>
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
             			<button type="submit" class="btn btn-primary" onclick="addFloorSubstage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editFloorSubstages" class="modal fade" style="">
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
    $('#floorsubstagetable').DataTable({
        "aaSorting": []
    });
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
function addFloorSubstage() {
	$.post("${baseUrl}/webapi/create/floor/substage/save/",{ stage_id: $("#stage_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchfloorstageId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/floor-substages.jsp?stage_id="+$("#searchfloorstageId").val();
});

function editFloorSubstages(floor_substage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editfloorsubstage.jsp?floor_substage_id="+floor_substage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editFloorSubstages").modal('show');
	},'html');
}

function updateFloorSubstages() {
	
	$.post("${baseUrl}/webapi/create/floor/substage/update/",{ id: $("#ufloor_substage_id").val(), stage_id: $("#ustage_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
</script>