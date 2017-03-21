<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalType"%>
<%@page import="java.util.List"%>
<%
	List<BuilderProjectApprovalType> project_approval_list = null;
BuilderProjectApprovalTypeDAO builderProjectApprovalTypeDAO = new BuilderProjectApprovalTypeDAO();
	
	int project_approval_id = Integer.parseInt(request.getParameter("project_approval_id"));
	BuilderProjectApprovalType builderProjectApprovalType = null;
	if (project_approval_id > 0) {
		project_approval_list = builderProjectApprovalTypeDAO.getCountryById(project_approval_id);
		builderProjectApprovalType = project_approval_list.get(0);
	}
%>				<input type="hidden" name="project_approval_id" id="uproject_approval_id" value="<% out.print(builderProjectApprovalType.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Approval Type Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderProjectApprovalType.getName()); %>" class="form-control" placeholder="Enter project approval type Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectApprovalType.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectApprovalType.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectApprovalType();">UPDATE</button>
             		</div>
              	</div>