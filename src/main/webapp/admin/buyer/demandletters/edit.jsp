<%@page import="org.bluepigeon.admin.model.FlatPaymentSchedule"%>
<%@page import="org.bluepigeon.admin.model.BuildingPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%@page import="org.bluepigeon.admin.model.DemandLettersInfo"%>
<%@page import="org.bluepigeon.admin.model.DemandLetters"%>
<%@page import="org.bluepigeon.admin.dao.DemandLettersDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.data.FlatData"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.Agreement"%>
<%@page import="org.bluepigeon.admin.dao.AgreementDAO"%>
<%@page import="org.bluepigeon.admin.model.AgreementInfo"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderFloorAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloorAmenity"%>
<%@page import="org.bluepigeon.admin.model.FloorAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.FloorLayoutImage"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="../../../../head.jsp"%>
<%@include file="../../../../leftnav.jsp"%>
<%
	int demandletter_id = 0;
	int p_user_id = 0;
	demandletter_id = Integer.parseInt(request.getParameter("demandletter_id"));
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
	DemandLetters demandLetters = new DemandLettersDAO().getDemandLettersById(demandletter_id);
	BuilderFloor builderFloor = null;
	List<BuildingData> buildings = null;
	List<FlatData> flats = null;
	List<DemandLettersInfo> floorAmenityInfos = new DemandLettersDAO().getDemandLettersInfoByDemandLetterId(demandletter_id);
	List<BuilderFloorStatus> builderFloorStatuses = new BuilderFloorStatusDAO().getFloorStatus();
	List<BuilderFloorAmenity> builderFloorAmenities = new BuilderFloorAmenityDAO().getBuilderFloorAmenityList();
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderAllProjects();
	if(builderProjects.size()>0){
		buildings  = new BuyerDAO().getBuildingByProjectId(demandLetters.getBuilderProject().getId());
	}
	if(buildings.size()>0){
		flats = new BuyerDAO().getBookedFlats(buildings.get(0).getId());
	}
	List<BuyerPayment> buyerPayments = new DemandLettersDAO().getBuyerPaymentByDemandId(demandletter_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>
				<li class="active">Update Demand letter</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/buyer/demandletters/list.jsp"> << Demand Letters List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Demand Letters Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Demand Letters Details</a></li>
			  	<li><a data-toggle="tab" href="#demandlettersdocuments">Demand Letters Document</a></li>
			</ul>
			<form id="updatedemandletters" name="updatedemandletters" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
				<div class="tab-content">
					<div id="basic" class="tab-pane fade in active">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="demandletter_id" id="demandletter_id" value="<%out.print(demandletter_id);%>"/>
										<input type="hidden" name="img_count" id="img_count" value="2"/>
										<div class="row">
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Project Name </label>
													<div class="col-sm-7">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == demandLetters.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Building Name </label>
													<div class="col-sm-7">
														<select id="building_id" name="building_id" class="form-control">
															<% if(buildings != null) { %>
															<% for(BuildingData builderBuilding2 :buildings) { %>
															<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == demandLetters.getBuilderBuilding().getId()) { %>selected<% } %>><% out.print(builderBuilding2.getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Building</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Flat Name </label>
													<div class="col-sm-7">
														<select id="flat_id" name="flat_id" class="form-control">
															<% if(flats != null) { %>
															<% for(FlatData flatData :flats) { %>
															<option value="<% out.print(flatData.getId());%>" <% if(flatData.getId() == demandLetters.getBuilderFlat().getId()) { %>selected<% } %>><% out.print(flatData.getName());%></option>
															<% } %>
															<% } else { %>
															<option value="0">Select Flat</option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Name <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(demandLetters.getName()); %>" id="name" name="name" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Email <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(demandLetters.getEmail()); %>" id="email" name="email" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Milestone Name </label>
													<div class="col-sm-7">
														<select id="milestone_id" name="milestone_id" class="form-control">
															<option value="0">Select Milestone</option>
															<% 
																if(builderProjects != null && buildings !=null && flats !=null){
																	List<FlatPaymentSchedule> flatPaymentSchedules = new DemandLettersDAO().getFlatPaymentSchedule( demandLetters.getBuilderFlat().getId());
																	for(FlatPaymentSchedule flatPaymentSchedule :flatPaymentSchedules) { %>
																	<option value="<% out.print(flatPaymentSchedule.getId()); %>" <% if(flatPaymentSchedule.getId() == demandLetters.getPaymentId()) { %>selected<% } %>><% out.print(flatPaymentSchedule.getMilestone()); %></option>
																	<% } 
																}else if(builderProjects != null && buildings !=null){
																	List<BuildingPaymentInfo> buildingPaymentInfos = new DemandLettersDAO().getBuildingPaymentInfo(demandLetters.getBuilderBuilding().getId());
																	for(BuildingPaymentInfo buildingPaymentInfo :buildingPaymentInfos) { %>
																	<option value="<% out.print(buildingPaymentInfo.getId()); %>" <% if(buildingPaymentInfo.getId() == demandLetters.getPaymentId()) { %>selected<% } %>><% out.print(buildingPaymentInfo.getMilestone()); %></option>
																	<% } 
																}else{
																	List<BuilderProjectPaymentInfo> builderProjectPaymentInfos = new DemandLettersDAO().getAllBuilderProjectPaymentInfo(demandLetters.getBuilderProject().getId());
																	for(BuilderProjectPaymentInfo builderProjectPaymentInfo :builderProjectPaymentInfos) { %>
																	<option value="<% out.print(builderProjectPaymentInfo.getId()); %>" <% if(builderProjectPaymentInfo.getId() == demandLetters.getPaymentId()) { %>selected<% } %>><% out.print(builderProjectPaymentInfo.getSchedule()); %></option>
																	<% } 
																}
															%>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Contact <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" value="<%out.print(demandLetters.getContact()); %>" id="contact" name="contact" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<%
												SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
											%>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-5">Last Date </label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="last_date" name="last_date" value="<% if(demandLetters.getLastDate() != null) { out.print(dt1.format(demandLetters.getLastDate()));} %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Remind Every <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<input type="text" class="form-control" id="remind" value="<%out.print(demandLetters.getRemind()); %>" name="remind" />
														<span class="input-group-addon">Days</span>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-4 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-5">Content <span class='text-danger'>*</span></label>
													<div class="col-sm-7">
														<textarea rows="" cols="" class="form-control" id="contect" name="content"><%out.print(demandLetters.getContent()); %></textarea>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											
											<div class="col-lg-12">
												<hr/>
											</div>
											
										</div>
									</div>
								</div>
							</div>	
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" class="btn btn-success btn-sm" onclick="showDetailTab();">Next</button>
								</span>
							</div>
						</div>
					</div>
					<div id="demandlettersdocuments" class="tab-pane fade">
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Demand Letter Document</h3>
										<br>
										<div class="row" id="project_images">
											<%
											 if(floorAmenityInfos !=null){
												for (DemandLettersInfo floorLayoutImage :floorAmenityInfos) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(floorLayoutImage.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Agreement Documents" src="${baseUrl}/<% out.print(floorLayoutImage.getDocUrl()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(floorLayoutImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Plan</a> </label>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<% 
												}
											}
											%>
											<div class="col-lg-6 margin-bottom-5" id="imgdiv-2">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Demand Letter Document </label>
													<div class="col-sm-8 input-group" style="padding:0px 12px;">
														<input type="file" class="form-control" id=demandletter_doc name="demandletter_doc[]" />
<!-- 														<a href="javascript:removeImage(2);" class="input-group-addon btn-danger">x</a></span> -->
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<span class="pull-right"><a href="javascript:addMoreDemandLetterDoc();" class="btn btn-info btn-xs"> + Add More</a></span>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="flooradd" class="btn btn-success btn-sm" >Submit</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#last_date').datepicker({
	format: "dd MM yyyy"
});
$('#updatedemandletters').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	floor_id: {
            validators: {
                notEmpty: {
                    message: 'Floor ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Buyer Name is required and cannot be empty'
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
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateDemandLetter();
});

function updateDemandLetter() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/demandletter/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatedemandletters').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/admin/buyer/demandletters/list.jsp";
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete demand letter ?");
	if(flag) {
		$.get("${baseUrl}/webapi/buyer/demandletter/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function addMoreDemandLetterDoc() {
	var img_count = parseInt($("img_count").val());
	img_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Demand Letter Document </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="demandletter_doc" name="demandletter_doc[]" />'
					+'<a href="javascript:removeImage('+img_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#project_images").append(html);
	$("#img_count").val(img_count);
}

function removeImage(id) {
	$("#imgdiv-"+id).remove();
}


function showDetailTab() {
	$('#buildingTabs a[href="#demandlettersdocuments"]').tab('show');
}
$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/demandletter/building/"+$("#project_id").val(),{},function(data){
		var html = "";
		var milestone = '<option value="">Select Milestone</option>';
		$(data).each(function(index){
			if(data[index].buildingId > 0)
				html = html + '<option value="'+data[index].buildingId+'"> '+data[index].buildingName+'</option>';
			if(data[index].paymentId > 0)
				milestone = milestone + '<option value="'+data[index].paymentId+'"> '+data[index].paymentMilestone+'</option>';
		});
		$("#building_id").html(html);
		$("#milestone_id").html(milestone);
	},'json');
});
$("#building_id").change(function(){
	//alert($("#building_id").val());
	//alert('Hello');
	//$.noConflict();
		$.get("${baseUrl}/webapi/buyer/demandletter/flat/",{ building_id: $("#building_id").val() }, function(data){
			var html = '<option value="">Select Flat</option>';
		//	$("#milestone_id").html("");
			var milestone = '<option value = "">Select Milestone</option>';
			
			$(data).each(function(index){
				if(data[index].flatId > 0)
					html = html + '<option value="'+data[index].flatId+'">'+data[index].flatName+'</option>';
				if(data[index].paymentId>0)
					milestone = milestone + '<option value="'+data[index].paymentId+'">'+data[index].paymentMilestone+'</option>';
			});
			$("#flat_id").html(html);
			$("#milestone_id").html(milestone);
		},'json');
});


$("#flat_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/demandletter/flat/buyer",{ flat_id: $("#flat_id").val() }, function(data){
		var milestone = '<option value = "">Select Milestone</option>';
		$(data).each(function(index){
			if( data[index].name != null || typeof data[index].name != 'undefined')
				$("#name").val(data[index].name);
// 			else
// 				$("#name").val("");
			if(data[index].contact != null)
				$("#contact").val(data[index].contact);
			//else
				//$("#contact").val("");
			if(data[index].email!= null)
				$("#email").val(data[index].email);
		//	else
			//	$("#email").val("");
			if(data[index].paymentId>0)
				milestone = milestone + '<option value="'+data[index].paymentId+'">'+data[index].paymentMilestone+'</option>';
		});
		$("#milestone_id").html(milestone);
	},'json');
});


</script>
</body>
</html>