<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalInfo"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectProjectType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="java.util.List"%>
<%
	int p_user_id = 0;
	int project_id=0;
	BuilderProject projectList = null;
	List<BuilderBuilding> buildingList = null;
	List<ProjectImageGallery> imageGaleries = new ArrayList<ProjectImageGallery>();
	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
	project_id = Integer.parseInt(request.getParameter("project_id"));
	projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectApprovalInfo> projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	imageGaleries = new ProjectDAO().getProjectImagesByProjectId(project_id);
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			p_user_id = builder.getBuilder().getId();
			buildingList =  new ProjectDAO().getBuilderProjectBuildings(project_id);
		}
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/custom.css">
     <link href="../plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/switchery/dist/switchery.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/multiselect/css/multi-select.css" rel="stylesheet" type="text/css" />
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
   <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../plugins/bower_components/raphael/raphael-min.js"></script>
    <script src="../plugins/bower_components/morrisjs/morris.js"></script>
   
  
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
       <div id="header">
        	<%@include file="../partial/header.jsp"%>
        </div>
    	<div id="sidebar1"> 
       		<%@include file="../partial/sidebar.jsp"%>
       	</div>
       	</div>
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <!-- .page title -->
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Property Detail</h4>
                        </div>
                    <!-- /.page title -->
                    <!-- .breadcrumb -->
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12"> 
                    <span class="pull-right"><a href="${baseUrl}/builder/sales/list.jsp" class="btn btn-default btn-sm"> << Project List</a></span>
                    </div>
                    <!-- /.breadcrumb -->
                </div>
                <!-- .row -->
                <input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id); %>" />
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div class="white-box">
                         <% if(imageGaleries != null){
                        	// int imgCount=1;
                        	 %>
                           <button class="full" data-toggle="modal" data-target=".bs-example-modal-lg">
                          <% try{
                        	  if(imageGaleries.get(0).getImage() != null){
                          %>
                           			<img src="${baseUrl}/<% out.print(imageGaleries.get(0).getImage()); %>" alt="Second slide image" width="491" height="390" class="full">
                           <%}}catch(Exception e){ %>
                           			<img src="../plugins/images/Untitled-1.png" alt="Second slide image" class="full">
                            <%}} %>
                           </button>
                        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						  <div class="modal-dialog modal-lg">
						    <div class="modal-content">
						      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						       <div class="carousel-inner">
								  <%
								//   out.print(imageGaleries);
								try{
								  if(imageGaleries.get(0).getImage() != null){
								   int imageCount=1;
								  for(ProjectImageGallery projectImageGallery : imageGaleries){ %>
								  
								 
								  <%if(projectImageGallery != null){ 
								  	
								  %>
								    <div class="item">
								     	<img class="img-responsive" src="${baseUrl}/<% out.print(projectImageGallery.getImage()); %>" alt="bp"  style="width: 100%;"  class="full">
								     	<div class="carousel-caption">
								        	Another Image
								      	</div>
								    </div>
								    <% }%>
<!-- 								     <div class="item"> -->
<!-- 								      <img class="img-responsive" src="../plugins/images/Untitled-1.png" alt="bp" style="width: 100%;" class="full"> -->
<!-- 								      <div class="carousel-caption"> -->
<!-- 								        Another Image -->
<!-- 								      </div> -->
<!-- 								    </div> -->
 								
								    <% }}}catch(Exception e){%>
<!-- 								    <div class="carousel-inner"> -->
								     <div class="item active">
								     	<img class="img-responsive full" src="../plugins/images/Untitled-1.png" alt="bp" style="width: 100%;" class="full">
								      	<div class="carousel-caption">
								        	One Image
								      	</div>
								    </div>
								    <%} %>
