<%@page import="org.bluepigeon.admin.data.NewLeadList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.model.Source"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
 	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
	int projectId = 0;
	int emp_id =0 ;
 	//List<ProjectData> builderProjects =null;
 	List<Source> sourceList = null;
 	BuilderProject builderProject = null;
 	List<NewLeadList> newLeadLists = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	projectId = Integer.parseInt(request.getParameter("project_id"));
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	List< BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos =null;
   	projectId = Integer.parseInt(request.getParameter("project_id")); 
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			if(builder_id > 0){
				//builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
				sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
					 builderProject = new ProjectDAO().getBuilderActiveProjectById(projectId);
					 builderProjectPropertyConfigurationInfos = new ProjectDAO().getPropertyConfigByProjectId(projectId);
					 newLeadLists = new ProjectDAO().getNewLeadList(projectId);
			}
			if(builderPropertyTypes != null){
			 	if(builderPropertyTypes.size()>0)
			 		type_size = builderPropertyTypes.size();
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

<link rel="stylesheet" type="text/css" href="../css/jquery.multiselect.css" />
    <!-- Menu CSS -->

    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
 <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- Custom CSS -->

    <link href="../css/style.css" rel="stylesheet">

    <!-- color CSS -->

    <link rel="stylesheet" type="text/css" href="../css/salemanaddleadpopup.css">

    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />

    <!-- jQuery -->

    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/jquery.form.js"></script>

    <script src="../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script>
     <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
      <script type="text/javascript" src="../js/selectize.min.js"></script>
  	<script type="text/javascript">
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-2').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-3').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-4').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-5').multiselect();
// 		    });
		</script>
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
		                    <button type="submit" id="leads" class="btn11 btn-lead waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">CAMPAIGN</button>
		                </div>
	                </div>
               <!-- row -->
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12">
                         <form class="navbar-form lead-search" role="search">
                          <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn">
						        <button class="btn btn-default" type="submit"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-lead waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal1">New Lead +</button>
                      </div>
                 </div>
                 <div class="white-box">
                   <div class="lead-bg">
                   <!-- buyer information end -->
	                 <div class="row blue-border">
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Name</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Phone no.</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Email Id</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Source</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Status</h2>
	                   </div>
	                 </div>
	                 <%
	                 //if(newLeadLists != null){
	                 for(NewLeadList newLeadList : newLeadLists){ %>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getLeadName()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getPhoneNo()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getEmail()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getSource()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="#">No Response</a></li>
						      <li><a href="#">Call Again</a></li>
						      <li><a href="#">Email Sent</a></li>
						      <li><a href="#">Visit Again</a></li>
						      <li><a href="#">Visit Complete</a></li>
						      <li><a href="#">Follow up</a></li>
						      <li><a href="#">Booked</a></li>
						      <li><a href="#">Not interested</a></li>
						    </ul>
						  </div>
	                    </div>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <img src="../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Last States: <b><%out.print(newLeadList.getLeadStatus()); %></b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6><%out.print(newLeadList.getSalemanName()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Rs <%out.print(newLeadList.getMin());%> -<%out.print(newLeadList.getMax()); %> Lakh</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>
	                      <%
	                      int a=newLeadList.getConfigDatas().size();
	                      for(int i=0;i<newLeadList.getConfigDatas().size();i++){ 
	                      	if(a>1){
	                      		out.print(newLeadList.getConfigDatas().get(i).getName()+", ");
	                      		a--;
	                      	}else{
	                      		out.print(newLeadList.getConfigDatas().get(i).getName());
	                      	}
	                      } %>
	                      </h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6><%out.print(newLeadList.getSource()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b><% if(newLeadList.getlDate() != null){ out.print(newLeadList.getlDate());} %></b></h6>
	                    </div>
	                 </div>
	               </div>
	               <%} //}%>
	               <!-- buyer information end -->
	                <!-- buyer information -->
	               <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Satish Rajvade</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>0000-000-000</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>info@gmail.com</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4>Google Source</h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="#">HTML</a></li>
						      <li><a href="#">CSS</a></li>
						      <li><a href="#">JavaScript</a></li>
						      <li><a href="#">About Us</a></li>
						    </ul>
						  </div>
	                    </div>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <img src="../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Last States: <b>Call</b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Salesman name</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6>Rs 50 -70 Lakh</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>2BHK, 3BHK</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Google Source</h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b>23 July 2017</b></h6>
	                    </div>
	                 </div>
	               </div>
	                <!-- buyer information end -->
                  </div>
               </div>
            </div>
       </div>
        <!-- Modal -->
		  <div class="modal fade" id="myModal1" role="dialog">
		   <div class="modal-dialog lead">
		      <div class="modal-content">
		        <div class="modal-body">
		           	  <div class="row">
						  <div class="col-md-10 col-sm-10 col-xs-10">
							<h3>Add Lead</h3>
						  </div>
						  <div class="col-md-2 col-sm-2 col-xs-2">
							<img src="../images/error.png" alt="cancle" data-dismiss="modal">
						  </div>
						</div>
						
				  		<div class="row bg12">
				  		 <form class="addlead1 addlead" id="addnewlead" name="addnewlead" action="" method="post"  enctype="multipart/form-data" >
				  		 <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
		                     <div class="col-md-6 col-sm-6 col-xs-12">
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Name <span class="text-danger">*</span></label>
									  <div class="col-7">
										  <div>
											 <input class="form-control" type="text"  id="leadname" name="leadname"  placeholder="Please enter lead name">
										  </div>
										  <div class="messageContainer"></div>
								  	 </div>
								 </div>
								 <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Email ID <span class="text-danger">*</span></label>
										<div class="col-7">
											<div>
										   <input class="form-control" type="text" id="email" name="email" placeholder="Please enter email id">
										 </div>
										   <div class="messageContainer"></div>
										   </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Configuration <span class="text-danger">*</span></label>
										  <div class="col-7">
										  	<div>
										      <select id="configuration" name="configuration[]"  multiple>
									           <% if(builderProjectPropertyConfigurationInfos != null){ 
									           	for(BuilderProjectPropertyConfigurationInfo builderProjectPropertyConfigurationInfo : builderProjectPropertyConfigurationInfos){
									           %>
									            <option value="<%out.print(builderProjectPropertyConfigurationInfo.getBuilderProjectPropertyConfiguration().getId());%>"><%out.print(builderProjectPropertyConfigurationInfo.getBuilderProjectPropertyConfiguration().getName()); %></option>
									           <%}} %>
										     </select>
										     </div>
										     <div class="messageContainer"></div>
										  </div>
									 </div>
		                            <div class="form-group row">
							           <label for="example-tel-input" class="col-5 col-form-label">Source <span class="text-danger">*</span></label>
								         <div class="col-7">
								         	<div>
									        <select id="select_source" name="select_source" data-style="form-control">
									        <%if(sourceList != null){
									        for(Source source: sourceList) {%>
					                          <option value="<%out.print(source.getId());%>"><%out.print(source.getName()); %></option>
					                        
					                          <%}} %>
					                        </select>
					                        </div>
					                         <div class="messageContainer"></div>
									     </div>
								    </div>
						       </div>
		                    <div class="col-md-6 col-sm-6 col-xs-12">
		                       <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Phone No. <span class="text-danger">*</span></label>
									  <div class="col-7">
									  	<div>
										 <input class="form-control" type="text" id="mobile" name="mobile"  placeholder="Enter Phone number">
									  </div>
									   <div class="messageContainer"></div>
									  </div>
								  </div>
								  <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
 								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Interested Project</label>
										<div class="col-7">
										   <select id="multiple-checkboxes-2" disabled>
									           <% if(builderProject != null){%>
									           <option value="<%out.print(builderProject.getId());%>" selected><%out.print(builderProject.getName()); %></option>
									           <%} %>
										     </select>
										 </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Budget</label>
										    <button id="min-max-price-range" class="dropdown-toggle" href="#" data-toggle="dropdown">Budget<strong class="caret"></strong>
        									</button>
								        <div class="dropdown-menu col-sm-6" style="padding:10px;">
								            <div class="row">
								                <div class="col-xs-3">
								                    <input class="form-control price-label" placeholder="Min" id="minprice" name="minprice" data-dropdown-id="pricemin"/>
								                </div>
								                <div class="col-xs-2"> - </div>
								                <div class="col-xs-3">
								                    <input class="form-control price-label" placeholder="Max"id="maxprice" name="maxprice" data-dropdown-id="pricemax"/>
								                </div>
												<div class="clearfix"></div>
								                <ul id="pricemin" class="col-sm-12 price-range list-unstyled">
								                    <li  data-value="0">0</li>
								                    <li data-value="10">10</li>
								                    <li  data-value="20">20</li>
								                    <li  data-value="30">30</li>
								                    <li  data-value="40">40</li>
								                    <li  data-value="50">50</li>
								                    <li  data-value="60">60</li>
								                </ul>
								                <ul id="pricemax" class="col-sm-12 price-range text-right list-unstyled hide">
								                    <li  data-value="0">0</li>
								                    <li  data-value="10">10</li>
								                    <li  data-value="20">20</li>
								                    <li  data-value="30">30</li>
								                    <li  data-value="40">40</li>
								                    <li  data-value="50">50</li>
								                    <li  data-value="60">60</li>
								                </ul>
								            </div>
								        </div>
									 </div>
								</div>
								<div class="center bcenter">
							  	   <button type="submit" class="button1">Save</button>
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
<script>
$("#booking").click(function(){
	 window.location.href="${baseUrl}/builder/buyer/booking.jsp?project_id="+$("#project_id").val();
});
$("#cancellation").click(function(){
	 window.location.href="${baseUrl}/builder/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(projectId);%>
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+<%out.print(projectId);%>
});
$select_scorce = $("#select_source").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#select_source").val() > 0 || $("#select_source").val() != '' ){
			
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#select_source :selected").text();
    	 if(textClear.trim() == "Enter Source Name"){
    		 obj[0].setValue("0");
    	 }
     }
});

