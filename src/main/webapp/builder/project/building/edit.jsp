<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
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
	int project_id = 0;
	int p_user_id = 0;
	int building_size_list = 0;
	BuilderBuilding builderBuilding = null;
	List<BuilderBuilding> builderBuildings = null;
	List<BuilderBuilding> builderBuildingList = null;
	List<ProjectData> builderProjects = null;
	List<BuilderBuildingAmenity> builderBuildingAmenities = null;
	List<BuilderBuildingStatus> builderBuildingStatusList = null;
	List<BuildingImageGallery> buildingImageGalleries = null;
	List<BuildingPanoramicImage> buildingPanoramicImages = null;
	List<BuildingAmenityInfo> buildingAmenityInfos  = null;
	List<BuildingPaymentInfo> buildingPaymentInfos = null;
	List<BuildingOfferInfo> buildingOfferInfos = null;
	List<BuildingAmenityWeightage> buildingAmenityWeightages = null;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	session = request.getSession(false);
	BuilderEmployee adminuserproject = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (BuilderEmployee)session.getAttribute("ubname");
			if(adminuserproject != null){
				p_user_id = adminuserproject.getBuilder().getId();
				builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(p_user_id);
				if(building_id>0 && project_id > 0){
					System.err.println("projectId :: "+project_id+" \n Building Id :: "+building_id);
					builderBuildings = new ProjectDAO().getBuilderProjectBuildingById(building_id);
					if(builderBuildings.size() > 0) {
						builderBuilding = builderBuildings.get(0);
					}
					builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
					building_size_list = builderBuildingList.size();
					builderBuildingStatusList = new BuilderBuildingStatusDAO().getActiveBuilderBuildingStatus();
					builderBuildingAmenities = new BuilderBuildingAmenityDAO().getActiveBuilderBuildingAmenityList();
					buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
				    buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
					buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
					buildingPaymentInfos = new ProjectDAO().getActiveBuilderBuildingPaymentInfoById(building_id);
					buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
					buildingAmenityWeightages = new ProjectDAO().getActiveBuilderBuildingAmenityWeightageById(building_id);
				}
// 				}else if(project_id > 0 && building_id == 0){
// 					out.println("projectId :: "+project_id+" \n Building Id :: "+building_id);
// 					builderBuildings = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
// 					if(builderBuildings.size()>0){
// 						building_id = builderBuildings.get(0).getId();
// 						builderBuildingStatusList = new BuilderBuildingStatusDAO().getActiveBuilderBuildingStatus();
// 						builderBuildingAmenities = new BuilderBuildingAmenityDAO().getActiveBuilderBuildingAmenityList();
// 						buildingImageGalleries = new ProjectDAO().getBuilderBuildingImagesById(building_id);
// 					    buildingPanoramicImages = new ProjectDAO().getBuilderBuildingElevationImagesById(building_id);
// 						buildingAmenityInfos = new ProjectDAO().getBuilderBuildingAmenityInfoById(building_id);
// 						buildingPaymentInfos = new ProjectDAO().getActiveBuilderBuildingPaymentInfoById(building_id);
// 						buildingOfferInfos = new ProjectDAO().getBuilderBuildingOfferInfoById(building_id);
// 						buildingAmenityWeightages = new ProjectDAO().getActiveBuilderBuildingAmenityWeightageById(building_id);
// 					}
				}
			}
		}
	//}
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
    <title>Blue Piegon</title>
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
    <link rel="stylesheet" type="text/css" href="${baseUrl}/builder/css/selectize.css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../js/jquery.form.js"></script>
    <script src="../../js/bootstrap-datepicker.min.js"></script>
  <script src="../../js/bootstrapValidator.min.js"></script>
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
        <div id="header">
        <%@include file="../../partial/header.jsp"%>
        </div>
       <div id="sidebar1"> 
       	<%@include file="../../partial/sidebar.jsp"%>
       </div>
    </div>
    <div id="page-wrapper" style="min-height: 2038px;">
        <div class="container-fluid">
          <div class="row">
                <div class="col-lg-3 col-sm-6 col-xs-12 m-t-15 ">
                	<a href="${baseUrl}/builder/project/edit.jsp?project_id=<%out.print(project_id);%>">
                    <div id="project" class="top-white-box ">PROJECT</div>
                    </a>
                </div>
            	 <div  class="col-lg-3 col-sm-6 col-xs-12 m-t-15">
	                 <a href="${baseUrl}/builder/project/building/edit.jsp?project_id=<%out.print(project_id);%>&building_id=<%out.print(building_id);%>">
	                     <div id="building" class="top-blue-box ">BUILDING</div>
	                 </a>
            	</div>
                <div  class="col-lg-3 col-sm-6 col-xs-12  m-t-15">
                    <div id="floor" class="top-white-box" >FLOOR</div>
                </div>
                <div  class="col-lg-3 col-sm-6 col-xs-12  m-t-15">
                    <div id="flat" class="top-white-box">FLAT</div>
                </div>
           </div>
          
           		<div class="row">
           			<div class="col-md-3 col-sm-6 col-xs-12">
                        <select id="filter_building_id" name="filter_building_id" class="form-control">
                                <% for(BuilderBuilding builderBuilding2 : builderBuildingList){ %>
                      			<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName()); %></option>
                      			<%} %>
                        </select>
                    </div>
          	 	</div>
           
           <div class="row">
               <div class="col-lg-12">
                   <div class="white-box">
                   	<div class="color-box">
                           <ul class="nav nav-tabs">
                               <li class="active" >
                                   <a data-toggle="tab"  href="#vimessages" > <span>Basic Details</span></a>
                               </li>
                                <li>
                                   <a  data-toggle="tab" href=""><span>Pricing Details</span></a>
                               </li>
                               <li>
                                   <a  data-toggle="tab" href=""><span>Payment Schedule</span></a>
                               </li>
                               <li>
                                   <a  data-toggle="tab" href=""><span>Offers</span></a>
                               </li>
                           </ul>
                           <div class="tab-content"> 
                             <div id="vimessages" class="tab-pane active" aria-expanded="false">
                               <div id="basicresponse" class="col-sm-12"></div><br>
                           <div class="col-12">
                           	<form id="updatebuilding" name="updatebuilding" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                           		<input type="hidden" name="admin_id" id="admin_id" value="1"/>
								<input type="hidden" name="building_id" id="building_id" value="<% out.print(building_id);%>"/>
								<div class="row">
									<div class="col-md-6">
                           				<div class="form-group row">
                             		  	<label for="example-search-input" class="col-sm-4 col-form-label">Project Name*</label>
                              		  		<div class="col-sm-6">
                              		 	 		<div>
                                	   <!-- <input class="form-control" type="text" value="project" id="example-search-input">-->
                                		  			<select id="project_id" name="project_id" class="form-control" disabled>
													  <% 
													  if(builderProjects !=null){
													  
													    	for(ProjectData builderProject :builderProjects) {
													  %>
													   <option value="<%if(builderProject != null && builderProjects.size() >0){ out.print(builderProject.getId()); }%>" <% if(builderProject != null){if(builderProject.getId() == builderBuilding.getBuilderProject().getId()) { %>selected<% }} %>><% out.print(builderProject.getName()); %></option>
													   <%}} %>
												  </select>
                               	  	  			</div>
                               	  	  		</div>
                               	  	  </div>
                               	</div>
                              	<div class="col-md-6">
                                	<div class="form-group row">
                                		<label for="example-search-input" class="col-sm-4 col-form-label">Building Name</label>
                                		<div class="col-sm-6">
                                			<div>
												<input class="form-control" type="text" readonly="true" id="name" name="name" value="<% out.print(builderBuilding.getName()); %>">
                                			</div>
                                		</div>
                               		</div>
                               	</div>
                           </div>
                           <% SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy"); %>
                           <div class="row">
                           		<div class="col-md-6">
	                               <div class="form-group row">
	                                    <label for="example-search-input" class="col-sm-4 col-form-label">Total Floors</label>
	                                    <div class="col-sm-6">
		                                    <div>
		                                        <input class="form-control" readonly="true" type="text" id="total_floor" name="total_floor" value="<% out.print(builderBuilding.getTotalFloor());%>"/>
		                                    </div>
	                                    </div>
	                               </div>
                               </div>
                               <div class="col-md-6">
                               		<div class="form-group row">
                               			<label for="example-search-input" class="col-sm-4 col-form-label">Launch Date*</label>
                               			<div class="col-sm-6">
                               				<input class="form-control" type="text" disabled id="launch_date" name="launch_date" value="<% if(builderBuilding.getLaunchDate() != null) { out.print(dt1.format(builderBuilding.getLaunchDate()));}%>">
                               			</div>
                               		</div>
                               </div>
                           </div>
                           <div class="row">
                           		<div class="col-md-6">
                           			<div class="form-group row">
                           			<label for="example-search-input" class="col-sm-4 col-form-label">Possession Date</label>
                           				<div class="col-sm-6">
                           					<input class="form-control" type="text" disabled id="possession_date" name="possession_date" value="<% if(builderBuilding.getPossessionDate() != null) { out.print(dt1.format(builderBuilding.getPossessionDate()));}%>"/>
                           				</div>
                           			</div>
                           		</div>
                           		<div class="col-md-6">
                           			<div class="form-group row">
                           				<label for="example-search-input" class="col-sm-4 col-form-label">Status *</label>
                           				<div class="col-sm-6">
                           					<select id="status" name="status" class="form-control" disabled>
												<% 	for(BuilderBuildingStatus builderBuildingStatus :builderBuildingStatusList) { %>
												<option value="<% out.print(builderBuildingStatus.getId());%>" <% if(builderBuildingStatus.getId() == builderBuilding.getBuilderBuildingStatus().getId()) { %>selected<% } %>><% out.print(builderBuildingStatus.getName()); %></option>
												<% } %>
											</select>
										</div>
                           			</div>
                           		</div>
                           </div>
                               <div class="offset-sm-5 col-sm-7">
                                    <button type="submit" name="basicdetail"  class="btn btn-info waves-effect waves-light m-t-10">Save</button>
                               </div>
                          </form>
                      </div>
                   </div>
                   
                        <div id="vimessages1" class="tab-pane" aria-expanded="false">
                           <div id="offerresponse" class="col-sm-12"></div><br>
						   		<form id="updateoffer" name="updateoffer" action="" method="post" class="form-horizontal" enctype="multipart/form-data">
									<input type="hidden" name="building_id" id="building_id" value="<% out.print(builderBuilding.getId());%>"/>
									<input type="hidden" name="amenity_wt" id="amenity_wt" value=""/>
									
                             		
                             		
		                            <%
		                            if(builderBuildingAmenities != null){
		                            for(BuilderBuildingAmenity builderBuildingAmenity :builderBuildingAmenities) {  
										String is_selected = "";
										if(buildingAmenityInfos.size() > 0) { 
											for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
												if(buildingAmenityInfo.getBuilderBuildingAmenity() != null){
													if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
														is_selected = "checked";
													}
												}
											}
										}
									%>
									<input type="hidden" name="amenity_type[]" value="<% out.print(builderBuildingAmenity.getId());%>" <% out.print(is_selected); %>/> <%// out.print(builderBuildingAmenity.getName());%>
									<%} %>
									<% 	for(BuilderBuildingAmenity builderBuildingAmenity : builderBuildingAmenities) { 
										String is_checked = "";
										if(buildingAmenityInfos.size() > 0) { 
											for(BuildingAmenityInfo buildingAmenityInfo :buildingAmenityInfos) {
												if(buildingAmenityInfo.getBuilderBuildingAmenity() != null){
													if(buildingAmenityInfo.getBuilderBuildingAmenity().getId() == builderBuildingAmenity.getId()) {
														is_checked = "checked";
													}
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
									<% } 
									}
									}}
									%>
			                   		<div id="offer" class="tab-pane fade active in">
										<input type="hidden" name="offer_count" id="offer_count" value="10002">
							 			<div class="row">
											<div class="col-lg-12">
												<div class="panel panel-default">
													<div class="panel-body">
														<div id="offer_area">
															<% for(BuildingOfferInfo buildingOfferInfo :buildingOfferInfos) { %>
															<div class="row" id="offer-<% out.print(buildingOfferInfo.getId()); %>">
																<input type="hidden" name="offer_id[]" value="<% out.print(buildingOfferInfo.getId()); %>" />
																<div class="col-lg-12" style="padding-bottom:5px;">
																	<span class="pull-right"><a href="javascript:deleteOffer(<% out.print(buildingOfferInfo.getId()); %>);" class="btn btn-primary btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span>
																</div>
																<div class="col-lg-5 margin-bottom-5">
																	<div class="form-group" id="error-offer_title">
																		<label class="control-label col-sm-4">Offer Title <span class="text-danger">*</span></label>
																		<div class="col-sm-8">
																			<input type="text" class="form-control" id="offer_title" name="offer_title[]" value="<% out.print(buildingOfferInfo.getTitle()); %>">
																		</div>
																		<div class="messageContainer"></div>
																	</div>
																</div>
																<div class="col-lg-3 margin-bottom-5">
																	<div class="form-group" id="error-discount">
																		<label class="control-label col-sm-6">Discount(%) <span class="text-danger">*</span></label>
																		<div class="col-sm-6">
																			<input type="text" class="form-control" id="discount" name="discount[]" value="<% out.print(buildingOfferInfo.getDiscount()); %>">
																		</div>
																		<div class="messageContainer"></div>
																	</div>
																</div>
																<div class="col-lg-4 margin-bottom-5">
																	<div class="form-group" id="error-discount_amount">
																		<label class="control-label col-sm-6">Discount Amount </label>
																		<div class="col-sm-6">
																			<input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value="<% out.print(buildingOfferInfo.getAmount()); %>">
																		</div>
																		<div class="messageContainer"></div>
																	</div>
																</div>
																<div class="col-lg-5 margin-bottom-5">
																	<div class="form-group" id="error-applicable_on">
																		<label class="control-label col-sm-4">Description </label>
																		<div class="col-sm-8">
																			<textarea class="form-control" id="description" name="description[]"><% out.print(buildingOfferInfo.getDescription()); %></textarea>
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
																	<a href="javascript:addMoreOffer();" class="btn btn-info btn-md">+ Add More Offers</a>
																</span>
															</div>
														</div>
														<div>
															<div class="row">
																<div class="col-lg-12">
																	<div class="col-sm-12">
																		<button type="button" class="btn btn-success btn-md" id="offerbtn" onclick="updateBuildingOffers();">Approve</button>
																	</div>
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
           </div>
        </div>
      </div>
            <!-- /.container-fluid -->
 <div id="sidebar1"> 
	<%@include file="../../partial/footer.jsp"%>
</div> 
</body>
</html>
<script src="../../js/bootstrapValidator.min.js"></script>
<script src="../../js/bootstrap-datepicker.min.js"></script>
<script src="../../js/jquery.form.js"></script>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script type="text/javascript" src="${baseUrl}/builder/js/selectize.min.js"></script>
<script type="text/javascript">
// $select_building = $("#filter_building_id").selectize({
// 	persist: false,
// 	 onChange: function(value) {
// 		// getProjectFilterList(value);
// 		//alert($("#project_id").val()+" "+value);
// 		window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+value;
// 	 },
// 	 onDropdownOpen: function(value){
//     	 var obj = $(this);
// 		var textClear =	 $("#filter_building_id :selected").text();
//     	 if(textClear.trim() == "Enter Building Name"){
//     		 obj[0].setValue("");
//     	 }
//      }
// });
<%-- <%if(building_size_list > 0){%> --%>
// 	select_building = $select_building[0].selectize;
<%-- <%}%> --%>

$("#filter_building_id").change(function(){
	
	window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val();
});

$('#launch_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updateoffer').data('bootstrapValidator').revalidateField('launch_date');
});

