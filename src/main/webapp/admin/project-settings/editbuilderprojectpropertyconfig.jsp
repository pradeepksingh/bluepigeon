<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="java.util.List"%>
<%
	
	List<BuilderProjectPropertyConfiguration> property_config_list = null;
	BuilderProjectPropertyConfigurationDAO builderBuildingAmenityDAO = new BuilderProjectPropertyConfigurationDAO();
	
	int config_id = Integer.parseInt(request.getParameter("config_id"));
	BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration = null;
	if (config_id > 0) {
		property_config_list = builderBuildingAmenityDAO.getCountryById(config_id);
		builderProjectPropertyConfiguration = property_config_list.get(0);
	}
%>				<input type="hidden" name="config_id" id="uconfig_id" value="<% out.print(builderProjectPropertyConfiguration.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Property Configuration</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderProjectPropertyConfiguration.getName()); %>" class="form-control" placeholder="Enter building property configuration Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectPropertyConfiguration.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectPropertyConfiguration.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectPropertyConfig();">UPDATE</button>
             		</div>
              	</div>
