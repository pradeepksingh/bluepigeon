<%@page import="java.util.Date"%>
<%@page import="org.bluepigeon.admin.data.InboxMessageData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.InboxMessage"%>
<%@page import="org.bluepigeon.admin.data.InboxBuyerData"%>
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
 	List<InboxBuyerData> buyerData = null;
 	List<InboxMessageData> inboxMessageList = null;
 	int empId = 0;
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	Date date = new Date();
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			empId = builder.getId();
			if(empId > 0){
				buyerData = new ProjectDAO().getAllBuyersByBuilderEmployee(builder);
				inboxMessageList = new ProjectDAO().getBookedBuyerList(empId);
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
   <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/inbox.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
      <script src="../js/jquery.form.js"></script>
 <script type="text/javascript" src="../js/selectize.min.js"></script>
    <style>
    .selectize-input{
	
	padding:4px 8px 7px !important;
	margin-top:3px !important;
	font-size:18px !important;
	background-color: #fafafa !important;
}
    </style>
    <script>
    function uploadFile(target) {
    	document.getElementById("file-name").innerHTML = target.files[0].name;
    }
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
           <div class="container-fluid inbox">
               <!-- row -->
                <h1>Inbox</h1>
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12">
                         <form class="navbar-form lead-search" role="search" method="post">
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search by Name" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn">
						        <button class="btn btn-default" id="leadSearch" type="button"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-compose waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal2">Compose</button>
                      </div>
                 </div>
                 <div class="white-box">
	               <div class="bg11">
	                 <!-- inbox -->
	                 <%
						SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
	                   SimpleDateFormat dt2 = new SimpleDateFormat("h:m a");
					 %>
					 <div id="inboxList">
	                 <%if(inboxMessageList != null){
	                	 for(InboxMessageData inboxMessage : inboxMessageList){
	                	 %>
	                	 <a href="#inbox" onclick="javascript:getActiveProjectFlats();">
	                  	<div class="border-lead1">
		                  <div class="row">
		                    <div class="col-md-2 col-sm-2 col-xs-2 user">
		                    <%if(inboxMessage.getImage()!= null){ %>
		                      <img src="${baseUrl}/<%out.print(inboxMessage.getImage());%>" alt="user profile"  class="img-responsive"/>
		                      <%}else{ %>
		                       <img src="../images/user.png" alt="user profile"  class="img-responsive"/>
		                      <%} %>
		                    </div>
		                    <div class="col-md-9 col-sm-9 col-xs-9 left1">
		                      <h3><%out.print(inboxMessage.getName()); %></h3>
		                      <div class="inline">
		                          <h6><% if(inboxMessage.getDate() != null) { out.print(dt1.format(inboxMessage.getDate()));} %></h6>
		                          <h6><% if(inboxMessage.getDate() != null) { out.print(dt2.format(inboxMessage.getDate()));} %></h6>
		                      </div>
		                      <p><%out.print(inboxMessage.getSubject()); %></p>
		                    </div>
		                    <div class="col-md-1 col-sm-1 col-xs-1 arrow">
		                       <img src="../images/status-green.png" alt="status"  class="img-responsive"/>
		                    </div>
		                  </div>
	                  	</div>
	                  	</a>
	                  <%}} %>
	                  </div>
	              </div>
               </div>
            </div>
       </div>
       <input type="hidden" id="cdate" name="cdate" value=""/>
       <!-- modal pop up -->
        <div class="modal fade" id="myModal2" role="dialog">
		   <div class="modal-dialog inbox">
		      <div class="modal-content">
		        <div class="modal-body">
		           <div class="row">
					  <div class="col-md-10 col-sm-10 col-xs-10">
					    <h3>Compose</h3>
				      </div>
					  <div class="col-md-2 col-sm-2 col-xs-2">
					     <img src="../images/error.png" alt="cancle" data-dismiss="modal">
					   </div>
				    </div>
				  	<div class="row">
				  	   <form class="addlead1 addlead" action="" method="post" id="addinbox" name="addinbox"  enctype="multipart/form-data">
				  	   		<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(empId); %>" />
		                     <div class="">
		                       <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> To</label>
									  <div class="col-7">
										<select id="filter_buyer_id" name="filter_buyer_id[]" multiple  data-style="form-control">
	                        			<% if(buyerData != null){ 
	                        				for(InboxBuyerData inboxBuyerData : buyerData){
	                        			%>
	                       					<option value="<%out.print(inboxBuyerData.getId());%>"><%out.print(inboxBuyerData.getName()); %></option>
	                       					<%} }%>
	                       	 			</select>
									  </div>
								  </div>
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Subject</label>
									  <div class="col-7">
									  	<div>
											<input class="form-control" type="text"  id="subject" name="subject" placeholder="">
									  	</div>
									  	<div class="messageContainer"></div>
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Message</label>
										<div class="col-7">
											<div>
											  <textarea id="message" name="message">
											  </textarea>
										 	  </div>
										 	  <div class="messageContainer"></div>
										</div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Attachment</label>
										  <div class="col-7">
										     <div class="inputfile-box">
											   <input type="file" id="file" name="attachment[]" class="inputfile" onchange='uploadFile(this)'>
											   <label for="file">
											     <span id="file-name" class="file-box"></span>
											     <span class="file-button">
											      <i class="fa fa-upload" aria-hidden="true"></i>
											      Choose file
											     </span>
											  </label>
											</div>
										  </div>
									 </div>
		                         </div>
		                     <div class="center">
		                        <br/>
							  	<button type="submit" class="button1">Send</button>
							 </div>
		                </form>	
				   </div>
			  	</div>
		 	  </div>
            </div>
		  </div>
       <!--  modal pop up ends -->
         <!-- modal pop up -->
        <div class="modal fade" id="myModal4" role="dialog">
		   <div class="modal-dialog inbox">
		      <div class="modal-content">
		        <div class="modal-body">
		           <div class="row">
					  <div class="col-md-10 col-sm-10 col-xs-10">
					    <h3>Compose</h3>
				      </div>
					  <div class="col-md-2 col-sm-2 col-xs-2">
					     <img src="../images/error.png" alt="cancle" data-dismiss="modal">
					   </div>
				    </div>
				  	<div class="row" id="inbox">
				  	   <form class="addlead1 addlead" action="" method="post" id="addinbox" name="addinbox"  enctype="multipart/form-data">
				  	   		<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(empId); %>" />
		                     <div class="">
		                       <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> To</label>
									  <div class="col-7">
										<select id="filter_buyer_id" name="filter_buyer_id[]" multiple  data-style="form-control">
	                        			<% if(buyerData != null){ 
	                        				for(InboxBuyerData inboxBuyerData : buyerData){
	                        			%>
	                       					<option value="<%out.print(inboxBuyerData.getId());%>"><%out.print(inboxBuyerData.getName()); %></option>
	                       					<%} }%>
	                       	 			</select>
									  </div>
								  </div>
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Subject</label>
									  <div class="col-7">
									  	<div>
											<input class="form-control" type="text"  id="subject" name="subject" placeholder="">
									  	</div>
									  	<div class="messageContainer"></div>
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Message</label>
										<div class="col-7">
											<div>
											  <textarea id="message" name="message">
											  </textarea>
										 	  </div>
										 	  <div class="messageContainer"></div>
										</div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Attachment</label>
										  <div class="col-7">
										     <div class="inputfile-box">
											   <input type="file" id="file" name="attachment[]" class="inputfile" onchange='uploadFile(this)'>
											   <label for="file">
											     <span id="file-name" class="file-box"></span>
											     <span class="file-button">
											      <i class="fa fa-upload" aria-hidden="true"></i>
											      Choose file
											     </span>
											  </label>
											</div>
										  </div>
									 </div>
		                         </div>
		                     <div class="center">
		                        <br/>
							  	<button type="submit" class="button1">Reply</button>
							 </div>
		                </form>	
				   </div>
			  	</div>
		 	  </div>
            </div>
		  </div>
       <!--  modal pop up ends -->
    </div>
    <!-- /.container-fluid -->
    <div id="sidebar1"> 
	     <%@include file="../partial/footer.jsp"%>
	</div> 
  </body>
</html>

<script>
$select_project = $("#filter_buyer_id").selectize({
	persist: false,
	 onChange: function(value) {
		 //getBookedBuyerFilterList();
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_buyer_id :selected").text();
    	 if(textClear.trim() == "Enter buyer Name"){
    		 obj[0].setValue("");
    	 }
     }
});

$('#addinbox').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	'filter_buyer_id[]': {
            validators: {
                notEmpty: {
                    message: 'Please select buyer'
                }
            }
        },
        
        subject: {
            validators: {
                notEmpty: {
                    message: 'Please enter subject'
                }
            }
        },
        message: {
            validators: {
                notEmpty: {
                    message: 'Please enter message'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateProjectPrice();
	
});

function updateProjectPrice() {
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#pricingresponse', 
	 		beforeSubmit : showPriceRequest,
	 		success :  showPriceResponse,
	 		url : '${baseUrl}/webapi/builder/inbox/new',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addinbox').ajaxSubmit(options);
}

function showPriceRequest(formData, jqForm, options){
	$("#pricingresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showPriceResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#pricingresponse").removeClass('alert-success');
       	$("#pricingresponse").addClass('alert-danger');
		$("#pricingresponse").html(resp.message);
		$("#pricingresponse").show();
		alert(resp.message);
		 ajaxindicatorstop();
  	} else {
  		$("#pricingresponse").removeClass('alert-danger');
        $("#pricingresponse").addClass('alert-success');
        $("#pricingresponse").html(resp.message);
        $("#pricingresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
        window.location.href = "${baseUrl}/builder/inbox/inbox.jsp";
  	}
}

$("#leadSearch").click(function(){
	getBuyerNames();
});
$("#srch-term").keydown(function (e) {
	if (e.keyCode == 13) {
		getBuyerNames();
		return false;
	}
});
function getBuyerNames(){
	var emp_id = <%out.print(empId);%>
	var nameorNumber = $("#srch-term").val();
	$("#inboxList").empty();
	ajaxindicatorstart("Loading...");
	$.post("${baseUrl}/webapi/builder/filter/inbox",{emp_id: emp_id, nameOrNumber : nameorNumber },function(data){
		   if(data == ""){
			   $("#inboxList").empty();
			   $("#inboxList").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				var image = '';
				var thour = '';
				var tmin ='';
				var amp ='';
				var month ='';
				var ndate ='';
				var nyear = '';
				var nmonth = '';
				var  locale = "en-us";
				if(data[index].image != ''){
					image = '${baseUrl}/'+data.image;
				}
				if(data[index].date != ' '){
					var strDate = data[index].date;
					var newdate = new Date(strDate);
					var adate = new Date(strDate);
					thour = newdate.getHours();
					tmin = newdate.getMinutes();
					amp = (thour >=12)?"PM":"AM";
					if(thour >=12){
						thour = thour-12;
					}
					//get only year in number
					nyear = newdate.getFullYear();
					//get only date in number
			        ndate = newdate.getDate();
					//get month name 
			       nmonth = newdate.toLocaleString(locale, { month: "short" });
				}
				 htmlBookedBuyers ='<div class="border-lead1">'
	                  	+'<div class="row">'
                 		+'<div class="col-md-2 col-sm-2 col-xs-2 user">'
                   		+'<img src="'+image+'" alt="user profile"  class="img-responsive"/>'
                 		+'</div>'
                 		+'<div class="col-md-9 col-sm-9 col-xs-9 left1">'
                   		+'<h3>'+data[index].name+'</h3>'
                   		+'<div class="inline">'
                        +'<h6>'+ndate+' '+nmonth+' '+nyear+'</h6>'
                        +'<h6>'+thour+':'+tmin+' '+amp+'</h6>'
                   		+'</div>'
                   		+'<p>'+data[index].subject+'</p>'
                 		+'</div>'
                 		+'<div class="col-md-1 col-sm-1 col-xs-1 arrow">'
                    	+'<img src="../images/status-green.png" alt="status"  class="img-responsive"/>'
                 		+'</div>'
               			+'</div>'
           				+'</div>';
         		$("#inboxList").append(htmlBookedBuyers);
         		
			});
			 ajaxindicatorstop();
	});
}

function getActiveProjectFlats(){
$("#myModal4").modal('show');
}
</script>