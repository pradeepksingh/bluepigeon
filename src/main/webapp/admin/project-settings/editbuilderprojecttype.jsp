<%@page import="org.bluepigeon.admin.dao.BuilderProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectType"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectStatusDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectStatus"%>
<%@page import="java.util.List"%>
<%
	List<BuilderProjectType> project_type_list = null;
	BuilderProjectTypeDAO bProjectTypeDAO = new BuilderProjectTypeDAO();
	
	int project_type_id = Integer.parseInt(request.getParameter("type_id"));
	BuilderProjectType builderProjectType = null;
	if (project_type_id > 0) {
		project_type_list = bProjectTypeDAO.getCountryById(project_type_id);
		builderProjectType = project_type_list.get(0);
	}
%>				<input type="hidden" name="utype_id" id="utype_id" value="<% out.print(builderProjectType.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Type Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderProjectType.getName()); %>" class="form-control" placeholder="Enter project level Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectType.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectType.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectType();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>