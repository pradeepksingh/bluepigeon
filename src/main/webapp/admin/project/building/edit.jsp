<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingStatusDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderBuildingAmenityDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuildingImageGallery"%>
<%@page import="org.bluepigeon.admin.model.BuildingPanoramicImage"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingStatus"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenity"%>
<%@page import="org.bluepigeon.admin.model.BuildingAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuildingPaymentInfo"%>
<%@page import="org.bluepigeon.admin.model.BuildingOfferInfo"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="../../../head.jsp"%>
<%@include file="../../../leftnav.jsp"%>
<%
	ServletContext webcontext = pageContext.getServletContext();
	int building_id = 0;
	int p_user_id = 0;
	building_id = Integer.parseInt(request.getParameter("building_id"));
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
	BuilderBuilding builderBuilding = null;
	List<BuilderBuilding> builderBuildings = new ProjectDAO().getBuilderProjectBuildingById(building_id);
	if(builderBuildings.size() > 0) {
		builderBuilding = builderBuildings.get(0);
	}
	List<BuilderProject> builderProjects = new ProjectDAO().getBuilderAllProjects();
	List<BuilderBuildingStatus> builderBuildingStatusList = new BuilderBuildingStatusDAO().getBuilderBuildingStatus();
	List<BuilderBuildingAmenity> builderBuildingAmenities = new BuilderBuildingAmenityDAO().getBuilderBuildingAmenityList();
	List<BuildingImageGallery> buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
	List<BuildingPanoramicImage> buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
	List<BuildingAmenityInfo> buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
	List<BuildingPaymentInfo> buildingPaymentInfos = new ProjectDAO().getBuilderBuildingPaymentInfoById(building_id);
	List<BuildingOfferInfo> buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="${baseUrl}/admin/project/building/list.jsp">Building</a></li>
				<li class="active">Update</li>
			</ul>
			<span class="pull-right"><a href="${baseUrl}/admin/project/list.jsp"> << Project List</a></span>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Building Update 
				</h1>
			</div>
			<ul class="nav nav-tabs" id="buildingTabs">
			  	<li class="active"><a data-toggle="tab" href="#basic">Basic Details</a></li>
			  	<li><a data-toggle="tab" href="#buildingdetail">Building Images</a></li>
			  	<li><a data-toggle="tab" href="#payment">Payment Schedules</a></li>
			  	<li><a data-toggle="tab" href="#offer">Offers</a></li>
			</ul>
			<div class="tab-content">
				<div id="basic" class="tab-pane fade in active">
					<form id="updatebuilding" name="updatebuilding" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div id="basicresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<input type="hidden" name="admin_id" id="admin_id" value="<% out.print(p_user_id);%>"/>
										<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
										<div class="row">
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Project Name <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<select id="project_id" name="project_id" class="form-control">
															<option value="0">Select Project</option>
															<% for(BuilderProject builderProject :builderProjects) { %>
															<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderBuilding.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Building Name </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="name" name="name" value="<% out.print(builderBuilding.getName()); %>" />
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Total Floors </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="total_floor" name="total_floor" value="<% out.print(builderBuilding.getTotalFloor());%>"/>
													</div>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-name">
													<label class="control-label col-sm-4">Launch Date <span class='text-danger'>*</span></label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="launch_date" name="launch_date" value="<% if(builderBuilding.getLaunchDate() != null) { out.print(dt1.format(builderBuilding.getLaunchDate()));}%>"/>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Possession Date </label>
													<div class="col-sm-8">
														<input type="text" class="form-control" id="possession_date" name="possession_date" value="<% if(builderBuilding.getPossessionDate() != null) { out.print(dt1.format(builderBuilding.getPossessionDate()));}%>"/>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-6 margin-bottom-5">
												<div class="form-group" id="error-landmark">
													<label class="control-label col-sm-4">Status </label>
													<div class="col-sm-8">
														<select id="status" name="status" class="form-control">
															<% 	for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
															<option value="<% out.print(builderBuildingStatus.getId());%>" <% if(builderBuildingStatus.getId() == builderBuilding.getBuilderBuildingStatus().getId()) { %>selected<% } %>><% out.print(builderBuildingStatus.getName()); %></option>
															<% } %>
														</select>
													</div>
													<div class="messageContainer col-sm-offset-6"></div>
												</div>
											</div>
											<div class="col-lg-12">
												<hr/>
											</div>
											<div class="col-lg-12 margin-bottom-5">
												<div class="form-group" id="error-project_type">
													<label class="control-label col-sm-2">Building Amenities <span class='text-danger'>*</span></label>
													<div class="col-sm-10">
														<% 	for(BuilderBuildingAmenity builderBuildingAmenity :builderBuildingAmenities) {  
															String is_selected = "";
															if(buildingAmenityInfos.size() > 0) { 
																for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
																	if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
																		is_selected = "checked";
																	}
																}
															}
														%>
														<div class="col-sm-3">
															<input type="checkbox" name="amenity_type[]" value="<% out.print(builderBuildingAmenity.getId());%>" <% out.print(is_selected); %>/> <% out.print(builderBuildingAmenity.getName());%>
														</div>
														<% } %>
													</div>
													<div class="messageContainer"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="submit" name="basicdetail" class="btn btn-success btn-sm" >SAVE</button>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div id="buildingdetail" class="tab-pane fade">
					<form id="updateimage" name="updateimage" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<div class="row">
							<div id="imageresponse"></div>
							<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
							<input type="hidden" name="img_count" id="img_count" value="2"/>
							<input type="hidden" name="elvimg_count" id="elvimg_count" value="2"/>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<h3>Upload Building Images</h3>
										<br>
										<div class="row" id="project_images">
											<% for (BuildingImageGallery buildingImageGallery :buildingImageGalleries) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_image<% out.print(buildingImageGallery.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(buildingImageGallery.getImage()); %>" width="200px;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(buildingImageGallery.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
													<div class="messageContainer col-sm-offset-4"></div>
												</div>
											</div>
											<% } %>
										</div>
										<div class="row">
											<span class="pull-right"><a href="javascript:addMoreImages();" class="btn btn-info btn-xs"> + Add More</a></span>
										</div>
										<hr/>
										<h3>Upload Elevation Images</h3>
										<br>
										<div class="row" id="elevation_images">
											<% for (BuildingPanoramicImage buildingPanoramicImage :buildingPanoramicImages) { %>
											<div class="col-lg-4 margin-bottom-5" id="b_elv_image<% out.print(buildingPanoramicImage.getId()); %>">
												<div class="form-group" id="error-landmark">
													<div class="col-sm-12">
														<img alt="Building Images" src="${baseUrl}/<% out.print(buildingPanoramicImage.getPanoImage()); %>" width="100%;">
													</div>
													<label class="col-sm-12 text-left"><a href="javascript:deleteElvImage(<% out.print(buildingPanoramicImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
													<div class="messageContainer col-sm-offset-3"></div>
												</div>
											</div>
											<% } %>
										</div>
										<div class="row">
											<span class="pull-right"><a href="javascript:addMoreElvImages();" class="btn btn-info btn-xs"> + Add More</a></span>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<span class="pull-right">
									<button type="button" name="imagebtn" class="btn btn-success btn-sm" onclick="updateBuildingImages();">SAVE</button>
								</span>
							</div>
						</div>
					</form>
				</div>
				<div id="payment" class="tab-pane fade">
					<form id="updatepayment" name="updatepayment" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="schedule_count" id="schedule_count" value="100000000000"/>
						<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
			 			<div class="row">
			 				<div id="paymentresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="payment_schedule">
											<% for(BuildingPaymentInfo buildingPaymentInfo : buildingPaymentInfos) { %>
											<div class="row" id="schedule-<% out.print(buildingPaymentInfo.getId());%>">
												<input type="hidden" name="payment_id[]" value="<% out.print(buildingPaymentInfo.getId()); %>" />
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% out.print(buildingPaymentInfo.getMilestone());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable </label>
														<div class="col-sm-4">
															<input type="text" class="form-control" id="payable" name="payable[]" value="<% out.print(buildingPaymentInfo.getPayable());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="amount" name="amount[]" value="<% out.print(buildingPaymentInfo.getAmount());%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:deletePayment(<% out.print(buildingPaymentInfo.getId());%>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% } %>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreSchedule();" class="btn btn-info btn-xs">+ Add More Schedule</a>
												</span>
											</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" name="paymentbtn" class="btn btn-success btn-sm" id="paymentbtn" onclick="updateBuildingPayments();">SAVE</button>
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
				<div id="offer" class="tab-pane fade">
					<form id="updateoffer" name="updateoffer" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
						<input type="hidden" name="offer_count" id="offer_count" value="1000000000000"/>
						<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
			 			<div class="row">
			 				<div id="offerresponse"></div>
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-body">
										<div id="offer_area">
											<% for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { %>
											<div class="row" id="offer-<% out.print(buildingOfferInfo.getId()); %>">
												<input type="hidden" name="offer_id[]" value="<% out.print(buildingOfferInfo.getId()); %>" />
												<div class="col-lg-12" style="padding-bottom:5px;">
													<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(buildingOfferInfo.getId()); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-offer_title">
														<label class="control-label col-sm-4">Offer Title <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% out.print(buildingOfferInfo.getTitle()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-discount">
														<label class="control-label col-sm-6">Discount(%) <span class='text-danger'>*</span></label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="discount" name="discount[]" value="<% out.print(buildingOfferInfo.getDiscount()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-4 margin-bottom-5">
													<div class="form-group" id="error-discount_amount">
														<label class="control-label col-sm-6">Discount Amount </label>
														<div class="col-sm-6">
															<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% out.print(buildingOfferInfo.getAmount()); %>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-4">Description </label>
														<div class="col-sm-8">
															<textarea class="form-control" id="description" name="description[]" ><% out.print(buildingOfferInfo.getDescription()); %></textarea>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-applicable_on">
														<label class="control-label col-sm-6">Offer Type </label>
														<div class="col-sm-6">
															<select class="form-control" id="offer_type" name="offer_type[]">
																<option value="1" <% if(buildingOfferInfo.getType().toString() == "1") { %>selected<% } %>>Percentage</option>
																<option value="2" <% if(buildingOfferInfo.getType().toString() == "2") { %>selected<% } %>>Flat Amount</option>
																<option value="3" <% if(buildingOfferInfo.getType().toString() == "3") { %>selected<% } %>>Other</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
												<div class="col-lg-4 margin-bottom-5">
													<div class="form-group" id="error-apply">
														<label class="control-label col-sm-6">Status </label>
														<div class="col-sm-6">
															<select class="form-control" id="offer_status" name="offer_status[]">
																<option value="1" <% if(buildingOfferInfo.getStatus().toString() == "1") { %>selected<% } %>>Active</option>
																<option value="0" <% if(buildingOfferInfo.getStatus().toString() == "0") { %>selected<% } %>>Inactive</option>
															</select>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div>
											</div>
											<% } %>
										</div>
										<div>
											<div class="col-lg-12">
												<span class="pull-right">
													<a href="javascript:addMoreOffer();" class="btn btn-info btn-xs">+ Add More Offers</a>
												</span>
											</div>
										</div>
										<div>
											<div class="row">
												<div class="col-lg-12">
													<div class="col-sm-12">
														<button type="button" class="btn btn-success btn-sm" id="offerbtn" onclick="updateBuildingOffers();">SAVE</button>
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
	</div>
</div>
<%@include file="../../../footer.jsp"%>
<!-- inline scripts related to this page -->
<style>
	.row {
		margin-bottom:5px;
	}
</style>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<script>
$('#possession_date').datepicker({
	format: "dd MM yyyy"
});
$('#launch_date').datepicker({
	format: "dd MM yyyy"
});
$('#updatebuilding').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	project_id: {
            validators: {
                notEmpty: {
                    message: 'Project ID is required and cannot be empty'
                }
            }
        },
    	name: {
            validators: {
                notEmpty: {
                    message: 'Building Name is required and cannot be empty'
                }
            }
        },
        launch_date: {
            validators: {
                notEmpty: {
                    message: 'Launch Date is required and cannot be empty'
                }
            }
        },
        possession_date: {
            validators: {
                notEmpty: {
                    message: 'Possession Date is required and cannot be empty'
                }
            }
        },
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuilding();
});

function updateBuilding() {
	var options = {
	 		target : '#basicresponse', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/building/info/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatebuilding').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#basicresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#basicresponse").removeClass('alert-success');
       	$("#basicresponse").addClass('alert-danger');
		$("#basicresponse").html(resp.message);
		$("#basicresponse").show();
  	} else {
  		$("#basicresponse").removeClass('alert-danger');
        $("#basicresponse").addClass('alert-success');
        $("#basicresponse").html(resp.message);
        $("#basicresponse").show();
        alert(resp.message);
  	}
}


function updateBuildingImages() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddImageRequest,
	 		success :  showAddImageResponse,
	 		url : '${baseUrl}/webapi/project/building/images/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateimage').ajaxSubmit(options);
}

