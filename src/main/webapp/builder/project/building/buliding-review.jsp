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
                                    <label for="example-search-input" class="col-3 col-form-label">Floors</label>
                                    <div class="col-6">
                                        <select class="form-control">
										  <option value="">abc</option>
										  <option value="">xyz</option>
										 
										</select>
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
	                                </div>
	                                <div class="form-group row">
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
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Upload Project Images</label>
                                    <div class="col-6">
                                        <input class="form-control" type="file" value="Acre" id="example-text-input">
                                    </div>
                                </div> 
                                
                                 <div class="form-group row">
                                <label for="example-text-input" class="col-3 col-form-label">Upload Elavation Images</label>
                                    <div class="col-6">
                                        <input class="form-control" type="file" value="5000.0" id="example-text-input">
                                    </div>
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
                
                
                <!-- /.row -->
                <!-- .row -->
               
                <!-- /.row -->
                <!-- .row -->
                
                <!-- .right-sidebar -->
                <div class="right-sidebar" style="overflow: visible;">
                    <div class="slimScrollDiv" style="position: relative; overflow-x: visible; overflow-y: hidden; width: auto; height: 100%;"><div class="slimscrollright" style="overflow: hidden; width: auto; height: 100%;">
                        <div class="rpanel-title"> Service Panel <span><i class="ti-close right-side-toggle"></i></span> </div>
                        <div class="r-panel-body">
                            <ul>
                                <li><b>Layout Options</b></li>
                                <li>
                                    <div class="checkbox checkbox-info">
                                        <input id="checkbox1" type="checkbox" class="fxhdr">
                                        <label for="checkbox1"> Fix Header </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="checkbox checkbox-warning">
                                        <input id="checkbox2" type="checkbox" checked="" class="fxsdr">
                                        <label for="checkbox2"> Fix Sidebar </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="checkbox checkbox-success">
                                        <input id="checkbox4" type="checkbox" class="open-close">
                                        <label for="checkbox4"> Toggle Sidebar </label>
                                    </div>
                                </li>
                            </ul>
                            <ul id="themecolors" class="m-t-20">
                                <li><b>With Light sidebar</b></li>
                                <li><a href="javascript:void(0)" theme="default" class="default-theme">1</a></li>
                                <li><a href="javascript:void(0)" theme="green" class="green-theme">2</a></li>
                                <li><a href="javascript:void(0)" theme="gray" class="yellow-theme">3</a></li>
                                <li><a href="javascript:void(0)" theme="blue" class="blue-theme">4</a></li>
                                <li><a href="javascript:void(0)" theme="purple" class="purple-theme">5</a></li>
                                <li><a href="javascript:void(0)" theme="megna" class="megna-theme working">6</a></li>
                                <li><b>With Dark sidebar</b></li>
                                <br>
                                <li><a href="javascript:void(0)" theme="default-dark" class="default-dark-theme">7</a></li>
                                <li><a href="javascript:void(0)" theme="green-dark" class="green-dark-theme">8</a></li>
                                <li><a href="javascript:void(0)" theme="gray-dark" class="yellow-dark-theme">9</a></li>
                                <li><a href="javascript:void(0)" theme="blue-dark" class="blue-dark-theme">10</a></li>
                                <li><a href="javascript:void(0)" theme="purple-dark" class="purple-dark-theme">11</a></li>
                                <li><a href="javascript:void(0)" theme="megna-dark" class="megna-dark-theme">12</a></li>
                            </ul>
                            <ul class="m-t-20 chatonline">
                                <li><b>Chat option</b></li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/varun.jpg" alt="user-img" class="img-circle"> <span>Varun Dhavan <small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/genu.jpg" alt="user-img" class="img-circle"> <span>Genelia Deshmukh <small class="text-warning">Away</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/ritesh.jpg" alt="user-img" class="img-circle"> <span>Ritesh Deshmukh <small class="text-danger">Busy</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/arijit.jpg" alt="user-img" class="img-circle"> <span>Arijit Sinh <small class="text-muted">Offline</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/govinda.jpg" alt="user-img" class="img-circle"> <span>Govinda Star <small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/hritik.jpg" alt="user-img" class="img-circle"> <span>John Abraham<small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/john.jpg" alt="user-img" class="img-circle"> <span>Hritik Roshan<small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/pawandeep.jpg" alt="user-img" class="img-circle"> <span>Pwandeep rajan <small class="text-success">online</small></span></a>
                                </li>
                            </ul>
                        </div>
                    </div><div class="slimScrollBar" style="background: rgb(220, 220, 220); width: 5px; position: absolute; top: 0px; opacity: 0.4; display: block; border-radius: 7px; z-index: 99; right: 1px;"></div><div class="slimScrollRail" style="width: 5px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div>
                </div>
                <!-- /.right-sidebar -->
            </div>
            <!-- /.container-fluid -->
          <div id="sidebar1"> 
	      		<%@include file="../../partial/footer.jsp"%>
			</div> 
        
        <!-- /#page-wrapper -->
    
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