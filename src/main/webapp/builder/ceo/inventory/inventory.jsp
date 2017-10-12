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
     <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet"> 
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/newstyle.css" rel="stylesheet">
    <link href="../../css/common.css" rel="stylesheet">
       <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/ceoinventory.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
<!--     <script src="../../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script> -->
      <script type="text/javascript" src="../../js/selectize.min.js"></script>
    
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
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                   <div class="white-box white-box1">
                              <h3 class="box-title">Total Inventory</h3>
                              <ul class="list-inline two-part">
                                <li><i class="ti-home"></i></li>
                                <li class="text-right"><span class="counter"><%out.print(totalProjects); %></span></li>
                              </ul>
                            </div>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <div class="white-box white-box1">
                               <h3 class="box-title">Sold</h3>
                                 <ul class="list-inline two-part">
                                  <li><i class="icon-tag"></i></li>
                                  <li class="text-right"><span class="counter"><%out.print(totalInventorySold); %></span></li>
                                 </ul>
                             </div>
		                  </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                   <div class="white-box white-box1">
                               <h3 class="box-title">New Leads</h3>
                                 <ul class="list-inline two-part">
                                  <li><i class="icon-user"></i></li>
                                  <li class="text-right"><span class="counter"><%out.print(totalLeads); %></span></li>
                                 </ul>
                           </div>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
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
		                    <button type="button" id="ceo_inventory_btn" class="btn11 btn-submit waves-effect waves-light m-t-10">Inventory</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_revenue_btn" class="btn11 btn-info waves-effect waves-light m-t-10">Revenue</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_campaign_btn" class="btn11 btn-info waves-effect waves-light m-t-10">Campaign</button>
		                </div>
	                </div>
               <!-- row -->
               <!-- row -->
                  <div class="row">
                       <div class="col-md-4 col-lg-4 col-sm-4 col-xs-12" style="padding-top:8px;">
	                       <select id="filter_building_id" name="filter_building_id"  data-style="form-control" >
	                         	<option value="0">Enter Building Name</option>
	                        <% if(builderBuildingList != null){ 
	                        		for(BuilderBuilding builderBuilding : builderBuildingList){
	                        %>
	                          	<option value="<% out.print(builderBuilding.getId());%>" <% if(builderBuilding.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding.getName()); %></option>
	                        <%} }%>
	                        </select>
                       </div>
                       <div class="col-md-8 col-lg-8 col-sm-8 col-xs-12" >
                         <form class="navbar-form lead-search" method="post" role="search">
						    <div class="input-group add-on wdth100">
						      <input class="form-control textinput" placeholder="Search by Name or Number" autocomplete="off" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn wdth10">
						        <button class="btn btn-default btn231" id="search_buyer" type="button"><img src="../../images/search.png"></button>
						      </div>
						    </div>
					     </form>
                       </div>
                  </div>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                      <div class="col-md-8">
                        <div class="blue-bg">
	                        <div id="flat_landing_area">
		               	 		<% if(flats !=null){ %>
	                   		<div class="floor1">
	                   		<% int floor_no = -100; %>
	                    	<% for(BuilderFlatList flat :flats) { %>
	                    	<% if(floor_no != -100 && flat.getFloorNo() != floor_no) { %>
	                         </div>
	                         <div class="floor2">
	                         <% } %>
	                         	<a href="javascript:return false;"><button <% if(flat.getFlatStatus().equalsIgnoreCase("booked") || flat.getFlatStatus().equalsIgnoreCase("hold") || flat.getFlatStatus().equalsIgnoreCase("available")) { %>style="pointer-events:none;"<% } %> class="<% if(flat.getFlatStatus().equalsIgnoreCase("booked")) { %>book-flat-button <%} if(flat.getFlatStatus().equalsIgnoreCase("available")) { %>flat-button<% } %> <% if(flat.getFlatStatus().equalsIgnoreCase("hold")) { %> yellowcolor yell<% } %>" data-value="<% out.print(flat.getId()); %>"><% out.print(flat.getFlatNo()); %></button></a>
	                   		<% floor_no = flat.getFloorNo(); %>
	                   		<% } %>
	                   		</div>
	                   		<% } %>
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
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_building_id :selected").text();
    	 if(textClear.trim() == "Enter Building Name"){
    		 obj[0].setValue("");
    	 }
     }
});
<%if(builderBuildingList.size() > 0){%>
	select_building = $select_building[0].selectize;
<%}%>
$("#search_buyer").click(function(){
	ajaxindicatorstart("Please wait while.. we search ...");
    $.get("${baseUrl}/builder/ceo/inventory/partialinventory.jsp?project_id=<% out.print(projectId);%>&building_id="+$('#filter_building_id').val()+"&keyword="+$('#srch-term').val(),{},function(data) {
    	$("#flat_landing_area").html(data);
    	ajaxindicatorstop();
    },'html');
});
$("#ceo_project_status_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/projectstatus/projectstatus.jsp?project_id=<% out.print(projectId);%>";
});
$("#ceo_campaign_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/campaign/campaigns.jsp?project_id=<% out.print(projectId);%>";
});
$("#ceo_revenue_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/revenue/projectrevenue.jsp?project_id=<% out.print(projectId);%>";
});
</script>
 
    