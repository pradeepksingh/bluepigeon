
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
<%@page import="org.bluepigeon.admin.service.CityNamesService"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="java.util.List"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
int state_id=0;
int city_size =0;
int country_size = 0;
int state_size = 0;
int locality_size = 0;
int country_id = 0;
int city_id = 0;
List<Locality> locality_list = null;
List<City> city_list = null;
List<State> state_list = null;
List<Country> country_list = null;
CountryDAOImp countryService = new CountryDAOImp();
List<Country> listCountry = countryService.getCountryList();
StateImp stateList = new StateImp();
country_size = listCountry.size(); 
if (request.getParameterMap().containsKey("city_id")) {
	city_id = Integer.parseInt(request.getParameter("city_id"));
	locality_list = new LocalityNamesImp().getLocalityByCity(city_id);
	locality_size = locality_list.size();
  	if(locality_size > 0) {
  		state_id = locality_list.get(0).getCity().getState().getId();
  		city_list = new CityNamesService().getAllCityNamesByStateId(state_id);
  	  	city_size = city_list.size(); 
	  	country_id = city_list.get(0).getState().getCountry().getId();
	  	state_list = stateList.getStateByCountryId(country_id);
	  	state_size = state_list.size();
  	}
}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Tables</a></li>
				<li class="active">Locality</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Locality 
					<a href="#addLocality" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Locality</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                            	<div class="col-sm-4">
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
				                <div class="col-sm-4">
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
				                <div class="col-sm-4">
		                            <div class="form-group">
						                <label class="col-sm-4 control-label">Select City</label>
						                <div class="col-sm-8">
							                <select name="searchcityId" id="searchcityId" class="form-control">
							                    <option value="0">Select City</option>
							                    <% for(int i=0; i < city_size ; i++){ %>
												<option value="<% out.print(city_list.get(i).getId());%>" <% if(city_id == city_list.get(i).getId()) { %>selected<% } %>><% out.print(city_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
                                <table class="table table-striped table-bordered" id="citytable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < locality_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(locality_list.get(i).getName()); %></td>
                                            <td><% if(locality_list.get(i).getStatus()) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editLocality(<% out.print(locality_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addLocality" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color:#fff">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Locality</h4>
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
                       		<label for="password" class="control-label">Select City</label>
                       		<select name="city_id" id="city_id" class="form-control">
								<option value=""> Select City </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Locality Name</label>
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
             			<button type="submit" class="btn btn-primary" onclick="addLocality();">SAVE</button>
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
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color:#fff">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Locality</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;" id="modalarea">
          	</div>
      	</div>
  	</div>
</div>
<%@include file="../footer.jsp"%>
	</body>
</html>
<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function(){
    $('#citytable').DataTable({
        "aaSorting": []
    });
});
function addLocality() {
	$.post("${baseUrl}/webapi/general/locality/save/",{ city_id: $("#city_id").val(), name: $("#name").val(), status: $("#status").val(), sortorder: 1, latitude: '', longitude: ''}, function(data){
		alert(data.message);
		window.location.href = "${baseUrl}/general/locality.jsp?city_id="+$("#city_id").val();
	},'json');
}
$("#country_id").change(function(){
	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
		var html = '<option value="">Select State</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#state_id").html(html);
	},'json');
});

$("#state_id").change(function(){
	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
		var html = '<option value="">Select City</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#city_id").html(html);
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
	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#searchstateId").val() }, function(data){
		var html = '<option value="">Select City</optio>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
		});
		$("#searchcityId").html(html);
	},'json');
});

$("#searchcityId").change(function(){
	window.location.href = "${baseUrl}/general/locality.jsp?city_id="+$("#searchcityId").val();
});

function editLocality(locality_id) {
	$.get("${baseUrl}/general/editlocality.jsp?locality_id="+locality_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editCity").modal('show');
	},'html');
}

function updateLocality() {
	$.post("${baseUrl}/webapi/general/locality/update/",{ id: $("#ulocality_id").val(), city_id: $("#ucity_id").val(), name: $("#uname").val(), status: $("#ustatus").val(), sortorder: 1, latitude: '', longitude: ''}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}


</script>