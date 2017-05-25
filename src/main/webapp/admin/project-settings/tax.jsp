
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="org.bluepigeon.admin.dao.TaxDAO"%>
<%@page import="org.bluepigeon.admin.model.Tax" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%

List<Tax> tax_list = new TaxDAO().getTaxList();
int tax_size=tax_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Tax</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Tax
					<a href="#addTax" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Tax</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="taxtable">
                                    <thead>
                                        <tr>
                                            <th>Pincode</th>
                                            <th>Tax</th>
                                            <th>Stamp Duty</th>
                                            <th>Vat</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < tax_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(tax_list.get(i).getPincode()); %></td>
                                            <td><% out.print(tax_list.get(i).getTax()); %></td>
                                            <td><% out.print(tax_list.get(i).getStampDuty()); %></td>
                                            <td><% out.print(tax_list.get(i).getVat()); %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editTax(<% out.print(tax_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addTax" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Tax</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Pincode</label>
                       		<input type="text" name="pincode" id="pincode" class="form-control" placeholder="Enter Pincode"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Tax</label>
                       		<input type="text" name="tax" id="tax" class="form-control" placeholder="Enter tax"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Stamp Duty</label>
                       		<input type="text" name="sduty" id="sduty" class="form-control" placeholder="Enter stamp Duty"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Vat</label>
                       		<input type="text" name="vat" id="vat" class="form-control" placeholder="Enter Vat"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="addTax();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="edittax" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Tax</h4>
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
    $('#taxtable').DataTable({
        "aaSorting": []
    });
});
$("#pincode").attr('maxlength','6');
$('#pincode').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease use only numbers.'); return ''; } ) );
});
$('#tax').keypress(function (event) {
    return isNumber(event, this)
});
$('#vat').keypress(function (event) {
    return isNumber(event, this)
});
$('#sduty').keypress(function (event) {
    return isNumber(event, this)
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
}    
function addTax() {
	$.post("${baseUrl}/webapi/create/tax/save/",{ pincode: $("#pincode").val(), tax: $("#tax").val(),sduty: $("#sduty").val(),vat: $("#vat").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function editTax(taxid) {
	$.get("${baseUrl}/admin/project-settings/edittax.jsp?tax_id="+taxid,{ }, function(data){
		$("#modalarea").html(data);
		$("#edittax").modal('show');
	},'html');
}

function updateTax() {
	$.post("${baseUrl}/webapi/create/tax/update/",{ id: $("#utax_id").val(), pincode: $("#upincode").val(), tax: $("#utax").val(),sduty: $("#usduty").val(),vat: $("#uvat").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
</script>