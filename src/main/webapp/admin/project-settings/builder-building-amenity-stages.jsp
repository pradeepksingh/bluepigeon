
<%@page import="org.bluepigeon.admin.data.StateData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenityStages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityStagesDAO"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int amenity_id=0;
int amenity_size=0;
List<BuilderBuildingAmenityStages> amenity_stage_list = null;//old name state_list
List<BuilderBuildingAmenity> amenity_list = null;
int amenity_stage_size=0; //old name state_size
if (request.getParameterMap().containsKey("amenity_id")) {
	amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	
	if (amenity_id > 0) {
		amenity_stage_list = new BuilderBuildingAmenityStagesDAO().getStateByAmenityId(amenity_id);
		amenity_stage_size = amenity_stage_list.size(); 
	}
} else {
	amenity_stage_list = new BuilderBuildingAmenityStagesDAO().getBuilderBuildingAmenityStagesList();
	amenity_stage_size = amenity_stage_list.size();
}
amenity_list = new BuilderBuildingAmenityDAO().getBuilderBuildingAmenityList();
amenity_size = amenity_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Project Settings</a></li>
				<li class="active">Building Amenity Stages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Amenity Stages 
					<a href="#addBuildingAmenityStage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Building Amenity Stage</a>
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
						                <label class="col-sm-6 control-label">Select Building Amenity</label>
						                <div class="col-sm-6">
							                <select name="searchamenityId" id="searchamenityId" class="form-control">
							                    <option value="0">Select Building Amenity</option>
							                    <% for(int i=0; i < amenity_size ; i++){ %>
												<option value="<% out.print(amenity_list.get(i).getId());%>" <% if(amenity_id == amenity_list.get(i).getId()) { %>selected<% } %>><% out.print(amenity_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				              
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
                                        	<td><% out.print(amenity_stage_list.get(i).getBuilderBuildingAmenity().getName()); %></td>
                                            <td><% out.print(amenity_stage_list.get(i).getName()); %></td>
                                            <td><% if(amenity_stage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editBuildingAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addBuildingAmenityStage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Building Amenity Stage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Building Amenity</label>
                       		<select name="amenity_id" id="amenity_id" class="form-control">
								<option value=""> Select Building Amenity </option>
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
                       		<label for="password" class="control-label">Building Amenity Stage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter Building amenity stage Name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addBuildingAmenityStage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editBuildingAmenityStages" class="modal fade" style="">
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
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#statetable').DataTable({
        "aaSorting": []
    });
});
function addBuildingAmenityStage() {
	$.post("${baseUrl}/webapi/create/builder/building/amenity/stages/save/",{ amenity_id: $("#amenity_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchamenityId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/builder-building-amenity-stages.jsp?amenity_id="+$("#searchamenityId").val();
});

function editBuildingAmenityStages(amenity_stage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editbuildingamenitystage.jsp?amenity_stage_id="+amenity_stage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editBuildingAmenityStages").modal('show');
	},'html');
}

function updateBuildingAmenityStages() {
	
	$.post("${baseUrl}/webapi/create/builder/building/amenity/stages/update/",{ id: $("#uamenity_stage_id").val(), amenity_id: $("#uamenity_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function deleteBuildingAmenityStages(amenity_stage_id){
	var yes = confirm("Do you want to delete ?");
	if(yes==true){
		$.ajax({
			url: "${baseUrl}/webapi/create/builder/building/amenity/stages/delete",
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