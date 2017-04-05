<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
	CountryDAOImp countryService = new CountryDAOImp();
	List<Country> listCountry = countryService.getCountryList();
	session = request.getSession(false);
	AdminUser adminuserproject = new AdminUser();
	List<Buyer> buyers = new BuyerDAO().getAllBuyer();
	List<BuilderProject> project_list = new ProjectDetailsDAO().getBuilderProjectList();
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
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Buyer</a></li>
				<li class="active">Add</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Buyer Add 
				</h1>
			</div>
			<form id="addbuyer" name="addbuyer" action="" method="post">
				<div id="basic" class="tab-pane fade in active">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-builder_id">
												<label class="control-label col-sm-3">Buyer Name<span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="name" name="name" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-builder_id">
												<label class="control-label col-sm-3">Contact<span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="contact" name="contact" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-name">
												<label class="control-label col-sm-3">Email <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="email" name="email" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-builder_id">
												<label class="control-label col-sm-3">PAN<span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="pan" name="pan" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-builder_id">
												<label class="control-label col-sm-3">Prem. Address<span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<textarea rows="" cols="" class="form-control" id="address" name="address"></textarea>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row" id="project_images">
										<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
											<div class="form-group" id="error-landmark">
												<label class="control-label col-sm-4">Select Image </label>
												<div class="col-sm-8 input-group" style="padding:0px 12px;">
													<input type="file" class="form-control" id="buyer_image" name="buyer_image[]" />
													<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a></span>
												</div>
												<div class="messageContainer col-sm-offset-3"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-project_type">
												<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
												<div class="col-sm-12">
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="1" />PAN 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="2" />Aadhar 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="3" />Passport 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="4" />Registered Rent Agreement 
													</div>
													<div class="col-sm-3">
														<input type="checkbox" name="document_type[]" value="5" />Vote ID 
													</div>
												</div>
												<div class="messageContainer"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-country_id">
												<label class="control-label col-sm-3"><b>Project Details</b><span class='text-danger'>*</span></label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-country_id">
												<label class="control-label col-sm-3">Project <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="project_id" id="project_id" class="form-control">
									                    <option value="">Select Project</option>
									                    <% for(BuilderProject builderProject : project_list){ %>
														<option value="<% out.print(builderProject.getId());%>" ><% out.print(builderProject.getName());%></option>
														<% } %>
										             </select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-state_id">
												<label class="control-label col-sm-3">Building <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="building_id" id="building_id" class="form-control">
									                    <option value="">Select Building</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-state_id">
												<label class="control-label col-sm-3">Floor <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="floor_id" id="floor_id" class="form-control">
									                    <option value="">Select Floor</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-state_id">
												<label class="control-label col-sm-3">Flat <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="flat_id" id="flat_id" class="form-control">
									                    <option value="">Select Flat</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
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
<%@include file="../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
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
	$.get("${baseUrl}/webapi/buyer/flat/list/",{ floor_id: $("#floor_id").val() }, function(data){
		var html = '<option value="">Select Flat</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
$('#addbuyer').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	builder_id: {
            validators: {
                notEmpty: {
                    message: 'Builder Group is required and cannot be empty'
                }
            }
        },
    	company_id: {
            validators: {
                notEmpty: {
                    message: 'Company Name is required and cannot be empty'
                }
            }
        },
        name: {
            validators: {
                notEmpty: {
                    message: 'Project Name is required and cannot be empty'
                }
            }
        },
        country_id: {
            validators: {
                notEmpty: {
                    message: 'Country Name is required and cannot be empty'
                }
            }
        },
        state_id: {
            validators: {
                notEmpty: {
                    message: 'State Name is required and cannot be empty'
                }
            }
        },
        city_id: {
            validators: {
                notEmpty: {
                    message: 'City Name is required and cannot be empty'
                }
            }
        },
        locality_id: {
            validators: {
                notEmpty: {
                    message: 'Locality Name is required and cannot be empty'
                }
            }
        },
        pincode: {
            validators: {
                notEmpty: {
                    message: 'The Pincode is required and cannot be empty'
                },
                stringLength: {
                    max: 6,
                    min: 6,
                    message: 'Invalid pin code.'
                },
                integer: {
                    message: 'Invalid pin code.'
           		}
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addBuyer();
});

function addBuyer() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addbuyer').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/buyer/list.jsp";
  	}
}


</script>
</body>
</html>
