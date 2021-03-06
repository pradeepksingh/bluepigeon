<%@page import="org.bluepigeon.admin.data.NameList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
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
	Double totalPropertySold = 0.0;
	List<NameList> cityNames = null;
	List<NameList> localityNames = null;
	List<NameList> projectNames = null;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder != null){
				if(builder_id > 0){
					totalBuyers = new BuyerDAO().getTotalBuyers(builder);
					totalInventorySold = new ProjectDAO().getTotalInventory(builder);
					project_list = new ProjectDAO().getBuilderFirstFourActiveProjectsByBuilderId(builder);
					cityDataList = new CityNamesImp().getCityActiveNames();
					totalLeads = new ProjectDAO().getTotalLeads(builder);
					totalProjects = new ProjectDAO().getTotalNumberOfProjects(builder);
					barGraphDatas = new BuilderDetailsDAO().getBarGraphByBuilderId(builder);
					//totalSoldInventory = new ProjectDAO().getTotalSoldInventory(builder);
					//totalSaleValue = new BuilderProjectPriceInfoDAO().getProjectPriceInfoByBuilderId(builder_id);
					project_size_list = project_list.size();
					city_size_list = cityDataList.size();
				//	totalCampaign = new ProjectDAO().getTotalCampaignByEmpId(builder.getId());
					totalPropertySold = new ProjectDAO().getTotalRevenues(builder);
					totalRevenue = totalPropertySold * totalInventorySold;
					cityNames = new BuilderDetailsDAO().getProjectCityList(builder);
					localityNames = new BuilderDetailsDAO().getProjectLocalityList(builder);
					projectNames = new BuilderDetailsDAO().getAllotedProjectDetails(builder);
					
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
  
    <!-- Menu CSS -->
    <link href="plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${baseUrl}/builder/css/dashboard.css">
    <link href="${baseUrl}/builder/plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="${baseUrl}/builder/css/selectize.css" />
     <style>
     .selectize-input{
	border: 1px solid #808080 !important;
	padding : 10px 8px !important;
}.selectize-control.single .selectize-input:after {
	border-color: #808080 transparent transparent transparent !important;
}
     </style>
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
        <div id="page-wrapper">
           <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Dashboard</h4> </div>
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12"> 
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!--.row -->
                <div class="row">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Properties</h3>
                            <ul class="list-inline two-part">
                                <li><i class="ti-home text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%out.print(totalProjects); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Buyers</h3>
                            <ul class="list-inline two-part">
									 <li><i class="icon-tag text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text" ><%out.print(totalBuyers); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">New leads</h3>
                            <ul class="list-inline two-part">
                                 <li><i class="icon-user text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"><%out.print(totalLeads); %></span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                        <div class="white-box white-border">
                            <h3 class="box-title">Total Revenue (Rs in cr)</h3>
                            <ul class="list-inline two-part">
									 <li><i class="ti-wallet text-info-new"></i></li>
                                <li class="text-right"><span class="counter dashboard-text"> <%out.print(Math.round(totalPropertySold)); %></span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="white-box">
                   <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-12">
                      <select  id="city_id" name="city_id">
                       		<option value="0">All City</option>
                            <%
                            if(cityNames != null){
                            for(NameList city : cityNames){ %>
                            <option value="<%out.print(city.getId());%>"><%out.print(city.getName()); %></option>
                            <%}} %>
                          </select>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
							<select id="locality_name" name="locality_name">
                                 <option value="">All Localities</option>
                                 <%
                                 if(localityNames != null){
                                 	for(NameList locality : localityNames){
                                 %>
                                 <option value="<%out.print(locality.getName());%>"><%out.print(locality.getName()); %></option>
                                 <%}} %>
                        	</select>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <select id="project_id" name="project_id">
                             <option value="0">All Projects</option>
                             <%
                             	if(projectNames != null){
                             		for(NameList projectName : projectNames){
                             %>
                             <option value="<%out.print(projectName.getId());%>"><%out.print(projectName.getName()); %></option>
                             <%}} %>
                        </select>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                       <select id="project_status" name="project_status">
                            <option value="0">Status</option>
                            <option value="1">Pending Projects</option>
                            <option value="2">Completed Projects</option>
                         </select>
                    </div>
                    <input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_id);%>"/>
                    <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
                    <input type="hidden" id="access_id" name="access_id" value="<%out.print(access_id);%>"/>
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
	                       	     if(projectList.getImage() != null){
	                       	%>
		                       	<img  src="${baseUrl}/<% out.print(projectList.getImage()); %>" height="348" width="438" alt="Project image"/>
		                       	<%}}catch(Exception e){ %>
		                       		 <img  src="" height="348"  width="438" alt="Project image"/>
		                       	<%} %>
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-6 left">
					                       <h3><%out.print(projectList.getName()); %></h3>
					                       <h4><%out.print(projectList.getLocalityName()); %></h4>
					                       <br>
						                       <div class="bottom">
						                       <h4><%if(projectList != null){out.print(Math.round(projectList.getSold()));} %>/<% if(projectList != null){out.print(Math.round(projectList.getTotalSold()));} %> SOLD</h4>
						                       </div>
				                       </div>
				                        <div class="col-md-6 right">
					                         <div class="chart" id="graph<%out.print(projectList.getId()); %>" data-percent="<%out.print(Math.round(projectList.getCompletionStatus())); %>"></div>
						                     <div class="bottom">
						                        <h4><% out.print(projectList.getTotalLeads()) ;%> NEW LEADS</h4>
						                     </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
	                       <%if(access_id == 1){ %>
	                       <div class="row">
                           		<div class="col-md-6 left"> 
                           			<a href="${baseUrl}/builder/ceo/projectstatus/projectstatus.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           		</div>
                         		<div class="col-md-6 center">
                          		 	<a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 	</div>
						  </div>
	                        <%}else if(access_id==2){ %>
	                       <div class="row">
                           		<div class="col-md-6 left"> 
                           			<a href="${baseUrl}/builder/admin/project/edit.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           		</div>
                         		<div class="col-md-6 center">
                          		 	<a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 	</div>
						  </div>
						  <%}
	                        else if(access_id == 5){%>
	                      <div class="row">
                           	  <div class="col-md-6 left"> 
                           		   <a href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           	  </div>
                         	  <div class="col-md-6 center">
                          		   <a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	  </div>
						 </div>
						 <%}
	                        else if(access_id == 7){%>
	                      <div class="row">
                           	  <div class="col-md-6 left"> 
                           		   <a href="${baseUrl}/builder/salesman/booking/salesman_bookingOpenForm.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           	  </div>
                         	  <div class="col-md-6 center">
                          		   <a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	  </div>
						 </div>
	                      <%  }else if(access_id == 3){%>
	                     <div class="row">
                           	 <div class="col-md-6 left"> 
                           	   	 <a href="${baseUrl}/builder/marketinghead/campaign/mycampaigns.jsp?project_id=<%out.print(projectList.getId()); %>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           	 </div>
                           	 <div class="col-md-6 center">
                          		 <a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 </div>
                        </div>
	                    <%  } else if(access_id == 4){%>
	                    <div class="row">
                           	 <div class="col-md-6 left"> 
                           	   	 <a href="${baseUrl}/builder/projecthead/projectstatus/projectstatus.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           	 </div>
                           	 <div class="col-md-6 center">
                          		 <a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 </div>
                        </div>
	                    <%  }  else{ %>
						<div class="row">
						 	<div class="col-md-6 left"> 
                           	   	 <a href="${baseUrl}/builder/postsale/buyerlist/buyerlist.jsp?project_id=<% out.print(projectList.getId());%>" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>
                           	</div>
                         	<div class="col-md-6 center">
                          		 <a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>
						 	 </div>
						</div>
						<%} %>
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
	                    <div class="offset-sm-5 col-sm-7" id="showMore">
	                        <button type="button" onclick="getAllProjectsByBuiderId();" class="btn btn11 btn-submit waves-effect waves-light m-t-10">MORE</button>
	                     </div>
                    </div>
                </div>
                <!-- /.row -->
                <!-- .row -->
                <div class="row" id="notvisible">
                    <div class="col-md-8 col-sm-6 col-xs-12">
                        <div class="white-box">
                            <h3 class="box-title">Project status</h3>
                            <div class="col-md-3 col-sm-6 col-xs-12">
                        		<select class="selectpicker border-drop-down" data-style="form-control" id="graph_project_id" name="graph_project_id">
                                        <option>Project Name</option>
                                       <% if(project_list != null){
                                       for(ProjectList projectList : project_list){%>
                                       <option value="<%out.print(projectList.getId());%>"><%out.print(projectList.getName()); %></option>
                                       <%} }%>
                           		</select>
                    		</div>
                            <ul class="list-inline text-right">
                                <li>
                                    <h5><i class="fa fa-circle m-r-5" style="color: #24bcd3;"></i>Flats</h5> </li>
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
                                            <h1 class="text-info-new sales-income">Rs <%out.print(Math.round(totalPropertySold)); %></h1>
                                            <p class="text-muted"></p> <b>(<%out.print(totalInventorySold); %> Sales)</b> 
                                        </div>
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
                                            <h1 class="text-white sales-income">Rs  <%out.print(Math.round(totalPropertySold)); %></h1>
                                            <p class="light_op_text"><br></p> <b class="text-white">(<%out.print(totalInventorySold); %> Sales)</b>
                                        </div>
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
                <div class="white-box" id="bottomhide">
	                <div class="row" >
	                <%if((access_id >=1 && access_id <=2)) {%>
		                <div class="col-md-4">
		                    <button type="button" onclick="addEmployee();" class="btn11 btn-submit waves-effect waves-light m-t-10">Add New Employee</button>
		                </div>
		                 <div class="col-md-4">
		                    <button type="button" onclick="addLead();" class="btn11 btn-submit waves-effect waves-light m-t-10">Add New Lead</button>
		                 </div>
		                  <%} %>
		                  <%if(access_id == 5 || access_id == 7){ %>
		                   <div class="col-md-4">
		                    <button type="button" onclick="addLead();" class="btn11 btn-submit waves-effect waves-light m-t-10">Add New Lead</button>
		                 </div>
		                 <%} %>
		                 <%if(access_id ==3) {%>
		                  <div class="col-md-4">
		                    <button type="button" onclick="addCampaign();" class="btn11 btn-submit waves-effect waves-light m-t-10">Add Campaign</button>
		                 </div>
		                  <%} %>
	                </div>
                </div>
              </div>
           </div>
      </div>
        <!-- /.container-fluid -->
  	<div id="footer"> 
		<%@include file="partial/footer.jsp"%>
    </div> 
