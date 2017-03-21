<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity" %>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderProjectAmenity> amenity_list = null;
	BuilderProjectAmenityDAO builderProjectAmenityDAO = new BuilderProjectAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderProjectAmenity builderProjectAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderProjectAmenityDAO.getBuilderProjectAmenityById(amenity_id);
		builderProjectAmenity = amenity_list.get(0);
	}
%>				<input type="hidden" name="amenity_id" id="uamenity_id" value="<% out.print(builderProjectAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Amenity Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderProjectAmenity.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectAmenity();">UPDATE</button>
             		</div>
              	</div>
