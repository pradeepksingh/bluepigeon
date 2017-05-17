<%@page import="org.bluepigeon.admin.dao.FloorSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.FloorSubstage"%>
<%@page import="org.bluepigeon.admin.dao.FloorStageDAO"%>
<%@page import="org.bluepigeon.admin.model.FloorStage"%>


<%@page import="java.util.List"%>
<%
int floor_stage_size=0;
int floor_substage_id = Integer.parseInt(request.getParameter("floor_substage_id"));
List<FloorStage> floor_stage_list = new FloorStageDAO().getFloorStageList();
List<FloorSubstage> floor_substage_detail = null;
FloorSubstage floorSubstage = null;
if (floor_substage_id > 0) {
	floor_substage_detail = new FloorSubstagesDAO().getFloorSubstageById(floor_substage_id);
	if(floor_substage_detail.size() > 0)
		floorSubstage = floor_substage_detail.get(0);
}
floor_stage_size = floor_stage_list.size();
%>				<input type="hidden" name="floor_substage_id" id="ufloor_substage_id" value="<% out.print(floor_substage_id); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Floor Stage </option>
								<% for(int i=0; i < floor_stage_size ; i++){ %>
								<option value="<% out.print(floor_stage_list.get(i).getId());%>" <% if(floor_stage_list.get(i).getId() == floorSubstage.getFloorStage().getId()){ %>selected<%}  %>><% out.print(floor_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Substage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(floorSubstage.getName()); %>" class="form-control" placeholder="Enter flat substage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(floorSubstage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(floorSubstage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFloorSubstages();">Update</button>
             		</div>
              	</div>
