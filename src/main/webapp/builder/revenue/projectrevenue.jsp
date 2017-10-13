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
	Double totalRevenue = 0.0;
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
					projectWiseDatas = new BuilderDetailsDAO().getBuildingWiseByEmployeeId(builder, projectId);
					//totalSoldInventory = new ProjectDAO().getTotalSoldInventory(builder);
					//totalSaleValue = new BuilderProjectPriceInfoDAO().getProjectPriceInfoByBuilderId(builder_id);
					project_size_list = project_list.size();
					city_size_list = cityDataList.size();
				//	totalCampaign = new ProjectDAO().getTotalCampaignByEmpId(builder.getId());
					totalPropertySold = new ProjectDAO().getTotalRevenues(builder);
					//totalRevenue = totalPropertySold * totalInventorySold;
					List<ProjectWiseData> projectWiseDatas2 = new BuilderDetailsDAO().getEmployeeBarGraphByProject(emp_id);
					if(projectWiseDatas2 !=null){
						for(ProjectWiseData projectWiseData : projectWiseDatas2){
							totalRevenue +=projectWiseData.getRevenue();
						}
					}
					
				}
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
    <link href="../plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
   	<!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
	<link rel="stylesheet" type="text/css" href="../css/cancellation-top.css">
	<link rel="stylesheet" type="text/css" href="../css/newcancellationlist.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
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
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        <%@include file="../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid">
                  <div class="row bspace">
	                <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="project_status_btn">Project Status</button>
	                </div>
	                 <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="inventory_btn">Inventory</button>
	                 </div>
	                 <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" class="btn11 btn-submit waves-effect waves-light m-t-10" id="revenue_btn">Revenue</button>
	                </div>
	                <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="campaign_btn">Campaign</button>
	                </div>
                </div>
                <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
                <!-- /.row -->
                <!-- .row -->
                <div class="row">
<!--                     <div class="col-md-8 col-sm-6 col-xs-12"> -->
                        <div class="white-box">
<!--                             <h3 class="box-title">Project status</h3> -->
<%--                             <div id="projecttotal" class="col-md-3 col-sm-6 col-xs-12">Booked Revenue :<%out.print(totalRevenue); %> </div> --%>
<!--                             <div id="sold" class="col-sm-3">Sold : </div> -->
                            <%if(access_id==7){ %>
                            
                            <div class="col-md-3 col-sm-6 col-xs-12">
                        		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                        <option value="0">Project wise</option>
                                       	<option value="1">Source Wise</option>
                                       	<option value="2">Month Wise</option>
                           		</select>
                    		</div>
                    		<%} %>
                    		<%if(access_id == 4||access_id == 5){ %>
                    		
                    		<div class="col-md-3 col-sm-6 col-xs-12">
                        		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                        <option value="0">Building wise</option>
                                       	<option value="1">Source Wise</option>
                                       	<option value="2">Month Wise</option>
                                       	<option value="3">Salesman Wise </option>
                           		</select>
                    		</div>
                    		
                    		<%} %>
                    		
<!--                             <ul class="list-inline text-left"> -->
<!--                                 <li> -->
<!--                                     <h5><i class="fa fa-circle m-r-5" style="color: #24bcd3;"></i>Flats</h5> </li> -->
<!--                                 <li> -->
<!--                                     <h5><i class="fa fa-circle m-r-5" style="color: #fb9678;"></i>Buyers</h5> </li> -->
<!--                                 <li> -->
<!--                                     <h5><i class="fa fa-circle m-r-5" style="color: #9675ce;"></i>Purchases</h5> </li> -->
<!--                             </ul> -->
                            <div id="morris-bar-chart" style="height:372px;"></div>
                        </div>
<!--                     </div> -->
                    
                </div>
                <!-- /.row -->
              
              </div>
           </div>
      </div>
        <!-- /.container-fluid -->
   	<div id="footer"> 
		<%@include file="../partial/footer.jsp"%>
    </div> 
</body>
</html>
<!-- <script src="../plugins/bower_components/switchery/dist/switchery.min.js"></script> -->
<script src="../plugins/bower_components/custom-select/custom-select.min.js" type="text/javascript"></script>
<!-- <script src="../plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script> -->
<script src="../plugins/bower_components/morrisjs/morris.js"></script>
<script src="../js/real-estate.js"></script>
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
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/source",{emp_id:$("#emp_id").val()},function(data){
				plotSourceGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		} else if($(this).val() == '2') {
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/month",{emp_id:$("#emp_id").val()},function(data){
				plotMonthGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		}
 		else if($(this).val()==3){
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/saleman",{emp_id:$("#emp_id").val()},function(data){
 				plotSalesmanGraph(data);
				ajaxindicatorstop();
		 	},'json');
 		}
 		else {
 			ajaxindicatorstart("Loading...");
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/building",{project_id:$("#project_id").val()},function(data){
 				plotProjectGraph(data);
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
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
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
 		
 	}
 	function plotSourceGraph(records) {
 		var data = [];
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].dataCount});
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
 		
 	}
 	
 	function plotMonthGraph(records) {
 		var data = [];
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
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
 		
 	}
 	
 	function plotSalesmanGraph(records) {
 		var data = [];
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
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
 		
 	}
 	
	$("#project_status_btn").click(function(){
		ajaxindicatorstart("Please wait while.. we load ...");
		window.location.href="${baseUrl}/builder/sales/projectstatus.jsp?project_id=<% out.print(projectId);%>";
	});
	$("#campaign_btn").click(function(){
		ajaxindicatorstart("Please wait while.. we load ...");
		window.location.href="${baseUrl}/builder/campaign/mycampaigns.jsp?project_id=<% out.print(projectId);%>";
	});
	$("#inventory_btn").click(function(){
		ajaxindicatorstart("Please wait while.. we load ...");
		window.location.href="${baseUrl}/builder/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
	});
</script>