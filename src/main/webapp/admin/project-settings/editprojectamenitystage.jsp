<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityStagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityStages"%>

<%@page import="java.util.List"%>
<%
int amenity_size=0;
int amenity_stage_id = Integer.parseInt(request.getParameter("amenity_stage_id"));
List<BuilderProjectAmenity> amenity_list = null;
List<BuilderProjectAmenityStages> amenity_stage_detail = null;
BuilderProjectAmenityStages builderProjectAmenityStages = null;
if (amenity_stage_id > 0) {
	amenity_stage_detail = new BuilderProjectAmenityStagesDAO().getBuilderProjectAmenityStagesById(amenity_stage_id);
	if(amenity_stage_detail.size() > 0)
		builderProjectAmenityStages = amenity_stage_detail.get(0);
}
amenity_list = new BuilderProjectAmenityDAO().getBuilderProjectAmenityList();
amenity_size = amenity_list.size();
%>				<input type="hidden" name="amenity_stage_id" id="uamenity_stage_id" value="<% out.print(builderProjectAmenityStages.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Project Amenity</label>
                       		<select name="amenity_id" id="uamenity_id" class="form-control">
								<option value=""> Select Project Amenity </option>
								<% for(int i=0; i < amenity_size ; i++){ %>
								<option value="<% out.print(amenity_list.get(i).getId());%>" <% if(amenity_list.get(i).getId() == builderProjectAmenityStages.getBuilderProjectAmenity().getId()){ %>selected<%}  %>><% out.print(amenity_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Amenity Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderProjectAmenityStages.getName()); %>" class="form-control" placeholder="Enter Project Amenity Stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderProjectAmenityStages.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderProjectAmenityStages.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectAmenityStages();">Update</button>
             		</div>
              	</div>
<script type="text/javascript">
// $("#country_id").change(function(){
// 	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
// 		var html = '<option value="">Select State</optio>';
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
// 		});
// 		$("#ustate_id").html(html);
// 	},'json');
// });
</script>