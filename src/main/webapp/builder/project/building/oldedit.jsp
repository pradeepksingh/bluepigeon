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
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenityStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuildingAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.model.BuildingAmenityWeightage"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletContext" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	ServletContext webcontext = pageContext.getServletContext();
	int building_id = 0;
	int p_user_id = 0;
	building_id = Integer.parseInt(request.getParameter("building_id"));
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
	List<BuildingAmenityWeightage> buildingAmenityWeightages = new ProjectDAO().getBuilderBuildingAmenityWeightageById(building_id);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../css/custom.css" rel="stylesheet">
    <link href="../../css/custom1.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="../../css/colors/megna.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
  
    
<script type="text/javascript">
    $('input[type=checkbox]').click(function(){
    if($(this).is(':checked')){
          var tb = $('<input type=text />');    
          $(this).after(tb)  ;
    }
    else if($(this).siblings('input[type=text]').length>0){
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
        <!-- Top Navigation -->
        <div id="header">
        <%@include file="../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../partial/sidebar.jsp"%>
       </div>
    
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Building Review</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
             
        

                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                             <!-- <h4 class="page-title">Add New Project</h4>
                             <br>-->
                                <ul class="nav tabs-horizontal">
                                    <li class="tab nav-item" aria-expanded="false">
                                        <a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"> <span>Project Details</span></a>
                                    </li>
                                     <li class="tab nav-item">
                                        <a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages1"><span>Building Details</span></a>
                                    </li>
                                    <li class="tab nav-item">
                                        <a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages2"><span>Images</span></a>
                                    </li>
                                     
                                </ul>
                                
                                
                              <div class="tab-content"> 
                              
                               <div id="vimessages" class="tab-pane active" aria-expanded="false">
                                <div class="col-12">
                                <form>
                                <input type="hidden" name="builder_id" id="builder_id" value="<% out.print(p_user_id);%>"/>
								<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
								<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Project Name*</label>
                                    <div class="col-6">
                                   		<select id="project_id" name="project_id" class="form-control">
	                                        <!-- <input class="form-control" type="text" value="project" id="example-search-input">-->
	                                        <option value="0">Select Project</option>
											<% for(BuilderProject builderProject :builderProjects) { %>
											<option value="<% out.print(builderProject.getId()); %>" <% if(builderProject.getId() == builderBuilding.getBuilderProject().getId()) { %>selected<% } %>><% out.print(builderProject.getName()); %></option>
											<% } %>
										</select>
                                    </div>
                                </div>
                              
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Building Name</label>
                                    <div class="col-6">
                                        <input type="text" class="form-control" id="name" name="name" value="<% out.print(builderBuilding.getName()); %>" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Total Floors</label>
                                    <div class="col-6">
                                       <input type="text" class="form-control" id="total_floor" name="total_floor" value="<% out.print(builderBuilding.getTotalFloor());%>"/>
                                    </div>
                                </div>
                                
                                <div class="offset-sm-5 col-sm-7">
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">Save</button>
                                 </div>
                                
                               </form>
                               </div>
                              </div>
                              
                             <div id="vimessages1" class="tab-pane" aria-expanded="false">
                             <form>
                             <input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
                              <% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>   
                                 <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Building Launch Date*</label>
                                    <div class="col-6">
                                        <input class="form-control" type="text" id="launch_date" name="launch_date" value="<% if(builderBuilding.getLaunchDate() != null) { out.print(dt1.format(builderBuilding.getLaunchDate()));}%>"/>
                                    </div>
                                    
                                </div>
                                                               
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Possession</label>
                                    <div class="col-6">
                                        <input class="form-control" type="text" id="possession_date" name="possession_date" value="<% if(builderBuilding.getPossessionDate() != null) { out.print(dt1.format(builderBuilding.getPossessionDate()));}%>"/>
                                    </div>
                                   
                                </div>
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Project Name*</label>
                                    <div class="col-6">
                                   		<select id="status" name="status" class="form-control">
											<% 	for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
											<option value="<% out.print(builderBuildingStatus.getId());%>" <% if(builderBuildingStatus.getId() == builderBuilding.getBuilderBuildingStatus().getId()) { %>selected<% } %>><% out.print(builderBuildingStatus.getName()); %></option>
											<% } %>
										</select>
                                    </div>
                                </div>
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
								<input type="hidden" name="amenity_type[]" value="<% out.print(builderBuildingAmenity.getId());%>" <% out.print(is_selected); %>/> <% //out.print(builderBuildingAmenity.getName());%>
								<% } %>
								<% 	for(BuilderBuildingAmenity builderBuildingAmenity : builderBuildingAmenities) { 
										String is_checked = "";
										if(buildingAmenityInfos.size() > 0) { 
											for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
												if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
													is_checked = "checked";
												}
											}
										}
										Double amenity_wt = 0.0;
										for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
											if(builderBuildingAmenity.getId() == buildingAmenityWeightage.getBuilderBuildingAmenity().getId()) {
												amenity_wt = buildingAmenityWeightage.getAmenityWeightage();
											}
										}
								%>
								<input type="hidden" class="form-control" name="amenity_weightage[]" id="amenity_weightage<% out.print(builderBuildingAmenity.getId());%>" placeholder="Amenity Weightage" value="<% out.print(amenity_wt);%>">
								<% 	for(BuilderBuildingAmenityStages bpaStages :builderBuildingAmenity.getBuilderBuildingAmenityStageses()) { 
										Double stage_wt = 0.0;
										for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
											if(bpaStages.getId() == buildingAmenityWeightage.getBuilderBuildingAmenityStages().getId()) {
												stage_wt = buildingAmenityWeightage.getStageWeightage();
											}
										}
								%>
								<input name="stage_weightage<% out.print(builderBuildingAmenity.getId());%>[]" id="<% out.print(bpaStages.getId());%>" type="hidden" class="form-control" placeholder="Amenity Stage weightage" style="width:200px;display: inline;" value="<% out.print(stage_wt);%>"/>
								<% 	for(BuilderBuildingAmenitySubstages bpaSubstage :bpaStages.getBuilderBuildingAmenitySubstageses()) { 
										Double substage_wt = 0.0;
										for(BuildingAmenityWeightage buildingAmenityWeightage :buildingAmenityWeightages) {
											if(bpaSubstage.getId() == buildingAmenityWeightage.getBuilderBuildingAmenitySubstages().getId()) {
												substage_wt = buildingAmenityWeightage.getSubstageWeightage();
											}
										}
								%>
								<input type="hidden" name="substage<% out.print(bpaStages.getId());%>[]" id="<% out.print(bpaSubstage.getId()); %>" class="form-control" placeholder="Substage weightage" value="<% out.print(substage_wt);%>"/>
								<% } %>
								<% } %>
								<% } %>
                                <div class="form-group row">
                                    <button type="button" class="col-2" onclick="showOffers()">+ADD offers</button>
                                   <!-- <label for="example-search-input" class="col-3 col-form-label">ADD offers</label>
									<div class="col-6">
                                        <input class="form-control" type="text" value="Active" id="example-search-input">
                                    </div>-->
                                </div>
                                
                                 <div id="displayoffers" style="display:none">
                                  <div class="offset-sm-11 col-sm-7">
                                    <i class="fa fa-times"></i> 
                                  </div>
                                   <div class="form-group row">
	                                    <label for="example-search-input" class="col-2 col-form-label">Offer Title*</label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" value="Free Parking" id="example-search-input">
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Discount(%)*</label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" value="100.0" id="example-search-input">
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Discount Amount</label>
	                                    <div class="col-2">
	                                        <input class="form-control" type="text" value="200000.0" id="example-search-input">
	                                    </div>
