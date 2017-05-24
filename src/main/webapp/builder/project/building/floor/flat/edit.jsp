<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFlatAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatType"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.FlatAmenityWeightage"%>
<%@page import="org.bluepigeon.admin.model.FlatAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FlatPaymentSchedule"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	int flat_id = 0;
	int p_user_id = 0;
	int building_id = 0;
	int project_id = 0;
	int floor_id = 0;
	flat_id = Integer.parseInt(request.getParameter("flat_id"));
	session = request.getSession(false);
	Builder adminuserproject = new Builder();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (Builder)session.getAttribute("ubname");
			p_user_id = adminuserproject.getId();
		}
	}
	List<BuilderBuilding> buildings = null;
	List<BuilderFloor> floors = null;
	BuilderFlat builderFlat = null;
	List<BuilderFlat> builderFlats = new ProjectDAO().getBuildingActiveFlatById(flat_id);
	if(builderFlats.size() > 0) {
		builderFlat = builderFlats.get(0);
		floor_id = builderFlat.getBuilderFloor().getId();
		building_id = builderFlat.getBuilderFloor().getBuilderBuilding().getId();
		project_id = builderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId();
		buildings = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
		floors = new ProjectDAO().getBuildingActiveFloors(building_id);
		
	}
	List<BuilderFlatStatus> builderFlatStatuses = new BuilderFlatStatusDAO().getBuilderActiveFlatStatus();
	List<BuilderFlatAmenity> builderFlatAmenities = new BuilderFlatAmenityDAO().getBuilderActiveFlatAmenityList();
	List<FlatAmenityInfo> flatAmenityInfos = new ProjectDAO().getBuilderFlatAmenityInfos(flat_id);
	List<FlatPaymentSchedule> flatPaymentSchedules = new ProjectDAO().getBuilderActiveFlatPaymentSchedules(flat_id);
	List<BuilderBuildingFlatType> builderFlatTypes = new ProjectDAO().getBuilderBuildingFlatTypeByBuildingId(builderFlat.getBuilderFloor().getBuilderBuilding().getId());
	List<ProjectData> builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(p_user_id);
	List<FlatAmenityWeightage> flatAmenityWeightages = new ProjectDAO().getActiveFlatAmenityWeightageByFlatId(flat_id);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../../../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="../../../../css/colors/megna.css" id="theme" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../../../css/custom.css">
 
    <script src="../../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../../../js/jquery.form.js"></script>
    <script src="../../../../js/bootstrap-datepicker.min.js"></script>
    <script src="../../../../js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
    $('input[type=checkbox]').click(function() {
        if ($(this).is(':checked')) {
            var tb = $('<input type=text />');
            $(this).after(tb);
        } else if ($(this).siblings('input[type=text]').length > 0) {
            $(this).siblings('input[type=text]').remove();
        }
    })
    </script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
         <div id="header">
        <%@include file="../../../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../../../partial/sidebar.jsp"%>
       </div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Flat Update</h4>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box"><br>
                              <div class="col-12">
                                   <form id="addfloor" name="addfloor" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                                   		 <input type="hidden" name="flat_id" id="flat_id" value="<% out.print(flat_id);%>"/>
                                   		 <input type="hidden" name="admin_id" id="admin_id" value="1"/>
										 <input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
										 <input type="hidden" name="img_count" id="img_count" value="2"/>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Flat No.</label>
                                             <div class="col-8">
                                                 <input class="form-control" type="text" id="flat_no" name="flat_no" value="<% out.print(builderFlat.getFlatNo()); %>" >
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <div class="form-group row">
                                             <label for="example-search-input" class="col-4 col-form-label">Project Name</label>
                                             <div class="col-8">
                                                <select id="project_id" name="project_id" class="form-control">
													<option value="0">Select Project</option>
													<% for(ProjectData builderProject :builderProjects) { %>
													<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == project_id) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
													<% } %>
												</select>
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                    	 <div class="form-group row">
                                             <label for="example-search-input" class="col-4 col-form-label">Flat Type Name</label>
                                             <div class="col-8">
                                                <select id="building_id" name="building_id" class="form-control">
													<% if(buildings != null) { %>
													<% for(BuilderBuilding builderBuilding2 :buildings) { %>
													<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
													<% } %>
													<% } else { %>
													<option value="0">Select Building</option>
													<% } %>
												</select>
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                          <div class="form-group row">
                                             <label for="example-search-input" class="col-4 col-form-label">>Floor No.</label>
                                             <div class="col-8">
                                                <select id="floor_id" name="floor_id" class="form-control">
													<% if(floors != null) { %>
													<% for(BuilderFloor builderFloor2 :floors) { %>
													<option value="<% out.print(builderFloor2.getId());%>" <% if(builderFloor2.getId() == floor_id) { %>selected<% } %>><% out.print(builderFloor2.getName());%></option>
													<% } %>
													<% } else { %>
													<option value="0">Select Floor</option>
													<% } %>
												</select>
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                          <div class="form-group row">
                                             <label for="example-search-input" class="col-4 col-form-label">Flat Type Name</label>
                                             <div class="col-8">
                                               <select id="flat_type_id" name="flat_type_id" class="form-control">
													<% if(builderFlatTypes != null) { %>
													<% for(BuilderBuildingFlatType builderFlatType :builderFlatTypes) { %>
													<option value="<% out.print(builderFlatType.getBuilderFlatType().getId());%>" <% if(builderFlat.getBuilderFlatType().getId() == builderFlatType.getBuilderFlatType().getId()) { %>selected<% } %>><% out.print(builderFlatType.getBuilderFlatType().getName());%></option>
													<% } %>
													<% } else { %>
													<option value="0">Select Flat Type</option>
													<% } %>
												</select>
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Bedrooms</label>
                                             <div class="col-8">
                                                 <input class="form-control" type="text" id="bedroom" name="bedroom" value="<% out.print(builderFlat.getBedroom()); %>" >
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Bathrooms</label>
                                             <div class="col-8">
                                                 <input class="form-control" type="text" id="bathroom" name="bathroom" value="<% out.print(builderFlat.getBathroom()); %>" >
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Balcony</label>
                                             <div class="col-8">
                                                 <input class="form-control" type="text" id="balcony" name="balcony" value="<% out.print(builderFlat.getBalcony()); %>" >
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Possession Date </label>
                                             <div class="col-8">
                                                 <input class="form-control" type="text" id="possession_date" name="possession_date" value="<% if(builderFlat.getPossessionDate() != null) { out.print(dt1.format(builderFlat.getPossessionDate()));}%>" >
                                             </div>
                                             <div class="messageContainer col-sm-offset-3"></div>
                                         </div>
                                         <div class="form-group row">
                                             <label for="example-text-input" class="col-4 col-form-label">Status</label>
                                             <div class="col-8">
                                                <select id="status" name="status" class="form-control">
													<% for(BuilderFlatStatus builderFlatStatus :builderFlatStatuses) { %>
													<option value="<% out.print(builderFlatStatus.getId());%>" <% if(builderFlat.getBuilderFlatStatus().getId() ==  builderFlatStatus.getId()) { %>selected<% } %>><% out.print(builderFlatStatus.getName()); %></option>
													<% } %>
												</select>
                                             </div>
                                         </div>
		                                 <div class="form-group row">
		                                     <label for="example-tel-input" class="col-4 col-form-label">Flat Configuration</label>
		                                     <div class="form-group row block">
			                                     <div class="checkbox checkbox-inverse">
			                                     <% for(BuilderFlatAmenity builderFlatAmenity :builderFlatAmenities) {  
													String is_checked = "";
													for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
														if(flatAmenityInfo.getBuilderFlatAmenity().getId() == builderFlatAmenity.getId()) {
															is_checked = "checked";
														}
													}
												%>
													<div class="col-sm-3">
														<input id="checkbox8c" type="checkbox" name="amenity_type[]" value="<% out.print(builderFlatAmenity.getId());%>" <% out.print(is_checked); %>/><label for="checkbox8c"> <% out.print(builderFlatAmenity.getName());%></label>
													</div>
												<% } %>
                                 				</div>
                                 			</div>
	                                    </div>
	                                    <% 	for(BuilderFlatAmenity builderFlatAmenity : builderFlatAmenities) { 
											String is_checked = "";
											if(flatAmenityInfos.size() > 0) { 
												for(FlatAmenityInfo flatAmenityInfo :flatAmenityInfos) {
													if(flatAmenityInfo.getBuilderFlatAmenity().getId() == builderFlatAmenity.getId()) {
														is_checked = "checked";
													}
												}
											}
											Double amenity_wt = 0.0;
											for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
												if(builderFlatAmenity.getId() == flatAmenityWeightage.getBuilderFlatAmenity().getId()) {
													amenity_wt = flatAmenityWeightage.getAmenityWeightage();
												}
											}
										%>
										<input type="hidden" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderFlatAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
										<% 	for(BuilderFlatAmenityStages bpaStages :builderFlatAmenity.getBuilderFlatAmenityStageses()) { 
											Double stage_wt = 0.0;
											for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
												if(bpaStages.getId() == flatAmenityWeightage.getBuilderFlatAmenityStages().getId()) {
													stage_wt = flatAmenityWeightage.getStageWeightage();
												}
											}
										%>
										<input name="stage_weightage<% out.print(builderFlatAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="hidden" class="form-control" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/>
										<% 	for(BuilderFlatAmenitySubstages bpaSubstage :bpaStages.getBuilderFlatAmenitySubstageses()) { 
											Double substage_wt = 0.0;
											for(FlatAmenityWeightage flatAmenityWeightage :flatAmenityWeightages) {
												if(bpaSubstage.getId() == flatAmenityWeightage.getBuilderFlatAmenitySubstages().getId()) {
													substage_wt = flatAmenityWeightage.getSubstageWeightage();
												}
											}
										%>
										<input type="hidden" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
										<% } %>
										<% } %>
										<% } %>
