<%@page import="org.bluepigeon.admin.dao.BuilderProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectType"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
BuilderProjectTypeDAO builderProjectTypeDAO = new BuilderProjectTypeDAO();
List<BuilderProjectType> builderProjectTList = builderProjectTypeDAO.getBuilderProjectTypes();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Project Type</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Type 
					<a href="#addProjectType" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Project Type</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="projecttypetable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < builderProjectTList.size(); i++){
                                        %>
                                        <tr>
                                            <td><% out.print(builderProjectTList.get(i).getName()); %></td>
                                            <td><% if(builderProjectTList.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editProjectType(<% out.print(builderProjectTList.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteProjectAmenity(<% out.print(amenity_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addProjectType" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Project Type</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Type Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter project type name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addProjectType();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editProjectType" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Project Type</h4>
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
    $('#projecttypetable').DataTable({
        "aaSorting": []
    });
});
function addProjectType() {
	$.post("${baseUrl}/webapi/create/builder/project/type/save",{ name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function editProjectType(typeid) {
	$.get("${baseUrl}/admin/project-settings/editbuilderprojecttype.jsp?type_id="+typeid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editProjectType").modal('show');
	},'html');
}

function updateProjectType() {
	$.post("${baseUrl}/webapi/create/builder/project/type/update",{ id: $("#utype_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

</script>