</body>
</html>
<script src="plugins/bower_components/custom-select/custom-select.min.js" type="text/javascript"></script>
<script src="${baseUrl}/builder/plugins/bower_components/morrisjs/morris.js"></script>
<script src="${baseUrl}/builder/js/real-estate.js"></script>
<script src="${baseUrl}/builder/plugins/bower_components/raphael/raphael-min.js"></script>
<script type="text/javascript" src="${baseUrl}/builder/js/selectize.min.js"></script>
<script>
   $("#notvisible").hide();
   $("#bottomhide").hide();
    $select_project = $("#project_id").selectize({
		persist: false,
		 onChange: function(value) {
			 if(value != "")
				 getProjectList();;
		 },
		 onDropdownOpen: function(value){
	    	 var obj = $(this);
    		var textClear =	 $("#project_id :selected").text();
	    	 if(textClear.trim() == "Enter Project Name"){
	    		 obj[0].setValue("0");
	    		 obj[0].setText("All Projects");
	    	 }
	     }
});
    <%if(project_size_list > 0){%>
    	select_project = $select_project[0].selectize;
    <%}%>
   $select_city = $("#city_id").selectize({
	  persist:false,
	  onChange:function(value){
		  
	  	if(value !=''){
			  $.get("${baseUrl}/webapi/general/locality/newlist/name",{ city_id: $("#city_id").val(),emp_id:$("#emp_id").val() }, function(data){
		    		var html = '<option value=""> All Localities</option>';
		    		$(data).each(function(index){
		    			html = html + '<option value="'+data[index].name+'">'+data[index].name+'</option>';
		    		});
		    		$select_locality[0].selectize.destroy();
		    		$("#locality_name").html(html);
		    		$select_locality = $("#locality_name").selectize({
						persist: false,
						 onChange: function(value) {
								 $.post("${baseUrl}/webapi/general/filterproject/list/name",{ locality_name: $("#locality_name").val(),emp_id : $("#emp_id").val() }, function(data){
							    		var html = '<option value="0">All Projects</option>';
							    		$(data).each(function(index){
							    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
							    		});
							    		$select_project[0].selectize.destroy();
							    		$("#project_id").html(html);
							    		$select_project = $("#project_id").selectize({
											persist: false,
											 onChange: function(value) {
												 if(value != ""){
													 getProjectList();
												 }
											 },
											 onDropdownOpen: function(value){
										   	 var obj = $(this);
												var textClear =	 $("#project_id :selected").text();
										   	 if(textClear.trim() == "Project"){
										   		 obj[0].setValue("0");
										   		 obj[0].setText("All Projects");
										   	 }
										    }
										});
							    	},'json');
								 getProjectList();
						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#locality_name :selected").text();
					   	 if(textClear.trim() == "Locality"){
					   		 obj[0].setValue("");
					   		 obj[0].setText("Localities")
					   	 }
					    }
					});
		    	},'json');
			  $.get("${baseUrl}/webapi/general/project/newlist/name",{ city_id: $("#city_id").val(),emp_id : $("#emp_id").val() }, function(data){
				    		var html = '<option value="0"> All Project</option>';
				    		$(data).each(function(index){
				    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
				    		});
				    		$select_project[0].selectize.destroy();
				    		$("#project_id").html(html);
				    		$select_project = $("#project_id").selectize({
								persist: false,
								 onChange: function(value) {
									 if(value != ""){
										 getProjectList();
									 }
								 },
								 onDropdownOpen: function(value){
							   	 var obj = $(this);
									var textClear =	 $("#project_id :selected").text();
							   	 if(textClear.trim() == "Project"){
							   		 obj[0].setValue("0");
							   		 obj[0].setText("All Projects");
							   	 }
							    }
							});
				    	},'json');
		    	getProjectList();
		  }
	  },
	  onDropdownOpen: function(value){
	    	 var obj = $(this);
 			 var textClear =	 $("#city_id :selected").text();
	    	 if(textClear.trim() == "City"){
	    		 obj[0].setValue("0");
	    	 }
	     }
   });
    <%if(city_size_list > 0){%>
    	select_city = $select_city[0].selectize;
    	
    <%}%>
    $select_locality = $("#locality_name").selectize({
    	persist: false,
    	 onChange: function(value) {
    		
    			 $.post("${baseUrl}/webapi/general/filterproject/list/name",{ locality_name: $("#locality_name").val(),emp_id : $("#emp_id").val() }, function(data){
			    		var html = '<option value="0">All Projects</option>';
			    		$(data).each(function(index){
			    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			    		});
			    		$select_project[0].selectize.destroy();
			    		$("#project_id").html(html);
			    		$select_project = $("#project_id").selectize({
							persist: false,
							 onChange: function(value) {
								 if(value != ""){
									 getProjectList();
								 }
							 },
							 onDropdownOpen: function(value){
						   	 var obj = $(this);
								var textClear =	 $("#project_id :selected").text();
						   	 if(textClear.trim() == "Project"){
						   		 obj[0].setValue("0");
						   		 obj[0].setText("All Projects");
						   	 }
						   }
						});
			    	},'json');
    		 	getProjectList();
    		 
    	 },
    	 onDropdownOpen: function(value){
       	 var obj = $(this);
    		var textClear =	 $("#locality_name :selected").text();
       	 if(textClear.trim() == "Locality"){
       		 obj[0].setValue("");
       		 obj[0].setText("All Localities");
       	 }
        }
    });
    select_locality = $select_locality[0].selectize;
    $select_project_status = $("#project_status").selectize({
    	persist: false,
   	 onChange: function(value) {
   		 if(value != ""){
   			getProjectList();
   		 }
   	 },
   	onDropdownOpen: function(value){
      	 var obj = $(this);
   		var textClear =	 $("#project_status :selected").text();
      	 if(textClear.trim() == "Status"){
      		 obj[0].setValue("");
      	 }
   		}
    });
    select_project_status = $select_project_status[0].selectize;
    
    function addLead(){
    	window.location.href="${baseUrl }/builder/leads/Salesman_add_lead.jsp"
    }
    function addEmployee(){
    	window.location.href="${baseUrl }/builder/employee/new.jsp";
    }
    function addBuyer(){
    	window.location.href="${baseUrl }/builder/buyer/new.jsp";
    }
    function addCampaign(){
    	window.location.href="${baseUrl}/builder/campaign/new.jsp";
    }
      
  
    <%
	if(project_list !=null){
		int i=1;
		for(ProjectList projectList : project_list ){
	%>
	createGraph("graph<%out.print(projectList.getId());%>");
	<%}}%>
    
    function createGraph(graphId){
    	 var el = document.getElementById(graphId); 
    	
    	var per= el.getAttribute('data-percent');
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
    
//$("#locality_name").attr('disabled',true);
 function getProjectList(){
 	
 	var html = "";
		var image = "";
		var projectName = "";
		var cityName = "";
		var projectId = "";
		var localityName = "";
		$("#project_list").empty();
		//if($("#city_id").val()>0)
			//$("#locality_name").attr('disabled',false);
		ajaxindicatorstart("Please wait while.. we search ...");
	   $.post("${baseUrl}/webapi/project/data/filterproject",{emp_id: $("#emp_id").val(), country_id: 1, city_id: $("#city_id").val(),locality_name : $("#locality_name").val(),project_id:$("#project_id").val(),project_status : $("#project_status").val() },function(data){
		   if(data == ""){
			   $("#project_list").empty();
			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				if(data[index].image != "")
					image = "${baseUrl}/"+data[index].image;
				else
//					image = "${baseUrl}/builder/plugins/images/Untitled-1.png";
					image = "";
					
				if(data[index].name != ""){
					projectName = data[index].name;
				}
// 				if(data[index].city != ""){
// 					cityName = data[index].city;
// 				}
				if(data[index].locality != ""){
					localityName = data[index].locality;
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
		            +'<h4>'+localityName+'</h4>'
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
            		<%if(access_id == 1){%>
            		+'<div class="col-md-6 left">' 
            		+'<a href="${baseUrl}/builder/ceo/projectstatus/projectstatus.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
            		+'</div>'
            		<%}%>
            		<%if(access_id==2){%>
            		+'<div class="col-md-6 left">' 
            		+'<a href="${baseUrl}/builder/admin/project/edit.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
            		+'</div>'
            		<%}%>
            		<%if(access_id == 3){%>
             		+'<div class="col-md-6 left">' 
             		+'<a href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id='+projectId+'"  class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
             		+'</div>'
             		<%}%>
             		<%if(access_id == 4){%>
             		+'<div class="col-md-6 left">' 
             		+'<a href="${baseUrl}/builder/projecthead/projectstatus/projectstatus.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
             		+'</div>'
             		<%}%>
            		<%if(access_id==5){%>
            		+'<div class="col-md-6 left">' 
             		+'<a href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
             		+'</div>'
             		<%}%>
             		<%if(access_id == 7){%>
             		+'<div class="col-md-6 left">' 
             		+'<a href="${baseUrl}/builder/salesman/booking/salesman_bookingOpenForm.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
             		+'</div>'
             		<%}%>
             		<%if(access_id==6){%>
             		+'<div class="col-md-6 left">' 
             		+'<a href="${baseUrl}/builder/postsale/buyerlist/buyerlist.jsp?project_id=='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
             		+'</div>'
             		<%}%>
          		+'<div class="col-md-6 center">'
           		+'<a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>'
			 	 	+'</div>'
			 		+'</div>'
	            	+'</div>';
	            		$("#project_list").append(html);
	            		createGraph("graph"+projectId);
			});
			ajaxindicatorstop();
		    },'json');
	   }
 
      function getAllProjectsByBuiderId(){
    	  var html = "";
  		var image = "";
  		var projectName = "";
  		var cityName = "";
  		var projectId = "";
  		var localityname = "";
  		$("#project_list").empty();
  		ajaxindicatorstart("Please wait while.. we search ...");
  	   $.post("${baseUrl}/webapi/project/filter/builderemp",{emp_id:$("#emp_id").val(),country_id: 1,state_id:1, city_id: $("#city_id").val(),locality_name : $("#locality_name").val(),project_status : $("#project_status").val()},function(data){
  		   if(data == ""){
  			   $("#project_list").empty();
  			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
  		   }
  			$(data).each(function(index){
  				if(data[index].image != "")
  					image = "${baseUrl}/"+data[index].image;
  				else
  					image = "";
  				//	image = "${baseUrl}/builder/plugins/images/Untitled-1.png";
  				if(data[index].name != ""){
  					projectName = data[index].name;
  				}
  				if(data[index].city != ""){
  					cityName = data[index].city;
  				}
  				if(data[index].locality != ""){
  					localityName = data[index].locality;
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
  		            +'<h4>'+localityName+'</h4>'
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
                 		<%if(access_id == 1){%>
                		+'<div class="col-md-6 left">' 
                		+'<a href="${baseUrl}/builder/ceo/projectstatus/projectstatus.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
                		+'</div>'
                		<%}%>
                 		<%if(access_id == 2){%>
                 		+'<div class="col-md-6 left">' 
                 		+'<a href="${baseUrl}/builder/admin/project/edit.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
                 		+'</div>'
                 		<%}%>
                 		<%if(access_id == 3){%>
                 		+'<div class="col-md-6 left">' 
                 		+'<a href="${baseUrl}/builder/marketinghead/campaign/mycampaigns.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
                 		+'</div>'
                 		<%}%>
                 		<%if(access_id == 4){%>
                 		+'<div class="col-md-6 left">' 
                 		+'<a href="${baseUrl}/builder/projecthead/projectstatus/projectstatus.jsp?project_id='+projectId+'"  class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
                 		+'</div>'
                 		<%}%>
                 		<% if(access_id == 5){%>
	             		+'<div class="col-md-6 left">' 
	             		+'<a href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
	             		+'</div>'
	             		<%}%>
	             		<%if(access_id==6){%>
	             		+'<div class="col-md-6 left">' 
	             		+'<a href="${baseUrl}/builder/postsale/buyerlist/buyerlist.jsp?project_id=='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
	             		+'</div>'
	             		<%}%>
	             		<% if( access_id == 7){%>
	             		+'<div class="col-md-6 left">' 
	             		+'<a href="${baseUrl}/builder/salesman/booking/salesman_bookingOpenForm.jsp?project_id='+projectId+'" class="btn btn11 btn-submit waves-effect waves-light m-t-1">Manage</a>'
	             		+'</div>'
	             		<%}%>
               			+'<div class="col-md-6 center">'
                		+'<a href="" class="btn btn11 btn-info-new waves-effect waves-light m-t-1 m-r--65">View</a>'
	  			 	 	+'</div>'
	  			 		+'</div>'
	  	            	+'</div>';
  	            		$("#project_list").append(html);
  	            		createGraph("graph"+projectId);
  			});
  			ajaxindicatorstop();
  		    },'json');
  	   $("#showMore").empty();
      }
   
    	//Morris bar chart
    	 <%
      	if(barGraphDatas != null){
       		%> 
     	Morris.Bar({
    	    element: 'morris-bar-chart',
    	    data: [
    	    	<% for(BarGraphData barGraphData : barGraphDatas){ %>
    	    	{
   		      y: '<%
     	    	    if(barGraphData.getBuiltYear() != 0){
    		      out.print(barGraphData.getBuiltYear());}%>', 
    	        Flat: <%out.print(barGraphData.getTotalFlats());%>,
             Buyer: <%out.print(barGraphData.getTotalBuyers()); %>,
             Purchases: <% out.print(barGraphData.getTotalSold());%>
             
             },
             <% } %>],
             xkey: 'y',
     	    ykeys: ['Flat', 'Buyer', 'Purchases'],
     	    labels: ['Flat', 'Buyer', 'Purchases'],
     	    barColors:['#24bcd3', '#fb9678', '#9675ce'],
     	    hideHover: 'auto',
     	   
     	    gridLineColor: '#eef0f2',
     	    resize: true
     	});
     <%	} %>
 	
 	$("#graph_project_id").change(function(){
 		barGraph();
 	});
 	function barGraph(){
 		//Morris bar chart
 		$("#morris-bar-chart").empty();
 		var chart = Morris.Bar({
 	   	    element: 'morris-bar-chart',
 	   	    data: [{
 	  		      y: '',
 	   	        Flat: 0,
 	            Buyers: 0,
 	            Purchases: 0
 	            }],
 	            xkey: 'y',
 	    	    ykeys: ['Flat', 'Buyers', 'Purchases'],
 	    	    labels: ['Flat', 'Buyers', 'Purchases'],
 	    	    barColors:['#00bfc7', '#fb9678', '#9675ce'],
 	    	    hideHover: 'auto',
 	    	   
 	    	    gridLineColor: '#eef0f2',
 	    	    resize: true
 	    	});
 		 $.post("${baseUrl}/webapi/builder/filter/bargraph",{project_id:$("#graph_project_id").val()},function(data){
 			 $(data).each(function(index){
 				var year = parseInt(data[index].builtYear); 
 				var buyers = data[index].totalBuyers;
 				var flats = data[index].totalFlats;
 				var purchases = data[index].totalSold;
 	 			chart.setData([{"y":year,"Flat":flats,"Buyers":buyers,"Purchases":purchases}]);
 			 });
 		 });
    }
</script>