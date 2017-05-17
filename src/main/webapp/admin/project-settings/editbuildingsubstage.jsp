<%@page import="org.bluepigeon.admin.dao.BuildingSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuildingSubstage"%>
<%@page import="org.bluepigeon.admin.dao.BuildingStageDAO"%>
<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="java.util.List"%>
<%
int building_stage_size=0;
int building_substage_id = Integer.parseInt(request.getParameter("building_substage_id"));
List<BuildingStage> building_stage_list = new BuildingStageDAO().getBuildingStageList();
List<BuildingSubstage> building_substage_detail = null;
BuildingSubstage buildingSubstage = null;
if (building_substage_id > 0) {
	building_substage_detail = new BuildingSubstagesDAO().getBuildingSubstageById(building_substage_id);
	if(building_substage_detail.size() > 0)
		buildingSubstage = building_substage_detail.get(0);
}
building_stage_size = building_stage_list.size();
%>				<input type="hidden" name="building_substage_id" id="ubuilding_substage_id" value="<% out.print(building_substage_id); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Building Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Building Stage </option>
								<% for(int i=0; i < building_stage_size ; i++){ %>
								<option value="<% out.print(building_stage_list.get(i).getId());%>" <% if(building_stage_list.get(i).getId() == buildingSubstage.getBuildingStage().getId()){ %>selected<%}  %>><% out.print(building_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Substage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(buildingSubstage.getName()); %>" class="form-control" placeholder="Enter building substage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(buildingSubstage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(buildingSubstage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateBuildingSubstages();">Update</button>
             		</div>
              	</div>
