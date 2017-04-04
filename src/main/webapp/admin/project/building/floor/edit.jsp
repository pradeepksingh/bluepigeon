<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FloorLayoutImage"%>
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
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingFloorById(floor_id);
	if(builderFloors.size() > 0) {
		builderFloor = builderFloors.get(0);
	}
	List<FloorAmenityInfo> floorAmenityInfos = new ProjectDAO().getBuildingFloorAmenityInfo(floor_id);
	List<FloorLayoutImage> floorLayoutImages = new ProjectDAO().getBuildingFloorPlanInfo(floor_id);
	List<BuilderFloorStatus> builderFloorStatuses = new BuilderFloorStatusDAO().getFloorStatus();
	List<BuilderFloorAmenity> builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderFloorAmenityList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Floor</a></li>
				<li class="active">Update</li>
			</ul>
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
			</ul>
			<form id="updatefloor" name="updatefloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderFloor.getBuilderBuilding().getId());%>"/>
										<input type="hidden" name="floor_id" id="floor_id" value="<% out.print(floor_id);%>"/>
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
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="building_name" name="building_name" value="<% out.print(builderFloor.getBuilderBuilding().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Project Name </label>
													<div class="col-sm-6">
														<input type="text" class="form-control" id="project_name" name="project_name" value="<% out.print(builderFloor.getBuilderBuilding().getBuilderProject().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-6">Status </label>
													<div class="col-sm-6">
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
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
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

</script>
</body>
</html>