
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="java.util.List"%>
<%
	List<BuilderPropertyType> project_type_list = null;
	BuilderPropertyTypeDAO bProjectTypeDAO = new BuilderPropertyTypeDAO();
	
	int project_type_id = Integer.parseInt(request.getParameter("type_id"));
	BuilderPropertyType builderProjectType = null;
	if (project_type_id > 0) {
		project_type_list = bProjectTypeDAO.getCountryById(project_type_id);
		builderProjectType = project_type_list.get(0);
	}
%>				<input type="hidden" name="utype_id" id="utype_id" value="<% out.print(builderProjectType.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Property Type Name</label>
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
             			<button type="submit" class="btn btn-primary" onclick="updatePropertyType();">UPDATE</button>
             		</div>
              	</div>