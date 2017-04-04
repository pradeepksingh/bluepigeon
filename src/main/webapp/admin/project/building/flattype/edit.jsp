<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatType"%>
<%@page import="org.bluepigeon.admin.model.FlatTypeImage"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int flat_type_id = 0;
	int p_user_id = 0;
	flat_type_id = Integer.parseInt(request.getParameter("flat_type_id"));
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
	BuilderFlatType builderFlatType = null;
	List<BuilderFlatType> builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeById(flat_type_id);
	if(builderFlatTypes.size() > 0) {
		builderFlatType = builderFlatTypes.get(0);
	}
	List<BuilderProjectPropertyConfiguration> projectConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderProjectConfigurations();
	List<FlatTypeImage> flatTypeImages = new ProjectDAO().getBuildingFlatTypeImages(flat_type_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Flat Type</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Type Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Flat Type Details</a></li>
			  	<li><a data-toggle="tab" href="#floorimages">Flat Type Images</a></li>
			</ul>
			<form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="flat_type_id" id="flat_type_id" value="<% out.print(flat_type_id);%>"/>
										<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderFlatType.getBuilderBuilding().getId());%>"/>
										<input type="hidden" name="project_id" id="project_id" value="<% out.print(builderFlatType.getBuilderBuilding().getBuilderProject().getId());%>"/>
										<input type="hidden" name="img_count" id="img_count" value="<% out.print(flatTypeImages.size()+1); %>"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Flat Type <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderFlatType.getName()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="building_name" name="building_name" value="<% out.print(builderFlatType.getBuilderBuilding().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Project Name </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="project_name" name="project_name" value="<% out.print(builderFlatType.getBuilderBuilding().getBuilderProject().getName()); %>" disabled="disabled"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Flat Area <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="floor_area" name="floor_area" value="<% out.print(builderFlatType.getFloorArea()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Floor Used </label>
													<div class="col-sm-7">
														<select id="floor_used" name="floor_used" class="form-control">
															<option value="1" <% if(builderFlatType.getFloorUsed() == 1) { %>selected<% } %>>Odd Floor</option>
															<option value="2" <% if(builderFlatType.getFloorUsed() == 2) { %>selected<% } %>>Even Floor</option>
															<option value="3" <% if(builderFlatType.getFloorUsed() == 3) { %>selected<% } %>>Single Floor</option>
															<option value="4" <% if(builderFlatType.getFloorUsed() == 4) { %>selected<% } %>>All Floor</option>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Configuration <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select name="config_id" id="config_id" class="form-control">
														<% for(BuilderProjectPropertyConfiguration builderProjectPropertyConfiguration :projectConfigurations) { %>
															<option value="<% out.print(builderProjectPropertyConfiguration.getId()); %>" <% if(builderFlatType.getBuilderProjectPropertyConfiguration().getId() == builderProjectPropertyConfiguration.getId()) { %>selected<% } %>><% out.print(builderProjectPropertyConfiguration.getName()); %></option>
														<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
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
										<h3>Upload Flat Type Images</h3>
										<br>
										<div class="row" id="project_images">
											<% for (FlatTypeImage flatTypeImage :flatTypeImages) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(flatTypeImage.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(flatTypeImage.getImage()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(flatTypeImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
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
    	name: {
            validators: {
                notEmpty: {
                    message: 'Flat Type is required and cannot be empty'
                }
            }
        },
        floor_area: {
            validators: {
                notEmpty: {
                    message: 'Floor Area is required and cannot be empty'
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
	 		url : '${baseUrl}/webapi/project/building/flattype/update',
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
        window.location.href = "${baseUrl}/admin/project/building/flattype/list.jsp?building_id="+$("#building_id").val();
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

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/flattype/image/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

</script>
</body>
</html>
