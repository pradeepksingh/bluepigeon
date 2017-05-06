<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.data.FlatData"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.Possession"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.bluepigeon.admin.model.PossessionInfo"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
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
	int possession_id = 0;
	int p_user_id = 0;
	possession_id = Integer.parseInt(request.getParameter("possession_id"));
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
	Possession possession = new PossessionDAO().getPossessionById(possession_id);
	BuilderFloor builderFloor = null;
	List<BuildingData> buildings = null;
	List<FlatData> flats = null;
	List<PossessionInfo> floorAmenityInfos = new PossessionDAO().getPossessionInfoByPossessionId(possession_id);//.getBuildingFloorAmenityInfo(floor_id);
	List<BuilderFloorStatus> builderFloorStatuses = new BuilderFloorStatusDAO().getFloorStatus();
	List<BuilderFloorAmenity> builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderFloorAmenityList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderAllProjects();
	if(builderProjects.size()>0){
		buildings  = new BuyerDAO().getBuildingByProjectId(possession.getBuilderProject().getId());
	}
	if(buildings.size()>0){
		flats = new BuyerDAO().getBookedFlats(buildings.get(0).getId());
	}
	
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li class="active">Update Possession</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/buyer/possession/list.jsp"> << Possession List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Possession Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="possessionTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Possession Details</a></li>
			  	<li><a data-toggle="tab" href="#possessiondocuments">Possession Document</a></li>
			</ul>
			<form id="updatepossession" name="updatepossession" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="possession_id" id="possession_id" value="<%out.print(possession_id);%>"/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Project Name </label>
													<div class="col-sm-7">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == possession.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
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
															<% for(BuildingData builderBuilding2 :buildings) { %>
															<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == possession.getBuilderBuilding().getId()) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
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
													<label class="control-label col-sm-5">Flat Name </label>
													<div class="col-sm-7">
														<select id="flat_id" name="flat_id" class="form-control">
															<% if(flats != null) { %>
															<% for(FlatData flatData :flats) { %>
															<option value="<% out.print(flatData.getId());%>" <% if(flatData.getId() == possession.getBuilderFlat().getId()) { %>selected<% } %>><% out.print(flatData.getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Flat</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Name <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(possession.getName()); %>" id="name" name="name" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Email <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(possession.getEmail()); %>" id="email" name="email" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Contact <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(possession.getContact()); %>" id="contact" name="contact" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Last Date </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="last_date" name="last_date" value="<% if(possession.getLastDate() != null) { out.print(dt1.format(possession.getLastDate()));} %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Remind Every <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="remind" value="<%out.print(possession.getRemind()); %>" name="remind" />
														<span class="input-group-addon">Days</span>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Content <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<textarea rows="" cols="" class="form-control" id="contect" name="content"><%out.print(possession.getContent()); %></textarea>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-12">
												<hr/>
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
					<div id="possessiondocuments" class="tab-pane fade">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Agreement Document</h3>
										<br>
										<div class="row" id="project_images">
											<%
											 if(floorAmenityInfos !=null){
												for (PossessionInfo floorLayoutImage :floorAmenityInfos) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(floorLayoutImage.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Possession Documents" src="${baseUrl}/<% out.print(floorLayoutImage.getDocUrl()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(floorLayoutImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Plan</a> </label>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<% 
												}
											}
											%>
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Possession Document </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id="possession_doc" name="possession_doc[]" />
<!-- 														<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a></span> -->
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<span class="pull-right"><a href="javascript:addMorePossessionDoc();" class="btn btn-info btn-xs"> + Add More</a></span>
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
$('#last_date').datepicker({
	format: "dd MM yyyy"
});
$('#updatepossession').bootstrapValidator({
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
                    message: 'Buyer Name is required and cannot be empty'
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
	addPossession();
});

function addPossession() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/possession/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatepossession').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/buyer/possession/list.jsp";
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete possession ?");
	if(flag) {
		$.get("${baseUrl}/webapi/buyer/possession/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function addMorePossessionDoc() {
	var img_count = parseInt($("img_count").val());
	img_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Possession Document </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="possession_doc" name="possession_doc[]" />'
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
	$('#possessionTabs a[href="#possessiondocuments"]').tab('show');
}
$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = "";
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
	
$("#building_id").change(function(){
		$.get("${baseUrl}/webapi/buyer/floor/list/",{ building_id: $("#building_id").val() }, function(data){
			var html = '<option value="">Select Flat</option>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			});
			$("#flat_id").html(html);
		},'json');
	});
});

$("#flat_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/flat/",{ flat_id: $("#flat_id").val() }, function(data){
		$(data).each(function(index){
			if(data[index].name != "")
				$("#name").val(data[index].name);
			else
				$("#name").val("");
			if(data[index].contact !="")
				$("#contact").val(data[index].contact);
			else
				$("#contact").val("");
			if(data[index].email!="")
				$("#email").val(data[index].email);
			else
				$("#email").val("");
		});
	},'json');
});
</script>
</body>
</html>