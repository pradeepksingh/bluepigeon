<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	List<Builder> builderList = new BuilderDetailsDAO().getBuilderList();
   	session = request.getSession(false);
    AdminUser adminuserproject = new AdminUser();
 	int p_user_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			adminuserproject  = (AdminUser)session.getAttribute("uname");
			p_user_id = adminuserproject.getId();
		}
   	}
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a></li>
				<li><a href="#">Project Update</a></li>
				<li class="active">Add New Project update</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>Add New Project update
				<span class="pull-right"><a href="${baseUrl}/admin/buyer/update-buyers/list.jsp" class="btn btn-default btn-sm"> << Project Update List</a></span>
				</h1>
			</div>
			<form id="addmanager" name="addmanager" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Builder Name</label>
												<div class="col-sm-9">
													<select name="builder_id" id="builder_id" class="form-control">
								                 	   	<option value="0">Select Name</option>
								                 	   	 <% for(Builder builder : builderList){ %>
														<option value="<% out.print(builder.getId());%>"><% out.print(builder.getName());%></option>
														<% } %>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
										  	</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Project</label>
												<div class="col-sm-9">
													<select name="project_id" id="project_id" class="form-control">
								                 	   	<option value="0">Select Project</option>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Building </label>
												<div class="col-sm-9">
													<select name="building_id" id="building_id" class="form-control">
								                 	   	<option value="0">Select Building</option>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Floor </label>
												<div class="col-sm-9">
												 	<select name="floor_id" id="floor_id" class="form-control">
									                    <option value="0">Select Floor</option>
									                </select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Flat </label>
												<div class="col-sm-9">
												 	<select name="flat_id" id="flat_id" class="form-control">
									                    <option value="0">Select flat</option>
									                </select>
												</div>
													<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Description</label>
												<div class="col-sm-9">
													<textarea id="description" name="description" placeholder="Enter description" class="form-control" ></textarea>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<input type="hidden" name="added_by" id="added_by" value="1"/>
										<div class="col-lg-12 margin-bottom-5">
											<div class="clearfix form-actions">
												<div class="pull-right">
													<button type="submit" class="btn btn-success btn-small">Submit</button>
												</div>
											</div>
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
<%@include file="../../../footer.jsp"%>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script type="text/javascript">
$("#builder_id").change(function(){
	var project = "<option value='0'>Select Project</option>";
	$.get("${baseUrl}/webapi/buyer/project/list/"+$("#builder_id").val(),{ }, function(data){
		 project = project + '<option value="'+data.id+'">'+data.name+'</option>';
		$("#project_id").html(project);
	},'json');
});
$("#buyer_id").change(function(){
	var html = "<option value='0'>Select flat</option>";
	$.get("${baseUrl}/webapi/buyer/project/list/"+$("#buyer_id").val(),{ }, function(data){
		var phone = phone + '<option value="'+data.id+'">'+data.contact+'</option>';
		var email = email + '<option value = "'+data.id+'">'+data.email+'</option>';
		$("#email").html(email);
		$("#phone").html(phone);
	},'json');
});
$('#addmanager').bootstrapValidator({
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
                    message: 'Lead name is required and cannot be empty'
                }
            }
        },
        mobile: {
        	validators: {
            	notEmpty: {
                    message: 'The Mobile is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[7-9][0-9]{9}$',
                    message: 'Invalid Mobile Number'
                }
            }
        },
//         email: {
//         	validators: {
//             	notEmpty: {
//                     message: 'The Email is required and cannot be empty'
//                 },
//                 regexp: {
//                     regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
//                     message: 'The value is not a valid email address'
//                 }
//             }
//         },
        project_id: {
            validators: {
                notEmpty: {
                    message: 'Project is required and cannot be empty'
                }
            }
        },
        city: {
            validators: {
                notEmpty: {
                    message: 'City Name is required and cannot be empty'
                }
            }
        },
        area: {
            validators: {
                notEmpty: {
                    message: 'Locality Name is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addPropertyManager();
});
function addPropertyManager() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/employee/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addmanager').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/employee/list.jsp";
  	}
}

function showDetailTab() {
	$('#managerTabs a[href="#managerdetail"]').tab('show');
}
</script>


