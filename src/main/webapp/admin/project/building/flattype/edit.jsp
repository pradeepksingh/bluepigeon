<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatType"%>
<%@page import="org.bluepigeon.admin.model.FlatTypeImage"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int flat_type_id = 0;
	int p_user_id = 0;
	int project_id = 0;
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
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderActiveProjects();
	BuilderFlatType builderFlatType = null;
	List<BuilderFlatType> builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeById(flat_type_id);
	if(builderFlatTypes.size() > 0) {
		builderFlatType = builderFlatTypes.get(0);
		project_id = builderFlatType.getBuilderProject().getId();
	}
	List<BuilderProjectPropertyConfiguration> projectConfigurations = new BuilderProjectPropertyConfigurationDAO().getBuilderActiveProjectConfigurations();
	List<FlatTypeImage> flatTypeImages = new ProjectDAO().getBuildingFlatTypeImages(flat_type_id);
	List<BuilderBuildingFlatType> builderBuildingFlatTypes = new ProjectDAO().getBuildingFlatTypes(flat_type_id);
	List<BuilderBuildingFlatTypeRoom> builderBuildingFlatTypeRooms = new ProjectDAO().getBuildingFlatTypeRooms(flat_type_id);
	List<BuilderBuilding> buildings = new ProjectDAO().getBuilderProjectBuildings(builderFlatType.getBuilderProject().getId());
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/building/flattype/list.jsp">Flat Type</a></li>
				<li class="active">Update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Flat Type Update 
				</h1>
				<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp" class="btn btn-default btn-sm"> << Project List</a></span>
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
										<input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id);%>"/>
										<input type="hidden" name="img_count" id="img_count" value="<% out.print(flatTypeImages.size()+1); %>"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Select Project <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<select id="project_id" name="project_id" class="form-control" disable>
															<option value="0">Select Project</option>
														<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId());%>" <% if(builderProject.getId() == builderFlatType.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
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
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderFlatType.getName()); %>" />
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
										<div class="row">
											<div class="col-lg-12">
												<hr>
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-2">Select Building <span class='text-danger'>*</span></label>
													<div class="col-sm-10" id="buildings">
													<% for(BuilderBuilding builderBuilding :buildings) { 
														String is_checked = "";
														for(BuilderBuildingFlatType builderBuildingFlatType :builderBuildingFlatTypes) {
															if(builderBuildingFlatType.getBuilderBuilding().getId() == builderBuilding.getId()) {
																is_checked = "checked";
															}
														}
													%>
														<div class="col-sm-3"><input type="checkbox" name="building_id[]" value="<% out.print(builderBuilding.getId());%>" <% out.print(is_checked); %>> <% out.print(builderBuilding.getName()); %></div>
													<% } %>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
												<hr>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Super BuiltUp <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="super_builtup_area" name="super_builtup_area" value="<% out.print(builderFlatType.getSuperBuiltupArea()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">BuiltUp Area <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="builtup_area" name="builtup_area" value="<% out.print(builderFlatType.getBuiltupArea()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Carpet Area <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="carpet_area" name="carpet_area" value="<% out.print(builderFlatType.getCarpetArea()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Rooms <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bedroom" name="bedroom" value="<% out.print(builderFlatType.getBedroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Bathroom <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="bathroom" name="bathroom" value="<% out.print(builderFlatType.getBathroom()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="balcony" name="balcony" value="<% out.print(builderFlatType.getBalcony()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Dry Balcony <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="drybalcony" name="drybalcony" value="<% out.print(builderFlatType.getDrybalcony()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-12" id="rooms">
											<% for(BuilderBuildingFlatTypeRoom builderBuildingFlatTypeRoom :builderBuildingFlatTypeRooms) { %>
												<div class="col-sm-12">
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label col-sm-6">Room Name</label>
															<div class="col-sm-6"><input type="text" class="form-control" name="room_name[]" value="<% out.print(builderBuildingFlatTypeRoom.getRoomName());%>"></div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label col-sm-6">Length</label>
															<div class="col-sm-6"><input type="text" name="length[]" onkeypress=" return isNumber(event, this);" class="form-control" value="<% out.print(builderBuildingFlatTypeRoom.getLength());%>"/></div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label col-sm-6">Breadth</label>
															<div class="col-sm-6"><input type="text" name="breadth[]" onkeypress=" return isNumber(event, this);" class="form-control" value="<% out.print(builderBuildingFlatTypeRoom.getBreadth());%>"/></div>
														</div>
													</div>
													<div class="col-sm-3">
														<div class="form-group">
															<label class="control-label col-sm-6">Unit</label>
															<div class="col-sm-6">
																<select name="length_unit[]" class="form-control">
																	<option value="1" <% if(builderBuildingFlatTypeRoom.getLengthUnit() == 1) { %>selected<% } %>>Feet</option>
																	<option value="2" <% if(builderBuildingFlatTypeRoom.getLengthUnit() == 2) { %>selected<% } %>>Meter</option>
																	<option value="3" <% if(builderBuildingFlatTypeRoom.getLengthUnit() == 3) { %>selected<% } %>>Inch</option>
																	<option value="4" <% if(builderBuildingFlatTypeRoom.getLengthUnit() == 4) { %>selected<% } %>>Yard</option>
																</select>
															</div>
														</div>
													</div>
												</div>
											<% } %>
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
														<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a>
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
$('#super_builtup_area').keypress(function (event) {
    return isNumber(event, this)
});
$('#builtup_area').keypress(function (event) {
    return isNumber(event, this)
});
$('#carpet_area').keypress(function (event) {
    return isNumber(event, this)
});
$('#bedroom').keypress(function (event) {
    return isNumber(event, this)
});
$('#bathroom').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#balcony').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
$('#drybalcony').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('Please use only numbers.'); return ''; } ) );
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
} 
$('#addfloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	project_id: {
            validators: {
                notEmpty: {
                    message: 'Project Name is required and cannot be empty'
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
        super_builtup_area: {
            validators: {
                notEmpty: {
                    message: 'Super BuiltUp Area is required and cannot be empty'
                }
            }
        },
        builtup_area: {
            validators: {
                notEmpty: {
                    message: 'BuiltUp Area is required and cannot be empty'
                }
            }
        },
        carpet_area: {
            validators: {
                notEmpty: {
                    message: 'Carpet Area is required and cannot be empty'
                }
            }
        },
        bedroom: {
            validators: {
                notEmpty: {
                    message: 'Rooms is required and cannot be empty'
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

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = "";
		$(data).each(function(index){
			html = html + '<div class="col-sm-3"><input type="checkbox" name="building_id[]" value="'+data[index].id+'"> '+data[index].name+'</div>';
		});
		$("#buildings").html(html);
	},'json');
	
});

$("#bedroom").focusout(function(){
	var bedrooms = parseInt($("#bedroom").val());
	var row = "";
	for(i = 1; i <= bedrooms; i++) {
		row = row + '<hr><div class="col-sm-12"><div class="col-sm-3"><div class="form-group"><label class="control-label col-sm-6">Room Name</label><div class="col-sm-6"><input type="text" class="form-control" name="room_name[]" value="Room '+i+'"/></div></div></div>'
				+'<div class="col-sm-3"><div class="form-group"><label class="control-label col-sm-6">Length</label><div class="col-sm-6"><input type="text" onkeypress=" return isNumber(event, this);" name="length[]" class="form-control"/></div></div></div>'
				+'<div class="col-sm-3"><div class="form-group"><label class="control-label col-sm-6">Breadth</label><div class="col-sm-6"><input type="text"  onkeypress=" return isNumber(event, this);" name="breadth[]" class="form-control"/></div></div></div>'
				+'<div class="col-sm-3"><div class="form-group"><label class="control-label col-sm-6">Unit</label><div class="col-sm-6"><select name="length_unit[]" class="form-control">'
				+'<option value="1">Feet</option>'
				+'<option value="2">Meter</option>'
				+'<option value="3">Inch</option>'
				+'<option value="4">Yard</option>'
				+'</select></div></div></div>'
				+'</div>';
	}
	$("#rooms").html(row);
});

</script>
</body>
</html>
