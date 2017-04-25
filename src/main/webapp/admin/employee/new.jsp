<%@page import="org.bluepigeon.admin.model.AdminUserRole"%>
<%@page import="org.bluepigeon.admin.dao.PropertyManagerDAO"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%

	List<AdminUserRole> adminUserRoles = new PropertyManagerDAO().getAdminUserRoles();
	List<AdminUser> adminUsers = new PropertyManagerDAO().getAminUserList();
   	session = request.getSession(false);
    AdminUser adminuserproject = new AdminUser();
 	int p_user_id = 0;
 	List<City> city_list = new CityNamesImp().getCityNames();
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
				<li><a href="#">PropertyManager</a></li>
				<li class="active">Add New Property manager</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>Add New Property manager</h1>
			</div>
			<ul class="nav nav-tabs" id="managerTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#managerdetail">Manager Photo</a></li>
			</ul>
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
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Name</label>
												<div class="col-sm-9">
													<select name="manager_id" id="manager_id" class="form-control">
								                 	   	<option value="0">Select Name</option>
								                 	   	 <% for(AdminUser adminUser : adminUsers){ %>
														<option value="<% out.print(adminUser.getId());%>"><% out.print(adminUser.getName());%></option>
														<% } %>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
										  	</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Phone</label>
												<div class="col-sm-9">
													<select name="phone" id="phone" class="form-control">
								                 	   	<option value="0">Select Contact No.</option>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>
												<div class="col-sm-9">
													<select name="email" id="email" class="form-control">
								                 	   	<option value="0">Select Email</option>
										       	  	</select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Current Address</label>
												<div class="col-sm-9">
													<textarea id="current_address" name="current_address" placeholder="Enter current Address" class="form-control" ></textarea>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Permanent Address</label>
												<div class="col-sm-9">
													<textarea id="permanent_address" name="permanent_address" placeholder="Enter Permanent Address" class="form-control" ></textarea>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">City </label>
												<div class="col-sm-9">
												 	<select name="city_id" id="city_id" class="form-control">
									                    <option value="0">Select City</option>
									                     <% for(City city : city_list){ %>
														<option value="<% out.print(city.getId());%>"><% out.print(city.getName());%></option>
														<% } %>
									                </select>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Access type </label>
												<div class="col-sm-9">
												 	<select name="access_id" id="access_id" class="form-control">
									                    <option value="0">Access Type</option>
									                     <% for(AdminUserRole adminUser : adminUserRoles){ %>
														<option value="<% out.print(adminUser.getId());%>"><% out.print(adminUser.getRoleName());%></option>
														<% } %>
									                </select>
												</div>
													<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
										<input type="hidden" name="added_by" id="added_by" value="1"/>
										<div class="col-lg-12 margin-bottom-5">
											<div class="clearfix form-actions">
												<div class="pull-right">
													<button type="button" onclick="showDetailTab()" class="btn btn-success btn-small">Submit</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>	
<!-- 						</form> -->
					</div>
					<div id="managerdetail" class="tab-pane fade">
	<!-- 					<form id="updateimage" name="updateimage" action="" method="post" class="form-horizontal" enctype="multipart/form-data"> -->
						<div class="row">
							<div id="imageresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload manager Photo</h3>
										<br>
										<div class="row" id="manager_images">
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Select Image </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
													<input type="file" class="form-control" id="manager_image" name="manager_image[]" />
								<!-- 					<a href="javascript:removeImage('+img_count+');" class="input-group-addon btn-danger">x</a></span> -->
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
									<button type="submit" name="imagebtn" class="btn btn-success">SAVE</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script type="text/javascript">
$("#manager_id").change(function(){
	if($("#manager_id").val() > 0){
		$.get("${baseUrl}/webapi/employee/list/"+$("#manager_id").val(),{ }, function(data){
			var phone = phone + '<option value="'+data.id+'">'+data.contact+'</option>';
			var email = email + '<option value = "'+data.id+'">'+data.email+'</option>';
			$("#email").html(email);
			$("#phone").html(phone);
		},'json');
	}else{
		var phone = phone + '<option value="0">Select Contact No.</option>';
		var email = email + '<option value = "0">Select Email</option>';
		$("#email").html(email);
		$("#phone").html(phone);
	}
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