<!-- 								    </div> -->
								     </div>
									  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
									    <span class="glyphicon glyphicon-chevron-left"></span>
									  </a>
									  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
									    <span class="glyphicon glyphicon-chevron-right"></span>
									  </a>
							   </div>
						    </div>
						  </div>
						</div>
                            <h4 class="p-t-20 fw-500"><%out.print(projectList.getCity().getName());%>, <%out.print(projectList.getLocality().getName());%>, <%out.print(projectList.getName());%></h4>
                            <h5><span class="text-muted"><i class="fa fa-map-marker text-danger m-r-10" aria-hidden="true"></i><%out.print(projectList.getState().getName());%> / <%out.print(projectList.getCountry().getName());%></span></h5>
                            <hr class="m-0">
                            <p class="text-dark p-t-20 pro-desc"><%out.print(projectList.getDescription()); %></p>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="white-box">
                                    <h5 class="box-title fw-500">Amenities</h5>
                                    <hr class="m-0">
                                    <ul class="pro-amenities text-dark m-b-0">
                                    <%
                                    	for(BuilderProjectAmenityInfo projectAmenity :projectAmenityInfos){
                                    %>
                                        <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span><%out.print(projectAmenity.getBuilderProjectAmenity().getName()); %></span></li>
                                     <%
                                     	}
                                     %>
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>WiFi</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Basketball Court</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Fireplace</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Doorman</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Swimming Pool</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Gym</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Parking</span></li> -->
<!--                                         <li> <span><i class="fa fa-check-circle text-success" aria-hidden="true"></i></span> <span>Laundry</span></li> -->
                                    </ul>
                                </div>
                            </div>
                            
                            <div class="col-sm-6">
                               <div class="white-box">
                            <h5 class="box-title fw-500">Community Information</h5>
                            <hr class="m-0">
                            <div class="table-responsive pro-rd p-t-10">
                                <table class="table">
                                    <tbody class="text-dark">
                                    	<% if(projectList!=null){ %>
                                        <tr>
                                            <td>Address</td>
                                            <td><%	
                                            	out.print(projectList.getAddr1()); %><br>
                                            	<% 
                                            	out.print(projectList.getAddr2()); %>
                                             </td> 
                                        </tr>
                                        <tr>
                                            <td>Subdivision</td>
                                            <td><%out.print(projectList.getLocality().getName()); %></td>
                                        </tr>
                                        <tr>
                                            <td>City</td>
                                            <td><%out.print(projectList.getCity().getName()); %></td>
		                                 </tr>
		                                 <% }%>
		                            </tbody>
		                         </table>
		                       </div>
		                     </div>
		                   </div>
                    
<!--                             <div class="col-sm-12"> -->
<!--                                 <div class="white-box p-l-0 p-r-0 p-b-10"> -->
<!--                                     <h5 class="box-title fw-500 p-l-20">Location</h5> -->
<!--                                     <iframe src="d" width="100%" height="244" frameborder="0" style="border:0" allowfullscreen></iframe> -->
<!--                                 </div> -->
<!--                             </div> -->
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="white-box">
                            <h5 class="box-title fw-500">Essential Information</h5>
                            <hr class="m-0">
                            <div class="table-responsive pro-rd p-t-10">
                                <table class="table">
                                    <tbody class="text-dark">
                                        <tr>
                                            <td>Project Type</td>
                                            <td><%
                                             		int j= projectProjectTypes.size();
		                                            for(int i=0;i<j;i++ ){
		                                            	if(j>1){
		                                            			out.print(projectProjectTypes.get(i).getBuilderProjectType().getName()+", ");
		                                            			
		                                            	}else{
		                                            		out.print(projectProjectTypes.get(i).getBuilderProjectType().getName());
		                                            	}
		                                         }%>
		                                     </td>
                                        </tr>
                                        <tr>
                                            <td>Property Type</td>
                                            <td><%
                                            		int propertytypeCount = projectPropertyTypes.size();
													for(int i=0;i<projectPropertyTypes.size();i++){
														if(propertytypeCount > 1){
															out.print(projectPropertyTypes.get(i).getBuilderPropertyType().getName()+", ");
															propertytypeCount--;
														}else{
															out.print(projectPropertyTypes.get(i).getBuilderPropertyType().getName());
														}
													}
                                            %></td>
                                        </tr>
                                         <tr>
                                            <td>Configuration</td>
                                            <td><%	int configurationCount = projectConfigurationInfos.size();
                                            		for(BuilderProjectPropertyConfigurationInfo configurationInfo : projectConfigurationInfos){
                                            			if(configurationCount > 1){
						                                	out.print(configurationInfo.getBuilderProjectPropertyConfiguration().getName()+", ");
						                                	configurationCount--;
                                            			}
                                            			else{
                                            				out.print(configurationInfo.getBuilderProjectPropertyConfiguration().getName());
                                            			}
                                            		}
                                            %></td>
                                        </tr>
                                        
                                        <tr>
                                            <td>Project Area</td>
                                            <td><%out.print(projectList.getProjectArea()+" "+projectList.getAreaUnit().getName()); %></td>
                                        </tr>
