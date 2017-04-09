<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityStagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenityStages"%>

<%@page import="java.util.List"%>
<%
int amenity_size=0;
int amenity_stage_id = Integer.parseInt(request.getParameter("amenity_stage_id"));
List<BuilderFloorAmenity> amenity_list = null;
List<BuilderFloorAmenityStages> amenity_stage_detail = null;
BuilderFloorAmenityStages builderFloorAmenityStages = null;
if (amenity_stage_id > 0) {
	amenity_stage_detail = new BuilderFloorAmenityStagesDAO().getBuilderFloorAmenityStagesById(amenity_stage_id);
	if(amenity_stage_detail.size() > 0)
		builderFloorAmenityStages = amenity_stage_detail.get(0);
}
amenity_list = new BuilderFloorAmenityDAO().getBuilderFloorAmenityList();
amenity_size = amenity_list.size();
%>				<input type="hidden" name="amenity_stage_id" id="uamenity_stage_id" value="<% out.print(builderFloorAmenityStages.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Floor Amenity</label>
                       		<select name="amenity_id" id="uamenity_id" class="form-control">
								<option value=""> Select Floor Amenity </option>
								<% for(int i=0; i < amenity_size ; i++){ %>
								<option value="<% out.print(amenity_list.get(i).getId());%>" <% if(amenity_list.get(i).getId() == builderFloorAmenityStages.getBuilderFloorAmenity().getId()){ %>selected<%}  %>><% out.print(amenity_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Amenity Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderFloorAmenityStages.getName()); %>" class="form-control" placeholder="Enter Project Amenity Stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderFloorAmenityStages.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderFloorAmenityStages.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFloorAmenityStages();">Update</button>
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