<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenityStages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityStagesDAO"%>
<%@page import="java.util.List"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
int amenity_id=0;
int amenity_size=0;
List<BuilderFloorAmenityStages> amenity_stage_list = null;
List<BuilderFloorAmenity> amenity_list = null;
int amenity_stage_size=0; 
if (request.getParameterMap().containsKey("amenity_id")) {
	amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	
	if (amenity_id > 0) {
		amenity_stage_list = new BuilderFloorAmenityStagesDAO().getStateByAmenityId(amenity_id);
		amenity_stage_size = amenity_stage_list.size(); 
	}
}

amenity_list = new BuilderFloorAmenityDAO().getBuilderFloorAmenityList();
amenity_size = amenity_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Create Projects</a></li>
				<li class="active">Floor Amenity Stages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Floor Amenity Stages 
					<a href="#addFloorAmenityStage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Floor Amenity Stage</a>
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
							                    <option value="0">Select Floor Amenity</option>
							                    <% for(int i=0; i < amenity_size ; i++){ %>
												<option value="<% out.print(amenity_list.get(i).getId());%>" <% if(amenity_id == amenity_list.get(i).getId()) { %>selected<% } %>><% out.print(amenity_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				              
                                <table class="table table-striped table-bordered" id="flooramenitystagetable">
                                    <thead>
                                        <tr>
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
                                            <td><% out.print(amenity_stage_list.get(i).getName()); %></td>
                                            <td><% if(amenity_stage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editFloorAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteFloorAmenityStages(<% out.print(amenity_stage_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addFloorAmenityStage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color:#fff">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Floor Amenity Stage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Amenity</label>
                       		<select name="amenity_id" id="amenity_id" class="form-control">
								<option value=""> Select Floor Amenity </option>
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
                       		<label for="password" class="control-label">Project Floor Stage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter Project amenity stage Name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addFloorAmenityStage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editFloorAmenityStages" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color:#fff">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;" id="modalarea">
          	</div>
      	</div>
  	</div>
</div>
<%@include file="../footer.jsp"%>
	</body>
</html>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#flooramenitystagetable').DataTable({
        "aaSorting": []
    });
});
function addFloorAmenityStage() {
	$.post("${baseUrl}/webapi/create/builder/floor/amenity/stages/save/",{ amenity_id: $("#amenity_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchamenityId").change(function(){
	window.location.href = "${baseUrl}/createprojects/builder-floor-amenity-stages.jsp?amenity_id="+$("#searchamenityId").val();
});



function editFloorAmenityStages(amenity_stage_id) {
	
	$.get("${baseUrl}/createprojects/editflooramenitystage.jsp?amenity_stage_id="+amenity_stage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editFloorAmenityStages").modal('show');
	},'html');
}

function updateFloorAmenityStages() {
	
	$.post("${baseUrl}/webapi/create/builder/floor/amenity/stages/update/",{ id: $("#uamenity_stage_id").val(), amenity_id: $("#uamenity_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

//Commented as delete is throwing Mysql Exception
//com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails
// function deleteProjectAmenityStages(amenity_stage_id){
// 	var yes = confirm("Do you want to delete ?");
// 	if(yes==true){
// 		$.ajax({
// 			url: "${baseUrl}/webapi/create/builder/project/amenity/stages/delete",
// 			data:{amenity_stage_id:amenity_stage_id},
// 			type:'delete',
// 			success:function(data){
// 				alert(data.message);
// 				window.location.reload();
// 			}
// 		});
// 	}
// }

</script>