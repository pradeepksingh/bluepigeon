<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity" %>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderFloorAmenity> amenity_list = null;
	BuilderFloorAmenityDAO builderFloorAmenityDAO = new BuilderFloorAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderFloorAmenity builderFloorAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderFloorAmenityDAO.getBuilderFloorAmenityById(amenity_id);
		builderFloorAmenity = amenity_list.get(0);
	}
%>				<input type="hidden" name="amenity_id" id="uamenity_id" value="<% out.print(builderFloorAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Amenity Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderFloorAmenity.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderFloorAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderFloorAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFloorAmenity();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>