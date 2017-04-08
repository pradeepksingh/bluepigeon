<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="java.util.Set"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderLead"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
	int lead_id = 0;
    int type_size = 0;
    int flat_size =	0;
    int building_size = 0;
    int city_size = 0;
	lead_id = Integer.parseInt(request.getParameter("lead_id"));
	BuilderLead builderLead = null;
	if(lead_id > 0) {
		builderLead = new ProjectDAO().getBuilderProjectLeadById(lead_id);
	}
	
	int project_size = 0;
	int builder_id = 0;
	List<BuilderBuilding> builderBuildings = null;
	List<BuilderFlat> builderFlats = null;
 	List<BuilderProject> builderProjects = new ProjectLeadDAO().getProjectList();
 	if(builderProjects.size()>0){
    	project_size = builderProjects.size();
 		builderBuildings = new ProjectLeadDAO().getBuildingByProjectId(builderProjects.get(0).getId());
 	}
 	if(builderBuildings.size()>0){
 		building_size =	builderBuildings.size();
 		builderFlats = new ProjectDAO().getBuilderProjectBuildingFlats(builderBuildings.get(0).getId());
 	}
 	if(builderFlats.size()>0)
 		flat_size = builderFlats.size();
 	List<City> cities = new	ProjectLeadDAO().getAllCity();
 	if(cities.size()>0)
 		city_size =	cities.size();
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	if(builderPropertyTypes.size()>0)
 		type_size = builderPropertyTypes.size();
 	
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a></li>
				<li><a href="#">Project Lead</a></li>
				<li class="active">Update New Lead</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>Update New Lead</h1>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<form id="updatelead" name="updatelead" class="form-horizontal" action="" method="post">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Project </label>
										<div class="col-sm-9">
											<select name="project_id" id="project_id" class="form-control">
						                 	   	<option value="0">Select Project</option>
						                  	   	<% for(int i=0; i < project_size ; i++){ %>
												<option value="<% out.print(builderProjects.get(i).getId());%>"<%if(builderProjects.get(i).getId() == builderLead.getBuilderProject().getId()) {%>selected<%} %> ><% out.print(builderProjects.get(i).getName());%></option>
											  	<% } %>
								       	  	</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
								  	</div>
							  	</div>
							  	<input type="hidden" id="lead_id" name="lead_id" value="<%out.print(lead_id); %>" >
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Select Building </label>
										<div class="col-sm-9">
											<select name="building_id" id="building_id" class="form-control">
						                 	   	<option value="0">Select Building</option>
						                 	   	<% for(int i=0; i < building_size ; i++){ %>
												<option value="<% out.print(builderBuildings.get(i).getId());%>"<%if(builderBuildings.get(i).getId() == builderLead.getBuilderBuilding().getId()) {%>selected<%} %> ><% out.print(builderBuildings.get(i).getName());%></option>
											  	<% } %>
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
						                 	   	<% for(int i=0; i < flat_size; i++){ %>
						                 	   	<script type="text/javascript">
						                 	   		consloe.log("HI :: "+<%out.print(builderLead.getBuilderFlat().getId());%>);
						                 	   	</script>
												<option value="<% out.print(builderFlats.get(i).getId());%>"<%if(builderFlats.get(i).getId() == builderLead.getBuilderFlat().getId()) {%>selected<%} %> ><% out.print(builderFlats.get(i).getFlatNo());%></option>
											  	<% } %>
								       	  	</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Lead Name </label>
										<div class="col-sm-9">
											<input type="text" id="name" name="name" value="<%out.print(builderLead.getName()); %>"	placeholder="Enter lead name" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Mobile </label>
										<div class="col-sm-9">
											<input type="text" id="mobile" name="mobile" value="<%out.print(builderLead.getMobile()); %>" placeholder="Enter lead phone number" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>
										<div class="col-sm-9">
											<input type="text" id="email" name="email" value="<%out.print(builderLead.getEmail()); %>" placeholder="Enter lead email" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">City </label>
										<div class="col-sm-9">
											<input type="text" id="city" name="city" value="<%out.print(builderLead.getCity()); %>"	 placeholder="Enter city name" class="form-control" />
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Area </label>
										<div class="col-sm-9">
											<input type="text" id="area" name="area" placeholder="Enter lead area" value="<%out.print(builderLead.getArea()); %>" class="form-control" />
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
							                    <option value="1" <%if(builderLead.getSource() == 1){ %>selected<%} %>>App</option>
							                    <option value="2" <%if(builderLead.getSource() == 2){ %>selected<%} %>>Website</option>
							                    <option value="3" <%if(builderLead.getSource() == 3){ %>selected<%} %>>Google</option>
							                    <option value="4" <%if(builderLead.getSource() == 4){ %>selected<%} %>>Facebook</option>
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
							                    <option value="1"<%if(builderLead.getIntrestedIn() == 1){ %>selected<%} %>>Buy</option>
							                    <option value="2"<%if(builderLead.getIntrestedIn() == 2){ %>selected<%} %>>Rental</option>
							                    <option value="3"<%if(builderLead.getIntrestedIn() == 3){ %>selected<%} %>>Resale</option>
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
												<option value="<% out.print(builderPropertyTypes.get(i).getId());%>" <%if(builderPropertyTypes.get(i).getId() == builderLead.getBuilderPropertyType().getId()){ %>selected<%} %> ><% out.print(builderPropertyTypes.get(i).getName());%></option>
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
											<textarea id="discount_offered" name="discount_offered" placeholder="Enter Discount " class="form-control" ><%out.print(builderLead.getDiscountOffered());%></textarea>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<div class="col-lg-6 margin-bottom-5">
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Status </label>
										<div class="col-sm-9">
				                       		<select name="status" id="status" class="form-control">
												<option value="1"<%if(builderLead.getStatus() == 1){ %>selected<%} %>> Active </option>
												<option value="0" <%if(builderLead.getStatus() == 0){ %>selected<%} %>> Inactive </option>
											</select>
										</div>
										<div class="messageContainer col-sm-offset-3"></div>
									</div>
								</div>
								<input type="hidden" name="added_by" id="added_by" value="1"/>
								<div class="col-lg-12 margin-bottom-5">
									<div class="clearfix form-actions">
										<div class="pull-right">
											<button type="submit" class="btn btn-success">Update</button>
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
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].flatNo+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
						
				
$('#updatelead').bootstrapValidator({
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
	updateLead();
});

function updateLead() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatelead').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/leads/list.jsp";
  	}
}
</script>