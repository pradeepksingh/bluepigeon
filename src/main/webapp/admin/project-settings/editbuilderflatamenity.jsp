<%@page import="org.bluepigeon.admin.model.FlatAmenityIcon"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderFlatAmenity> amenity_list = null;
	FlatAmenityIcon flatAmenityIcon = null;
	
	BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderFlatAmenity builderFlatAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderFlatAmenityDAO.getBuilderFlatAmenityById(amenity_id);
		builderFlatAmenity = amenity_list.get(0);
	}
%>
<form class="form-horizontal" role="form" method="post" action="" id="editFlatAmenity" name="editFlatAmenity" enctype="multipart/form-data">		
	<input type="hidden" name="uamenity_id" id="uamenity_id" value="<% out.print(builderFlatAmenity.getId()); %>"/>
    <div class="row">
  		<div class="col-xs-12">
      		<div class="form-group">
           		<label for="password" class="control-label">Flat Amenity Name</label>
           		<input type="text" name="uname" id="uname" value="<% out.print(builderFlatAmenity.getName()); %>" class="form-control" placeholder="Enter flat amenity Name"/>
      		</div>
  		</div>
    </div>
    <div class="row">
         <div class="col-xs-12">
              <div class="form-group">
              		<label for="password" class="control-label"><% if(builderFlatAmenity.getIconUrl() != null && !builderFlatAmenity.getIconUrl().equals("")) {%>Select New<% } else { %>Flat<% } %> Amenity Icon</label>
                    <div class="row">
	                    <div class="col-sm-8">
	                    	<input type="file" class="form-control" id="flat_amenity_icon" name="flat_amenity_icon[]" />
	                    </div>
	                   	<% if(builderFlatAmenity.getIconUrl() != null && !builderFlatAmenity.getIconUrl().equals("")) {%>
	                    <div class="col-sm-4">
							<img alt="floor amenity icon" src="${baseUrl}/<% out.print(builderFlatAmenity.getIconUrl()); %>" width="50px;">
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
					<option value="1" <% if(builderFlatAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
					<option value="0" <% if(builderFlatAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
				</select>
              </div>
         </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
    		<button type="submit" class="btn btn-primary" name="updateFlatAmenityIncon">UPDATE</button>
         </div>
     </div>
</form>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
$('#editFlatAmenity').bootstrapValidator({
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
	updateFlatAmenity();
});


function updateFlatAmenity() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showUpdateRequest,
	 		success :  showUpdateResponse,
	 		url : '${baseUrl}/webapi/create/builder/flat/amenity/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#editFlatAmenity').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/project-settings/builder-flat-amenity.jsp";
  	}
}
</script>