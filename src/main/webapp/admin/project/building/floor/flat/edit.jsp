<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.FlatAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FlatPaymentSchedule"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../../../../../head.jsp"%>
<%@include file="../../../../../leftnav.jsp"%>
<%
	int flat_id = 0;
	int p_user_id = 0;
	flat_id = Integer.parseInt(request.getParameter("flat_id"));
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
	}
	BuilderFlat builderFlat = null;
	List<BuilderFlat> builderFlats = new ProjectDAO().getBuildingFlatById(flat_id);
	if(builderFlats.size() > 0) {
		builderFlat = builderFlats.get(0);
	}
	List<BuilderFlatStatus> builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderFlatStatus();
	List<BuilderFlatAmenity> builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderFlatAmenityList();
	List<FlatAmenityInfo> flatAmenityInfos = new ProjectDAO().getBuilderFlatAmenityInfos(flat_id);
	List<FlatPaymentSchedule> flatPaymentSchedules = new ProjectDAO().getBuilderFlatPaymentSchedules(flat_id);
	List<BuilderFlatType> builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypes(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Flat</a></li>
				<li class="active">Add</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Add 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Flat Details</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Details</a></li>
			</ul>
			<form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="flat_id" id="flat_id" value="<% out.print(flat_id);%>"/>
										<input type="hidden" name="floor_id" id="floor_id" value="<% out.print(builderFlat.getBuilderFloor().getId());%>"/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="flat_no" name="flat_no" value="<% out.print(builderFlat.getFlatNo()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat Type <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select id="flat_type_id" name="flat_type_id" class="form-control">
															<% for(BuilderFlatType builderFlatType :builderFlatTypes) { %>
															<option value="<% out.print(builderFlatType.getId());%>" <% if(builderFlat.getBuilderFlatType().getId() == builderFlatType.getId()) { %>selected<% } %>><% out.print(builderFlatType.getName());%> - <% if(builderFlatType.getFloorUsed() == 2) { %>Even<% } else { %>Odd<% } %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Floor No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="floor_no" name="floor_no" value="<% out.print(builderFlat.getBuilderFloor().getName()); %>" disabled="disabled" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="building_name" name="building_name" value="<% out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Project Name </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="project_name" name="project_name" value="<% out.print(builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bedrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bedroom" name="bedroom" value="<% out.print(builderFlat.getBedroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bathrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bathroom" name="bathroom" value="<% out.print(builderFlat.getBathroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="balcony" name="balcony" value="<% out.print(builderFlat.getBalcony()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Possession Date <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="<% if(builderFlat.getPossessionDate() != null) { out.print(dt1.format(builderFlat.getPossessionDate()));}%>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Status </label>
													<div class="col-sm-7">
														<select id="status" name="status" class="form-control">
															<% for(BuilderFlatStatus builderFlatStatus :builderFlatStatuses) { %>
															<option value="<% out.print(builderFlatStatus.getId());%>" <% if(builderFlat.getBuilderFlatStatus().getId() ==  builderFlatStatus.getId()) { %>selected<% } %>><% out.print(builderFlatStatus.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-12">
												<hr/>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Flat Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) {  
															String is_checked = "";
															for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
																if(flatAmenityInfo.getBuilderFlatAmenity().getId() == builderFlatAmenity.getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFlatAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderFlatAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" class="btn btn-success btn-sm" onclick="showDetailTab();">Next</button>
								</span>
							</div>
						</div>
					</div>
					<div id="payment" class="tab-pane fade">
						<input type="hidden" name="schedule_count" id="schedule_count" value="<% out.print(flatPaymentSchedules.size() + 1);%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% for(FlatPaymentSchedule flatPaymentSchedule : flatPaymentSchedules) { %>
											<div class="row" id="schedule-<% out.print(flatPaymentSchedule.getId());%>">
												<input type="hidden" name="payment_id[]" value="<% out.print(flatPaymentSchedule.getId()); %>" />
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% out.print(flatPaymentSchedule.getMilestone());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value="<% out.print(flatPaymentSchedule.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value="<% out.print(flatPaymentSchedule.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:deletePayment(<% out.print(flatPaymentSchedule.getId());%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% } %>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="flooradd" class="btn btn-success btn-sm" >Submit</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#possession_date').datepicker({
	format: "dd MM yyyy"
});
$('#addfloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	flat_id: {
            validators: {
                notEmpty: {
                    message: 'Flat ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Floor Name is required and cannot be empty'
                }
            }
        },
        floor_no: {
            validators: {
                notEmpty: {
                    message: 'Floor Number is required and cannot be empty'
                }
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateFlat();
});

function updateFlat() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addfloor').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project/building/floor/flat/list.jsp?floor_id="+$("#floor_id").val();
  	}
}

function deletePayment(id) {
	var flag = confirm("Are you sure ? You want to delete payment slab ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/flat/payment/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#schedule-"+id).remove();
			}
		},'json');
	}
}

function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	var html = '<div class="row" id="schedule-'+schedule_count+'"><input type="hidden" name="payment_id[]" value="0" />'
				+'<hr/>'
				+'<div class="col-lg-5 margin-bottom-5">'
				+'<div class="form-group" id="error-schedule">'
				+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
				+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-payable">'
				+'<label class="control-label col-sm-8">% of Net Payable </label>'
				+'<div class="col-sm-4">'
				+'<input type="text" class="form-control" id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="text" class="form-control" id="amount" name="amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-1">'
				+'<span><a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs">x</a></span>'
				+'</div>'
			+'</div>';
	$("#payment_schedule").append(html);
	$("#schedule_count").val(schedule_count);
}
function removeSchedule(id) {
	$("#schedule-"+id).remove();
}


function showDetailTab() {
	$('#buildingTabs a[href="#payment"]').tab('show');
}

</script>
</body>
</html>