<!--                                         <div class="form-group row"> -->
<!--                                              <label for="example-tel-input" class="col-4 col-form-label">Building Name</label> -->
<!--                                              <div class="col-8"> -->
<!--                                                  <input class="form-control" type="text" value="How do I shoot web" id="example-search-input"> -->
<!--                                              </div> -->
<!--                                         </div> -->
<!--                                         <div class="form-group row"> -->
<!--                                             <label for="example-tel-input" class="col-4 col-form-label">Floor Layout Images</label> -->
<!--                                             <div class="col-8"> -->
<!--                                                 <input class="form-control" type="file" value="How do I shoot web" id="example-search-input"> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="form-group row"> -->
<!--                                              <label for="example-tel-input" class="col-4 col-form-label">Floor Elevation Images</label> -->
<!--                                              <div class="col-8"> -->
<!--                                                  <input class="form-control" type="file" value="How do I shoot web" id="example-search-input"> -->
<!--                                              </div> -->
<!--                                         </div> -->
                                   		<button type="submit" name="floorUpdate" class="btn btn-success waves-effect waves-light m-r-10">Update</button>
                              	    </form>
                              </div>
                           </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
	 <div id="sidebar1"> 
	   	  <%@include file="../../../../partial/footer.jsp"%>
	 </div> 
