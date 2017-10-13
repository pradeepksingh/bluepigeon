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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%
	List<ProjectList> project_list = null;
	List<City> cityDataList = null;
	List<BarGraphData> barGraphDatas = null;
	List<ProjectWiseData> projectWiseDatas = null;
	ProjectImageGallery imageGaleries = null;
	Long totalBuyers = (long)0;
	Long totalInventorySold = (long) 0;
	Long totalLeads = (long)0;
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
	int project_size_list = 0;
	int city_size_list =0 ;
//	ProjectWiseData totalProjectRevenue = null;
	Double totalPropertySold = 0.0;
	Long avaiable=0L;
	Long sold=0L;
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
					projectWiseDatas = new BuilderDetailsDAO().getProjectWiseByEmployee(builder);
					project_size_list = project_list.size();
					city_size_list = cityDataList.size();
					totalPropertySold = new ProjectDAO().getTotalRevenues(builder);
					List<ProjectWiseData> projectWiseDatas2 = new BuilderDetailsDAO().getEmployeeBarGraphByProject(emp_id);
				//	totalProjectRevenue=	new BuilderDetailsDAO().getTotalRevenueByEmployee(builder);
// 					if(projectWiseDatas2 !=null){
// 						for(ProjectWiseData projectWiseData : projectWiseDatas2){
// 							totalRevenue +=projectWiseData.getRevenue();
// 						}
// 					}

					if(projectWiseDatas2 != null){
						for(ProjectWiseData projectWiseData : projectWiseDatas2){
							totalRevenue += projectWiseData.getRevenue();
							avaiable = (long)avaiable+(long)projectWiseData.getAvaliable();
							sold = (long)sold+(long)projectWiseData.getSold();
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
<!--     <link rel="stylesheet" type="text/css" href="../css/cancellation.css"> -->
<!-- 	 <link rel="stylesheet" type="text/css" href="../css/custom7.css"> -->
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
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Data Analytics</h4> </div>
                    
                    <!-- /.col-lg-12 -->
                </div>
                <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                <input type="hidden" id="totalrevenue" name="totalrevenue" value="<%out.print(totalRevenue);%>"/>
                <input type="hidden" id="totalavaiable" name="totalavaiable" value="<%out.print(avaiable);%>"/>
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
                    		<%if(access_id == 4||access_id == 5 || access_id == 1){ %>
                    		
                    		<div class="col-md-3 col-sm-6 col-xs-12">
                        		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                        <option value="0">Project wise</option>
                                       	<option value="1">Source Wise</option>
                                       	<option value="2">Month Wise</option>
                                       	<option value="3">Salesman Wise </option>
                           		</select>
                    		</div>
                    		
                    		<%} %>
                    		
                            <ul class="list-inline text-left" id="revenues">
                                <li>
                                    <h4><i class="m-r-5"></i>Booked Revenue :<%out.print(totalRevenue); %> </h4> </li>
                                <li>
                                    <h4><i class="m-r-5"></i>Sold : <%out.print(sold); %>/<%out.print(avaiable); %></h4> </li>
                            </ul>
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
<script src="../plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
<!-- <script src="../plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script> -->
<!-- <script src="../plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js" type="text/javascript"></script> -->
<!-- <script type="text/javascript" src="../plugins/bower_components/multiselect/js/jquery.multi-select.js"></script> -->
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
 			$.post("${baseUrl}/webapi/builder/filter/bargraph/project",{emp_id:$("#emp_id").val()},function(data){
 				plotProjectGraph(data);
 				ajaxindicatorstop();
		 	},'json');
 		}
 	});
 	
 	function plotProjectGraph(records) {
 		var data = [];
 		var sold =0;
 		var newrevenue="";
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			sold +=records[index].sold;
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
                	+'<h4><i class="m-r-5"></i>Sold : '+sold+'/'+$("#totalavaiable").val()+'</h4> </li>';
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
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			sold +=records[index].bookingCount;
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
                	+'<h4><i class="m-r-5"></i>Sold : '+sold+'/'+$("#totalavaiable").val()+'</h4> </li>';
 		$("#revenues").html(newrevenue);
 		
 	}
 	
 	function plotSalesmanGraph(records) {
 		var data = [];
 		var sold=0;
 		$(records).each(function(index){
			data.push({"y":records[index].name, "a":records[index].revenue});
			sold +=records[index].sold;
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
                	+'<h4><i class="m-r-5"></i>Sold : '+sold+'/'+$("#totalavaiable").val()+'</h4> </li>';
 		$("#revenues").html(newrevenue);
 	}
</script>