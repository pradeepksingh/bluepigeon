<%@page import="org.bluepigeon.admin.model.BuildingImageGallery"%>
<%@page import="org.bluepigeon.admin.model.BuildingPanoramicImage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.BuildingAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.BuildingStage"%>
<%@page import="org.bluepigeon.admin.model.BuildingSubstage"%>
<%@page import="org.bluepigeon.admin.model.BuildingWeightage"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getCountryList();
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	List<BuildingAmenityWeightage> amenityWeightages = new ArrayList<BuildingAmenityWeightage>();
	List<BuildingImageGallery> imageGaleries = new ArrayList<BuildingImageGallery>();
	List<BuildingPanoramicImage> panoromicImages = new ArrayList<BuildingPanoramicImage>();
	List<BuildingWeightage> buildingWeightages = new ArrayList<BuildingWeightage>();
	int p_user_id = 0;
	int building_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
   	}
	if (request.getParameterMap().containsKey("building_id")) {
		building_id = Integer.parseInt(request.getParameter("building_id"));
		amenityWeightages = new ProjectDAO().getBuilderBuildingAmenityWeightageById(building_id);
		imageGaleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
		panoromicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
		buildingWeightages = new ProjectDAO().getBuildingWeightage(building_id);
	}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/list.jsp">Project</a></li>
				<li class="active">Updates</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Updates 
					<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp" class="btn btn-default btn-sm"> << Project List</a></span>
				</h1>
			</div>
			<form id="addproject" name="addproject" action="" method="post" enctype="multipart/form-data">
				<div id="basic" class="tab-pane fade in active">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
									<input type="hidden" name="building_id" id="building_id" value="<% out.print(building_id);%>"/>
									<input type="hidden" name="img_count" id="img_count" value="29999999999"/>
									<input type="hidden" name="elvimg_count" id="elvimg_count" value="299999999999"/>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-name">
												<label class="control-label col-sm-12">Amenities <span class='text-danger'>*</span></label>
												<div class="col-sm-12">
													<% 	
													int amenity_id = 0;
													int stage_id = 0;
													for(BuildingAmenityWeightage buildingAmenityWeightage :amenityWeightages) { 
														String is_checked = "";
													%>
													<% if(amenity_id == 0 || amenity_id != buildingAmenityWeightage.getBuilderBuildingAmenity().getId()) { stage_id = 0; %>
													<% if(amenity_id != 0) {%>
																	</div>
																</div>
															</div>
														</div>
													</div>
													<% } %>
													<div class="col-sm-12" style="margin-bottom:5px;">
														<div class="row">
															<label class="control-label col-sm-2" style="padding-top:5px;"><strong><% out.print(buildingAmenityWeightage.getBuilderBuildingAmenity().getName());%></strong></label>
															<div class="col-sm-10">
													<% } %>
													<% if(stage_id == 0 || stage_id != buildingAmenityWeightage.getBuilderBuildingAmenityStages().getId()) { %>
													<% if(stage_id != 0) {%>
																	</div>
																</div>
													<% } %>
																<div class="row">
																	<label class="control-label col-sm-3" style="padding-top:5px;"><strong><% out.print(buildingAmenityWeightage.getBuilderBuildingAmenityStages().getName());%></strong></label>
																	<div class="col-sm-9">
													<% } %>
																		<div class="col-sm-4">
																			<input type="checkbox" name="substagewt_id[]" value="<% out.print(buildingAmenityWeightage.getId());%>" <% if(buildingAmenityWeightage.isStatus()) { %>checked<% } %>/> <% out.print(buildingAmenityWeightage.getBuilderBuildingAmenitySubstages().getName());%>
																		</div>
													<% 
													amenity_id = buildingAmenityWeightage.getBuilderBuildingAmenity().getId();
													stage_id = buildingAmenityWeightage.getBuilderBuildingAmenityStages().getId();
													} 
													%>
												</div>
											</div>
										</div>
									</div>
									<hr/>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-name">
												<label class="control-label col-sm-12"><b>Stages/Substages</b> <span class='text-danger'>*</span></label>
												<div class="col-sm-12">
													<% 	
													int sstage_id = 0;
													for(BuildingWeightage buildingWeightage :buildingWeightages) { 
														String is_checked = "";
													%>
													<% if(sstage_id == 0 || sstage_id != buildingWeightage.getBuildingStage().getId()) { %>
													<% if(sstage_id != 0) {%>
														</div>
													</div>
													<% } %>
																<div class="row">
																	<label class="control-label col-sm-3" style="padding-top:5px;"><strong><% out.print(buildingWeightage.getBuildingStage().getName());%></strong></label>
																	<div class="col-sm-9">
													<% } %>
																		<div class="col-sm-4">
																			<input type="checkbox" name="ssubstagewt_id[]" value="<% out.print(buildingWeightage.getId());%>" <% if(buildingWeightage.getStatus()) { %>checked<% } %>/> <% out.print(buildingWeightage.getBuildingSubstage().getName());%>
																		</div>
													<% 
													sstage_id = buildingWeightage.getBuildingStage().getId();
													} 
													%>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<hr/>
									<h3>Upload Building Images</h3>
									<br>
									<div class="row" id="project_images">
