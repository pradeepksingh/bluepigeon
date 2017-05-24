<%@page import="org.bluepigeon.admin.data.ProjectData"%>
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
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	int floor_id = 0;
	int p_user_id = 0;
	floor_id = Integer.parseInt(request.getParameter("floor_id"));
	session = request.getSession(false);
	Builder adminuserproject = new Builder();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (Builder)session.getAttribute("ubname");
			p_user_id = adminuserproject.getId();
		}
	}
	BuilderFloor builderFloor = null;
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> builderFloors = new ProjectDAO().getBuildingActiveFloorById(floor_id);
	if(builderFloors.size() > 0) {
		builderFloor = builderFloors.get(0);
		buildings = new ProjectDAO().getBuilderActiveProjectBuildings(builderFloor.getBuilderBuilding().getBuilderProject().getId());
	}
	List<FloorAmenityInfo> floorAmenityInfos = new ProjectDAO().getBuildingFloorAmenityInfo(floor_id);
	List<FloorLayoutImage> floorLayoutImages = new ProjectDAO().getBuildingFloorPlanInfo(floor_id);
	List<BuilderFloorStatus> builderFloorStatuses = new BuilderFloorStatusDAO().getActiveFloorStatus();
	List<BuilderFloorAmenity> builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderActiveFloorAmenityList();
	List<ProjectData> builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(p_user_id);
	List<FloorAmenityWeightage> floorAmenityWeightages = new ProjectDAO().getActiveFloorAmenityWeightages(floor_id);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="../../../css/colors/megna.css" id="theme" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../../css/custom.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    <!-- jQuery -->
    <script src="../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
      <script src="../../../js/jquery.form.js"></script>
    <script src="../../../js/bootstrap-datepicker.min.js"></script>
  <script src="../../../js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
    $('input[type=checkbox]').click(function() {
        if ($(this).is(':checked')) {
            var tb = $('<input type=text />');
            $(this).after(tb);
        } else if ($(this).siblings('input[type=text]').length > 0) {
            $(this).siblings('input[type=text]').remove();
        }
    })
    </script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <div id="header">
        <%@include file="../../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../../partial/sidebar.jsp"%>
       </div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Floor Update</h4>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box"><br>
                             <div class="col-12">
                                  <form id="updatefloor" name="updatefloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
										<input type="hidden" name="floor_id" id="floor_id" value="<% out.print(floor_id);%>"/>
										<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
                                        <div class="form-group row">
                                            <label for="example-text-input" class="col-4 col-form-label">Floor Name</label>
                                            <div class="col-8">
                                                <input class="form-control" type="text" id="name" name="name" value="<% out.print(builderFloor.getName()); %>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="example-search-input" class="col-4 col-form-label">Floor No.</label>
                                            <div class="col-8">
                                                <div class="input-group bootstrap-touchspin"><input type="text" id="floor_no" name="floor_no" value="<% out.print(builderFloor.getFloorNo()); %>" ></div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="example-text-input" class="col-4 col-form-label">Project Name</label>
                                            <div class="col-8">
                                               <select id="project_id" name="project_id" class="form-control">
													<option value="0">Select Project</option>
													<% for(ProjectData builderProject :builderProjects) { %>
													<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderFloor.getBuilderBuilding().getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
													<% } %>
												</select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="example-text-input" class="col-4 col-form-label">Building Name</label>
                                            <div class="col-8">
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
                                        </div>
                                        <div class="form-group row">
                                            <label for="example-text-input" class="col-4 col-form-label">Status</label>
                                            <div class="col-8">
                                               <select id="status" name="status" class="form-control">
													<% for(BuilderFloorStatus builderFloorStatus :builderFloorStatuses) { %>
													<option value="<% out.print(builderFloorStatus.getId());%>" <% if(builderFloor.getBuilderFloorStatus().getId() == builderFloorStatus.getId()) { %>selected<% } %>><% out.print(builderFloorStatus.getName()); %></option>
													<% } %>
												</select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="example-text-input" class="col-4 col-form-label">Floor Amenities</label>
                                            <div class="col-8">
                                              <% 	for(BuilderFloorAmenity builderFloorAmenity :builderFloorAmenities) { 
													String is_checked = "";
													for(FloorAmenityInfo floorAmenityInfo :floorAmenityInfos) {
														if(floorAmenityInfo.getBuilderFloorAmenity().getId() == builderFloorAmenity.getId()) {
															is_checked = "checked";
														}
													}
											 %>
												<div class="checkbox checkbox-inverse">
													<input id="checkbox1c" type="checkbox" name="amenity_type[]" value="<% out.print(builderFloorAmenity.getId());%>" <% out.print(is_checked); %>/> <label for="checkbox1c"><% out.print(builderFloorAmenity.getName());%></label>
												</div>
											<% } %>
                                            </div>
                                        </div>
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
										<input type="hidden" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFloorAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
										<% 	for(BuilderFloorAmenityStages bpaStages :builderFloorAmenity.getBuilderFloorAmenityStageses()) { 
											Double stage_wt = 0.0;
											for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
												if(bpaStages.getId() == floorAmenityWeightage.getBuilderFloorAmenityStages().getId()) {
													stage_wt = floorAmenityWeightage.getStageWeightage();
												}
											}
										%>
										<input name="stage_weightage<% out.print(builderFloorAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="hidden" class="form-control" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/>
										<% 	for(BuilderFloorAmenitySubstages bpaSubstage :bpaStages.getBuilderFloorAmenitySubstageses()) { 
											Double substage_wt = 0.0;
											for(FloorAmenityWeightage floorAmenityWeightage :floorAmenityWeightages) {
												if(bpaSubstage.getId() == floorAmenityWeightage.getBuilderFloorAmenitySubstages().getId()) {
													substage_wt = floorAmenityWeightage.getSubstageWeightage();
												}
											}
										%>
										<input type="hidden" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
										<% } %>
										<% } %>
										<% } %>
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
										<div class="row">
											<span class="pull-right"><a href="javascript:addMoreImages();" class="btn btn-info btn-ms"> + Add More</a></span>
										</div>
									</div>
                                          <button type="submit" name="floorupdate" class="btn btn-success waves-effect waves-light m-r-10">Update</button>
                                   </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
     <div id="sidebar1"> 
      	<%@include file="../../../partial/footer.jsp"%>
	</div> 
</body>

</html>
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
        window.location.href = "${baseUrl}/builder/project/building/floor/list.jsp?building_id="+$("#building_id").val();
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
</script>