<!--                                         <tr> -->
<!--                                             <td>Lot SQFT</td> -->
<!--                                             <td>256</td> -->
<!--                                         </tr> -->
                                        <%
                                        	for(BuilderProjectPropertyType builderProjectPropertyType: projectPropertyTypes){
                                        %>
                                        <tr>
                                         <td>No. of <%out.print(builderProjectPropertyType.getBuilderPropertyType().getName());; %>
                                            <td><%out.print(builderProjectPropertyType.getValue()); %></td>
                                              </tr>
                                        <%} %>
<!--                                             <tr> -->
<!--                                                 <td>No. of Flats</td> -->
<!--                                                 <td>50</td> -->
<!--                                                 </tr> -->
                                           <tr>
                                            <td>Year Built</td>
                                            <td><%
                                            DateFormat dateFormat = new SimpleDateFormat("yyyy");
                            	    	    Date date = projectList.getPossessionDate();
                                            out.print(dateFormat.format(date)); %></td>
                                        </tr>
                                       
                                        <tr>
                                            <td>Project Approval</td>
                                            <td><%	int approvalCount=projectApprovalInfos.size();
													for(BuilderProjectApprovalInfo builderProjectApprovalInfo : projectApprovalInfos){
														if(approvalCount > 1){
															out.print(builderProjectApprovalInfo.getBuilderProjectApprovalType().getName()+", ");
															approvalCount--;
														}else{
															out.print(builderProjectApprovalInfo.getBuilderProjectApprovalType().getName());
														}
													}
                                           %></td>
                                    </tbody>
                                </table>
                                 
                            </div>
                        </div>
                        <div class="white-box col-sm-12">
                        <a href="#addCountry" class="btn btn-info btn-lg btn-round pull-right col-sm-12" style="margin: -22px 1px;" onclick="getActiveProjectFlats();" role="button" data-toggle="modal"><i class="fa fa-plus"></i>Book Now</a>
<!--                         <button id="#addCountry" type="button" onclick="getActiveProjectFlats();" class="btn btn-info bt-sm btn-rounded pull-right" style="margin-right:-20px;">New Request</button> -->
                        </div>
<!--                         <div class="white-box p-0"> -->
                    
