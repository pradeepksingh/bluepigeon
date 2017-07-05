<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityStagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenitySubstagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenityStages"%>

<%@page import="java.util.List"%>
<%
	int country_size = 0;
	int state_size = 0;
	List<BuilderBuildingAmenity> country_list = null;
	BuilderBuildingAmenityDAO countryService = new BuilderBuildingAmenityDAO();
	List<BuilderBuildingAmenity> listCountry = countryService.getBuilderBuildingAmenityList();
	country_size = listCountry.size(); 
	List<BuilderBuildingAmenityStages> state_list = null;
	BuilderBuildingAmenityStagesDAO stateList = new BuilderBuildingAmenityStagesDAO();
	int city_id = Integer.parseInt(request.getParameter("substage_id"));
	List<BuilderBuildingAmenitySubstages> city_detail = null;
	BuilderBuildingAmenitySubstages city = null;
	if (city_id > 0) {
		city_detail = new BuilderBuildingAmenitySubstagesDAO().getBuilderBuildingAmenityStagesById(city_id);
		if(city_detail.size() > 0)
		city = city_detail.get(0);
		state_list = stateList.getStateByAmenityId(city.getBuilderBuildingAmenityStages().getBuilderBuildingAmenity().getId());
		state_size = state_list.size();
	}
%>				<input type="hidden" name="substage_id" id="usubstage_id" value="<% out.print(city.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Building Amenity</label>
                       		<select name="amenity_id" id="uamenity_id" class="form-control">
								<option value=""> Select Building Amenity </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(listCountry.get(i).getId());%>" <% if(listCountry.get(i).getId() == city.getBuilderBuildingAmenityStages().getBuilderBuildingAmenity().getId()){ %>selected<%}  %>><% out.print(listCountry.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Building Amenity Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Building Amenity Stage</option>
								<% for(int i=0; i < state_size ; i++){ %>
								<option value="<% out.print(state_list.get(i).getId());%>" <% if(state_list.get(i).getId() == city.getBuilderBuildingAmenityStages().getId()){ %>selected<%}  %>><% out.print(state_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Building Amenity Substage Name</label>
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
             			<button type="submit" class="btn btn-primary" onclick="updateBuildingAmenitySubstage();">Update</button>
             		</div>
              	</div>
<script type="text/javascript">
// $("#amenity_id").change(function(){
// 	$.get("${baseUrl}/webapi/general/state/list",{ amenity_id: $("#amenity_id").val() }, function(data){
// 		var html = '<option value="">Select Building Amenity Stage</optio>';
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
// 		});
// 		$("#ustage_id").html(html);
// 	},'json');
// });
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
</script>