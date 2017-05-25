<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityStagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenitySubstagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityStages"%>

<%@page import="java.util.List"%>
<%
	int country_size = 0;
	int state_size = 0;
	List<BuilderProjectAmenity> country_list = null;
	BuilderProjectAmenityDAO countryService = new BuilderProjectAmenityDAO();
	List<BuilderProjectAmenity> listCountry = countryService.getBuilderProjectAmenityList();
	country_size = listCountry.size(); 
	List<BuilderProjectAmenityStages> state_list = null;
	BuilderProjectAmenityStagesDAO stateList = new BuilderProjectAmenityStagesDAO();
	int city_id = Integer.parseInt(request.getParameter("substage_id"));
	List<BuilderProjectAmenitySubstages> city_detail = null;
	BuilderProjectAmenitySubstages city = null;
	if (city_id > 0) {
		city_detail = new BuilderProjectAmenitySubstagesDAO().getBuilderProjectAmenityStagesById(city_id);
		if(city_detail.size() > 0)
		city = city_detail.get(0);
		state_list = stateList.getStateByAmenityId(city.getBuilderProjectAmenityStages().getBuilderProjectAmenity().getId());
		state_size = state_list.size();
	}
%>				<input type="hidden" name="substage_id" id="usubstage_id" value="<% out.print(city.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Project Amenity</label>
                       		<select name="amenity_id" id="uamenity_id" class="form-control">
								<option value=""> Select Project Amenity </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(listCountry.get(i).getId());%>" <% if(listCountry.get(i).getId() == city.getBuilderProjectAmenityStages().getBuilderProjectAmenity().getId()){ %>selected<%}  %>><% out.print(listCountry.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Project Amenity Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Project Amenity Stage</option>
								<% for(int i=0; i < state_size ; i++){ %>
								<option value="<% out.print(state_list.get(i).getId());%>" <% if(state_list.get(i).getId() == city.getBuilderProjectAmenityStages().getId()){ %>selected<%}  %>><% out.print(state_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Amenity Substage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(city.getName()); %>" class="form-control" placeholder="Enter City Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(city.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(city.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectAmenitySubstage();">Update</button>
             		</div>
              	</div>
<script type="text/javascript">
// $("#amenity_id").change(function(){
// 	$.get("${baseUrl}/webapi/general/state/list",{ amenity_id: $("#amenity_id").val() }, function(data){
// 		var html = '<option value="">Select Project Amenity Stage</optio>';
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
// 		});
// 		$("#ustage_id").html(html);
// 	},'json');
// });
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>