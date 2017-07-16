<%@page import="org.bluepigeon.admin.model.FloorAmenityIcon"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderFloorAmenity> amenity_list = null;
	FloorAmenityIcon floorAmenityIcon = null;
	BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderFloorAmenity builderFloorAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderFloorAmenityDAO.getBuilderFloorAmenityById(amenity_id);
		builderFloorAmenity = amenity_list.get(0);
	}
%>
<form class="form-horizontal" role="form" method="post" action="" id="updateFloorAmenity" name="updateFloorAmenity" enctype="multipart/form-data">			
	<input type="hidden" name="uamenity_id" id="uamenity_id" value="<% out.print(builderFloorAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Amenity Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderFloorAmenity.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
			         <div class="col-xs-12">
			              <div class="form-group">
			              		<label for="password" class="control-label"><% if(builderFloorAmenity.getIconUrl() != null && !builderFloorAmenity.getIconUrl().equals("")) {%>Select New<% } else { %>Floor<% } %> Amenity Icon</label>
			              		<div class="row">
				              		<div class="col-sm-8">
				                    	<input type="file" class="form-control" id="floor_amenity_icon" name="floor_amenity_icon[]" />
				                    </div>
				                    <% if(builderFloorAmenity.getIconUrl() != null && !builderFloorAmenity.getIconUrl().equals("")) {%>
				                    <div class="col-sm-4">
										<img alt="floor amenity icon" src="${baseUrl}/<% out.print(builderFloorAmenity.getIconUrl()); %>" width="50px;">
									</div>
									<% } %>
									<div class="messageContainer col-sm-offset-4"></div>
								</div>
			               </div>
			          </div>
			    </div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(builderFloorAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderFloorAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" name="updateFloorAmenityIcon">UPDATE</button>
             		</div>
              	</div>
            </form>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
$('#updateFloorAmenity').bootstrapValidator({
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
	updateFloorAmenity();
});


function updateFloorAmenity() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showUpdateRequest,
	 		success :  showUpdateResponse,
	 		url : '${baseUrl}/webapi/create/builder/floor/amenity/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#editFloorAmenity').ajaxSubmit(options);
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
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project-settings/builder-floor-amenity.jsp";
  	}
}
</script>