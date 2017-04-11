<%@page import="org.bluepigeon.admin.data.FlatData"%>
<%@page import="org.bluepigeon.admin.data.FloorData"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.data.ProjectDetails"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%@page import="org.bluepigeon.admin.model.BuyerOffer"%>
<%@page import="org.bluepigeon.admin.model.BuyingDetails"%>
<%@page import="org.bluepigeon.admin.model.BuyerUploadDocuments"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuyerDocuments"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	int buyer_id = 0;
	int projectId = 0;
	int buildingId = 0;
	int floorId = 0;
	int flatId = 0;
	int p_user_id = 0;
	List<BuildingData> building_list = null;
	List<FloorData> floor_list = null;
	List<FlatData> flat_list = null;
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
	List<BuilderProject> project_list = new ProjectDetailsDAO().getBuilderProjectList();
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Agreement</a></li>
				<li class="active">Add</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Add Agreement
				</h1>
			</div>
			<div class="tab-content">
			  	<div id="basic" class="tab-pane fade in active">
			  		<form id="basicfrm" name="basicfrm" method="post">
			  			<div id="basicresponse"></div>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-project_id">
													<label class="control-label col-sm-4">Project <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="project_id" id="project_id" class="form-control">
										                	<option value="">Select Project</option>
										                	 <% for(BuilderProject builderProject : project_list){ %>
															<option value="<% out.print(builderProject.getId());%>" ><% out.print(builderProject.getName());%></option>
															<% } %>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-building_id">
													<label class="control-label col-sm-4">Building <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="building_id" id="building_id" class="form-control">
										                    <option value="">Select Building</option>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-floor_id">
													<label class="control-label col-sm-4">Floor <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="floor_id" id="floor_id" class="form-control">
										                    <option value="">Select Floor</option>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Flat <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select name="flat_id" id="flat_id" class="form-control">
										                	<option value="">Select Flat</option>
											          	</select>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Buyer <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="name" name="name" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Contact <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="contact" name="contact" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Email <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="email" name="email" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Last Date </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="last_date" name="last_date" />
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-flat_id">
													<label class="control-label col-sm-4">Remind Every <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="remind" name="remind" />
														<span class="input-group-addon">Days</span>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-address">
												<label class="control-label col-sm-4">Content</label>
												<div class="col-sm-8">
													<textarea rows="" cols="" class="form-control" id="contect" name="content"></textarea>
												</div>
												<div class="messageContainer col-sm-4"></div>
												</div>
										   </div>
											<div class="col-lg-6">
												<div class="col-sm-12">
													<button type="submit" name="basicbtn" class="btn btn-success btn-sm">Submit</button>
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
			<br> <br>
		</div>
	</div>
</div>
<%@include file="../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
	.margin-bottom-5 {
		padding-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#last_date').datepicker({
	format: "dd MM yyyy"
});
$("#project_id").change(function(){
	if($("#project_id").val() != "") {
		$.get("${baseUrl}/webapi/buyer/building/list/",{ project_id: $("#project_id").val() }, function(data){
			var html = '<option value="">Select Building</option>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			});
			$("#building_id").html(html);
		},'json');
	}
});

$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/floor/list/",{ building_id: $("#building_id").val() }, function(data){
		var html = '<option value="">Select Floor</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#floor_id").html(html);
	},'json');
});
$("#floor_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/flat/booked/list/",{ floor_id: $("#floor_id").val() }, function(data){
		var html = '<option value="">Select Flat</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
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
$('#basicfrm').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
        name: {
            validators: {
                notEmpty: {
                    message: 'Buyer Name is required and cannot be empty'
                }
            }
        },
        email: {
            validators: {
                notEmpty: {
                    message: 'Email is required and cannot be empty'
                }
            }
        },
        contact: {
            validators: {
                notEmpty: {
                    message: 'Contact number is required and cannot be empty'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Flat Number is required and cannot be empty'
                }
            }
        },
        floor_id: {
            validators: {
                notEmpty: {
                    message: 'Floor is required and cannot be empty'
                }
            }
        },
        building_id: {
            validators: {
                notEmpty: {
                    message: 'Building Name is required and cannot be empty'
                }
            }
        },
        project_id: {
            validators: {
                notEmpty: {
                    message: 'Project Name is required and cannot be empty'
                }
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addAgreement();
});

function addAgreement() {
	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/agreement/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#basicfrm').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#basicresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#basicresponse").removeClass('alert-success');
       	$("#basicresponse").addClass('alert-danger');
		$("#basicresponse").html(resp.message);
		$("#basicresponse").show();
  	} else {
  		$("#basicresponse").removeClass('alert-danger');
        $("#basicresponse").addClass('alert-success');
        $("#basicresponse").html(resp.message);
        $("#basicresponse").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/builder/buyer/agreement/list.jsp";
  	}
}
</script>
</body>
</html>
