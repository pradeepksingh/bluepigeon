<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.service.CityNamesService"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>

<%@page import="java.util.List"%>
<%
	int country_size = 0;
	int state_size = 0;
	int city_size = 0;
	List<Country> country_list = null;
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getActiveCountryList();
	country_size = listCountry.size(); 
	List<State> state_list = null;
	List<City> city_list = null;
	StateImp stateList = new StateImp();
	CityNamesImp cityList = new CityNamesImp();
	int locality_id = Integer.parseInt(request.getParameter("locality_id"));
	List<Locality> locality_detail = null;
	Locality locality = null;
	if (locality_id > 0) {
		locality_detail = new LocalityNamesImp().getLocalityById(locality_id);
		if(locality_detail.size() > 0) {
			locality = locality_detail.get(0);
			state_list = stateList.getActiveStateByCountryId(locality.getCity().getState().getCountry().getId());
			state_size = state_list.size();
			city_list = cityList.getActiveCityNamesByStateId(locality.getCity().getState().getId());
			city_size = city_list.size();
		}
	}
%>				<input type="hidden" name="locality_id" id="ulocality_id" value="<% out.print(locality.getId()); %>"/>
				<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Country</label>
                       		<select name="country_id" id="ucountry_id" class="form-control">
								<option value=""> Select Country </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(listCountry.get(i).getId());%>" <% if(listCountry.get(i).getId() == locality.getCity().getState().getCountry().getId()){ %>selected<%}  %>><% out.print(listCountry.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select State</label>
                       		<select name="state_id" id="ustate_id" class="form-control">
								<option value=""> Select State </option>
								<% for(int i=0; i < state_size ; i++){ %>
								<option value="<% out.print(state_list.get(i).getId());%>" <% if(state_list.get(i).getId() == locality.getCity().getState().getId()){ %>selected<%}  %>><% out.print(state_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select City</label>
                       		<select name="city_id" id="ucity_id" class="form-control">
								<option value=""> Select City </option>
								<% for(int i=0; i < city_size ; i++){ %>
								<option value="<% out.print(city_list.get(i).getId());%>" <% if(city_list.get(i).getId() == locality.getCity().getId()){ %>selected<%}  %>><% out.print(city_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Locality Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(locality.getName()); %>" class="form-control" placeholder="Enter City Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(locality.getStatus() == true) { %>selected<% } %>> Active </option>
								<option value="0" <% if(locality.getStatus() == false) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateLocality();">SAVE</button>
             		</div>
              	</div>
<script type="text/javascript">
$("#ucountry_id").change(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#ucountry_id").val() }, function(data){
		var html = '<option value="">Select State</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#ustate_id").html(html);
		ajaxindicatorstop();
	},'json');
});
$("#ustate_id").change(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#ustate_id").val() }, function(data){
		var html = '<option value="">Select City</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#ucity_id").html(html);
		ajaxindicatorstop();
	},'json');
});
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>