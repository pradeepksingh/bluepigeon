<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
 	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
 	List<BuilderProject> builderProjects = new ProjectLeadDAO().getProjectList();
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	if(builderProjects.size()>0)
    	project_size = builderProjects.size();
 	if(builderPropertyTypes.size()>0)
 		type_size = builderPropertyTypes.size();
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
				<li><a href="#">Project Lead</a></li>
				<li class="active">Add New Lead</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>Add New Lead</h1>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<form id="addlead" name="addlead" class="form-horizontal" action="" method="post">
						<div class="panel panel-default">
							<div class="panel-body">
								<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Project </label>
										<div class="col-sm-9">
											<select name="project_id" id="project_id" class="form-control">
						                 	   	<option value="0">Select Project</option>
						                  	   	<% for(int i=0; i < project_size ; i++){ %>
												<option value="<% out.print(builderProjects.get(i).getId());%>"><% out.print(builderProjects.get(i).getName());%></option>
											  	<% } %>
								       	  	</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
								  	</div>
							  	</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Building </label>
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
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Flat </label>
										<div class="col-sm-9">
											<select name="flat_id" id="flat_id" class="form-control">
						                 	   	<option value="0">Select Flat</option>
								       	  	</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Lead Name </label>
										<div class="col-sm-9">
											<input type="text" id="name" name="name" placeholder="Enter lead name" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Mobile </label>
										<div class="col-sm-9">
											<input type="text" id="mobile" name="mobile" placeholder="Enter lead phone number" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>
										<div class="col-sm-9">
											<input type="text" id="email" name="email" placeholder="Enter lead email" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">City </label>
										<div class="col-sm-9">
											<input type="text" id="city" name="city" placeholder="Enter City" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Area </label>
										<div class="col-sm-9">
											<input type="text" id="area" name="area" placeholder="Enter lead area" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Source </label>
										<div class="col-sm-9">
										 	<select name="source" id="source" class="form-control">
							                    <option value="0">Select Source</option>
							                    <option value="1">App</option>
							                    <option value="2">Website</option>
							                    <option value="3">Google</option>
							                    <option value="4">Facebook</option>
							                </select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Interested in </label>
										<div class="col-sm-9">
										 	<select name="interest" id="interest" class="form-control">
							                    <option value="0">Select Interest</option>
							                    <option value="1">Buy</option>
							                    <option value="2">Rental</option>
							                    <option value="3">Resale</option>
							                </select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Type </label>
										<div class="col-sm-9">
										 	<select name="type_id" id="type_id" class="form-control">
							                    <option value="0">Select Type</option>
							                   	<% for(int i=0; i < type_size ; i++){ %>
												<option value="<% out.print(builderPropertyTypes.get(i).getId());%>"><% out.print(builderPropertyTypes.get(i).getName());%></option>
											  	<% } %>
							                </select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Discount Offered </label>
										<div class="col-sm-9">
											<textarea id="discount_offered" name="discount_offered" placeholder="Enter Discount " class="form-control" ></textarea>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Status </label>
										<div class="col-sm-9">
				                       		<select name="status" id="status" class="form-control">
												<option value="1"> Active </option>
												<option value="0"> Inactive </option>
											</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<input type="hidden" name="added_by" id="added_by" value="1"/>
								<div class="col-lg-12 margin-bottom-5">
									<div class="clearfix form-actions">
										<div class="pull-right">
											<button type="submit" class="btn btn-success">Submit</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script type="text/javascript">
$("#project_id").change(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
		ajaxindicatorstop();
	},'json');
});
$("#building_id").change(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	$.get("${baseUrl}/webapi/project/building/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].flatNo+'</option>';
		});
		$("#flat_id").html(html);
		ajaxindicatorstop();
	},'json');
});

$("#email").keyup(function(){
	var th = $(this);
	$th.val($th.val().replace(/[^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$]/g,function(str){return '';}));
});
	
$('#addlead').bootstrapValidator({
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
        email: {
        	validators: {
            	notEmpty: {
                    message: 'The Email is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                    message: 'The value is not a valid email address'
                }
            }
        },
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
	addLead();
});

function addLead() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/add',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addlead').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/leads/list.jsp";
  	}
}
</script>


