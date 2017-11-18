<%@page import="org.bluepigeon.admin.model.BuildingAmenityIcon"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderBuildingAmenity> amenity_list = null;
	BuildingAmenityIcon buildingAmenityIcon = null;
	BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderBuildingAmenity builderBuildingAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderBuildingAmenityDAO.getBuilderBuildingAmenityById(amenity_id);
		builderBuildingAmenity = amenity_list.get(0);
	}
%>

<form class="form-horizontal" role="form" method="post" action="" id="editBuildingAmenity" name="editBuildingAmenity" enctype="multipart/form-data">		
		<input type="hidden" name="uamenity_id" id="uamenity_id" value="<% out.print(builderBuildingAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Amenity Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderBuildingAmenity.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label"><% if(builderBuildingAmenity.getIconUrl() != null && !builderBuildingAmenity.getIconUrl().equals("")) {%>Select New<% } else { %>Building<% } %> Amenity Icon</label>
							<input type="hidden" id="building_amenity_id" name="building_amenity_id[]" value="0"/>
							<div class="col-sm-8" style="padding-left:0px;">
                       			<input type="file" class="form-control" id="building_amenity_icon" name="building_amenity_icon[]" />
                       		</div>
                       		<% if(builderBuildingAmenity.getIconUrl() != null && !builderBuildingAmenity.getIconUrl().equals("")) {%>
							<div class="col-sm-4">
									<img alt="project amenity icon" src="${baseUrl}/<% out.print(builderBuildingAmenity.getIconUrl()); %>" width="50px;">
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
								<option value="1" <% if(builderBuildingAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderBuildingAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" name="updateBuildingAmenityIcon">UPDATE</button>
             		</div>
              	</div>
            </form>
<Script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});

$('#editBuildingAmenity').bootstrapValidator({
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
	updateBuildingAmenity();
});


function updateBuildingAmenity() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showUpdateRequest,
	 		success :  showUpdateResponse,
	 		url : '${baseUrl}/webapi/create/builder/building/amenity/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#editBuildingAmenity').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/project-settings/builder-building-amenity.jsp";
  	}
}
</Script>