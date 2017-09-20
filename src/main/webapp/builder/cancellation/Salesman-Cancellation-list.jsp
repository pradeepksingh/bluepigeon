<%@page import="org.bluepigeon.admin.dao.CancellationDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.data.BookedBuyerList"%>
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
	int p_user_id = 0;
	int emp_id = 0;
	List<BookedBuyerList> buyerList = null;	
	List<ProjectData> projectList = null;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			p_user_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			buyerList = new CancellationDAO().getCancelledBuyerList(builder);
			projectList = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
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
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
       <link rel="stylesheet" type="text/css" href="../css/custom10.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
      <link rel="stylesheet" type="text/css" href="../css/cancellationlist.css">
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="../js/selectize.min.js"></script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
       <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid cancellation-lead">
               <!-- row -->
                  <h1>Cancellation</h1>
                   <div class="row">
                      <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12">
                        <select id="filter_project_id" name="filter_project_id" data-style="form-control">
                          <option value="0">Enter Project Name</option>
                        <% if(projectList != null){
                        	for(ProjectData projectData : projectList){
                        	%>
                          <option value="<%out.print(projectData.getId());%>"><%out.print(projectData.getName()); %></option>
                          <%}} %>
                        </select>
                        <img src="../images/filter.png" alt="flter" class="filter-img"/>
                      </div>
                       <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12">
                         <form class="navbar-form lead-search" method="post" role="search">
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search by Name or Number"  autocomplete="off" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn">
						        <button class="btn btn-default" id="search_buyer"  type="button"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                 </div>
                 <div class="white-box">
                   <div class="lead-bg">
                   <!-- buyer information end -->
	                 <div class="row blue-border1">
	                   <div class="col-md-2 col-sm-2 col-xs-2">
	                     <h2>Flat No</h2>
	                   </div>
	                   <div class="col-md-4 col-sm-4 col-xs-4">
	                     <h2>Buyer Name & Number</h2>
	                   </div>
	                   <div class="col-md-4 col-sm-4 col-xs-4">
	                     <h2>Reason Of Cancellation</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-2">
	                     <h2>Amount</h2>
	                   </div>
	                 </div>
	                 <div id="booked_buyers">
	                 <%if(buyerList != null){ 
	                 	for(BookedBuyerList bookedBuyerList : buyerList){
	                 %>
	                 <div class="border-lead1">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-2">
	                     <h4><%out.print(bookedBuyerList.getBuildingName()); %>-<%out.print(bookedBuyerList.getFlatNo()); %> <%out.print(bookedBuyerList.getProjectName()); %>, <%out.print(bookedBuyerList.getLocalityName()); %>, <%out.print(bookedBuyerList.getCityName()); %></h4>
	                    </div>
	                     <div class="col-md-4 col-sm-4 col-xs-4">
	                     <h4><%out.print(bookedBuyerList.getBuyerName()); %></h4>
	                     <h4><%out.print(bookedBuyerList.getBuyerContact()); %></h4>
	                    </div>
	                     <div class="col-md-4 col-sm-4 col-xs-4">
	                     <h4><%out.print(bookedBuyerList.getCancelReason());%></h4>
	                    </div>
	                   <div class="col-md-2 col-sm-2 col-xs-2">
	                     <h4><%out.print(bookedBuyerList.getCharges()); %>/-</h4>
	                    </div>
	                 </div>
	               </div>
	               <%}} %>
	               <!-- buyer information end -->
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
<script>

$select_project = $("#filter_project_id").selectize({
	persist: false,
	 onChange: function(value) {
		 getBookedBuyerFilterList();
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_project_id :selected").text();
    	 if(textClear.trim() == "Enter Project Name"){
    		 obj[0].setValue("");
    	 }
     }
});
<% if(projectList != null){
if(projectList.size() > 0){%>
	select_project = $select_project[0].selectize;
<%}}%>
function getBookedBuyerFilterList(){
	var emp_id = <%out.print(emp_id);%>;
	var htmlBookedBuyers = "";
	var project_id = $("#filter_project_id").val();
	var nameorNumber = $("#srch-term").val();
	alert(nameorNumber);
	ajaxindicatorstart("Loading...");
	$("#booked_buyers").empty();
	$.post("${baseUrl}/webapi/cancellation/filter/cancel/buyers",{emp_id: emp_id, project_id : project_id, nameOrNumber : nameorNumber },function(data){
		   if(data == ""){
			   $("#booked_buyers").empty();
			   $("#booked_buyers").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				 htmlBookedBuyers ='<div class="border-lead1">'
	                  +'<div class="row">'
                 +'<div class="col-md-2 col-sm-2 col-xs-2">'
                 +'<h4>'+data[index].buildingName+'-'+data[index].flatNo+' '+data[index].projectName+', '+data[index].localityName+', '+data[index].cityName+'</h4>'
                 +'</div>'
                 +' <div class="col-md-4 col-sm-4 col-xs-4">'
                  +'<h4>'+data[index].buyerName+'</h4>'
                  +'<h4>'+data[index].buyerContact+'</h4>'
                 +'</div>'
                 +'<div class="col-md-4 col-sm-4 col-xs-4">'
                  +'<h4>'+data[index].cancelReason+'</h4>'
                 +'</div>'
                +'<div class="col-md-2 col-sm-2 col-xs-2">'
                  +'<h4>'+data[index].charges+'/-</h4>'
                 +'</div>'
              +'</div>'
            +'</div>';
            $("#booked_buyers").append(htmlBookedBuyers);
			});
			 ajaxindicatorstop();
	});
}

$("#search_buyer").click(function(){
	getBookedBuyerFilterList();
});

$("#srch-term").keydown(function (e) {
	if (e.keyCode == 13) {
		getBookedBuyerFilterList();
		return false;
	}
});
</script>
