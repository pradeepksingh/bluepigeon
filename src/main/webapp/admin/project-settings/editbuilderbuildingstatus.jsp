<%@page import="org.bluepigeon.admin.dao.BuilderBuildingStatusDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingStatus"%>
<%@page import="java.util.List"%>
<%
	List<BuilderBuildingStatus> building_status_list = null;
BuilderBuildingStatusDAO builderBuildingAmenityDAO = new BuilderBuildingStatusDAO();
	
	int building_status_id = Integer.parseInt(request.getParameter("building_status_id"));
	BuilderBuildingStatus builderBuildingStatus = null;
	if (building_status_id > 0) {
		building_status_list = builderBuildingAmenityDAO.getCountryById(building_status_id);
		builderBuildingStatus = building_status_list.get(0);
	}
%>				<input type="hidden" name="building_status_id" id="ubuilding_status_id" value="<% out.print(builderBuildingStatus.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Status Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderBuildingStatus.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderBuildingStatus.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderBuildingStatus.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateBuildingStatus();">UPDATE</button>
             		</div>
              	</div>
