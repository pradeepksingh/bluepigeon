<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%@page import="org.bluepigeon.admin.data.BuyerBuildingList"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
 <%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
 <%@page import="org.bluepigeon.admin.model.BuilderFloor"%> 
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
 	int emp_id = 0; 
 	int access_id=0; 
 	int projectId = 0;
 	List<CampaignListNew> campaignListNews = null;
 	session = request.getSession(false); 
	projectId = Integer.parseInt(request.getParameter("project_id"));
 	BuilderEmployee builder = new BuilderEmployee(); 
 	if(session!=null) 
 	{ 
 		if(session.getAttribute("ubname") != null) 
 		{ 
 			builder  = (BuilderEmployee)session.getAttribute("ubname"); 
 			emp_id = builder.getId(); 
 			access_id = builder.getBuilderEmployeeAccessType().getId(); 
 			//buildingList =  new ProjectDAO().getBuilderActiveProjectBuildings(project_id); 
 			campaignListNews = new CampaignDAO().getNewCampaignListByBuilderEmployee(builder, projectId);
 			
 		} 
 		 
 	} 
 	SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
 	Date date = new Date();
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
   <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/salemancampaign.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    
  
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
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        <%@include file="../../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">BOOKING</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">CANCELLATION</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit"  id="leads" class="btn11 btn-info waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-submit waves-effect waves-light m-t-10">CAMPAIGN</button>
		                </div>
	                </div>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                   <% try{
                	   int count=1;
                   if(campaignListNews != null){ 
                       		for(CampaignListNew campaignListNew : campaignListNews){
                       %>
                   		<div class="col-md-6 col-sm-6 col-xs-12 projectsection">
	                       <div class="image">
		                        <% if(campaignListNew.getImage() != ""  && campaignListNew.getImage() !=null){ %>
		                       <img src="${baseUrl}/builder/<%out.print(campaignListNew.getImage()); %>" alt="Campaign image" />
		                       <%}else{ if(count%2 ==0){%>
		                        <img src="../../images/images.jpg" alt="Campaign image" />
		                       <%} else{
		                       %>
		                        <img src="../../images/images1.jpg" alt="Campaign image" />
		                        <%}} %>
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-6 col-sm-9 col-xs-9 left">
					                       <h3><%if(campaignListNew.getName() != null && campaignListNew.getName() != "")out.print(campaignListNew.getName()); %></h3>
					                        <br>
						                    <div class="bottom">
						                      <h6>Duration</h6>
						                      <h4><%out.print(dt1.format(campaignListNew.getStartDate())); %> to <%if(campaignListNew.getEndDate() != null){out.print(dt1.format(campaignListNew.getEndDate())); }else{out.print("till date");}%></h4>
						                    </div>
				                        </div>
				                        <h3 class="center-tag">
				                            <% if(campaignListNew.getContent() != null && campaignListNew.getContent() != "")out.print(campaignListNew.getContent()); %> <br/>
				                           <span>on your next booking</span>
										</h3>
				                        <div class="col-md-6 col-sm-3 col-xs-3 right">
				                        <%
				                        	if(campaignListNew.getEndDate() != null){
				                       		   if(date.after(campaignListNew.getEndDate())){ %>
					                       <div class="right">
					                          <img src="../../images/red.png" alt="inactive" class="icon"/>
					                        </div>
					                        <%}else{ %>
					                        <div class="right">
					                          <img src="../../images/green.png" alt="active" class="icon"/>
					                        </div>
					                        <%}}else{ %>
					                        <div class="right">
					                          <img src="../../images/green.png" alt="active" class="icon"/>
					                        </div>
					                        <%} %>
						                    <div class="bottom">
						                        <h4><span>T&C</span></h4>
						                    </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
                       </div>
                       
                   <% count++;}}else{
                	   out.print("No Campaign is running..");
                	   }}catch(Exception e){ %>
                   }
	                       No Campaign is running.
	                       <%} %>
	              </div>
                <!-- row -->
           </div>
         </div>
      </div>
    <!-- /.container-fluid -->
    </div>
    <div id="sidebar1"> 
	     <%@include file="../../partial/footer.jsp"%>
	</div> 
  </body>
</html>
<script>
 $("#booking").click(function(){
	 window.location.href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id="+<%out.print(projectId);%>
 });
 $("#cancellation").click(function(){
	 window.location.href="${baseUrl}/builder/saleshead/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(projectId);%>
 });
 $("#leads").click(function(){
		window.location.href="${baseUrl}/builder/saleshead/leads/Salesman_leads.jsp?project_id="+<%out.print(projectId);%>
	});
</script>

