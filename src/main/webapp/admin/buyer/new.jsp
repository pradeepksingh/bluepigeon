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
<%@include file="../../../leftnav.jsp"%>
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
					Add Buyer
				</h1>
			</div>
			<form id="addbuyer" name="addbuyer" action="" method="post" enctype="multipart/form-data">
				<div id="basic" class="tab-pane fade in active">
					<div class="row" id="buyer-1">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
									<div id="buyer_area">
									<input type="hidden" name="buyer_count" id="buyer_count" value="1"/>
										<div class="row" id="buyer-1">
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-buyer_name">
													<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value="" placeholder="Full name"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-6">
													<div class="form-group" id="error-contact">
														<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="contact" name="contact[]" value="" placeholder="Mobile Number"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
										    </div>
										    <div class="row">
												<div class="col-lg-6 margin-bottom-6">
													<div class="form-group" id="error-email">
														<label class="control-label col-sm-4">Email <span class="text-danger">*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="email" name="email[]" value="" placeholder="Email ID"/>
														</div>
														<div class="messageContainer"></div><br/>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-6">
													<div class="form-group" id="error-email">
														<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="pan" name="pan[]" value="" placeholder="Pancard number"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
													<label class="control-label col-sm-4"> Premanent Address <span class="text-danger">*</span></label>
													<div class="col-sm-8">
													<textarea class="form-control" id="address" name="address[]" placeholder="Permanent Address"></textarea>
													</div>
													<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-6 margin-bottom-6">
													<div class="form-group" id="error-state_id">
														<label class="control-label col-sm-4">Owner <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<select name="is_primary[]" id="is_primary" class="form-control">
											                    <option value="">Select Owner</option>
											                     <option value="0">Co-Owner</option>
											                      <option value="1" selected>Owner</option>
												          	</select>
														</div>
														<div class="messageContainer col-sm-4"></div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-6 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4"> Upload Buyer Pic <span class="text-danger">*</span></label>
														<div class="col-sm-8">
															<input type="file" name="photo[]" class="form-control" />
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<hr>
											<div class="col-lg-12 margin-bottom-6">
													<div class="form-group" id="error-project_type">
														<label class="control-label col-sm-2">Documents <span class='text-danger'>*</span></label>
														<div class="col-sm-10">
															<div class="col-sm-3">
																<input type="checkbox" name="document_type[]" value="1" /> PAN Card
															</div>
															<div class="col-sm-3">
																<input type="checkbox" name="document_type[]" value="2" /> Aadhar Card
															</div>
															<div class="col-sm-3">
																<input type="checkbox" name="document_type[]" value="3" /> Passport 
															</div>
															<div class="col-sm-3">
																<input type="checkbox" name="document_type[]" value="4" /> Registered Rent Agreement 
															</div>
															<div class="col-sm-3">
																<input type="checkbox" name="document_type[]" value="5" /> Vote ID 
															</div>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
										</div>
									<hr>
									<div>
										<div class="col-lg-12">
											<label class="control-label"><b>Project Details</b></label>
											<span class="pull-right">
												<a href="javascript:addMoreBuyers();" class="btn btn-info btn-xs">+ Add More Buyers</a>
											</span>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-6 margin-bottom-5">
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
										<div class="col-lg-6 margin-bottom-5">
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
										<div class="col-lg-6 margin-bottom-5">
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
<!-- 										<div class="col-lg-6 margin-bottom-5"> -->
<!-- 											<div class="form-group" id="error-state_id"> -->
<!-- 												<label class="control-label col-sm-3">Agreement <span class='text-danger'>*</span></label> -->
<!-- 												<div class="col-sm-5"> -->
<!-- 													<select name="agreement" id="agreement" class="form-control"> -->
<!-- 									                    <option value="">Select Agreement</option> -->
<!-- 									                     <option value="0">No</option> -->
<!-- 									                      <option value="1">Yes</option> -->
<!-- 										          	</select> -->
<!-- 												</div> -->
<!-- 												<div class="messageContainer col-sm-4"></div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="row"> -->
<!-- 										<div class="col-lg-6 margin-bottom-5"> -->
<!-- 											<div class="form-group" id="error-state_id"> -->
<!-- 												<label class="control-label col-sm-3">Possession <span class='text-danger'>*</span></label> -->
<!-- 												<div class="col-sm-5"> -->
<!-- 													<select name="possession" id="possession" class="form-control"> -->
<!-- 									                    <option value="">Select Possession</option> -->
<!-- 									                     <option value="0">No</option> -->
<!-- 									                      <option value="1">Yes</option> -->
<!-- 										          	</select> -->
<!-- 												</div> -->
<!-- 												<div class="messageContainer col-sm-4"></div> -->
<!-- 											</div> -->
<!-- 										</div> -->
										<div class="col-lg-6 margin-bottom-5">
											<div class="form-group" id="error-state_id">
												<label class="control-label col-sm-3">Status <span class='text-danger'>*</span></label>
												<div class="col-sm-5">
													<select name="status" id="status" class="form-control">
									                    <option value="">Select Status</option>
									                     <option value="0">Inactive</option>
									                      <option value="1">Active</option>
										          	</select>
												</div>
												<div class="messageContainer col-sm-4"></div>
											</div>
										</div>
									</div>
									<div class="col-lg-12 margin-bottom-5">
										<div class="clearfix form-actions">
											<div class="pull-right">
												<button type="submit" class="btn btn-success">Submit</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
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
	$.get("${baseUrl}/webapi/buyer/buildings/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/building/available/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
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
        //window.location.href = "${baseUrl}/admin/buyer/list.jsp";
  	}
}

