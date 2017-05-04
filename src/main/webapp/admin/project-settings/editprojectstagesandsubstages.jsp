<%@page import="org.bluepigeon.admin.model.BuilderOverallProjectStagesAndSubStages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderOverallProjectStagesAndSubStagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingStatusDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingStatus"%>
<%@page import="java.util.List"%>
<%
	List<BuilderOverallProjectStagesAndSubStages> building_status_list = null;
BuilderOverallProjectStagesAndSubStagesDAO builderBuildingAmenityDAO = new BuilderOverallProjectStagesAndSubStagesDAO();
	
	int building_status_id = Integer.parseInt(request.getParameter("stage_id"));
	BuilderOverallProjectStagesAndSubStages builderBuildingStatus = null;
	if (building_status_id > 0) {
		building_status_list = builderBuildingAmenityDAO.getCountryById(building_status_id);
		builderBuildingStatus = building_status_list.get(0);
	}
%>				<input type="hidden" name="ustage_id" id="ustage_id" value="<% out.print(builderBuildingStatus.getId()); %>"/>
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
             			<button type="submit" class="btn btn-primary" onclick="updateProjectStages();">UPDATE</button>
             		</div>
              	</div>
