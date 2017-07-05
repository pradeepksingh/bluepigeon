<%@page import="org.bluepigeon.admin.dao.ProjectStageDAO"%>
<%@page import="org.bluepigeon.admin.model.ProjectStage"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity" %>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	ProjectStageDAO projectStageDAO = new ProjectStageDAO();
	
	int id = Integer.parseInt(request.getParameter("stage_id"));
	ProjectStage projectStage = null;
	if (id > 0) {
		projectStage = projectStageDAO.getProjectStageById(id);
	}
%>				<input type="hidden" name="stage_id" id="ustage_id" value="<% out.print(projectStage.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(projectStage.getName()); %>" class="form-control" placeholder="Enter project stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(projectStage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(projectStage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectStage();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
</script>