function showAddImageRequest(formData, jqForm, options){
	$("#imageresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddImageResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#imageresponse").removeClass('alert-success');
       	$("#imageresponse").addClass('alert-danger');
		$("#imageresponse").html(resp.message);
		$("#imageresponse").show();
  	} else {
  		$("#imageresponse").removeClass('alert-danger');
        $("#imageresponse").addClass('alert-success');
        $("#imageresponse").html(resp.message);
        $("#imageresponse").show();
        alert(resp.message);
  	}
}

function updateBuildingPayments() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddPaymentRequest,
	 		success :  showAddPaymentResponse,
	 		url : '${baseUrl}/webapi/project/building/payment/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatepayment').ajaxSubmit(options);
}

function showAddPaymentRequest(formData, jqForm, options){
	$("#paymentresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddPaymentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#paymentresponse").removeClass('alert-success');
       	$("#paymentresponse").addClass('alert-danger');
		$("#paymentresponse").html(resp.message);
		$("#paymentresponse").show();
  	} else {
  		$("#paymentresponse").removeClass('alert-danger');
        $("#paymentresponse").addClass('alert-success');
        $("#paymentresponse").html(resp.message);
        $("#paymentresponse").show();
        alert(resp.message);
  	}
}

function updateBuildingOffers() {
	var options = {
	 		target : '#imageresponse', 
	 		beforeSubmit : showAddOfferRequest,
	 		success :  showAddOfferResponse,
	 		url : '${baseUrl}/webapi/project/building/offer/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateoffer').ajaxSubmit(options);
}

