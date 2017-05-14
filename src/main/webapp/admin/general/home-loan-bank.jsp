
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%

List<HomeLoanBanks> home_loan_bank_list = new HomeLoanBanksDAO().getHomeLoanBanksList();
int home_loan_bank_size=home_loan_bank_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>General</li>
				<li class="active">Home Loan Bank</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Home Loan Bank
					<a href="#addHomeLoanBank" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Home Loan Bank</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="homeloanbanktable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                    	byte status = 1;
                                        for(int i=0; i < home_loan_bank_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(home_loan_bank_list.get(i).getName()); %></td>
                                            <td><% if(home_loan_bank_list.get(i).getStatus() == status) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editHomeLoanBank(<% out.print(home_loan_bank_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
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
<div id="addHomeLoanBank" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" >×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Home Loan Bank</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Bank Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter bank name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Location</label>
                       		<input type="text" name="location" id="location" class="form-control" placeholder="Enter bank location"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Contact Person Name</label>
                       		<input type="text" name="contact name" id="contact_name" class="form-control" placeholder="Enter contact person name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Email</label>
                       		<input type="text" name="email" id="email" class="form-control" placeholder="Enter contact person email id"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Phone</label>
                       		<input type="text" name="phone" id="phone" class="form-control" placeholder="Enter contact person phone number"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addHomeLoanBank();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editHomeLoanBank" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Home Loan Bank</h4>
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
    $('#homeloanbanktable').DataTable({
        "aaSorting": []
    });
});
function addHomeLoanBank() {
	$.post("${baseUrl}/webapi/general/bank/save/",{ name: $("#name").val(),location:$("#location").val(),contact_name:$("#contact_name").val(), email:$("#email").val(),phone:$("#phone").val(),status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

function editHomeLoanBank(bankid) {
	$.get("${baseUrl}/admin/general/edithomeloanbank.jsp?bank_id="+bankid,{ }, function(data){
		$("#modalarea").html(data);
		$("#editHomeLoanBank").modal('show');
	},'html');
}

function updateHomeLoanBank() {
	$.post("${baseUrl}/webapi/general/bank/update/",{ id: $("#ubank_id").val(), name: $("#uname").val(),location:$("#ulocation").val(),contact_name:$("#ucontact_name").val(), email:$("#uemail").val(),phone:$("#uphone").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}
function deleteAreaUnit(amenityid){
	var yes = confirm("Do you want to delete ?");
	if(yes==true){
		$.ajax({
			url: "${baseUrl}/webapi/general/area/delete",
			data:{amenityid:amenityid},
			type:'delete',
			success:function(data){
				alert(data.message);
				window.location.reload();
			}
		});
	}
}

</script>