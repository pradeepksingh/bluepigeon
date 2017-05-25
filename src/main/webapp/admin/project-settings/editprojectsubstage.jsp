<%@page import="org.bluepigeon.admin.dao.ProjectSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.ProjectSubstage"%>
<%@page import="org.bluepigeon.admin.dao.ProjectStageDAO"%>
<%@page import="org.bluepigeon.admin.model.ProjectStage"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>

<%@page import="java.util.List"%>
<%
int project_stage_size=0;
int project_substage_id = Integer.parseInt(request.getParameter("project_substage_id"));
List<ProjectStage> project_stage_list = new ProjectStageDAO().getProjectStageList();
List<ProjectSubstage> project_substage_detail = null;
ProjectSubstage projectSubstage = null;
if (project_substage_id > 0) {
	project_substage_detail = new ProjectSubstagesDAO().getProjectSubstageById(project_substage_id);
	if(project_substage_detail.size() > 0)
		projectSubstage = project_substage_detail.get(0);
}
project_stage_size = project_stage_list.size();
%>				<input type="hidden" name="project_substage_id" id="uproject_substage_id" value="<% out.print(project_substage_id); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Project Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Project Stage </option>
								<% for(int i=0; i < project_stage_size ; i++){ %>
								<option value="<% out.print(project_stage_list.get(i).getId());%>" <% if(project_stage_list.get(i).getId() == projectSubstage.getProjectStage().getId()){ %>selected<%}  %>><% out.print(project_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Substage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(projectSubstage.getName()); %>" class="form-control" placeholder="Enter project substage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(projectSubstage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(projectSubstage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectSubstages();">Update</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>