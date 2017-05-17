<%@page import="org.bluepigeon.admin.model.FlatStage"%>
<%@page import="org.bluepigeon.admin.dao.FlatStageDAO"%>
<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="org.bluepigeon.admin.dao.BuildingStageDAO"%>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	FlatStageDAO flatStageDAO = new FlatStageDAO();
	
	int id = Integer.parseInt(request.getParameter("stage_id"));
	FlatStage flatStage = null;
	if (id > 0) {
		flatStage = flatStageDAO.getFlatStageById(id);
	}
%>				<input type="hidden" name="stage_id" id="ustage_id" value="<% out.print(flatStage.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Flat Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(flatStage.getName()); %>" class="form-control" placeholder="Enter flat stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(flatStage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(flatStage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFlatStage();">UPDATE</button>
             		</div>
              	</div>
