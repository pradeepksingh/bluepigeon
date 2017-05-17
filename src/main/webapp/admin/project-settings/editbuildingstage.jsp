<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="org.bluepigeon.admin.dao.BuildingStageDAO"%>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	BuildingStageDAO buildingStageDAO = new BuildingStageDAO();
	
	int id = Integer.parseInt(request.getParameter("stage_id"));
	BuildingStage buildingStage = null;
	if (id > 0) {
		buildingStage = buildingStageDAO.getBuildingStageById(id);
	}
%>				<input type="hidden" name="stage_id" id="ustage_id" value="<% out.print(buildingStage.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(buildingStage.getName()); %>" class="form-control" placeholder="Enter building stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(buildingStage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(buildingStage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateBuildingStage();">UPDATE</button>
             		</div>
              	</div>
