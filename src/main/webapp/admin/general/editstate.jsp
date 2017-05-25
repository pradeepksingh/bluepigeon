<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>

<%@page import="java.util.List"%>
<%
int country_size=0;
int state_id = Integer.parseInt(request.getParameter("state_id"));
List<Country> country_list = new CountryDAOImp().getCountryList();
List<State> state_detail = null;
State state = null;
if (state_id > 0) {
	state_detail = new StateImp().getStateById(state_id);
	if(state_detail.size() > 0)
		state = state_detail.get(0);
}
country_list = new CountryDAOImp().getActiveCountryList();
country_size = country_list.size();
%>				<input type="hidden" name="state_id" id="ustate_id" value="<% out.print(state.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Country</label>
                       		<select name="country_id" id="ucountry_id" class="form-control">
								<option value=""> Select Country </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(country_list.get(i).getId());%>" <% if(country_list.get(i).getId() == state.getCountry().getId()){ %>selected<%}  %>><% out.print(country_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">State Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(state.getName()); %>" class="form-control" placeholder="Enter State Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(state.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(state.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateState();">Update</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>