
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenitySubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenityStages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityStagesDAO"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int stage_id=0;
int substage_size =0;
int amenity_size = 0;
int stage_size = 0;
int amenity_id = 0;
List<BuilderFloorAmenitySubstages> substage_list = null;
List<BuilderFloorAmenityStages> stage_list = null;
List<BuilderFloorAmenity> country_list = null;
BuilderFloorAmenityDAO countryService = new BuilderFloorAmenityDAO();
List<BuilderFloorAmenity> listCountry = countryService.getBuilderFloorAmenityList();
BuilderFloorAmenityStagesDAO stageList = new BuilderFloorAmenityStagesDAO();
amenity_size = listCountry.size(); 
if (request.getParameterMap().containsKey("stage_id")) {
  stage_id = Integer.parseInt(request.getParameter("stage_id"));
  System.out.println("Stage id :: "+stage_id);
  substage_list = new BuilderFloorAmenitySubstagesDAO().getBuilderFloorAmenitySubstagesByStageId(stage_id);
  substage_size = substage_list.size(); 
  if(substage_size > 0) {
	  amenity_id = substage_list.get(0).getBuilderFloorAmenityStages().getBuilderFloorAmenity().getId();
	  stage_list = stageList.getStateByAmenityId(amenity_id);
	  stage_size = stage_list.size();
  }
} else {
	substage_list = new BuilderFloorAmenitySubstagesDAO().getBuilderFloorAmenitySubstagesList();
	substage_size = substage_list.size(); 
}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Project Settings</a></li>
				<li class="active">Floor Amenity Substages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Floor Amenity Substages 
					<a href="#addFloorAmenitySubstages" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Floor Amenity Substage</a>
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
						                <label class="col-sm-6 control-label">Select Floor Amenity</label>
						                <div class="col-sm-6">
							                <select name="searchamenityId" id="searchamenityId" class="form-control">
							                    <option value="">Select Floor Amenity</option>
							                    <% for(int i=0; i < amenity_size ; i++){ %>
												<option value="<% out.print(listCountry.get(i).getId());%>" <% if(amenity_id == listCountry.get(i).getId()) { %>selected<% } %>><% out.print(listCountry.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				                <div class="col-sm-6">
		                            <div class="form-group">
						                <label class="col-sm-6 control-label">Select Floor Amenity Stages</label>
						                <div class="col-sm-6">
							                <select name="searchstageId" id="searchstageId" class="form-control">
							                    <option value="0">Select Floor Amenity Stage</option>
							                    <% for(int i=0; i < stage_size ; i++){ %>
												<option value="<% out.print(stage_list.get(i).getId());%>" <% if(stage_id == stage_list.get(i).getId()) { %>selected<% } %>><% out.print(stage_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
                                <table class="table table-striped table-bordered" id="flooramenitysubstagetable">
                                    <thead>
                                        <tr>
                                        	<th>Amenity Name</th>
                                        	<th>Amenity Stage Name</th>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < substage_size; i++){
                                        %>
                                        <tr>
                                        	<td><% out.print(substage_list.get(i).getBuilderFloorAmenityStages().getBuilderFloorAmenity().getName()); %></td>
                                        	<td><%out.print(substage_list.get(i).getBuilderFloorAmenityStages().getName()); %></td>
                                            <td><% out.print(substage_list.get(i).getName()); %></td>
                                            <td><% if(substage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editFloorAmenitySubstage(<% out.print(substage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteFloorAmenitySubstage(<% out.print(substage_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addFloorAmenitySubstages" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Floor Amenity substage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Amenity</label>
                       		<select name="amenity_id" id="amenity_id" class="form-control">
								<option value=""> Select Floor Amenity </option>
								<% for(int i=0; i < amenity_size ; i++){ %>
								<option value="<% out.print(listCountry.get(i).getId());%>"><% out.print(listCountry.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Amenity Stage</label>
                       		<select name="stage_id" id="stage_id" class="form-control">
								<option value=""> Select Floor Amenity Stage </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Amenity substage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter Floor Amenity substage Name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addFloorAmenitySubstage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editFloorAmenitySubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Floor Amenity Substage</h4>
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
    $('#flooramenitysubstagetable').DataTable({
        "aaSorting": []
    });
});
function addFloorAmenitySubstage() {
	$.post("${baseUrl}/webapi/create/builder/floor/amenity/substages/save",{ stage_id: $("#stage_id").val(), name: $("#name").val(), status: $("#status").val(), sortorder: 1}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
$("#amenity_id").change(function(){
	$.get("${baseUrl}/webapi/create/builder/floor/amenity/stages/list",{ amenity_id: $("#amenity_id").val() }, function(data){
		var html = '<option value="">Select Floor Amenity Stage</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#stage_id").html(html);
	},'json');
});

$("#searchamenityId").change(function(){
	$.get("${baseUrl}/webapi/create/builder/floor/amenity/stages/list",{ amenity_id: $("#searchamenityId").val() }, function(data){
		var html = '<option value="">Select Floor Amenity Stage</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#searchstageId").html(html);
	},'json');
});

$("#searchstageId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/builder-floor-amenity-substages.jsp?stage_id="+$("#searchstageId").val();
});

function editFloorAmenitySubstage(substageid) {

	$.get("${baseUrl}/admin/project-settings/editbuilderflooramenitysubstages.jsp?substage_id="+substageid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editFloorAmenitySubstage").modal('show');
	},'html');
}

function updateFloorAmenitySubstage() {
	$.post("${baseUrl}/webapi/create/builder/floor/amenity/substages/update/",{ id: $("#usubstage_id").val(), stage_id: $("#ustage_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function deleteFloorAmenitySubstage(substage_id){
	var yes = confirm("Do you want to delete ?");
	if(yes==true){
		$.ajax({
			url: "${baseUrl}/webapi/create/builder/floor/amenity/substages/delete",
			data:{substage_id:substage_id},
			type:'delete',
			success:function(data){
				alert(data.message);
				window.location.reload();
			}
		});
	}
}

</script>