$('#possession_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updateoffer').data('bootstrapValidator').revalidateField('possession_date');
});
function showDemand()
{
	 $("#demandfile").show(); 
}

function showOffers()
{
	$("#displayoffers").show(); 
}

function addMoreOffer() {
	var offers = parseInt($("#offer_count").val());
	offers++;
	var html = '<div class="row" id="offer-'+offers+'"><hr/><input type="hidden" name="offer_id[]" value="0" />'
		+'<div class="col-lg-12" style="padding-bottom:5px;"><span class="pull-right"><a href="javascript:removeOffer('+offers+');" class="btn btn-primary btn-xs" style="background-color: #000000;border-color: #000000;">x</a></span></div>'
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
$('#updateoffer').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	launch_date: {
            validators: {
                callback: {
                    message: 'Wrong Launch Date',
                    callback: function (value, validator) {
                        var m = new moment(value, 'DD MMM YYYY', true);
                        if (!m.isValid()) {
                            return false;
                        } else {
                        	return true;
                        }
                    }
                }
            }
        },
        possession_date: {
            validators: {
                callback: {
                    message: 'Wrong Possession Date',
                    callback: function (value, validator) {
                        var m = new moment(value, 'DD MMM YYYY', true);
                        if (!m.isValid()) {
                            return false;
                        } else {
                        	return true;
                        }
                    }
                }
            }
        },
        total_floor: {
            validators: {
                notEmpty: {
                    message: 'Total floor number is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuildingOffers();
});
function updateBuildingOffers() {
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
	 		target : '#offerresponse', 
	 		beforeSubmit : showAddOfferRequest,
	 		success :  showAddOfferResponse,
	 		url : '${baseUrl}/webapi/builder/building/offer/update',
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

$("#building").click(function(){
	 var check = $("#building").hasClass('top-lue-box');
	 if(!check){
		 $("#building").removeClass('top-white-box');
		 $("#building").addClass('top-blue-box');
		 var isProject = $("#project").hasClass('top-blue-box');
		 if(isProject){
			 $("#project").removeClass('top-blue-box');
			 $('#project').addClass('top-white-box');
		 }
		 var isFloor = $('#floor').hasClass('top-blue-box');
		 if(isFloor){
			 $('#floor').removeClass('top-blue-box');
			 $('#floor').addClass('top-white-box');
		 }
		 var isFlat = $("#flat").hasClass('top-blue-box');
		 if(isFlat){
			 $('#flat').removeClass('top-blue-box');
			 $('#flat').addClass('top-white-box');
		 }
	 }
	
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
        total_floor: {
            validators: {
                notEmpty: {
                    message: 'Total floor number is required and cannot be empty'
                }
            }
        }
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
	 		url : '${baseUrl}/webapi/builder/building/update',
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

</script>