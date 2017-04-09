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

				<li><a href="${baseUrl}/admin/project/list.jsp">Project</a></li>
				<li class="active">Add</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project Add 
					<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp" class="btn btn-default btn-sm"> << Project List</a></span>
				</h1>
			</div>
			<form id="addproject" name="addproject" action="" method="post">
				<div id="basic" class="tab-pane fade in active">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-builder_id">
												<label class="control-label col-sm-3">Builder Group <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select id="builder_id" name="builder_id" class="form-control">
														<option value="">Select Builder Group</option>
														<% for (Builder builder : builders) { %>
														<option value="<%out.print(builder.getId());%>"> <% out.print(builder.getName()); %> </option>
														<% } %>
													</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-company_id">
												<label class="control-label col-sm-3">Builder Company <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select id="company_id" name="company_id" class="form-control">
														<option value="">Select Builder Company</option>
													</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-name">
												<label class="control-label col-sm-3">Project Name <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="name" name="name" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-landmark">
												<label class="control-label col-sm-3">Landmark </label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="landmark" name="landmark" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-sublocation">
												<label class="control-label col-sm-3">Sub Location </label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="sublocation" name="sublocation" />
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-country_id">
												<label class="control-label col-sm-3">Country <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="country_id" id="country_id" class="form-control">
									                    <option value="">Select Country</option>
									                    <% for(Country country : listCountry){ %>
														<option value="<% out.print(country.getId());%>" ><% out.print(country.getName());%></option>
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
												<label class="control-label col-sm-3">State <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="state_id" id="state_id" class="form-control">
									                    <option value="">Select State</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-city_id">
												<label class="control-label col-sm-3">City <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="city_id" id="city_id" class="form-control">
									                	<option value="">Select City</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-locality_id">
												<label class="control-label col-sm-3">Locality <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="locality_id" id="locality_id" class="form-control">
									                	<option value="">Select Locality</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-pincode">
												<label class="control-label col-sm-3">Pincode </label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="pincode" name="pincode" autocomplete="off"/>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-latitude">
												<label class="control-label col-sm-3">Latitude </label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="latitude" name="latitude" autocomplete="off"/>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-longitude">
												<label class="control-label col-sm-3">Longitude </label>
												<div class="col-sm-5">
													<input type="text" class="form-control" id="longitude" name="longitude" autocomplete="off"/>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-longitude">
												<label class="control-label col-sm-3">Description </label>
												<div class="col-sm-5">
													<textarea class="form-control" id="description" name="description"></textarea>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12 margin-bottom-5">
											<div class="form-group" id="error-highlight">
												<label class="control-label col-sm-3">Highlight (USP) </label>
												<div class="col-sm-5">
													<textarea class="form-control" id="highlight" name="highlight"></textarea>
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
$("#builder_id").change(function(){
	if($("#builder_id").val() != "") {
		$.get("${baseUrl}/webapi/create/project/list/",{ builder_id: $("#builder_id").val() }, function(data){
			var html = '<option value="">Select Builder Comapny</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#company_id").html(html);
		},'json');
	}
});
$("#country_id").change(function(){
	if($("#country_id").val() != "") {
		$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
			var html = '<option value="">Select State</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#state_id").html(html);
		},'json');
	}
});

$("#state_id").change(function(){
	if($("#state_id").val() != "") {
		$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
			var html = '<option value="">Select City</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#city_id").html(html);
		},'json');
	}
});
$("#city_id").change(function(){
	if($("#city_id").val() != "") {
		$.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#city_id").val() }, function(data){
			var html = '<option value="">Select Locality</optio>';
			$(data).each(function(index){
				html = html + '<option value="'+data[index].id+'">'+data[index].name+'</optio>';
			});
			$("#locality_id").html(html);
		},'json');
	}
});
$('#addproject').bootstrapValidator({
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
	addProject();
});

function addProject() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/add',
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
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project/list.jsp";
  	}
}


</script>
</body>
</html>