<%-- 										<% for (BuildingImageGallery buildingImageGallery :imageGaleries) { %> --%>
<%-- 										<div class="col-lg-6 margin-bottom-5" id="b_image<% out.print(buildingImageGallery.getId()); %>"> --%>
<!-- 											<div class="form-group" id="error-landmark"> -->
<!-- 												<div class="col-sm-12"> -->
<%-- 													<img alt="Building Images" src="${baseUrl}/<% out.print(buildingImageGallery.getImage()); %>" width="200px;"> --%>
<!-- 												</div> -->
<%-- 												<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(buildingImageGallery.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label> --%>
<!-- 												<div class="messageContainer col-sm-offset-4"></div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<%-- 										<% } %> --%>
										<div class="col-lg-6 margin-bottom-5" id="imgdiv-n2333">
											<div class="form-group" id="error-landmark">
												<label class="control-label col-sm-4">Select Image </label>
												<div class="col-sm-8 input-group" style="padding:0px 12px;">
													<input type="file" class="form-control" id="building_image" name="building_image" />
<!-- 													<a href="javascript:removeImage('n2333');" class="input-group-addon btn-danger">x</a> -->
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
<!-- 										<div class="col-lg-6 margin-bottom-5" id="imgdiv-n2334"> -->
<!-- 											<div class="form-group" id="error-landmark"> -->
<!-- 												<label class="control-label col-sm-4">Select Image </label> -->
<!-- 												<div class="col-sm-8 input-group" style="padding:0px 12px;"> -->
<!-- 													<input type="file" class="form-control" id="project_image" name="building_image[]" /> -->
<!-- 													<a href="javascript:removeImage('n2334');" class="input-group-addon btn-danger">x</a> -->
<!-- 												</div> -->
<!-- 												<div class="messageContainer col-sm-offset-3"></div> -->
<!-- 											</div> -->
<!-- 										</div> -->
									</div>
									<div class="row">
										<span class="pull-right"><a href="javascript:addMoreImages();" class="btn btn-info btn-xs"> + Add More</a></span>
									</div>
									<hr/>
									<h3>Upload Elevation Images</h3>
									<br>
									<div class="row" id="elevation_images">
										<% for (BuildingPanoramicImage buildingPanoramicImage :panoromicImages) { %>
										<div class="col-lg-6 margin-bottom-5" id="b_elv_image<% out.print(buildingPanoramicImage.getId()); %>">
											<div class="form-group" id="error-landmark">
												<div class="col-sm-12">
													<img alt="Building Images" src="${baseUrl}/<% out.print(buildingPanoramicImage.getPanoImage()); %>" width="100%;">
												</div>
												<label class="col-sm-12 text-left"><a href="javascript:deleteElvImage(<% out.print(buildingPanoramicImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<% } %>
										<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-m2333">
											<div class="form-group" id="error-landmark">
												<label class="control-label col-sm-4">Select Image </label>
												<div class="col-sm-8 input-group" style="padding:0px 12px;">
													<input type="file" class="form-control" id="elevation_image" name="elevation_image[]" />
													<a href="javascript:removeElvImage('m2333');" class="input-group-addon btn-danger">x</a>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-m2334">
											<div class="form-group" id="error-landmark">
												<label class="control-label col-sm-4">Select Image </label>
												<div class="col-sm-8 input-group" style="padding:0px 12px;">
													<input type="file" class="form-control" id="elevation_image" name="elevation_image[]" />
													<a href="javascript:removeElvImage('m2334');" class="input-group-addon btn-danger">x</a>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<span class="pull-right"><a href="javascript:addMoreElvImages();" class="btn btn-info btn-xs"> + Add More</a></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="response"></div>
				<button type="submit" class="btn btn-success">Submit</button>
				<br> <br>
			</form>
		</div>
	</div>
</div>
<br><br>
<%@include file="../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#addproject').bootstrapValidator({
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
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProject();
});

function updateProject() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/status/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addproject').ajaxSubmit(options);
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
		ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.reload();
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/image/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function deleteElvImage(id) {
	var flag = confirm("Are you sure ? You want to delete Elevation Image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/elevationimage/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_elv_image"+id).remove();
			}
		});
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
	alert(id);
	$("#imgdiv-"+id).remove();
}

function addMoreElvImages() {
	var elvimg_count = parseInt($("elvimg_count").val());
	elvimg_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-'+elvimg_count+'"><input type="hidden" name="payment_id[]" value="0" />'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="elevation_image" name="elevation_image[]" />'
					+'<a href="javascript:removeElvImage('+elvimg_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#elevation_images").append(html);
	$("#elvimg_count").val(elvimg_count);
}

function removeElvImage(id) {
	$("#elvimgdiv-"+id).remove();
}


</script>
</body>
</html>
