<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity" %>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	List<BuilderFlatAmenity> amenity_list = null;
	BuilderFlatAmenityDAO builderFlatAmenityDAO = new BuilderFlatAmenityDAO();
	
	int amenity_id = Integer.parseInt(request.getParameter("amenity_id"));
	BuilderFlatAmenity builderFlatAmenity = null;
	if (amenity_id > 0) {
		amenity_list = builderFlatAmenityDAO.getBuilderFlatAmenityById(amenity_id);
		builderFlatAmenity = amenity_list.get(0);
	}
%>				<input type="hidden" name="amenity_id" id="uamenity_id" value="<% out.print(builderFlatAmenity.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Flat Amenity Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderFlatAmenity.getName()); %>" class="form-control" placeholder="Enter flat amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderFlatAmenity.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderFlatAmenity.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFlatAmenity();">UPDATE</button>
             		</div>
              	</div>
