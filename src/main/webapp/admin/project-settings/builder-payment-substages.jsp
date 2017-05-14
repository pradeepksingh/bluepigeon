<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.bluepigeon.admin.model.BuilderPaymentStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderPaymentSubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPaymentStagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPaymentSubstagesDAO"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int payment_id=0;
int payment_size=0;
List<BuilderPaymentSubstages> payment_stage_list = null;
List<BuilderPaymentStages> payment_list = null;
int payment_stage_size=0; 
if (request.getParameterMap().containsKey("payment_id")) {
	payment_id = Integer.parseInt(request.getParameter("payment_id"));
	
	if (payment_id > 0) {
		payment_stage_list = new BuilderPaymentSubstagesDAO().getBuilderPaymentSubstagesByPaymentId(payment_id);
		payment_stage_size = payment_stage_list.size(); 
	}
} else {
	payment_stage_list = new BuilderPaymentSubstagesDAO().getBuilderPaymentSubstagesList();
	payment_stage_size = payment_stage_list.size(); 
}

payment_list = new BuilderPaymentStagesDAO().getBuilderPaymentStagesList();
payment_size = payment_list.size();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">Payment Substages</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Payment Substages
					<a href="#addPaymentSubstage" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Payment Substage</a>
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
						                <label class="col-sm-6 control-label">Select Payment Stage</label>
						                <div class="col-sm-6">
							                <select name="searchpaymentId" id="searchpaymentId" class="form-control">
							                    <option value="0">Select Payment Substage</option>
							                    <% for(int i=0; i < payment_size ; i++){ %>
												<option value="<% out.print(payment_list.get(i).getId());%>" <% if(payment_id == payment_list.get(i).getId()) { %>selected<% } %>><% out.print(payment_list.get(i).getName());%></option>
												<% } %>
							                </select>
						                </div>
					                </div>
				                </div>
				              
                                <table class="table table-striped table-bordered" id="paymentsubstagetable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < payment_stage_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(payment_stage_list.get(i).getName()); %></td>
                                            <td><% if(payment_stage_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editPaymentSubstages(<% out.print(payment_stage_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
<%--                                             	<a href="javascript:deleteFloorAmenityStages(<% out.print(payment_stage_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<div id="addPaymentSubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Add New Payment Substage</h4>
          	</div>
          	<div class="modal-body" style="background-color:#f5f5f5;">
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Payment Stages</label>
                       		<select name="payment_id" id="payment_id" class="form-control">
								<option value=""> Select Payment Substages </option>
								<% for(int i=0; i < payment_size ; i++){ %>
								<option value="<% out.print(payment_list.get(i).getId());%>"><% out.print(payment_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Payment substage Name</label>
                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter payment substage Name"/>
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
             			<button type="submit" class="btn btn-primary" onclick="addPaymentSubstage();">SAVE</button>
             		</div>
              	</div>
          	</div>
      	</div>
  	</div>
</div>
<div id="editPaymentSubstage" class="modal fade" style="">
    <div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
      	<div class="modal-content">
          	<div class="modal-header">
              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
              	<h4 class="modal-title" id="myModalLabel">Update Payment Substage</h4>
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
    $('#paymentsubstagetable').DataTable({
        "aaSorting": []
    });
});
function addPaymentSubstage() {
	$.post("${baseUrl}/webapi/create/builder/payment/substages/save/",{ payment_id: $("#payment_id").val(), name: $("#name").val(), status: $("#status").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

$("#searchpaymentId").change(function(){
	window.location.href = "${baseUrl}/admin/project-settings/builder-payment-substages.jsp?payment_id="+$("#searchpaymentId").val();
});



function editPaymentSubstages(payment_stage_id) {
	
	$.get("${baseUrl}/admin/project-settings/editbuilderpaymentsubstage.jsp?payment_stage_id="+payment_stage_id,{ }, function(data){
		$("#modalarea").html(data);
		$("#editPaymentSubstage").modal('show');
	},'html');
}

function updatePaymentSubstages() {
	
	$.post("${baseUrl}/webapi/create/builder/payment/substages/update/",{ id: $("#ustage_id").val(), payment_id: $("#upayment_id").val(), name: $("#uname").val(), status: $("#ustatus").val()}, function(data){
		alert(data.message);
		window.location.reload();
	},'json');
}

</script>