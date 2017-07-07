<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FloorLayoutImage"%>
<%@page import="org.bluepigeon.admin.model.FloorStage"%>
<%@page import="org.bluepigeon.admin.model.FloorSubstage"%>
<%@page import="org.bluepigeon.admin.model.FloorWeightage"%>
<%@page import="org.bluepigeon.admin.dao.FloorStageDAO"%>
<%@page import="org.bluepigeon.admin.dao.FloorSubstagesDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int floor_id = 0;
	int p_user_id = 0;
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
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingFloorById(floor_id);
	if(builderFloors.size() > 0) {
		builderFloor = builderFloors.get(0);
		buildings = new ProjectDAO().getBuilderProjectBuildings(builderFloor.getBuilderBuilding().getBuilderProject().getId());
	}
	List<FloorAmenityInfo> floorAmenityInfos = new ProjectDAO().getBuildingFloorAmenityInfo(floor_id);
	List<FloorLayoutImage> floorLayoutImages = new ProjectDAO().getBuildingFloorPlanInfo(floor_id);
	List<BuilderFloorStatus> builderFloorStatuses = new BuilderFloorStatusDAO().getFloorStatus();
	List<BuilderFloorAmenity> builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderActiveFloorAmenityList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderAllProjects();
	List<FloorAmenityWeightage> floorAmenityWeightages = new ProjectDAO().getFloorAmenityWeightages(floor_id);
	List<FloorStage> floorStages = new FloorStageDAO().getActiveFloorStages();
	List<FloorWeightage> floorWeightages = new ProjectDAO().getFloorWeightage(floor_id);
	List<BuilderFlat> builderFlats = new ProjectDAO().getActiveFlatByFloorId(floor_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li><a href="${baseUrl}/admin/project/building/floor/list.jsp">Floor</a></li>
				<li class="active">Update</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp"> << Project List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Floor Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Floor Details</a></li>
			  	<li><a data-toggle="tab" href="#floorimages">Floor Layouts</a></li>
			  	<li><a data-toggle="tab" href="#productsubstage">Floor Amenity</a></li>
			</ul>
			<form id="updatefloor" name="updatefloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="floor_id" id="floor_id" value="<% out.print(floor_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Floor No. <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="floor_no" name="floor_no" value="<% out.print(builderFloor.getFloorNo()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Floor Name <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderFloor.getName()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Project Name </label>
													<div class="col-sm-7">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderFloor.getBuilderBuilding().getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
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
															<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == builderFloor.getBuilderBuilding().getId()) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
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
													<label class="control-label col-sm-5">Status </label>
													<div class="col-sm-7">
														<select id="status" name="status" class="form-control">
															<% for(BuilderFloorStatus builderFloorStatus :builderFloorStatuses) { %>
															<option value="<% out.print(builderFloorStatus.getId());%>" <% if(builderFloor.getBuilderFloorStatus().getId() == builderFloorStatus.getId()) { %>selected<% } %>><% out.print(builderFloorStatus.getName()); %></option>
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
													<label class="control-label col-sm-2">Floor Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderFloorAmenity builderFloorAmenity :builderFloorAmenities) { 
															String is_checked = "";
															for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
																if(floorAmenityInfo.getBuilderFloorAmenity().getId() == builderFloorAmenity.getId()) {
																	is_checked = "checked";
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderFloorAmenity.getId());%>" <% out.print(is_checked); %>/> <% out.print(builderFloorAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-amenity_type">
													<label class="control-label col-sm-2">Floor Amenities Weightage </label>
													<div class="col-sm-10">
														<% 	for(BuilderFloorAmenity builderFloorAmenity : builderFloorAmenities) { 
															String is_checked = "";
															if(floorAmenityInfos.size() > 0) { 
																for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
																	if(floorAmenityInfo.getBuilderFloorAmenity().getId() == builderFloorAmenity.getId()) {
																		is_checked = "checked";
																	}
																}
															}
															Double amenity_wt = 0.0;
															for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																if(builderFloorAmenity.getId() == floorAmenityWeightage.getBuilderFloorAmenity().getId()) {
																	amenity_wt = floorAmenityWeightage.getAmenityWeightage();
																}
															}
														%>
														<div class="col-sm-12" id="amenity_stage<% out.print(builderFloorAmenity.getId());%>" style="<% if(is_checked == "checked") {%>display:block;<% } else { %>display:none;<% } %>margin-bottom:5px;">
															<div class="row">
																<label class="control-label col-sm-3" style="padding-top:5px;text-align:left;"><strong><% out.print(builderFloorAmenity.getName());%> (%)</strong></label>
																<div class="col-sm-4">
																	<input type="text" class="form-control errorMsg" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFloorAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
																</div>
															</div>
															<% 	for(BuilderFloorAmenityStages bpaStages :builderFloorAmenity.getBuilderFloorAmenityStageses()) { 
																Double stage_wt = 0.0;
																for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																	if(bpaStages.getId() == floorAmenityWeightage.getBuilderFloorAmenityStages().getId()) {
																		stage_wt = floorAmenityWeightage.getStageWeightage();
																	}
																}
															%>
															<fieldset class="scheduler-border">
																<legend class="scheduler-border">Stages</legend>
																<div class="col-sm-12">
																	<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(bpaStages.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage<% out.print(builderFloorAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="text" class="form-control errorMsg" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																	<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																		<legend class="scheduler-border">Sub Stages</legend>
																	<% 	for(BuilderFloorAmenitySubstages bpaSubstage :bpaStages.getBuilderFloorAmenitySubstageses()) { 
																		Double substage_wt = 0.0;
																		for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
																			if(bpaSubstage.getId() == floorAmenityWeightage.getBuilderFloorAmenitySubstages().getId()) {
																				substage_wt = floorAmenityWeightage.getSubstageWeightage();
																			}
																		}
																	%>
																		<div class="col-sm-3">
																			<% out.print(bpaSubstage.getName()); %> (%)<br>
																			<input type="text" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control errorMsg" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
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
									<button type="button" class="btn btn-success btn-sm" onclick="showDetailTab();">Next</button>
								</span>
							</div>
						</div>
					</div>
					<div id="floorimages" class="tab-pane fade">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Floor Plans</h3>
										<br>
										<div class="row" id="project_images">
											<% for (FloorLayoutImage floorLayoutImage :floorLayoutImages) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(floorLayoutImage.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(floorLayoutImage.getLayout()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(floorLayoutImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Plan</a> </label>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<% } %>
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id="building_image" name="building_image[]" />
														<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a></span>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<span class="pull-right"><a href="javascript:addMoreImages();" class="btn btn-info btn-xs"> + Add More</a></span>
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
					<div id="productsubstage" class="tab-pane fade">
						<form id="subpfrm" name="subpfrm" method="post">
				 			<div class="row">
								<div class="col-lg-12">
									<div class="panel panel-default">
										<div class="panel-body">
											<div id="offer_area">
												<div class="row">
													<div class="col-lg-12 margin-bottom-5">
														<div class="row" id="error-amenity_type">
															<div class="col-sm-6">
																<div class="form-group" id="error-amenity_weightage">
																	<label class="control-label col-sm-6">Amenity Weightage </label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control" id="amenity_weightage" name="amenity_weightage" value="<%out.print(builderFloor.getAmenityWeightage());%>" placeholder="amenity weightage in %"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="row" id="error-amenity_type">
															<div class="col-sm-6">
																<div class="form-group" id="error-discount_amount">
																	<label class="control-label col-sm-6">Flat Weightage</label>
																	<div class="col-sm-6">
																		<input type="text" class="form-control" id="flat_weightage" name="flat_weightage" value="<%out.print(builderFloor.getFlatWeightage());%>"/>
																	</div>
																	<div class="messageContainer"></div>
																</div>
															</div>
														</div>
														<div class="col-sm-12">
															<label class="control-label col-sm-2">Flats</label>
														</div>
														<%
														  if(builderFlats != null){
															  for(BuilderFlat builderFlat : builderFlats ){
														%>
														<input type="hidden" id="flat_ids" name="flat_ids[]" value="<%out.print(builderFlat.getId());%>">
														<div class="col-sm-4 margin-bottom-5">
															<div class="form-group" id="error-discount_amount">
																<label class="control-label col-sm-6"><%out.print(builderFlat.getFlatNo()); %></label>
																<div class="col-sm-6">
																	<input type="text" class="form-control" id="weightage[]" name="weightage[]" value="<%out.print(builderFlat.getWeightage());%>"/>
																</div>
																<div class="messageContainer"></div>
															</div>
														</div>	  
														<%	  }
														  }
														%>
													</div>
														<div class="form-group" id="error-amenity_type">
															<div class="col-sm-12">
																<% 	for(FloorStage floorStage :floorStages) { 
																	Double stage_wt = 0.0;
																	for(FloorWeightage floorWeightage :floorWeightages) {
																		if(floorStage.getId() == floorWeightage.getFloorStage().getId()) {
																			stage_wt = floorWeightage.getStageWeightage();
																		}
																	}
																%>
																<fieldset class="scheduler-border">
																	<legend class="scheduler-border">Stages</legend>
																	<div class="col-sm-12">
																		<div class="row"><label class="col-sm-3" style="padding-top:5px;"><b><% out.print(floorStage.getName()); %> (%)</b> - </label><div class="col-sm-4"><input name="stage_weightage[]" id="<% out.print(floorStage.getId());%>" type="text" class="form-control" placeholder="Project Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/></div></div>
																		<fieldset class="scheduler-border" style="margin-bottom:0px !important">
																			<legend class="scheduler-border">Sub Stages</legend>
																		<% 	for(FloorSubstage floorSubstage :floorStage.getFloorSubstages()) { 
																			Double substage_wt = 0.0;
																			for(FloorWeightage floorWeightage :floorWeightages) {
																				if(floorSubstage.getId() == floorWeightage.getFloorSubstage().getId()) {
																					substage_wt = floorWeightage.getSubstageWeightage();
																				}
																			}
																		%>
																			<div class="col-sm-3">
																				<% out.print(floorSubstage.getName()); %> (%)<br>
																				<input type="text" name="substage_weightage<% out.print(floorStage.getId());%>[]" id="<% out.print(floorSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
																			</div>
																		<% } %>
																		</fieldset>
																	</div>
																</fieldset>
																<% } %>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
											</div>
											<div>
												<div class="row">
													<div class="col-lg-12">
														<div class="col-sm-12">
															<button type="button" class="btn btn-success btn-sm" id="subpbtn">UPDATE</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>	
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../../../footer.jsp"%>
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
$(".errorMsg").keypress(function(event){
	return isNumber(event, this)
});

$('#floor_no').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9- ]/g, function(str) { alert('Please use only letters and numbers.'); return ''; } ) );
});
$('#amenity_weightage').keypress(function (event) {
    return isNumber(event, this)
});
$('#flat_weightage').keypress(function (event) {
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
$('#updatefloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	floor_id: {
            validators: {
                notEmpty: {
                    message: 'Floor ID is required and cannot be empty'
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
	 		url : '${baseUrl}/webapi/project/building/floor/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatefloor').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/project/building/floor/list.jsp?building_id="+$("#building_id").val();
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete plan ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/plan/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function addMoreImages() {
	var img_count = parseInt($("img_count").val());
	img_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="building_image" name="building_image[]" />'
					+'<a href="javascript:removeImage('+img_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#project_images").append(html);
	$("#img_count").val(img_count);
}

function removeImage(id) {
	$("#imgdiv-"+id).remove();
}


function showDetailTab() {
	$('#buildingTabs a[href="#floorimages"]').tab('show');
}
$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = "";
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
	
});
$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

$("#subpbtn").click(function(){
	var amenityWeightage = [];
	var flats = [];
	var flat_id = [];
	$('input[name="stage_weightage[]"]').each(function() {
		stage_id = $(this).attr("id");
		stage_weightage = $(this).val();
		$('input[name="substage_weightage'+stage_id+'[]"]').each(function() {
			amenityWeightage.push({builderFloor:{id:$("#floor_id").val()},floorStage:{id:stage_id},stageWeightage:stage_weightage,floorSubstage:{id:$(this).attr("id")},substageWeightage:$(this).val(),status:false});
		});
	});
	
	$('input[name="flat_ids[]"]').each(function(index){
		flat_id.push($(this).val());
	});
	
	$('input[name="weightage[]"]').each(function(index){
		flats.push({id:flat_id[index],weightage:$(this).val()});
	});
	var floors = {id:$("#floor_id").val(),amenityWeightage : $("#amenity_weightage").val(),flatWeightage:$("#flat_weightage").val()};
	var final_data = {floorId: $("#floor_id").val(),floorWeightages:amenityWeightage, builderFloor:floors,builderFlats : flats};
	$.ajax({
	    url: '${baseUrl}/webapi/project/floor/substage/update',
	    type: 'POST',
	    data: JSON.stringify(final_data),
	    contentType: 'application/json; charset=utf-8',
	    dataType: 'json',
	    async: false,
	    success: function(data) {
			if (data.status == 0) {
				alert(data.message);
			} else {
				alert(data.message);
			}
		},
		error : function(data)
		{
			alert("Fail to save data");
		}
		
	});
});

</script>
</body>
</html>