function showAddOfferRequest(formData, jqForm, options){
	$("#offerresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddOfferResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#offerresponse").removeClass('alert-success');
       	$("#offerresponse").addClass('alert-danger');
		$("#offerresponse").html(resp.message);
		$("#offerresponse").show();
  	} else {
  		$("#offerresponse").removeClass('alert-danger');
        $("#offerresponse").addClass('alert-success');
        $("#offerresponse").html(resp.message);
        $("#offerresponse").show();
        alert(resp.message);
  	}
}

function deleteImage(id) {
	var flag = confirm("Are you sure ? You want to delete image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/image/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_image"+id).remove();
			}
		},'json');
	}
}

function deleteElvImage(id) {
	var flag = confirm("Are you sure ? You want to delete Elevation Image ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/elevationimage/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#b_elv_image"+id).remove();
			}
		});
	}
}

function deletePayment(id) {
	var flag = confirm("Are you sure ? You want to delete payment slab ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/payment/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#schedule-"+id).remove();
			}
		},'json');
	}
}

function deleteOffer(id) {
	var flag = confirm("Are you sure ? You want to delete offer ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/building/offer/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				$("#offer-"+id).remove();
			}
		});
	}
}


function addMoreImages() {
	var img_count = parseInt($("img_count").val());
	img_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="imgdiv-'+img_count+'">'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="building_image" name="building_image[]" />'
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

function addMoreElvImages() {
	var elvimg_count = parseInt($("elvimg_count").val());
	elvimg_count++;
	var html = '<div class="col-lg-6 margin-bottom-5" id="elvimgdiv-'+elvimg_count+'"><input type="hidden" name="payment_id[]" value="0" />'
					+'<div class="form-group" id="error-landmark">'
					+'<label class="control-label col-sm-4">Select Image </label>'
					+'<div class="col-sm-8 input-group" style="padding:0px 12px;">'
					+'<input type="file" class="form-control" id="elevation_image" name="elevation_image[]" />'
					+'<a href="javascript:removeElvImage('+elvimg_count+');" class="input-group-addon btn-danger">x</a></span>'
					+'</div>'
					+'<div class="messageContainer col-sm-offset-3"></div>'
					+'</div>'
				+'</div>';
	$("#elevation_images").append(html);
	$("#elvimg_count").val(elvimg_count);
}

function removeElvImage(id) {
	$("#elvimgdiv-"+id).remove();
}

function showDetailTab() {
	$('#buildingTabs a[href="#buildingdetail"]').tab('show');
}

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-danger btn-xs">x</a></span></div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-offer_title">'
			+'<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>'
				+'<div class="col-sm-8">'
					+'<input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
			+'<div class="form-group" id="error-discount">'
				+'<label class="control-label col-sm-6">Discount(%) <span class="text-danger">*</span></label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control" id="discount" name="discount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-discount_amount">'
				+'<label class="control-label col-sm-6">Discount Amount </label>'
				+'<div class="col-sm-6">'
					+'<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>'
				+'</div>'
				+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-5 margin-bottom-5">'
			+'<div class="form-group" id="error-applicable_on">'
			+'<label class="control-label col-sm-4">Description </label>'
			+'<div class="col-sm-8">'
			+'<textarea class="form-control" id="description" name="description[]" ></textarea>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'<div class="col-lg-3 margin-bottom-5">'
		+'<div class="form-group" id="error-applicable_on">'
		+'<label class="control-label col-sm-6">Offer Type </label>'
		+'<div class="col-sm-6">'
		+'<select class="form-control" id="offer_type" name="offer_type[]">'
		+'<option value="1">Percentage</option>'
		+'<option value="2">Flat Amount</option>'
		+'<option value="3">Other</option>'
		+'</select>'
		+'</div>'
		+'<div class="messageContainer"></div>'
		+'</div>'
		+'</div>'
		+'<div class="col-lg-4 margin-bottom-5">'
			+'<div class="form-group" id="error-apply">'
			+'<label class="control-label col-sm-6">Status </label>'
			+'<div class="col-sm-6">'
			+'<select class="form-control" id="offer_status" name="offer_status[]">'
			+'<option value="1">Active</option>'
			+'<option value="0">Inactive</option>'
			+'</select>'
			+'</div>'
			+'<div class="messageContainer"></div>'
			+'</div>'
		+'</div>'
		+'</div>';
	$("#offer_area").append(html);
	$("#offer_count").val(offers);
}
function removeOffer(id) {
	$("#offer-"+id).remove();
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


</script>
</body>
</html>
