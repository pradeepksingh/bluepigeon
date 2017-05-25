<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country" %>
<%@page import="java.util.List"%>
<%
	int country_size = 0;
	List<Country> country_list = null;
	CountryDAOImp countryDAOImp = new CountryDAOImp();
	
	int country_id = Integer.parseInt(request.getParameter("country_id"));
	Country country = null;
	if (country_id > 0) {
		country_list = countryDAOImp.getCountryById(country_id);
		country = country_list.get(0);
	}
%>				<input type="hidden" name="country_id" id="ucountry_id" value="<% out.print(country.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Country Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(country.getName()); %>" class="form-control" placeholder="Enter country Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(country.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(country.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateCountry();">UPDATE</button>
             		</div>
              	</div>
<script>
$('input').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>
