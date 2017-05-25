<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity" %>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderBuildingAmenity> amenity_list = null;
	BuilderBuildingAmenityDAO builderBuildingAmenityDAO = new BuilderBuildingAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderBuildingAmenity builderBuildingAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderBuildingAmenityDAO.getBuilderBuildingAmenityById(amenity_id);
		builderBuildingAmenity = amenity_list.get(0);
	}
%>				<input type="hidden" name="amenity_id" id="uamenity_id" value="<% out.print(builderBuildingAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Amenity Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderBuildingAmenity.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderBuildingAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderBuildingAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateBuildingAmenity();">UPDATE</button>
             		</div>
              	</div>
<Script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</Script>