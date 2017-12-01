<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.data.ProjectWiseData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPriceInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.BarGraphData"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.data.CityData"%>
<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%
	List<ProjectList> project_list = null;
	List<City> cityDataList = null;
	List<BarGraphData> barGraphDatas = null;
	List<ProjectWiseData> projectWiseDatas = null;
	ProjectImageGallery imageGaleries = null;
	Long totalBuyers = (long)0;
	Long totalInventorySold = (long) 0;
	Long totalLeads = (long)0;
	int projectId = 0;
	List<EmployeeList> employeeLists = null;
	Double totalRevenue = 0.0;
	Double totalRevenue1 = 0.0;
	//Double totalSaleValue = 0.0;
	Long totalCampaign = (long)0;
	//Long totalSoldInventory = (long)0;
	Long totalProjects = (long)0;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
    DecimalFormat decimalFormat = new DecimalFormat("#.##");
	int builder_id = 0;
	int emp_id = 0;
	int access_id = 0;
	//Double totalRevenue =0.0;
	int project_size_list = 0;
	int city_size_list =0 ;
	
	Double totalPropertySold = 0.0;
	Long avaliable =0L;
	Long booked = 0L;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
				builder_id = builder.getBuilder().getId();
				emp_id = builder.getId();
				access_id = builder.getBuilderEmployeeAccessType().getId();
				if(builder_id > 0){
					totalBuyers = new BuyerDAO().getTotalBuyers(builder);
					totalInventorySold = new ProjectDAO().getTotalInventory(builder);
					project_list = new ProjectDAO().getBuilderFirstFourActiveProjectsByBuilderId(builder);
					cityDataList = new CityNamesImp().getCityActiveNames();
					totalLeads = new ProjectDAO().getTotalLeads(builder);
					totalProjects = new ProjectDAO().getTotalNumberOfProjects(builder);
					barGraphDatas = new BuilderDetailsDAO().getBarGraphByBuilderId(builder);
					if (request.getParameterMap().containsKey("project_id")) {
						projectId = Integer.parseInt(request.getParameter("project_id"));
					}
					projectWiseDatas = new BuilderDetailsDAO().getBuildingWiseByEmployeeIdCEO(builder, projectId);
					employeeLists = new ProjectDAO().getBuilderEmployeeList(builder,projectId);
					//totalSoldInventory = new ProjectDAO().getTotalSoldInventory(builder);
					//totalSaleValue = new BuilderProjectPriceInfoDAO().getProjectPriceInfoByBuilderId(builder_id);
					project_size_list = project_list.size();
					city_size_list = cityDataList.size();
				//	totalCampaign = new ProjectDAO().getTotalCampaignByEmpId(builder.getId());
					totalPropertySold = new ProjectDAO().getTotalRevenues(builder);
					totalRevenue1 = totalPropertySold * totalInventorySold;
					List<ProjectWiseData> projectWiseDatas2 = new BuilderDetailsDAO().getEmployeeBarGraphByProject(emp_id);
					if(projectWiseDatas !=null){
						for(ProjectWiseData projectWiseData : projectWiseDatas){
							totalRevenue +=projectWiseData.getRevenue();
							avaliable +=projectWiseData.getAvaliable();
							booked += projectWiseData.getBookingCount();
						}
					}
					
				}
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<!-- <head> -->
<!--     <meta charset="utf-8"> -->
<!--     <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!--     <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--     <meta name="description" content=""> -->
<!--     <meta name="author" content=""> -->
<!--     <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png"> -->
<!--     <title>Blue Pigeon</title> -->
<!--     Bootstrap Core CSS -->
<!--     <link href="../../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet"> -->
<!--      <link href="plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">  -->
<!--     Menu CSS -->
<!--     <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet"> -->
<!--     Custom CSS -->
<!--      <link href="../plugins/bower_components/morrisjs/morris.css" rel="stylesheet"> -->
<!--     <link href="../../css/style.css" rel="stylesheet"> -->
<!--     <link href="../../css/common.css" rel="stylesheet"> -->
<!--     color CSS -->
 
<!--     jQuery -->
<!--     <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script> -->
<!-- <!--     <script src="../../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script> --> 
  
