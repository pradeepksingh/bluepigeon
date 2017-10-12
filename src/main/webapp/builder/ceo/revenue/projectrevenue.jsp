
<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.BuilderFlatList"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%
List<CampaignListNew> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int session_id = 0;
int access_id = 0;
List<BuilderBuilding> builderBuildingList = null;
int projectId = 0;
int building_id = 0;
Long totalInventorySold = (long) 0;
Long totalLeads = (long)0;
Long totalProjects = (long)0;
Double totalRevenue = 0.0;
List<FlatListData> flatListDatas = null; 
BookingFlatList bookingFlatList2 = null; 
List<BuilderFlatList> flats = null;
List<EmployeeList> employeeLists = null;
Double totalPropertySold = 0.0;

if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		session_id = builder.getBuilder().getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		if(session_id > 0){
			if (request.getParameterMap().containsKey("project_id")) {
				projectId = Integer.parseInt(request.getParameter("project_id"));
				if(projectId != 0) {
					builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(projectId);
					building_id = builderBuildingList.get(0).getId(); 
		 			flats = new ProjectDAO().getProjectFlatListByBuilder(projectId, building_id, "");
		 			totalLeads = new ProjectDAO().getTotalLeads(builder);
					totalProjects = new ProjectDAO().getTotalNumberOfProjects(builder);
					totalInventorySold = new ProjectDAO().getTotalInventory(builder);
					totalPropertySold = new ProjectDAO().getTotalRevenues(builder);
					totalRevenue = totalPropertySold * totalInventorySold;
					campaignLists = new CampaignDAO().getMyCampaignsByProjectId(projectId);
					employeeLists = new ProjectDAO().getBuilderEmployeeList(builder,projectId);
				}
			}
		}
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
    <link href="../../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <!--  <link href="plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">  -->
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/newstyle.css" rel="stylesheet">
    <link href="../../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/ceocampaigns.css">
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
<!--     <script src="../../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script> -->
  
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
               <!-- row -->
                 <div class="row">
		                <div class="col-md-3 col-sm-6 col-lg-3">
		                   <div class="white-box white-box1">
                              <h3 class="box-title">Total Inventory</h3>
                              <ul class="list-inline two-part">
                                <li><i class="ti-home"></i></li>
                                <li class="text-right"><span class="counter"><%out.print(totalProjects); %></span></li>
                              </ul>
                            </div>
		                </div>
		                 <div class="col-md-3 col-sm-6 col-lg-3">
		                    <div class="white-box white-box1">
                               <h3 class="box-title">Sold</h3>
                                 <ul class="list-inline two-part">
                                  <li><i class="icon-tag"></i></li>
                                  <li class="text-right"><span class="counter"><%out.print(totalInventorySold); %></span></li>
                                 </ul>
                             </div>
		                  </div>
		                 <div class="col-md-3 col-sm-6 col-lg-3">
		                   <div class="white-box white-box1">
                               <h3 class="box-title">New Leads</h3>
                                 <ul class="list-inline two-part">
                                  <li><i class="icon-user"></i></li>
                                  <li class="text-right"><span class="counter"><%out.print(totalLeads); %></span></li>
                                 </ul>
                           </div>
		                </div>
		                <div class="col-md-3 col-sm-6 col-lg-3">
		                   <div class="white-box white-box1">
                               <h3 class="box-title">Total Revenue (Rs in cr)</h3>
                                 <ul class="list-inline two-part">
                                  <li><i class="ti-wallet"></i></li>
                                  <li class="text-right"><span class="counter"><%out.print(Math.round(totalRevenue)); %></span></li>
                                 </ul>
                             </div>
		                </div>
	              </div>
               <!-- row -->
               <!-- /.row -->
	                 <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button"  id="ceo_project_status_btn" class="btn11 btn-info waves-effect waves-light m-t-10">Project Status</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_inventory_btn" class="btn11 btn-info waves-effect waves-light m-t-10">Inventory</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_revenue_btn" class="btn11 btn-info waves-effect waves-light m-t-10">Revenue</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_campaign_btn" class="btn11 btn-submit waves-effect waves-light m-t-10">Campaign</button>
		                </div>
	                </div>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                      <div class="col-md-8">
                        <div class="blue-bg">
                             <div class="nav nav-pills">
							  
					<div class="row">
					 <%if(campaignLists != null) { %>
                   <% for(CampaignListNew campaign:campaignLists) { %>
                       <div class="projectsection active" data-toggle="pill" href="#home">
	                       <div class="image">
	                       <%if(campaign.getImage() != null){ %>
	                        <img src="${baseUrl}/<% out.print(campaign.getImage());%>" alt="Project image">
	                        <%}else{ %>
		                    <img src="../../plugins/images/Untitled-1.png" alt="Project image">
		                       <%} %>
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-9 col-sm-8 col-xs-8 left">
					                       <h3><% out.print(campaign.getName()); %></h3>
					                        <br>
						                    <div class="bottom">
						                     <h4><span><a href="javascript:openTermsModal(`<% out.print(campaign.getTerms()); %>`);" class="tcanchor">T&C</a></span></h4>
						                      <h6>Duration</h6>
						                      <h4><% if(campaign.getStartDate() != null){ out.print(dt1.format(campaign.getStartDate()));} %> to <%if(campaign.getEndDate() != null){out.print(dt1.format(campaign.getEndDate())); }else{out.print("till date");}%></h4>
						                    </div>
				                        </div>
				                        <h3 class="center-tag">
				                           <% if(campaign.getContent() != null && campaign.getContent() != "")out.print(campaign.getContent()); %> <br>
				                           <span>on your next booking</span>
										</h3>
				                        <div class="col-md-3 col-sm-4 col-xs-4 right">
					                       <div class="right">
					                        <% if(campaign.getEndDate() != null){
				                       		   	if(date.after(campaign.getEndDate())){ %>
					                          <img src="../../images/red.png" alt="cancle" class="icon">
					                          	<% } else { %>
					                          	 <img src="../../images/green.png" alt="cancle" class="icon">
					                          	 <% } %>
					                       	<% } else { %>
					                          	  <img src="../../images/green.png" alt="cancle" class="icon">
					                        <% } %>
					                        </div>
						                    <div class="bottom">
						                       <div class="row">
						                          <div class="col-xs-6">
						                      		<img src="../../images/key.png" alt="cancle" class="icon">
						                      		<span class="span-style">BOOKED</span>
						                      		<h4><% out.print(campaign.getBooking()); %></h4>
						                          </div>
						                          <div class="col-xs-6">
								                      <img src="../../images/click.png" alt="cancle" class="icon">
								                      <span class="span-style">LEADS</span>
						                      		 <h4><% out.print(campaign.getLeads()); %></h4>
						                          </div>
						                       </div>
						                    </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
                       </div>
                       <%}} %>
	                </div>
				</div>
					</div>
                      </div>
                      <div class="col-md-4">
                        <div class="blue-bg tab-content">
                          <div id="home" class="tab-pane fade in active">
                           <%if(employeeLists != null){
                        	for(EmployeeList employeeList: employeeLists){
                        	%>
                              <div>
						          <div class="user-profile center">
						            <img src="../../plugins/images/Untitled-1.png" alt="User Image" class="custom-img">
						            <p><b><%out.print(employeeList.getName()); %></b></p>
						            <p class="p-custom"><%out.print(employeeList.getAccess()); %></p>
						            <br>
						          </div>
						             <div class="row custom-row user-row">
								        <p class="p-custom">Mobile No.</p>
								        <p><b><%out.print(employeeList.getMobileNo()); %></b></p>
								        <p class="p-custom">Email</p>
								        <p><b><%out.print(employeeList.getEmail()); %></b></p>
								     </div>
						          <hr>
						      </div>
						      <%}} %>
					       </div>  
					 </div>
	                </div>
	              </div>
                <!-- row -->
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
<script>


$("#ceo_project_status_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/projectstatus/projectstatus.jsp?project_id=<% out.print(projectId);%>";
});
$("#ceo_inventory_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
});
$("#ceo_revenue_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/revenue/projectrevenue.jsp?project_id=<% out.print(projectId);%>";
});
</script>
 
    