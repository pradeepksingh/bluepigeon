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
	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
	project_id = Integer.parseInt(request.getParameter("project_id"));
	projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	session = request.getSession(false);
	Builder builder = new Builder();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			p_user_id = builder.getId();
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
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                        <h4 class="page-title">Property Detail</h4> </div>
                    <!-- /.page title -->
                    <!-- .breadcrumb -->
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12"> 
                    </div>
                    <!-- /.breadcrumb -->
                </div>
                <!-- .row -->
                <div class="row">
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div class="white-box">
                           <button class="full" data-toggle="modal" data-target=".bs-example-modal-lg">
                           <img src="../plugins/images/Untitled-1.png" alt="Second slide image" class="full">
                           </button>
                        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						  <div class="modal-dialog modal-lg">
						    <div class="modal-content">
						      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

								  <div class="carousel-inner">
								    <div class="item active">
								     <img class="img-responsive full" src="../plugins/images/Untitled-1.png" alt="bp" style="width: 100%;" class="full">
								      <div class="carousel-caption">
								        One Image
								      </div>
								    </div>
								    <div class="item">
								      <img class="img-responsive" src="../plugins/images/Untitled-1.png" alt="bp" style="width: 100%;" class="full">
								      <div class="carousel-caption">
								        Another Image
								      </div>
								    </div>
								     <div class="item">
								      <img class="img-responsive" src="../plugins/images/Untitled-1.png" alt="bp" style="width: 100%;" class="full">
								      <div class="carousel-caption">
								        Another Image
								      </div>
								    </div>
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
                                        <tr>
                                            <td>Address</td>
                                            <td><%	if(projectList!=null){
                                            	out.print(projectList.getAddr1()); %><br>
                                            	<% 
                                            	out.print(projectList.getAddr2()); %>
                                             </td> 
                                        </tr>
                                        <tr>
                                            <td>Subdivision</td>
                                            <td><%
                                            out.print(projectList.getLocality().getName()); %></td>
                                        </tr>
                                        <tr>
                                            <td>City</td>
                                            <td><% 
                                            out.print(projectList.getCity().getName()); }%></td>
		                                 </tr>
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
		                                            			out.print(projectProjectTypes.get(i).getBuilderProjectType().getName()+",");
		                                            			
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
                                            <td>1BHK, 2BHK</td>
                                        </tr>
                                        
                                        <tr>
                                            <td>Square Footage</td>
                                            <td>2,123</td>
                                        </tr>
                                        <tr>
                                            <td>Lot SQFT</td>
                                            <td>256</td>
                                        </tr>
                                        <tr>
                                         <td>No. of Building</td>
                                            <td>4</td>
                                              </tr>
                                            <tr>
                                                <td>No. of Flats</td>
                                                <td>50</td>
                                                </tr>
                                           <tr>
                                            <td>Year Built</td>
                                            <td>2012</td>
                                        </tr>
                                       
                                        <tr>
                                            <td>Project Approval</td>
                                            <td>Active</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="white-box p-0">
                    
                            <hr class="m-0">
                            <div class="pd-agent-inq">
                                <h4 class="box-title">Request Inquiry</h4>
                                <form class="form-horizontal form-agent-inq">
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input type="text" class="form-control" placeholder="Name"> </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input type="text" class="form-control" placeholder="Phone"> </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input type="email" class="form-control" placeholder="E-Mail"> </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <textarea class="form-control" rows="3" placeholder="Message"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-danger btn-rounded pull-right">Submit Request</button>
                                        </div>
                                    </div>
                                </form>
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