<!-- </head> -->
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
    <link href="../../plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
   	<!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
	<link rel="stylesheet" type="text/css" href="../../css/cancellation-top.css">
	<link rel="stylesheet" type="text/css" href="../../css/newcancellationlist.css">
	   <link rel="stylesheet" type="text/css" href="../../css/ceorevenues.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
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
                                  <li class="text-right"><span class="counter"><%out.print(Math.round(totalRevenue1)); %></span></li>
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
		                    <button type="button" id="ceo_revenue_btn" class="btn11 btn-submit waves-effect waves-light m-t-10">Revenue</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="ceo_campaign_btn" class="btn11  btn-info waves-effect waves-light m-t-10">Campaign</button>
		                </div>
	                </div>
	                 <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                	<input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
               	 	<input type="hidden" id="totalrevenue" name="totalrevenue" value="<%out.print(totalRevenue);%>"/>
                	<input type="hidden" id="totalavaiable" name="totalavaiable" value="<%out.print(avaliable);%>"/>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                      <div class="col-md-8">
                        <div class="blue-bg">
                             <div class="nav nav-pills">
							  
					<div class="row">
						  <div class="white-box">
						<div class="col-md-3 col-sm-6 col-xs-12">
                       		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                 <option value="0">Building wise</option>
                               	<option value="1">Source Wise</option>
                               	<option value="2">Month Wise</option>
                               	<option value="3">Salesman Wise </option>
                        	</select>
                    	</div>
                   		 <ul class="list-inline text-left" id="revenues">
                             <li>
                                 <h4><i class="m-r-5"></i>Booked Revenue :<%out.print(totalRevenue); %> </h4> </li>
                             <li>
                                 <h4><i class="m-r-5"></i>Sold : <%out.print(booked); %>/<%out.print(avaliable); %></h4> </li>
                         </ul>
                            <div id="morris-bar-chart" style="height:372px;"></div>
                          </div>
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
<script src="../../plugins/bower_components/custom-select/custom-select.min.js" type="text/javascript"></script>
<script src="../../plugins/bower_components/morrisjs/morris.js"></script>
<script src="../../js/real-estate.js"></script>
<script src="${baseUrl}/builder/plugins/bower_components/raphael/raphael-min.js"></script>
<script>
   
    	var mychart = null; 
 
   
    	//Morris bar chart
    	 <%
      	if(projectWiseDatas != null){
       		%> 
  
       	mychart = Morris.Bar({
       	  barSize:50,
    	    element: 'morris-bar-chart',
    	    data: [
    	    	<% for(ProjectWiseData barGraphData : projectWiseDatas){ %>
    	    	{ y: '<%out.print(barGraphData.getName());%>', a: <%out.print(barGraphData.getRevenue());%> },
             	<% } %>
             ],
             xkey: 'y',
     	     ykeys: ['a'],
     	     labels: ['Revenue'],
     	     barColors:['#24bcd3'],
     	     hideHover: 'auto',
     	     gridLineColor: '#eef0f2',
     	     resize: true
     	});
     <%	} %>
 	
 	
 	
 	$("#graph_project_id").change(function(){
 		if($(this).val() == '1') {
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/ceo/source",{project_id:$("#project_id").val()},function(data){
				plotSourceGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		} else if($(this).val() == '2') {
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/ceo/month",{project_id:$("#project_id").val()},function(data){
				plotMonthGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		}
 		else if($(this).val()==3){
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/ceo/saleman",{project_id:$("#project_id").val()},function(data){
 				plotSalesmanGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		}
 		else {
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/building",{project_id:$("#project_id").val()},function(data){
 				plotBuildingGraph(data);
 				ajaxindicatorstop();
		 	},'json');
 		}
 	});
 	
 	function plotProjectGraph(records) {
 		var data = [];
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
		});
 		mychart.destroy();
 		mychart = Morris.Bar({
 			//barGap:4,
 			barSize:50,
			element: 'morris-bar-chart',
    	    data: data,
            xkey: 'y',
     	    ykeys: ['a'],
     	    labels: ['Revenue'],
     	    barColors:['#24bcd3'],
     	    hideHover: 'auto',
     	    gridLineColor: '#eef0f2',
     	    resize: true
     	});
 		
 	}
 	function plotBuildingGraph(records) {
 		var data = [];
 		var avaliable = 0;
 		var booked = 0;
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			avaliable = records[index].avaliable;
			booked +=records[index].bookingCount;
		});
 		mychart.destroy();
 		mychart = Morris.Bar({
 			barSize:50,
    	    element: 'morris-bar-chart',
    	    data: data,
            xkey: 'y',
     	    ykeys: ['a'],
     	    labels: ['Revenue'],
     	    barColors:['#24bcd3'],
     	    hideHover: 'auto',
     	    gridLineColor: '#eef0f2',
     	    resize: true
     	});
 		$("ul li h4").empty();
 		newrevenue='<li>'
    		+'<h4><i class="m-r-5"></i>Booked Revenue : '+$("#totalrevenue").val()+' </h4> </li>'
    		+'<li>'
        	+'<h4><i class="m-r-5"></i>Sold : '+booked+'/'+avaliable+'</h4> </li>';
	$("#revenues").html(newrevenue);
 	}
 	function plotSourceGraph(records) {
 		var data = [];
 		var totalLeads = 0;
 		var totalBooked = 0;
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].dataCount});
			totalLeads +=records[index].dataCount;
			totalBooked +=records[index].booked;
		});
 		mychart.destroy();
 		mychart = Morris.Bar({
 			barSize:50,
    	    element: 'morris-bar-chart',
    	    data: data,
          	xkey: 'y',
     	   	ykeys: ['a'],
     	   	labels: ['Responses'],
     	    barColors:['#24bcd3'],
     	   	barSize:50,
     	    hideHover: 'auto',
     	    gridLineColor: '#eef0f2',
     	    resize: true
     	});
 		$("ul li h4").empty();
 		newrevenue='<li>'
            		+'<h4><i class="m-r-5"></i> </h4> </li>'
            		+'<li>'
                	+'<h4><i class="m-r-5"></i>Leads : '+totalBooked+'/'+totalLeads+'</h4> </li>';
 		$("#revenues").html(newrevenue);
 	}
 	
 	function plotMonthGraph(records) {
 		var data = [];
 		var sold = 0;
 		var avaliable = 0;
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			sold +=records[index].bookingCount;
			avaliable = records[index].avaliable;
		});
 		mychart.destroy();
 		mychart = Morris.Bar({
 			barSize:50,
    	 	element: 'morris-bar-chart',
    	    data: data,
           	xkey: 'y',
     	   	ykeys: ['a'],
     	  	labels: ['Revenue'],
     	   	barColors:['#24bcd3'],
     	   	hideHover: 'auto',
     	   	gridLineColor: '#eef0f2',
     	   	barSize:50,
     	   	resize: true
     	});
 		$("ul li h4").empty();
 		newrevenue='<li>'
            		+'<h4><i class="m-r-5"></i>Booked Revenue : '+$("#totalrevenue").val()+' </h4> </li>'
            		+'<li>'
                	+'<h4><i class="m-r-5"></i>Sold : '+sold+'/'+avaliable+'</h4> </li>';
 		$("#revenues").html(newrevenue);
 		
 	}
 	
 	function plotSalesmanGraph(records) {
 		var data = [];
 		var sold=0;
 		var avaliable = 0;
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			sold +=records[index].sold;
			avaliable = records[index].avaliable;
		});
 		mychart.destroy();
 		mychart = Morris.Bar({
 			barSize:50,
    	  	element: 'morris-bar-chart',
    	  	data: data,
           	xkey: 'y',
     	   	ykeys: ['a'],
     	   	labels: ['Revenue'],
     	   	barColors:['#24bcd3'],
     	   	hideHover: 'auto',
     	   	gridLineColor: '#eef0f2',
     	   	resize: true
     	});
 		$("ul li h4").empty();
 		newrevenue='<li>'
            		+'<h4><i class="m-r-5"></i>Booked Revenue : '+$("#totalrevenue").val()+' </h4> </li>'
            		+'<li>'
                	+'<h4><i class="m-r-5"></i>Sold : '+sold+'/'+avaliable+'</h4> </li>';
 		$("#revenues").html(newrevenue);
 	}

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
$("#ceo_campaign_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/ceo/campaign/campaigns.jsp?project_id=<% out.print(projectId);%>";
});
</script>
 
    