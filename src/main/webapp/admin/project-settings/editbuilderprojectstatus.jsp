<%@page import="org.bluepigeon.admin.dao.BuilderProjectStatusDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectStatus"%>
<%@page import="java.util.List"%>
<%
	List<BuilderProjectStatus> project_status_list = null;
	BuilderProjectStatusDAO builderFlatAmenityDAO = new BuilderProjectStatusDAO();
	
	int project_status_id = Integer.parseInt(request.getParameter("status_id"));
	BuilderProjectStatus builderProjectStatus = null;
	if (project_status_id > 0) {
		project_status_list = builderFlatAmenityDAO.getCountryById(project_status_id);
		builderProjectStatus = project_status_list.get(0);
	}
%>				<input type="hidden" name="lustatus_id" id="ustatus_id" value="<% out.print(builderProjectStatus.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Level Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderProjectStatus.getName()); %>" class="form-control" placeholder="Enter project level Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectStatus.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectStatus.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectStatus();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
</script>