select_scorce = $select_scorce[0].selectize;

$('#configuration').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true
});

$('#min-max-price-range').click(function (event) {
    setTimeout(function(){ $('.price-label').first().focus();	},0);    
});
var priceLabelObj;
$('.price-label').focus(function (event) {
    priceLabelObj=$(this);
    $('.price-range').addClass('hide');
    $('#'+$(this).data('dropdownId')).removeClass('hide');
});

$(".price-range li").click(function(){    
    priceLabelObj.attr('value', $(this).attr('data-value'));
    var curElmIndex=$( ".price-label" ).index( priceLabelObj );
    var nextElm=$( ".price-label" ).eq(curElmIndex+1);

    if(nextElm.length){
        $( ".price-label" ).eq(curElmIndex+1).focus();
    }else{
        $('#min-max-price-range').dropdown('toggle');
    }
});

$('#addnewlead').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	leadname: {
            validators: {
                notEmpty: {
                    message: 'Lead name is required and cannot be empty'
                }
            }
        },
        mobile: {
        	validators: {
            	notEmpty: {
                    message: 'The Mobile is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[7-9][0-9]{9}$',
                    message: 'Invalid Mobile Number'
                }
            }
        },
        email: {
        	validators: {
            	notEmpty: {
                    message: 'The Email is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                    message: 'The value is not a valid email address'
                }
            }
        },
//         project_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Project is required and cannot be empty'
//                 }
//             }
//         },
//         city: {
//             validators: {
//                 notEmpty: {
//                     message: 'City Name is required and cannot be empty'
//                 }
//             }
//         },
//         area: {
//             validators: {
//                 notEmpty: {
//                     message: 'Locality Name is required and cannot be empty'
//                 }
//             }
//         },
        pricemin:{
            validators: {
                notEmpty: {
                    message: 'min price is required and cannot be empty'
                }
            }
        } ,
        pricemax:{
            validators: {
                notEmpty: {
                    message: 'max price is required and cannot be empty'
                }
            }
        } 
    }
    
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	//alert("success...Find solution on google..");
	event.preventDefault();
	addLead();
}).on('error.form.bv',function(event,data){
	alert("error...Find solution on google..");
});

function addLead() {
	alert("Hello from add new lead");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/new1',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addnewlead').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
		alert(resp.message);
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+$("#project_id").val();
  	}
}

</script>
