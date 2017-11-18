<%@page import="org.bluepigeon.admin.model.ProjectAmenityIcon"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderProjectAmenity> amenity_list = null;
	ProjectAmenityIcon projectAmenityIcon = null;
	
	BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderProjectAmenity builderProjectAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderProjectAmenityDAO.getBuilderProjectAmenityById(amenity_id);
		builderProjectAmenity = amenity_list.get(0);
		projectAmenityIcon = builderProjectAmenityDAO.getProjectAmenityIconById(amenity_id);
	}
%>	
	<form class="form-horizontal" role="form" method="post" action="" id="editMyProjectAmenity" name="editMyProjectAmenity" enctype="multipart/form-data">
		<input type="hidden" name="uamenity_id" id="uamenity_id" value="<% out.print(builderProjectAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Amenity Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderProjectAmenity.getName()); %>" class="form-control" placeholder="Enter project amenity Name"/>
                  		</div>
                  		<div class="messageContainer"></div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label"><% if(builderProjectAmenity.getIconUrl() != null && !builderProjectAmenity.getIconUrl().equals("")) {%>Select New<% } else { %>Project<% } %> Amenity Icon</label>
							<input type="hidden" value="<% out.print(builderProjectAmenity.getId()); %>" name="project_amenity_id[]" id="project_amenity_id"/>
							<div class="col-sm-8" style="padding:0px;">
                       			<input type="file" class="form-control" id="project_amenity_icon" name="project_amenity_icon[]" />
                       		</div>
                       		<% if(builderProjectAmenity.getIconUrl() != null && !builderProjectAmenity.getIconUrl().equals("")) {%>
							<div class="col-sm-4">
									<img alt="project amenity icon" src="${baseUrl}/<% out.print(builderProjectAmenity.getIconUrl()); %>" width="50px;">
							</div>
							<div class="messageContainer col-sm-offset-4"></div>
							<% } %>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" name="updateProjectAmenityIcon">UPDATE</button>
             		</div>
              	</div>
         </form>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});


$('#editMyProjectAmenity').bootstrapValidator({
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
	updateProjectAmenity();
});


function updateProjectAmenity() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showUpdateRequest,
	 		success :  showUpdateResponse,
	 		url : '${baseUrl}/webapi/create/builder/project/amenity/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#editMyProjectAmenity').ajaxSubmit(options);
}

function showUpdateRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showUpdateResponse(resp, statusText, xhr, $form){
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
</script>