<!-- 	                                </div> -->
<!-- 	                                <div class="form-group row"> -->
	                                    <label for="example-search-input" class="col-2 col-form-label">Description</label>
	                                    <div class="col-2">
	                                        <textarea class="form-control" rows="" cols=""></textarea>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Offer Type</label>
	                                    <div class="col-2">
	                                     <select class="form-control">
										  <option value="">Percentage</option>
										  <option value="">Discount</option>
										</select>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Status</label>
	                                    <div class="col-2">
	                                     <select class="form-control">
										  <option value="">Active</option>
										  <option value="">Inactive</option>
										</select>
										</div>
	                                </div>
	                             </div>
                                
                                 <div class="form-group row">
                                    <button type="button" class="col-3" id="demandletter" onclick="showDemand()">Demand Letter Breakage</button>
                                    <div class="col-6">
                                        <input class="form-control" style="display:none" type="file" id="demandfile">
                                    </div>
                                   
                                 </div>
                                
                                <div class="offset-sm-10 col-sm-7">
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">Approve</button>
                                 </div>
                                 
                                </form>   
                               </div>

                                <div id="vimessages2" class="tab-pane" aria-expanded="false">
                                 <div class="col-12">
                                  <form>
                                <div class="form-group row" id="project_images">
                                <% for (BuildingImageGallery buildingImageGallery :buildingImageGalleries) { %>
                                    <label for="example-text-input" class="col-3 col-form-label">Upload Project Images</label>
                                    <div class="col-sm-12">
                                    	<img alt="Building Images" src="${baseUrl}/<% out.print(buildingImageGallery.getImage()); %>" width="200px;">
                                    </div>
                                    <label class="col-sm-12 text-left"><a href="javascript:deleteImage(<% out.print(buildingImageGallery.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
                                    <div class="col-6">
                                        <input class="form-control" type="file" value="Acre" id="example-text-input">
                                    </div>
                                </div> 
                                <% } %>
                                <div class="row">
									<span class="pull-right"><a href="javascript:addMoreImages();" class="btn btn-info btn-xs"> + Add More</a></span>
								</div>
                                 <div class="form-group row" id="elevation_images">
                                 <% for (BuildingPanoramicImage buildingPanoramicImage :buildingPanoramicImages) { %>
	                                <label for="example-text-input" class="col-3 col-form-label">Upload Elavation Images</label>
	                                <div class="col-sm-12">
	                                	<img alt="Building Images" src="${baseUrl}/<% out.print(buildingPanoramicImage.getPanoImage()); %>" width="100%;">
	                                </div>
	                                <label class="col-sm-12 text-left"><a href="javascript:deleteElvImage(<%out.print(buildingPanoramicImage.getId()); %>);" class="btn btn-danger btn-sm">x Delete Image</a> </label>
	                                    <div class="col-6">
	                                        <input class="form-control" type="file" value="5000.0" id="example-text-input">
	                                    </div>
                                </div> 
                              <% } %>
                               <div class="row">
									<span class="pull-right"><a href="javascript:addMoreElvImages();" class="btn btn-info btn-xs"> + Add More</a></span>
							   </div> 
                                <div class="offset-sm-5 col-sm-7">
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">SAVE</button>
                                 </div>
                                </form>
                                </div>
                               </div>

                                
                                
                             </div>
                        </div>

                        </div>
                    </div>
                </div>
                
                
            </div>
            <!-- /.container-fluid -->
          <div id="sidebar1"> 
	      		<%@include file="../../partial/footer.jsp"%>
			</div> 
        
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
    
</body>
</html>
<script type="text/javascript">

function showDemand()
{
	 $("#demandfile").show(); 
}

function showOffers()
{
	$("#displayoffers").show(); 
}

</script>
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

$('input[name="amenity_type[]"]').click(function() {
	if($(this).prop("checked")) {
		$("#amenity_stage"+$(this).val()).show();
	} else {
		$("#amenity_stage"+$(this).val()).hide();
	}
});

</script>