</body>
</html>
<script>
$('#possession_date').datepicker({
	format: "dd MM yyyy"
});
$('#addfloor').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	flat_id: {
            validators: {
                notEmpty: {
                    message: 'Flat ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Floor Name is required and cannot be empty'
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
        'amenity_type[]': {
        	validators: {
                notEmpty: {
                    message: 'Please select amenity'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateFlat();
});

function updateFlat() {
	var amenityWeightage = "";
	$('input[name="amenity_type[]"]:checked').each(function() {
		amenity_id = $(this).val();
		$('input[name="stage_weightage'+amenity_id+'[]"]').each(function() {
			stage_id = $(this).attr("id");
			stage_weightage = $(this).val();
			$('input[name="substage'+stage_id+'[]"]').each(function() {
				if(amenityWeightage != "") {
					amenityWeightage = amenityWeightage + "," + amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				} else {
					amenityWeightage = amenity_id + "#" + $("#amenity_weightage"+amenity_id).val() + "#" + stage_id + "#" + stage_weightage + "#" + $(this).attr("id") + "#" + $(this).val() + "#" + false;
				}
			});
		});
	});
	$("#amenity_wt").val(amenityWeightage);
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/floor/flat/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addfloor').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/project/building/floor/flat/list.jsp?floor_id="+$("#floor_id").val();
  	}
}

function deletePayment(id) {
	var flag = confirm("Are you sure ? You want to delete payment slab ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/floor/flat/payment/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#schedule-"+id).remove();
			}
		},'json');
	}
}

function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	var html = '<div class="row" id="schedule-'+schedule_count+'"><input type="hidden" name="payment_id[]" value="0" />'
				+'<hr/>'
				+'<div class="col-lg-5 margin-bottom-5">'
				+'<div class="form-group" id="error-schedule">'
				+'<label class="control-label col-sm-4">Milestone <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
				+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-payable">'
				+'<label class="control-label col-sm-8">% of Net Payable </label>'
				+'<div class="col-sm-4">'
				+'<input type="text" class="form-control" id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-3 margin-bottom-5">'
				+'<div class="form-group" id="error-amount">'
				+'<label class="control-label col-sm-6">Amount </label>'
				+'<div class="col-sm-6">'
				+'<input type="text" class="form-control" id="amount" name="amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
				+'</div>'
				+'</div>'
				+'<div class="col-lg-1">'
				+'<span><a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs">x</a></span>'
				+'</div>'
			+'</div>';
	$("#payment_schedule").append(html);
	$("#schedule_count").val(schedule_count);
}
function removeSchedule(id) {
	$("#schedule-"+id).remove();
}


function showDetailTab() {
	$('#buildingTabs a[href="#payment"]').tab('show');
}

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{},function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
	
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/floor/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Floor</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#floor_id").html(html);
	},'json');
	$.get("${baseUrl}/webapi/project/building/flattype/names/"+$("#building_id").val(),{},function(data){
		var html = '<option value="0">Select Flat Type</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
		});
		$("#flat_type_id").html(html);
	},'json');
	
});
$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

</script>
