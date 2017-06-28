<%@page import="org.bluepigeon.admin.model.BuildingPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenitySubstages"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../../head.jsp"%>
<%@include file="../../../../../leftnav.jsp"%>
<%
	int floor_id = 0;
	int p_user_id = 0;
	int building_id = 0;
	int project_id = 0;
	List<BuildingPaymentInfo> buildingPaymentInfos = null;
	floor_id = Integer.parseInt(request.getParameter("floor_id"));
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
	BuilderFloor builderFloor = null;
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> floors = null;
	List<BuilderBuildingFlatType> builderFlatTypes = null;
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingFloorById(floor_id);
	if(builderFloors.size() > 0) {
		builderFloor = builderFloors.get(0);
		building_id = builderFloor.getBuilderBuilding().getId();
		project_id = builderFloor.getBuilderBuilding().getBuilderProject().getId();
		buildings = new ProjectDAO().getBuilderProjectBuildings(builderFloor.getBuilderBuilding().getBuilderProject().getId());
		floors = new ProjectDAO().getBuildingFloors(builderFloor.getBuilderBuilding().getId());
		builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeByBuildingId(builderFloor.getBuilderBuilding().getId());
		buildingPaymentInfos = new ProjectDAO().getBuilderBuildingPaymentInfoById(building_id);
	}
	List<BuilderFlatStatus> builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderFlatStatus();
	List<BuilderFlatAmenity> builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderActiveFlatAmenityList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/list.jsp">Floor</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/flat/list.jsp">Flat</a></li>
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
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="flat_no" name="flat_no" value="" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Project Name </label>
													<div class="col-sm-6">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == project_id) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<select id="building_id" name="building_id" class="form-control">
															<% if(buildings != null) { %>
															<% for(BuilderBuilding builderBuilding2 :buildings) { %>
															<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Building</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Floor No. </label>
													<div class="col-sm-7">
														<select id="floor_id" name="floor_id" class="form-control">
															<% if(floors != null) { %>
															<% for(BuilderFloor builderFloor2 :floors) { %>
															<option value="<% out.print(builderFloor2.getId());%>" <% if(builderFloor2.getId() == floor_id) { %>selected<% } %>><% out.print(builderFloor2.getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Floor</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat Type <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select id="flat_type_id" name="flat_type_id" class="form-control">
															<% if(builderFlatTypes != null) { %>
															<% for(BuilderBuildingFlatType builderFlatType :builderFlatTypes) { %>
															<option value="<% out.print(builderFlatType.getBuilderFlatType().getId());%>"><% out.print(builderFlatType.getBuilderFlatType().getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Flat Type</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bedrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bedroom" name="bedroom" value="" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Bathrooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bathroom" name="bathroom" value="" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="balcony" name="balcony" value="" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Possession Date <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="" />
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
															<option value="<% out.print(builderFlatStatus.getId());%>"><% out.print(builderFlatStatus.getName()); %></option>
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
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) {  %>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFlatAmenity.getId());%>" /> <% out.print(builderFlatAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Flat Amenities Weightage </label>
													<div class="col-sm-10">
														<% 	for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) { 
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderFlatAmenity.getId());%>" style="display:none;margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderFlatAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="number" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFlatAmenity.getId());%>" placeholder="Amenity Weightage" value="">
																</div>
															</div>
															<% 	for(BuilderFlatAmenityStages bpaStages :builderFlatAmenity.getBuilderFlatAmenityStageses()) { 
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(builderFlatAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="number" class="form-control" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value=""/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderFlatAmenitySubstages bpaSubstage :bpaStages.getBuilderFlatAmenitySubstageses()) { 
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="number" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value=""/>
																		</div>
																	<% } %>
																	</fieldset>
																</div>
															</fieldset>
															<% } %>
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
									<button type="submit" name="flooradd" class="btn btn-success btn-sm">Submit</button>
								</span>
							</div>
						</div>
					</div>
					<div id="payment" class="tab-pane fade">
					
						<input type="hidden" name="schedule_count" id="schedule_count" value="1"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
			 				<%
							if(buildingPaymentInfos != null){
								for(BuildingPaymentInfo  buildingPaymentInfo: buildingPaymentInfos){ %>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<div class="row" id="schedule-1">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value="<%out.print(buildingPaymentInfo.getMilestone());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="number" class="form-control" id="payable" name="payable[]" value="<%out.print(buildingPaymentInfo.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="number" class="form-control" id="amount" name="amount[]" value="<%out.print(buildingPaymentInfo.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
<!-- 												<div class="col-lg-1"> -->
<!-- 													<span><a href="javascript:removeSchedule(1);" class="btn btn-danger btn-xs">x</a></span> -->
<!-- 												</div> -->
											</div>
										</div>
										<div>
<!-- 											<div class="col-lg-12"> -->
<!-- 												<span class="pull-right"> -->
<!-- 													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a> -->
<!-- 												</span> -->
<!-- 											</div> -->
										</div>
									</div>
								</div>
							</div>
							<%	
								}
							}else{
							%>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<div class="row" id="schedule-1">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="number" class="form-control" id="payable" name="payable[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="number" class="form-control" id="amount" name="amount[]" value=""/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
<!-- 												<div class="col-lg-1"> -->
<!-- 													<span><a href="javascript:removeSchedule(1);" class="btn btn-danger btn-xs">x</a></span> -->
<!-- 												</div> -->
											</div>
										</div>
										<div>
<!-- 											<div class="col-lg-12"> -->
<!-- 												<span class="pull-right"> -->
<!-- 													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a> -->
<!-- 												</span> -->
<!-- 											</div> -->
										</div>
									</div>
								</div>
							</div>
							
							<%} %>
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
	fieldset.scheduler-border {
	    border: 1px groove #ddd !important;
	    padding: 0 1.4em 1.4em 1.4em !important;
	    margin: 0 0 1.5em 0 !important;
	    -webkit-box-shadow:  0px 0px 0px 0px #000;
	            box-shadow:  0px 0px 0px 0px #000;
	}
	legend.scheduler-border {
	    width:inherit; /* Or auto */
	    padding:0 10px; /* To give a bit of padding on the left and right */
	    border-bottom:none;
	    margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#flat_no').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#bedroom').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#bathroom').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#balcony').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#floor_no').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
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
    	building_id: {
            validators: {
                notEmpty: {
                    message: 'Building ID is required and cannot be empty'
                }
            }
        },
        flat_no: {
            validators: {
                notEmpty: {
                    message: 'Flat Number is required and cannot be empty'
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
        'amenity_type[]': {
        	validators: {
                notEmpty: {
                    message: 'Please select amenity'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addFloor();
});

function addFloor() {
	var amenityWeightage = "";
	$('input[name="amenity_type[]"]:checked').each(function() {
		amenity_id = $(this).val();
		$('input[name="stage_weightage'+amenity_id+'[]"]').each(function() {
			stage_id = $(this).attr("id");
			stage_weightage = $(this).val();
			$('input[name="substage'+stage_id+'[]"]').each(function() {
				if(amenityWeightage != "") {
					amenityWeightage = amenityWeightage + "," + amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				} else {
					amenityWeightage = amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				}
			});
		});
	});
	$("#amenity_wt").val(amenityWeightage);
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/add',
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


function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	var html = '<div class="row" id="schedule-'+schedule_count+'">'
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
				+'<input type="number" class="form-control" id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="number" class="form-control" id="amount" name="amount[]" value=""/>'
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
$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
	
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/floor/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Floor</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#floor_id").html(html);
	},'json');
	$.get("${baseUrl}/webapi/project/building/flattype/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Flat Type</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#flat_type_id").html(html);
	},'json');
	
});
$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});
</script>
</body>
</html>
