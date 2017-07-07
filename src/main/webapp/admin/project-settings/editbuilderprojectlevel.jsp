<%@page import="org.bluepigeon.admin.dao.BuilderProjectLevelDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectLevel"%>
<%@page import="java.util.List"%>
<%
	List<BuilderProjectLevel> project_level_list = null;
	BuilderProjectLevelDAO builderFlatAmenityDAO = new BuilderProjectLevelDAO();
	
	int project_level_id = Integer.parseInt(request.getParameter("level_id"));
	BuilderProjectLevel builderProjectLevel = null;
	if (project_level_id > 0) {
		project_level_list = builderFlatAmenityDAO.getCountryById(project_level_id);
		builderProjectLevel = project_level_list.get(0);
	}
%>				<input type="hidden" name="level_id" id="ulevel_id" value="<% out.print(builderProjectLevel.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Level Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderProjectLevel.getName()); %>" class="form-control" placeholder="Enter project level Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectLevel.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectLevel.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectLevel();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>