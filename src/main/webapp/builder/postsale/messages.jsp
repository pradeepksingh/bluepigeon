<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<ProjectData> project_list = null;
	int builder_id = 0;
	int emp_id=0;
	int access_id =0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id= builder.getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder_id > 0 && access_id == 6){
				project_list = new ProjectDAO().getAssigProjects(emp_id);
			}else{
				response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
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
    <link rel="icon" type="image/png" sizes="16x16"  href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/newstyle.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
    <link href="../css/jquery.multiselect.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/adminadddocument.css">
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/newjquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
    <script src="../js/jquery.form.js"></script>
     <script src="../js/Moment.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
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
        <div id="page-wrapper" style="min-height: 238px;">
           <div class="container-fluid addlead">
               <!-- /.row -->
	            <h1>MESSAGES</h1>
               <!-- row -->
               <div class="white-box">
               <div class="bg11">
                  <form class="addlead1" name="addinbox" id="addinbox" action="" method="post" enctype="multipart/form-data">
                   <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                    <div class="spacer">
                      <h3>COMPOSE</h3>
                   </div>
                    <div class="row">
                     <div class="col-sm-12 col-xs-12 padding-left-right">
                         <div class="form-group row">
							<label for="example-text-input" class="col-sm-2 col-form-label"> Subject</label>
							  <div class="col-sm-10">
							  	<div>
								   <input type="text" class="form-control form-control1" id="subject" name="subject"  placeholder="">
			                      </div>
			                      <div class="messageContainer"></div>
							  </div>
						  </div>
					</div>
                    <div class="col-sm-12 col-xs-12 padding-left-right">
                       <div class="form-group row">
							<label for="example-text-input" class="col-sm-2 col-form-label"> Message</label>
							  <div class="col-sm-10">
							  	<div>
								 <textarea type="text"  id="message"  name="message" placeholder="Enter your message here."class="form-control form-control1"  placeholder=""></textarea>
							  </div>
							   <div class="messageContainer"></div>
							  </div>
						  </div>
						</div>
				   </div>
				   <div class="row">
                     <div class="col-sm-12 col-xs-12 padding-left-right">
                         <div class="form-group row">
							<label for="example-text-input" class="col-sm-2 col-form-label"> Attachment</label>
							  <div class="col-sm-7">
								<div>
									<div class="file-upload">
										<p class="file-name" id="noFile"></p>
									    <label for="file" id="fileName" class="btn">Choose File</label>
									   	<input type="file"  name="attachment[]" id="file">
									</div>
								</div>
								<div class="messageContainer"></div>
							</div>
						  </div>
					</div>
				   </div>
				      <hr>
				 <div class="spacer">
                   <h3>Add Recipients</h3>
                 </div>
				   <div class="row">
                     <div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                         <div class="form-group row">
							<label for="example-text-input" class="col-sm-5 col-form-label"> Project Name</label>
							<div class="col-sm-7">
								<div id="selectproject">
									<select id="filer_project_ids" name="filter_project_ids[]"  multiple>
			                        	<%if(project_list != null){
			                        		for(ProjectData projectData : project_list){
			                        		%>
			                        	<option value="<%out.print(projectData.getId()); %>"><%out.print(projectData.getName()); %></option>
			                        	<%} }%>
			                      	</select>
			                   </div>
			                   <div class="messageContainer"></div>
							</div>
						</div>
					</div>
                    <div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                      	<label for="example-text-input" class="col-sm-5 col-form-label"> Building Name</label>
                      		<div id="selectbuilding">
							  <div class="col-sm-7">
								  <select id="filer_building_ids" name="filter_building_ids[]" multiple></select>
							 </div>
							 <div class="messageContainer"></div> 
						</div>
				   </div>
				   </div>
				    <div class="row">
				       <div class="form-group row spacer1">
							  <label for="example-search-input" class="col-sm-5 col-form-label">Flat No. &#38; Buyer Name</label>
								<div class="col-sm-7">
									<div>
									   <select id="filter_buyer_id" name="filter_buyer_id[]" multiple></select>
								 	</div>
								 	<div class="messageContainer"></div>
							  </div>
						   </div>
				      </div>
					   <div class="row">
						   <div class="center">
					  	     <button type="submit" class="btn11">Save</button>
					  	  </div>
						</div>
					</form>
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
$('#filer_project_ids').multiselect({
    columns: 1,
    placeholder: 'Select Project',
    search: true,
    selectAll: true,
    onControlClose : function(element){getBuildingList(element);}     
});

$('#filer_building_ids').multiselect({
    columns: 1,
    placeholder: 'Select Building',
    search: true,
    selectAll: true,
    onControlClose : function(element){getFlatBuyerList(element);}  
});


function getBuildingList(element){
	var ids = "";
	 $("#selectproject .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	 });
	 if(ids != ""){
	 ajaxindicatorstart("Loading...");
	$.get("${baseUrl}/webapi/builder/building/data/"+ids,{},function(data){
		$("#filer_building_ids").multiselect('loadOptions',data);
		  $("#filer_building_ids").multiselect('reload');
		  ajaxindicatorstop();
	});
	 }
}
function getFlatBuyerList(element){
	var ids = "";
	 $("#selectbuilding .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	 });
	// alert(ids);
	if(ids != ""){
	 ajaxindicatorstart("Loading...");
		$.get("${baseUrl}/webapi/builder/flatbuyer/data/"+ids,{},function(data){
			$("#filter_buyer_id").multiselect('loadOptions',data);
			  $("#filter_buyer_id").multiselect('reload');
			  ajaxindicatorstop();
		});
	}
}

$('#filter_buyer_id').multiselect({

    columns: 1,
    placeholder: 'Select Flat & Buyer',
    search: true,
    selectAll: true,
	    
});
  jQuery(function($) {
	  $('input[type="file"]').change(function() {
	    if ($(this).val()) {
		    error = false;
	      var filename = $(this).val();
				$(this).closest('.file-upload').find('.file-name').html(filename);
	      if (error) {
	        parent.addClass('error').prepend.after('<div class="alert alert-error">' + error + '</div>');
	      }
	    }
	  });
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
	        'filter_project_ids[]': {
	            validators: {
	                notEmpty: {
	                    message: 'Please select atleat one project'
	                }
	            }
	        },
	        'filter_building_ids[]': {
	            validators: {
	                notEmpty: {
	                    message: 'Please select atleat one building'
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
		addInboxMessage();
		
	});

	function addInboxMessage() {
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
</script>