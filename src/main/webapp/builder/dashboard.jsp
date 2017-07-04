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
	ProjectImageGallery imageGaleries = null;
	Long totalBuyers = (long)0;
	Long totalInventory = (long) 0;
	Long totalLeads = (long)0;
	Double totalRevenue = 0.0;
	Double totalSaleValue = 0.0;
	Long totalCampaign = (long)0;
	Long totalSoldInventory = (long)0;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
    DecimalFormat decimalFormat = new DecimalFormat("#.##");
	int builder_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			if(builder != null){
				builder_id = builder.getBuilder().getId();
				if(builder_id > 0){
					totalBuyers = new BuyerDAO().getTotalBuyers(builder_id);
					totalInventory = new ProjectDAO().getTotalInventory(builder_id);
					project_list = new ProjectDAO().getBuilderFirstFourActiveProjectsByBuilderId(builder_id);
					cityDataList = new CityNamesImp().getCityActiveNames();
					totalLeads = new ProjectDAO().getTotalLeads(builder_id);
					barGraphDatas = new BuilderDetailsDAO().getBarGraphByBuilderId(builder_id);
					totalSoldInventory = new ProjectDAO().getTotalSoldInventory(builder_id);
					totalSaleValue = new BuilderProjectPriceInfoDAO().getProjectPriceInfoByBuilderId(builder_id);
					totalRevenue = totalSaleValue * totalSoldInventory;
				//	totalCampaign = new ProjectDAO().getTotalCampaignByEmpId(builder.getId());
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
    <link rel="icon" type="image/png" sizes="16x16" href="${baseUrl}/builder/plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="${baseUrl}/builder/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${baseUrl}/builder/plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <link href="${baseUrl}/builder/plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="${baseUrl}/builder/css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${baseUrl}/builder/css/custom.css">
     <link href="${baseUrl}/builder/plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="${baseUrl}/builder/plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="${baseUrl}/builder/plugins/bower_components/switchery/dist/switchery.min.css" rel="stylesheet" />
    <link href="${baseUrl}/builder/plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <link href="${baseUrl}/builder/plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css" rel="stylesheet" />
    <link href="${baseUrl}/builder/plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css" rel="stylesheet" />
    <link href="${baseUrl}/builder/plugins/bower_components/multiselect/css/multi-select.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="${baseUrl}/builder/plugins/bower_components/jquery/dist/jquery.min.js"></script>
    
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
	       <%@include file="partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="partial/sidebar.jsp"%>
      </div>
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Dashboard</h4> </div>
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12"> 
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!--.row -->
                <%if(builder.getBuilderEmployeeAccessType().getId() == 1 || builder.getBuilderEmployeeAccessType().getId() == 2){ %>
                <div class="row re">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Properties</h3>
                            <ul class="list-inline two-part">
                                <li><i class="ti-home text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%out.print(totalInventory); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Buyers</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="icon-tag text-purple"></i></li> -->
									 <li><i class="icon-tag text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text" ><%out.print(totalBuyers); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">New leads</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="icon-user text-danger"></i></li> -->
                                 <li><i class="icon-user text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%out.print(totalLeads); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Revenue (in Rs)</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="ti-wallet text-success"></i></li> -->
									 <li><i class="ti-wallet text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"> <%out.print(Math.round(totalRevenue)); %></span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%} %>
                    <%if(builder.getBuilderEmployeeAccessType().getId() == 3){ %>
                <div class="row re">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border" style="padding: 15px;">
                            <h3 class="box-title">Total No. Of Campaigns</h3>
                            <ul class="list-inline two-part">
                                <li><i class="ti-home text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%if(totalCampaign != null){out.print(totalCampaign);} %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border" style="padding: 15px;">
                            <h3 class="box-title">Leads through Campaigns</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="icon-tag text-purple"></i></li> -->
									 <li><i class="icon-tag text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text" ><%out.print(totalBuyers); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6" >
                        <div class="white-box white-border" style="padding: 15px;">
                            <h3 class="box-title">Buyers through Campaigns</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="icon-user text-danger"></i></li> -->
                                 <li><i class="icon-user text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%out.print(totalLeads); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border" style="padding: 15px;">
                            <h3 class="box-title">Total Revenue (in Rs)</h3>
                            <ul class="list-inline two-part">
<!--                                 <li><i class="ti-wallet text-success"></i></li> -->
									 <li><i class="ti-wallet text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"> <%out.print(Math.round(totalRevenue)); %></span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <%} %>
                <div class="white-box">
                   <div class="row re">
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <select class="selectpicker border-drop-down" data-style="form-control" id="project_id" name="project_id">
                                        <option value="0">Project Name</option>
                                       <%
                                       if(project_list != null){
                                       for(ProjectList projectList : project_list){%>
                                       <option value="<%out.print(projectList.getId());%>"><%out.print(projectList.getName()); %></option>
                                       <% }}%>
                           </select>
                               
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                      <select class="selectpicker" data-style="form-control" id="city_id" name="city_id">
                                   		<option value="0">City</option>
                                        <%for(City city : cityDataList){ %>
                                        <option value="<%out.print(city.getId());%>"><%out.print(city.getName()); %></option>
                                        <%} %>
                          </select>
                             
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                       <select class="selectpicker" data-style="form-control" id="locality_id" name="locality_id">
                                        <option value="0">Locality</option>
                         </select>
                              
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                       <select class="selectpicker" data-style="form-control">
                                        <option value="0">Project Status</option>
                                        <option value="1">Pending Projects</option>
                                        <option value="2">Complete Projects</option>
                         </select>
                               
                    </div>
                    <input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_id);%>"/>
                    <div class="container" id="project_list">
                   		<%
                       		if(project_list !=null){
                       			for(ProjectList projectList : project_list ){
                       				if(projectList.getId() > 0){
                       	%>
                       <div class="col-md-6 col-sm-6 col-xs-12 projectsection">
	                       <div class="image">
		                      <%
	                       		try{
	                       		imageGaleries = new ProjectDAO().getProjectImagesByProjectId(projectList.getId()).get(0);
	                       	     if(imageGaleries.getImage() != null){
	                       	%>
		                       	<img  src="${baseUrl}/<% out.print(imageGaleries.getImage()); %>" height="348" width="438" alt="Project image"/>
		                       	<%}}catch(Exception e){ %>
		                       		 <img  src="${baseUrl}/builder/plugins/images/Untitled-1.png" height="348"  width="438" alt="Project image"/>
		                       	<%} %>
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-6 left">
					                       <h3><%out.print(projectList.getName()); %></h3>
					                       <h4><%out.print(projectList.getCityName()); %></h4>
					                       <br>
						                       <div class="bottom">
						                       <h4><%if(projectList != null){out.print(Math.round(projectList.getSold()));} %>/<% if(projectList != null){out.print(Math.round(projectList.getTotalSold()));} %> SOLD</h4>
						                       </div>
				                       </div>
				                        <div class="col-md-6 right">
					                         <div class="chart" id="graph<%out.print(projectList.getId()); %>" data-percent="<%out.print(Math.round(projectList.getCompletionStatus())); %>">
					                         </div>
						                        <div class="bottom">
						                        <h4><%out.print(projectList.getTotalLeads()) ;%> NEW LEADS</h4>
						                        </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
	                       <div class="row">
                           	<div class="col-md-6 left"> 
                           		<a href="${baseUrl}/builder/project/edit.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-info waves-effect waves-light m-t-1">Edit</a>
                           	</div>
                         	<div class="col-md-6 center">
                          		 <a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 </div>
						  </div>
	                       </div>
	                       
	                       <%  
                       		}
                       		else{
                        		out.print("<h2><center>No Records Found</center></h2>");
                        		break;
                       		 }
                       	}
                       	}%>
                        </div>
<!--                         <div class="image"> -->
<!--                           <div class="image"> -->
<!-- 	                       <img src="plugins/images/Untitled-1.png" alt="Project image"/> -->
<!-- 	                       <div class="overlay"> -->
<!-- 		                       <div class="row"> -->
<!-- 			                       <div class="col-md-6 left"> -->
<!-- 				                       <h3>Rohan Lehare</h3> -->
<!-- 				                       <h4>Baner</h4> -->
<!-- 				                       <br> -->
<!-- 					                       <div class="bottom"> -->
<!-- 					                       <h4>50/500 SOLD</h4> -->
<!-- 					                       </div> -->
<!-- 			                       </div> -->
<!-- 			                        <div class="col-md-6 right"> -->
<!-- 				                         <div class="chart" id="graph1" data-percent="50"> -->
<!-- 				                         </div> -->
<!-- 					                        <div class="bottom"> -->
<!-- 					                        <h4>10 NEW LEADS</h4> -->
<!-- 					                        </div> -->
<!-- 			                       </div> -->
<!-- 		                       </div> -->
<!--                            </div> -->
<!--                        </div> -->
<!--                         </div> -->
<!--                        </div> -->
<!--                        <div class="col-md-6 col-sm-6 col-xs-12 projectsection"> -->
<!--                       <div class="image"> -->
<!-- 	                       <img src="plugins/images/Untitled-1.png" alt="Project image"/> -->
<!-- 	                       <div class="overlay"> -->
<!-- 		                       <div class="row"> -->
<!-- 			                       <div class="col-md-6 left"> -->
<!-- 				                       <h3>Rohan Lehare</h3> -->
<!-- 				                       <h4>Baner</h4> -->
<!-- 				                       <br> -->
<!-- 					                       <div class="bottom"> -->
<!-- 					                       <h4>50/500 SOLD</h4> -->
<!-- 					                       </div> -->
<!-- 			                       </div> -->
<!-- 			                        <div class="col-md-6 right"> -->
<!-- 				                         <div class="chart" id="graph" data-percent="30"> -->
<!-- 				                         </div> -->
<!-- 					                        <div class="bottom"> -->
<!-- 					                        <h4>10 NEW LEADS</h4> -->
<!-- 					                        </div> -->
<!-- 			                       </div> -->
<!-- 		                       </div> -->
<!--                            </div> -->
<!--                        </div>   -->
<!--                        <div class="image"> -->
<!-- 	                       <img src="plugins/images/Untitled-1.png" alt="Project image"/> -->
<!-- 	                       <div class="overlay"> -->
<!-- 		                       <div class="row"> -->
<!-- 			                       <div class="col-md-6 left"> -->
<!-- 				                       <h3>Rohan Lehare</h3> -->
<!-- 				                       <h4>Baner</h4> -->
<!-- 				                       <br> -->
<!-- 					                       <div class="bottom"> -->
<!-- 					                       <h4>50/500 SOLD</h4> -->
<!-- 					                       </div> -->
<!-- 			                       </div> -->
<!-- 			                        <div class="col-md-6 right"> -->
<!-- 				                         <div class="chart" id="graph" data-percent="90"> -->
<!-- 				                         </div> -->
<!-- 					                        <div class="bottom"> -->
<!-- 					                        <h4>10 NEW LEADS</h4> -->
<!-- 					                        </div> -->
<!-- 			                       </div> -->
<!-- 		                       </div> -->
<!--                            </div> -->
<!--                        </div> -->
<!--                        </div> -->

	                    <div class="offset-sm-5 col-sm-7" id="showMore">
	                        <button type="button" onclick="getAllProjectsByBuiderId();" class="btn btn11 btn-default waves-effect waves-light m-t-10">More...</button>
	                     </div>
	                     
                    </div>
                </div>
                
                
                <!-- /.row -->
                <!-- .row -->
                <div class="row">
                    <div class="col-md-8 col-sm-6 col-xs-12">
                        <div class="white-box">
                            <h3 class="box-title">Project status</h3>
                            <div class="col-md-3 col-sm-6 col-xs-12">
                        		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                        <option>Project Name</option>
                                       <% for(ProjectList projectList : project_list){%>
                                       <option value="<%out.print(projectList.getId());%>"><%out.print(projectList.getName()); %></option>
                                       <% }%>
                           		</select>
                    		</div>
                            <ul class="list-inline text-right">
                                <li>
                                    <h5><i class="fa fa-circle m-r-5" style="color: #00bfc7;"></i>Flats</h5> </li>
                                <li>
                                    <h5><i class="fa fa-circle m-r-5" style="color: #fb9678;"></i>Buyers</h5> </li>
                                <li>
                                    <h5><i class="fa fa-circle m-r-5" style="color: #9675ce;"></i>Purchases</h5> </li>
                            </ul>
                            <div id="morris-bar-chart" style="height:372px;"></div>
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="white-box m-b-15">
                                    <h3 class="box-title">Property sales</h3>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-xs-6  m-t-30">
                                            <h1 class="text-info sales-income">Rs 64057</h1>
                                            <p class="text-muted">APRIL 2017</p> <b>(150 Sales)</b> </div>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <div id="sparkline2dash" class="text-center"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="white-box bg-blue m-b-15 ">
                                    <h3 class="text-white box-title">PROPERTY SALE INCOME</h3>
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6 col-xs-6  m-t-30">
                                            <h1 class="text-white sales-income">Rs 30447</h1>
                                            <p class="light_op_text"><br></p> <b class="text-white">(110 Sales)</b> </div>
                                        <div class="col-md-6 col-sm-6 col-xs-6">
                                            <div id="sales1" class="text-center"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
                <div class="white-box">
	                <div class="row">
		                <div class="col-md-4">
		                    <button type="button" onclick="addEmployee();" class="btn11 btn-info waves-effect waves-light m-t-10">Add New Employee</button>
		                </div>
		                 <div class="col-md-4">
		                    <button type="button" onclick="addLead();" class="btn11 btn-info waves-effect waves-light m-t-10">Add New Lead</button>
		                 </div>
		                 <div class="col-md-4">
		                    <button type="button" onclick="addBuyer();" class="btn11 btn-info waves-effect waves-light m-t-10">Add New Buyer</button>
		                </div>
	                </div>
                </div>
                </div>
                </div>
                </div>
        <!-- /.container-fluid -->
   			<div id="footer"> 
	      		<%@include file="partial/footer.jsp"%>
			</div> 
       
    <script src="plugins/bower_components/switchery/dist/switchery.min.js"></script>
    <script src="plugins/bower_components/custom-select/custom-select.min.js" type="text/javascript"></script>
    <script src="plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
    <script src="plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
    <script src="plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="plugins/bower_components/multiselect/js/jquery.multi-select.js"></script>
    <script src="${baseUrl}/builder/plugins/bower_components/morrisjs/morris.js"></script>
    <script src="${baseUrl}/builder/js/real-estate.js"></script>
<%--     <script src="${baseUrl}/builder/plugins/bower_components/jquery-sparkline/jquery.charts-sparkline.js"></script> --%>
<%--     <script src="${baseUrl}/builder/plugins/bower_components/jquery-sparkline/jquery.sparkline.min.js"></script> --%>
    <script>
    function addLead(){
    	window.location.href="${baseUrl }/builder/leads/new.jsp"
    }
    function addEmployee(){
    	window.location.href="${baseUrl }/builder/employee/new.jsp";
    }
    function addBuyer(){
    	window.location.href="${baseUrl }/builder/buyer/new.jsp";
    }
    
    $("#city_id").change(function(){
    	$.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#city_id").val() }, function(data){
    		var html = '<option value="">Select Locality</option>';
    		$(data).each(function(index){
    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
    		});
    		$("#locality_id").html(html);
    		$('.selectpicker').selectpicker('refresh');
    	},'json');
    	getProjectList();
    });
    $("#locality_id").change(function(){
    	getProjectList();
    });
    
    jQuery(document).ready(function() {
        // Switchery
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
        $('.js-switch').each(function() {
            new Switchery($(this)[0], $(this).data());

        });
        // For select 2

        $(".select2").select2();
        $('.selectpicker').selectpicker();

        //Bootstrap-TouchSpin
        $(".vertical-spin").TouchSpin({
            verticalbuttons: true,
            verticalupclass: 'ti-plus',
            verticaldownclass: 'ti-minus'
        });
        var vspinTrue = $(".vertical-spin").TouchSpin({
            verticalbuttons: true
        });
        if (vspinTrue) {
            $('.vertical-spin').prev('.bootstrap-touchspin-prefix').remove();
        }

        $("input[name='tch1']").TouchSpin({
            min: 0,
            max: 100,
            step: 0.1,
            decimals: 2,
            boostat: 5,
            maxboostedstep: 10,
            postfix: '%'
        });
        $("input[name='tch2']").TouchSpin({
            min: -1000000000,
            max: 1000000000,
            stepinterval: 50,
            maxboostedstep: 10000000,
            prefix: '$'
        });
        $("input[name='tch3']").TouchSpin();

        $("input[name='tch3_22']").TouchSpin({
            initval: 40
        });

        $("input[name='tch5']").TouchSpin({
            prefix: "pre",
            postfix: "post"
        });

        // For multiselect

        $('#pre-selected-options').multiSelect();
        $('#optgroup').multiSelect({
            selectableOptgroup: true
        });

        $('#public-methods').multiSelect();
        $('#select-all').click(function() {
            $('#public-methods').multiSelect('select_all');
            return false;
        });
        $('#deselect-all').click(function() {
            $('#public-methods').multiSelect('deselect_all');
            return false;
        });
        $('#refresh').on('click', function() {
            $('#public-methods').multiSelect('refresh');
            return false;
        });
        $('#add-option').on('click', function() {
            $('#public-methods').multiSelect('addOption', {
                value: 42,
                text: 'test 42',
                index: 0
            });
            return false;
        });

    });
    </script>
    <script>
    
    <%
	if(project_list !=null){
		int i=1;
		for(ProjectList projectList : project_list ){
%>
	createGraph("graph<%out.print(projectList.getId());%>");
	<%}}%>
    
    function createGraph(graphId){
    	//alert(graphId);
    	 var el = document.getElementById(graphId); 
    	//var el = $('div #'+graphId).attr('data-percent');
    	// alert("Graph Id "+el);
    	var per= el.getAttribute('data-percent');
    	//alert("per : "+per);
 	    var options = {
 	        percent:  el.getAttribute('data-percent') || 2,
 	        size: el.getAttribute('data-size') || 100,
 	        lineWidth: el.getAttribute('data-line') || 5,
 	        rotate: el.getAttribute('data-rotate') || 0
 	    }

 	    var canvas = document.createElement('canvas');
 	    var span = document.createElement('span');
 	    span.textContent = options.percent + '%';
 	        
 	    if (typeof(G_vmlCanvasManager) !== 'undefined') {
 	        G_vmlCanvasManager.initElement(canvas);
 	    }

 	    var ctx = canvas.getContext('2d');
 	    canvas.width = canvas.height = options.size;

 	    el.appendChild(span);
 	    el.appendChild(canvas);

 	    ctx.translate(options.size / 2, options.size / 2); // change center
 	    ctx.rotate((-1 / 2 + options.rotate / 180) * Math.PI); // rotate -90 deg

 	    //imd = ctx.getImageData(0, 0, 240, 240);
 	    var radius = (options.size - options.lineWidth) / 2;

 	    var drawCircle = function(color, lineWidth, percent) {
 	    		percent = Math.min(Math.max(0, percent || 1), 1);
 	    		ctx.beginPath();
 	    		ctx.arc(0, 0, radius, 0, Math.PI * 2 * percent, false);
 	    		ctx.strokeStyle = color;
 	            ctx.lineCap = 'round'; // butt, round or square
 	    		ctx.lineWidth = lineWidth
 	    		ctx.stroke();
 	    };

 	    drawCircle('#efefef', options.lineWidth, 100 / 100);
 	    drawCircle('#03a9f3', options.lineWidth, options.percent / 100);
    }
    
    $("#project_id").change(function(){
    	getProjectFilterList($("#project_id").val());
    });
    
 function getProjectList(){
    	
    	var html = "";
		var image = "";
		var projectName = "";
		var cityName = "";
		var projectId = "";
		$("#project_list").empty();
	   $.post("${baseUrl}/webapi/project/data/list",{builder_id: $("#builder_id").val(), country_id: 1, city_id: $("#city_id").val(),locality_id : $("#locality_id").val() },function(data){
		   if(data == ""){
			   $("#project_list").empty();
			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				if(data[index].image != "")
					image = "${baseUrl}/"+data[index].image;
				else
					image = "${baseUrl}/builder/plugins/images/Untitled-1.png";
				if(data[index].name != ""){
					projectName = data[index].name;
				}
				if(data[index].city != ""){
					cityName = data[index].city;
				}
				if(data[index].id != ""){
					projectId = data[index].id;
				}
				html='<div class="col-md-6 col-sm-6 col-xs-12 projectsection" id="projectlist">'
		    		+'<div class="image">'
                   	+'<img  src="'+image+'" height="348"  width="438" alt="Project image"/>'
                   	+'<div class="overlay">'
                    +'<div class="row">'
	                +'<div class="col-md-6 left">'
		            +'<h3>'+projectName+'</h3>'
		            +'<h4>'+cityName+'</h4>'
		            +'<br>'
               		+'<div class="bottom">'
                	+'<h4>'+data[index].sold+'/'+data[index].totalSold+' SOLD</h4>'
                	+'</div>'
	                +'</div>'
	                +'<div class="col-md-6 right">'
		            +'<div class="chart" id="graph'+projectId+'" data-percent="'+data[index].completionStatus+'"></div>'
		            +'<div class="bottom">'
                    +'<h4>'+data[index].totalLeads+ ' NEW LEADS</h4>'
                    +'</div>'
	                +'</div>'
                    +'</div>'
                    +'</div>'
               		+'</div>'
               		+'<div class="row">'
               		+'<div class="col-md-6 left">' 
               		+'<a href="${baseUrl}/builder/project/edit.jsp?project_id='+projectId+'" class="btn btn11 btn-info waves-effect waves-light m-t-1">Edit</a>'
               		+'</div>'
             		+'<div class="col-md-6 center">'
              		+'<a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id='+projectId+'" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>'
			 	 	+'</div>'
			 		+'</div>'
	            	+'</div>';
	            		$("#project_list").append(html);
	            		createGraph("graph"+projectId);
			});
		    },'json');
	   }
 
 function getProjectFilterList(project_id){
 	
 	var html = "";
		var image = "";
		var projectName = "";
		var cityName = "";
		var projectId = "";
		$("#project_list").empty();
	   $.post("${baseUrl}/webapi/project/filter",{project_id:project_id},function(data){
		   if(data == ""){
			   $("#project_list").empty();
			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				if(data[index].image != "")
					image = "${baseUrl}/"+data[index].image;
				else
					image = "${baseUrl}/builder/plugins/images/Untitled-1.png";
				if(data[index].name != ""){
					projectName = data[index].name;
				}
				if(data[index].city != ""){
					cityName = data[index].city;
				}
				if(data[index].id != ""){
					projectId = data[index].id;
				}
				html='<div class="col-md-6 col-sm-6 col-xs-12 projectsection" id="projectlist">'
		    		+'<div class="image">'
                   	+'<img  src="'+image+'" height="348"  width="438" alt="Project image"/>'
                   	+'<div class="overlay">'
                    +'<div class="row">'
	                +'<div class="col-md-6 left">'
		            +'<h3>'+projectName+'</h3>'
		            +'<h4>'+cityName+'</h4>'
		            +'<br>'
               		+'<div class="bottom">'
                	+'<h4>'+data[index].sold+'/'+data[index].totalSold+' SOLD</h4>'
                	+'</div>'
	                +'</div>'
	                +'<div class="col-md-6 right">'
		            +'<div class="chart" id="graph'+projectId+'" data-percent="'+data[index].completionStatus+'"></div>'
		            +'<div class="bottom">'
                    +'<h4>'+data[index].totalLeads+ ' NEW LEADS</h4>'
                    +'</div>'
	                +'</div>'
                    +'</div>'
                    +'</div>'
               		+'</div>'
               		+'<div class="row">'
               		+'<div class="col-md-6 left">' 
               		+'<a href="${baseUrl}/builder/project/edit.jsp?project_id='+projectId+'" class="btn btn11 btn-info waves-effect waves-light m-t-1">Edit</a>'
               		+'</div>'
             		+'<div class="col-md-6 center">'
              		+'<a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id='+projectId+'" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>'
			 	 	+'</div>'
			 		+'</div>'
	            	+'</div>';
	            		$("#project_list").append(html);
	            		createGraph("graph"+projectId);
			});
		    },'json');
	   }
 
      function getAllProjectsByBuiderId(){
    	  var html = "";
  		var image = "";
  		var projectName = "";
  		var cityName = "";
  		var projectId = "";
  		alert($("#project_id").val());
  	//  $('#project_id').prop('selectedIndex',0);
  	$("#project_id").val('0');
  		//alert("Builder Id :: "+$("#builder_id").val());
  		$("#project_list").empty();
  	   $.post("${baseUrl}/webapi/project/filter/builder",{builder_id:$("#builder_id").val()},function(data){
  		   if(data == ""){
  			   $("#project_list").empty();
  			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
  		   }
  			$(data).each(function(index){
  				if(data[index].image != "")
  					image = "${baseUrl}/"+data[index].image;
  				else
  					image = "${baseUrl}/builder/plugins/images/Untitled-1.png";
  				if(data[index].name != ""){
  					projectName = data[index].name;
  				}
  				if(data[index].city != ""){
  					cityName = data[index].city;
  				}
  				if(data[index].id != ""){
  					projectId = data[index].id;
  				}
  				html='<div class="col-md-6 col-sm-6 col-xs-12 projectsection" id="projectlist">'
  		    		+'<div class="image">'
                     	+'<img  src="'+image+'" height="348"  width="438" alt="Project image"/>'
                     	+'<div class="overlay">'
                      +'<div class="row">'
  	                +'<div class="col-md-6 left">'
  		            +'<h3>'+projectName+'</h3>'
  		            +'<h4>'+cityName+'</h4>'
  		            +'<br>'
                 		+'<div class="bottom">'
                  	+'<h4>'+data[index].sold+'/'+data[index].totalSold+' SOLD</h4>'
                  	+'</div>'
  	                +'</div>'
  	                +'<div class="col-md-6 right">'
  		            +'<div class="chart" id="graph'+projectId+'" data-percent="'+projectId+'"></div>'
  		            +'<div class="bottom">'
                      +'<h4>'+data[index].totalLeads+ ' NEW LEADS</h4>'
                      +'</div>'
  	                +'</div>'
                      +'</div>'
                      +'</div>'
                 		+'</div>'
                 		+'<div class="row">'
                 		+'<div class="col-md-6 left">' 
                 		+'<a href="${baseUrl}/builder/project/edit.jsp?project_id='+projectId+'" class="btn btn11 btn-info waves-effect waves-light m-t-1">Edit</a>'
                 		+'</div>'
               		+'<div class="col-md-6 center">'
                		+'<a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id='+projectId+'" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>'
  			 	 	+'</div>'
  			 		+'</div>'
  	            	+'</div>';
  	            		$("#project_list").append(html);
  	            		createGraph("graph"+projectId);
  			});
  		    },'json');
  	   $("#showMore").empty();
      }
    </script>
    
    <script>
   
    
    //	 alert("Total Flats :: "+totalFlats);
    	//Morris bar chart
    	 <%
     	if(barGraphDatas != null){
      		%>
     // alert("Total Flats :: "+totalFlats);
     // alert("Total buyers :: "+totalBuyers);
      //alert("totalSold :: "+totalSold);
     	//getMorrisBar(totalFlats,totalBuyers,totalSold);
     	Morris.Bar({
     		 
    	    element: 'morris-bar-chart',
    	    data: [
    	    	<% for(BarGraphData barGraphData : barGraphDatas){
    	    		System.out.println("graph Count :: "+barGraphDatas.size());%>
    	    	{
    	    	
    	    	
   		      y: '<% DateFormat dateFormat = new SimpleDateFormat("yyyy");
    	    	    if(barGraphData.getBuiltYear() != null){
    	    	    	Date date = barGraphData.getBuiltYear();
   		      out.print(dateFormat.format(date));}%>',
    	        Flat: <%out.print(barGraphData.getTotalFlats());%>,
             Buyer: <%out.print(barGraphData.getTotalBuyers()); %>,
             Purchases: <% out.print(barGraphData.getTotalSold());%>
             
             },
             <% } %>],
             xkey: 'y',
     	    ykeys: ['Flat', 'Buyer', 'Purchases'],
     	    labels: ['Flat', 'Buyer', 'Purchases'],
     	    barColors:['#00bfc7', '#fb9678', '#9675ce'],
     	    hideHover: 'auto',
     	   
     	    gridLineColor: '#eef0f2',
     	    resize: true
     	});

     	//This is for the sparkline chart

//      	var sparklineLogin = function() { 
     	    
//      	    $('#sparkline2dash').sparkline([6, 10, 9, 11, 9, 10, 12], {
//      	        type: 'bar',
//      	        height: '154',
//      	        barWidth: '4',
//      	        resize: true,
//      	        barSpacing: '10',
//      	        barColor: '#25a6f7'
//      	    });
//      	   $('#sales1').sparkline([6, 10, 9, 11, 9, 10, 12], {
//      	        type: 'bar',
//      	        height: '154',
//      	        barWidth: '4',
//      	        resize: true,
//      	        barSpacing: '10',
//      	        barColor: '#fff'
//      	    });
     	    
//      	}
//      	var sparkResize;

//      	    $(window).resize(function(e) {
//      	        clearTimeout(sparkResize);
//      	        sparkResize = setTimeout(sparklineLogin, 500);
//      	    });
//      	    sparklineLogin();

     	
     <%
 	} %>
    </script>
</body>

</html>
