
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int state_id=0;
int city_size =0;
int country_size = 0;
int state_size = 0;
int country_id = 0;
List<City> city_list = null;
List<State> state_list = null;
List<Country> country_list = null;
CountryDAOImp countryService = new CountryDAOImp();
List<Country> listCountry = countryService.getActiveCountryList();
StateImp stateList = new StateImp();
country_size = listCountry.size(); 
if (request.getParameterMap().containsKey("state_id")) {
  	state_id = Integer.parseInt(request.getParameter("state_id"));
  	List<State> states = stateList.getStateById(state_id);
  	city_list = new CityNamesImp().getCityNamesByStateId(state_id);
  	city_size = city_list.size(); 
  	if(states.size() > 0)
  	country_id = states.get(0).getCountry().getId();
  	if(city_size > 0) {
	  	country_id = city_list.get(0).getState().getCountry().getId();
  	}
  	state_list = stateList.getActiveStateByCountryId(country_id);
  	state_size = state_list.size();
} else {
	city_list = new CityNamesImp().getCityNames();
	city_size = city_list.size(); 
}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>General</li>
				<li class="active">City</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					City 
					<a href="#addCity" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New City</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                            	<div class="col-sm-6">
		                            <div class="form-group">
						                <label class="col-sm-4 control-label">Select Country</label>
						                <div class="col-sm-8">
							                <select name="searchcountryId" id="searchcountryId" class="form-control">
							                    <option value="">Select Country</option>
							                    <% for(int i=0; i < country_size ; i++){ %>
												<option value="<% out.print(listCountry.get(i).getId());%>" <% if(country_id == listCountry.get(i).getId()) { %>selected<% } %>><% out.print(listCountry.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				                <div class="col-sm-6">
		                            <div class="form-group">
						                <label class="col-sm-4 control-label">Select State</label>
						                <div class="col-sm-8">
							                <select name="searchstateId" id="searchstateId" class="form-control">
							                    <option value="0">Select State</option>
							                    <% for(int i=0; i < state_size ; i++){ %>
												<option value="<% out.print(state_list.get(i).getId());%>" <% if(state_id == state_list.get(i).getId()) { %>selected<% } %>><% out.print(state_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
                                <table class="table table-striped table-bordered" id="citytable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>State</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < city_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(city_list.get(i).getName()); %></td>
                                            <td><% out.print(city_list.get(i).getState().getName()); %></td>
                                            <td><% if(city_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editCity(<% out.print(city_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
               </form>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="addCity" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New City</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Country</label>
                       		<select name="country_id" id="country_id" class="form-control">
								<option value=""> Select Country </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(listCountry.get(i).getId());%>"><% out.print(listCountry.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select State</label>
                       		<select name="state_id" id="state_id" class="form-control">
								<option value=""> Select State </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">City Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter City Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="status" class="form-control">
								<option value="1"> Active </option>
								<option value="0"> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="addCity();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editCity" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update City</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;" id="modalarea">
          	</div>
      	</div>
  	</div>
</div>
<%@include file="../../footer.jsp"%>
	</body>
</html>
<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#citytable').DataTable({
        "aaSorting": []
    });
});
function addCity() {
	$.post("${baseUrl}/webapi/general/city/save/",{ state_id: $("#state_id").val(), name: $("#name").val(), status: $("#status").val(), sortorder: 1}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
$("#country_id").change(function(){
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
		var html = '<option value="">Select State</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#state_id").html(html);
	},'json');
});

$("#searchcountryId").change(function(){
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#searchcountryId").val() }, function(data){
		var html = '<option value="">Select State</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#searchstateId").html(html);
	},'json');
});

$("#searchstateId").change(function(){

	window.location.href = "${baseUrl}/admin/general/city.jsp?state_id="+$("#searchstateId").val();
});

function editCity(cityid) {
	$.get("${baseUrl}/admin/general/editcity.jsp?city_id="+cityid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editCity").modal('show');
	},'html');
}

function updateCity() {
	$.post("${baseUrl}/webapi/general/city/update/",{ id: $("#ucity_id").val(), state_id: $("#ustate_id").val(), name: $("#uname").val(), status: $("#ustatus").val(), sortorder: 1}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}


</script>