<!--                             <hr class="m-0"> -->
<!--                             <div class="pd-agent-inq"> -->
<!--                                 <h4 class="box-title">Request Inquiry</h4> -->
<!--                                 <form class="form-horizontal form-agent-inq"> -->
<!--                                     <div class="form-group"> -->
<!--                                         <div class="col-md-12"> -->
<!--                                             <input type="text" class="form-control" placeholder="Name"> </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group"> -->
<!--                                         <div class="col-md-12"> -->
<!--                                             <input type="text" class="form-control" placeholder="Phone"> </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group"> -->
<!--                                         <div class="col-md-12"> -->
<!--                                             <input type="email" class="form-control" placeholder="E-Mail"> </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group"> -->
<!--                                         <div class="col-md-12"> -->
<!--                                             <textarea class="form-control" rows="3" placeholder="Message"></textarea> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="form-group"> -->
<!--                                         <div class="col-md-12"> -->
<!--                                             <button type="submit" class="btn btn-danger btn-rounded pull-right">Submit Request</button> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </form> -->
<!--                             </div> -->
<!--                         </div> -->
                     
                    </div>
                </div>
              </div>
            </div>
            <div id="addCountry" class="modal fade" style="">
				<div id="cancel-overlay" class="modal-dialog" style="opacity:1 ;width:400px ">
  					<div class="modal-content-new">
		          	<div class="modal-header">
		              	<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
		              	<h4 class="modal-title" id="myModalLabel">Refine results to show project with</h4>
		          	</div>
         				<div class="modal-body" style="background-color:#f5f5f5;">
             				<div class="row">
	             				<div class="col-sm-4">
	                       			<select name="building_id" id="building_id" class="form-control">
										<option value="0"> building </option>
										<%for(BuilderBuilding builderBuilding : buildingList){ %>
										<option value="<%out.print(builderBuilding.getId());%>"> <%out.print(builderBuilding.getName()); %> </option>
										<%} %>
									</select>
								</div>
								<div class="col-sm-4">
									<select name="floor_id" id="floor_id" class="form-control">
										<option value="0"> Floor </option>
									</select>
								</div>
								<div class="col-sm-4">
									<select name="even_odd_id" id="even_odd_id" class="form-control">
										<option value="0">Odd / Even</option>
										<option value="1">odd</option>
										<option value ="2">even</option>
								</select>
								</div>
							</div>
							<div class="row" id="flatList">
		              		<div class="col-xs-3">
		                       		<label for="password" class="control-label">Country Name</label>
		                       		<p id="error" class="bg-danger nopadding" ></p>
		                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter country name"/>
		                  		
		              		</div>
		              		<div class="col-xs-3">
		                  		
		                       		<label for="password" class="control-label">Country Name</label>
		                       		<p id="error" class="bg-danger nopadding" ></p>
		                       		<input type="text" name="name" id="name" class="form-control" placeholder="Enter country name"/>
		                  		
		              		</div>
		              	</div>
		              	<div class="row">
		              		<div class="col-xs-12">
		                  		<div class="form-group">
		                       		<label for="password" class="control-label">Status</label>
		                       		<select name="status" id="status" class="form-control">
										<option value="1"> Active </option>
										<option value="0"> Inactive </option>
									</select>
		                  		</div>
		              		</div>
		              	</div>
			              <div class="row">
			           		<div class="col-xs-12">
			           			<button type="submit" class="btn btn-info" onclick="addCountry();">SAVE</button>
			           		</div>
			           	</div>
          			</div>
      			</div>
			</div>
		</div>
	        <!-- /.container-fluid -->
	        <div id="sidebar1"> 
	       	   		<%@include file="../partial/footer.jsp"%>
	      	</div>
</body>

</html>
<script type="text/javascript">
$(document).ready(function(){ 
	$('.item').first().addClass('active');
});
window.openNewModal = function() {
	$('#addCountry').modal('hide');
	setTimeout(function() {
    	$('#addCountry').modal('show');
    }, 500);
}
$("#building_id").change(function(){
	//$("#flatList").empty();
// 	var flats = "";
// 	$.get("${baseUrl}/webapi/builder/building/floor/filternames/"+$("#building_id").val(),{},function(data){
// 		var html = "<option value='0'>Floor</option>";
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'"> '+data[index].name+'</option>';
// 		});
// 		$("#floor_id").html(html);
// 	},'json');
 	getActiveProjectFlats();
 	
	
});
function getActiveProjectFlats(){
	alert("Project Id :: "+$("#project_id").val());
	$.post("${baseUrl}/webapi/builder/building/floor/filternames",{project_id: $("#project_id").val(), building_id : $("#building_id").val(), floor_id : $("#floor_id").val(), evenOrodd : $("#even_odd_id").val()},function(data){
		alert(data);
// 		var oTable = $("#tblProjects").dataTable();
// 	    oTable.fnClearTable();
// 	    $(data).each(function(index){
// 		    var vieworder = '<a href="${baseUrl}/admin/project/edit.jsp?project_id='+data[index].id+'" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>';
// 		    var status = '';
// 		    if(data[index].status == 1) {
// 		    	status = '<span class="label label-success">Active</span>';
// 		    } else {
// 		    	status = '<span class="label label-warning">Inactive</span>';
// 		    }
// 	    	var row = [];
// 	    	row.push(data[index].name);
// 	    	row.push(data[index].builderName);
// 	    	row.push(data[index].cityName);
// 		    row.push(data[index].localityName);
// 	    	row.push(status);
// 	    	row.push(vieworder);
// 	    	oTable.fnAddData(row);
// 	    });
// sucess: {
// 	alert(data);
// };
// eoor:{
// 	alert("Hi tehere is amn eoor");
// }
	},'json');
}
</script>
