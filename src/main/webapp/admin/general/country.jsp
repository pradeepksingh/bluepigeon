
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%

List<Country> country_list = new CountryDAOImp().getCountryList();
int country_size=country_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> Home
				</li>

				<li>General</li>
				<li class="active">Country</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Country 
					<a href="#addCountry" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Country</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="countrytable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < country_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(country_list.get(i).getName()); %></td>
                                            <td><% if(country_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editCountry(<% out.print(country_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteBuildingAmenity(<% out.print(amenity_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addCountry" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add Country</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Country Name</label>
                       		<p id="error" class="bg-danger nopadding" ></p>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter country name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Tax Label 1</label>
                       		<p id="error" class="bg-danger nopadding" ></p>
                       		<input type="text" name="tax1" id="tax1" class="form-control" placeholder="Enter 1st tax label"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Tax Label 2</label>
                       		<p id="error" class="bg-danger nopadding" ></p>
                       		<input type="text" name="tax2" id="tax2" class="form-control" placeholder="Enter 2nd tax label"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Tax Label 3</label>
                       		<p id="error" class="bg-danger nopadding" ></p>
                       		<input type="text" name="tax3" id="tax3" class="form-control" placeholder="Enter 3rd tax label"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addCountry();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editCountry" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Country</h4>
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
    $('#countrytable').DataTable({
        "aaSorting": []
    });
});
$('input').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});

function addCountry() {
		$.post("${baseUrl}/webapi/general/country/save",{ name: $("#name").val(), tax1:$("#tax1").val(), tax2:$("#tax2").val(),tax3 : $("#tax3").val(),status: $("#status").val()}, function(data){
			if(data.status == 1){
				$('#error').empty();
				alert(data.message);
				window.location.reload();
			}else{
				//alert(data.message);
				$('#error').empty();
				$("#error").append(data.message);
			}
		},'json');
}

function editCountry(countryid) {
	$.get("${baseUrl}/admin/general/editcountry.jsp?country_id="+countryid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editCountry").modal('show');
	},'html');
}

function updateCountry() {
	$.post("${baseUrl}/webapi/general/country/update/",{ id: $("#ucountry_id").val(), name: $("#uname").val(), tax1: $("#utax1").val(), tax2 : $("#utax2").val(), tax3 : $("#utax3").val(),  status: $("#ustatus").val(), sortOrder:1}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

</script>