<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
List<BuilderProjectAmenity> amenity_list = new BuilderProjectAmenityDAO().getBuilderProjectAmenityList();
int amenity_size=amenity_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Project Amenity</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Amenity 
					<a href="#addProjectAmenity" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Project Amenity</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="projectamenitytable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Icon</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < amenity_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(amenity_list.get(i).getName()); %></td>
                                            <td><img src="${baseUrl}/<% out.print(amenity_list.get(i).getIconUrl()); %>" width="32px" height="32px"/></td>
                                            <td><% if(amenity_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editProjectAmenity(<% out.print(amenity_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addProjectAmenity" class="modal fade" style="">
	<form class="form-horizontal" role="form" method="post" action="" id="addProjectAmenity" name="addProjectAmenity" enctype="multipart/form-data">
	    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
	      	<div class="modal-content">
	          	<div class="modal-header">
	              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
	              	<h4 class="modal-title" id="myModalLabel">Add New Project Amenity</h4>
	          	</div>
	          	<div class="modal-body" style="background-color:#f5f5f5;">
	              	<div class="row">
	              		<div class="col-xs-12">
	                  		<div class="form-group">
	                       		<label for="password" class="control-label">Project Amenity Name</label>
	                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter project amenity name"/>
	                  		</div>
	                  		<div class="messageContainer"></div>
	              		</div>
	              		
	              	</div>
	              	<div class="row">
	              		<div class="col-xs-12">
	                  		<div class="form-group">
	                       		<label for="password" class="control-label">Project Amenity Icon</label>
	                       		<input type="file" class="form-control" id="project_amenity_icon" name="project_amenity_icon[]" />
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
	             			<button type="submit" class="btn btn-primary" name="newProjectAmenity">SAVE</button>
	             		</div>
	              	</div>
	          	</div>
	      	</div>
	  	</div>
  	</form>
</div>
<div id="editProjectAmenity" class="modal fade" style="">
	
	    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
	      	<div class="modal-content">
	          	<div class="modal-header">
	              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
	              	<h4 class="modal-title" id="myModalLabel">Update Project Amenity</h4>
	          	</div>
	          	<div class="modal-body" style="background-color:#f5f5f5;" id="modalarea">
	          	</div>
	      	</div>
	  	</div>
	
</div>
<%@include file="../../footer.jsp"%>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
	</body>
</html>
<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#projectamenitytable').DataTable({
        "aaSorting": []
    });
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});

$('#addProjectAmenity').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	name: {
            validators: {
                notEmpty: {
                    message: 'Amenity Name is required and cannot be empty'
                }
            }
        },
        status: {
            validators: {
                notEmpty: {
                    message: 'Status  is required and cannot be empty'
                }
            }
        }
   
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addProjectAmenity();
});


function addProjectAmenity() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/create/builder/project/amenity/save/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addProjectAmenity').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
		ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project-settings/builder-project-amenity.jsp";
  	}
}

// function addProjectAmenity() {
// 	$.post("${baseUrl}/webapi/create/builder/project/amenity/save/",{ name: $("#name").val(), status: $("#status").val()}, function(data){
// 		alert(data.message);
// 		window.location.reload();
// 	},'json');
// }




function editProjectAmenity(amenityid) {
	ajaxindicatorstart("Please wait while.. we load ...");
	$.get("${baseUrl}/admin/project-settings/editbuilderprojectamenity.jsp?amenity_id="+amenityid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editProjectAmenity").modal('show');
		ajaxindicatorstop();
	},'html');
}

// function updateProjectAmenity() {
// 	$.post("${baseUrl}/webapi/create/builder/project/amenity/update/",{ id: $("#uamenity_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
// 		alert(data.message);
// 		window.location.reload();
// 	},'json');
// }
function deleteProjectAmenity(amenityid){
	var yes = confirm("Do you want to delete ?");
	if(yes==true){
		ajaxindicatorstart("Please wait while.. we load ...");
		$.ajax({
			url: "${baseUrl}/webapi/create/builder/project/amenity/delete",
			data:{amenityid:amenityid},
			type:'delete',
			success:function(data){
				alert(data.message);
				window.location.reload();
			}
		});
	}
}
</script>