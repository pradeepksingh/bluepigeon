
<%@page import="org.bluepigeon.admin.data.StateData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenityStages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityStagesDAO"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int amenity_id=0;
int amenity_size=0;
List<BuilderFlatAmenityStages> amenity_stage_list = null;//old name state_list
List<BuilderFlatAmenity> amenity_list = null;
int amenity_stage_size=0; //old name state_size
if (request.getParameterMap().containsKey("amenity_id")) {
	amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	
	if (amenity_id > 0) {
		amenity_stage_list = new BuilderFlatAmenityStagesDAO().getFlatAmenityStagesByAmenityId(amenity_id);
		amenity_stage_size = amenity_stage_list.size(); 
	}
} else {
	amenity_stage_list = new BuilderFlatAmenityStagesDAO().getBuilderFlatAmenityStagesList();
	amenity_stage_size = amenity_stage_list.size();
}

amenity_list = new BuilderFlatAmenityDAO().getBuilderFlatAmenityList();
amenity_size = amenity_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Flat Amenity Stages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Amenity Stages 
					<a href="#addFlatAmenityStage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Flat Amenity Stage</a>
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
<!-- 						                <label class="col-sm-6 control-label">Select Flat Amenity</label> -->
<!-- 						                <div class="col-sm-6"> -->
<!-- 							                <select name="searchamenityId" id="searchamenityId" class="form-control"> -->
<!-- 							                    <option value="0">Select Flat Amenity</option> -->
<%-- 							                    <% for(int i=0; i < amenity_size ; i++){ %> --%>
<%-- 												<option value="<% out.print(amenity_list.get(i).getId());%>" <% if(amenity_id == amenity_list.get(i).getId()) { %>selected<% } %>><% out.print(amenity_list.get(i).getName());%></option> --%>
<%-- 												<% } %> --%>
<!-- 							                </select> -->
<!-- 						                </div> -->
<!-- 					                </div> -->
<!-- 				                </div> -->
				              
                                <table class="table table-striped table-bordered" id="statetable">
                                    <thead>
                                        <tr>
                                        	<th>Amenity Name</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < amenity_stage_size; i++){
                                        %>
                                        <tr>
                                        	<td><% out.print(amenity_stage_list.get(i).getBuilderFlatAmenity().getName()); %></td>
                                            <td><% out.print(amenity_stage_list.get(i).getName()); %></td>
                                            <td><% if(amenity_stage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editFlatAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteFlatAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addFlatAmenityStage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Flat Amenity Stage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Flat Amenity</label>
                       		<select name="amenity_id" id="amenity_id" class="form-control">
								<option value=""> Select Flat Amenity </option>
								<% for(int i=0; i < amenity_size ; i++){ %>
								<option value="<% out.print(amenity_list.get(i).getId());%>"><% out.print(amenity_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Flat Amenity Stage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter Flat amenity stage Name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addFlatAmenityStage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editFlatAmenityStages" class="modal fade" style="">
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
    $('#statetable').DataTable({
        "aaSorting": []
    });
});
function addFlatAmenityStage() {
	$.post("${baseUrl}/webapi/create/builder/flat/amenity/stages/save/",{ amenity_id: $("#amenity_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchamenityId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/builder-flat-amenity-stages.jsp?amenity_id="+$("#searchamenityId").val();
});

$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});


function editFlatAmenityStages(amenity_stage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editflatamenitystage.jsp?amenity_stage_id="+amenity_stage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editFlatAmenityStages").modal('show');
	},'html');
}

function updateFlatAmenityStages() {
	
	$.post("${baseUrl}/webapi/create/builder/flat/amenity/stages/update/",{ id: $("#uamenity_stage_id").val(), amenity_id: $("#uamenity_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function deleteFlatAmenityStages(amenity_stage_id){
	var yes = confirm("Do you want to delete ?");
	if(yes==true){
		$.ajax({
			url: "${baseUrl}/webapi/create/builder/flat/amenity/stages/delete",
			data:{amenity_stage_id:amenity_stage_id},
			type:'delete',
			success:function(data){
				alert(data.message);
				window.location.reload();
			}
		});
	}
}

</script>