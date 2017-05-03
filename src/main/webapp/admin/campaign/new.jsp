<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
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
				<li><a href="#">Campaign</a></li>
				<li class="active">Add New Campaign</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>Add New Campaign</h1>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<form id="addcampaign" name="addcampaign" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
						<div class="panel panel-default">
							<div class="panel-body">
								<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Campaign Title <span class="text-danger">*</span> </label>
										<div class="col-sm-9">
											<input type="text" id="title" name="title" placeholder="Enter Campaign title" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
								  	</div>
							  	</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Campaign Type <span class="text-danger">*</span></label>
										<div class="col-sm-9">
											<select name="campaign_type" id="campaign_type" class="form-control">
						                 	   	<option value="">Select Campaign</option>
						                 	   	<option value="1">New Project</option>
						                 	   	<option value="2">New Property</option>
						                 	   	<option value="3">Offers</option>
						                 	   	<option value="4">Event</option>
						                 	   	<option value="5">Referral</option>
								       	  	</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Set date <span class="text-danger">*</span></label>
										<div class="col-sm-9">
											<input type="text" id="set_date" name="set_date" placeholder="Enter Campaign start date" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Content <span class="text-danger">*</span></label>
										<div class="col-sm-9">
											<textarea id="content" name="content" placeholder="Enter content " class="form-control" ></textarea>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Terms <span class="text-danger">*</span></label>
										<div class="col-sm-9">
											<textarea id="terms" name="terms" placeholder="Enter terms" class="form-control" ></textarea>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Recipient Type <span class="text-danger">*</span></label>
										<div class="col-sm-9">
										 	<select name="recipient_type_id" id="recipient_type_id" class="form-control">
							                    <option value="0">Select Recipient Type</option>
							                     <option value="1">Lead</option>
							                     <option value="2">Buyer</option>
							                </select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select City <span class="text-danger">*</span></label>
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
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Project <span class="text-danger">*</span></label>
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
								<div class="col-lg-12 margin-bottom-6">
									<div class="form-group" id="error-project_type">
										<label class="control-label col-sm-2">Recipient <span class='text-danger'>*</span></label>
											<div id="appendbuyer"></div>
										</div>
										<div class="messageContainer"></div>
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
$('#set_date').datepicker({
	format: "dd MM yyyy"
});

$("#city_id").change(function(){
	$.get("${baseUrl}/webapi/campaign/projectlist/"+$("#city_id").val(),{ }, function(data){
		var html = '<option value="0">Select Project</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].projectId+'">'+data[index].projectName+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		checkbox+='</div>';
		$("#project_id").html(html);
 		$("#appendbuyer").html(checkbox);
	},'json');
});

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/campaign/building/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].buildingId+'">'+data[index].buildingName+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		$("#building_id").html(html);
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/campaign/building/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].flatId+'">'+data[index].flatNo+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		$("#flat_id").html(html);
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});

$("#flat_id").change(function(){
	$.get("${baseUrl}/webapi/campaign/flat/buyer/names/"+$("#flat_id").val(),{ }, function(data){
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+data[index].id+'" />'+'&nbsp;'+data[index].name
				checkbox +='</div>';
		});
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});
						
$('#addcampaign').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	title: {
            validators: {
                notEmpty: {
                    message: 'Lead name is required and cannot be empty'
                }
            }
        },
        campaign_type:{
        	validators:{
        		notEmpty: {
        			message:'campaign type is required and cannot be empty'
        		}
        	}
        },
        set_date:{
        	 excluded: false,
             validators: {
                 notEmpty: {
                     message: 'The date is required'
                 }
             }
        },
        content:{
        	validators:{
        		notEmpty:{
        			message: 'content is required and cannot be empty'
        		}
        	}
        },
        terms:{
        	validators:{
        		notEmpty:{
        			message: 'term is required and cannot be empty'
        		}
        	}
        },
        recipient_type_id:{
        	validators:{
        		notEmpty:{
        			message: 'recipient type is required and cannot be empty'
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
        city_id: {
            validators: {
                notEmpty: {
                    message: 'City Name is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addCampaign();
});
function addCampaign() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/campaign/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addcampaign').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/campaign/list.jsp";
  	}
}
</script>