function addMoreBuyers() {
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	var html = '<div class="row" id="buyer-'+buyers+'"><hr>'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span></div>'
			+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-buyer_name">'
			+'<label class="control-label col-sm-4">Buyer Name <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="buyer_name" name="buyer_name[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
			+'<div class="form-group" id="error-contact">'
				+'<label class="control-label col-sm-4">Contact <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="contact" name="contact[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-6">'
			+'<div class="form-group" id="error-email">'
				+'<label class="control-label col-sm-4">Email <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="email" name="email[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div><br/>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
			+'<div class="form-group" id="error-email">'
				+'<label class="control-label col-sm-4">PAN <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="pan" name="pan[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4"> Prem. Address <span class="text-danger">*</span></label>'
			+'<div class="col-sm-8">'
			+'<textarea class="form-control" id="address" name="address[]" ></textarea>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-6 margin-bottom-6">'
			+'<div class="form-group" id="error-state_id">'
				+'<label class="control-label col-sm-4">Owner <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<select name="is_primary[]" id="is_primary" class="form-control">'
	                    +'<option value="">Select Owner</option>'
	                     +'<option value="0" selected>Co-Owner</option>'
	                      +'<option value="1">Owner</option>'
		          	+'</select>'
				+'</div>'
				+'<div class="messageContainer col-sm-4"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<div class="row">'
		+'<div class="col-lg-6 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
				+'<label class="control-label col-sm-4"> Upload Buyer Pic <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="file" name="photo[]" class="form-control" />'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'<hr>'
	+'<div class="col-lg-12 margin-bottom-6">'
			+'<div class="form-group" id="error-project_type">'
				+'<label class="control-label col-sm-2">Documents <span class="text-danger">*</span></label>'
				+'<div class="col-sm-10">'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_type[]" value="1" /> PAN Card'
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_type[]" value="2" /> Aadhar Card' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_type[]" value="3" /> Passport' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_type[]" value="4" /> Registered Rent Agreement' 
					+'</div>'
					+'<div class="col-sm-3">'
						+'<input type="checkbox" name="document_type[]" value="5" /> Vote ID' 
					+'</div>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
	+'</div>'
	+'</div>'
	+'</div>';
	$("#buyer_area").append(html);
	$("#buyer_count").val(buyers);
}
function removeBuyer(id) {
	$("#buyer-"+id).remove();
}

</script>
</body>
</html>
