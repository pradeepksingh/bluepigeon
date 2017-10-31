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
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id= builder.getId();
			if(builder_id > 0){
				project_list = new ProjectDAO().getActiveProjectsByBuilderId(builder_id);
				
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
<!--        <link href="../css/bootstrap.css" rel="stylesheet"> -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
      <link href="../css/jquery.multiselect.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="../css/Postsale_Massages.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/postsalebuyerlist.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../js/selectize.min.js"></script>
     <script src="../js/jquery.form.js"></script>
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
        <div id="page-wrapper">
         <section class="content">
            <div class="container-fluid">
           <div class="row"></div>
<!--                     <h3 style="font-weight: lighter;">Messages</h3> -->
          	<h1>MESSAGES</h1>
            <!-- Color Pickers -->
              
            <!-- #END# Color Pickers -->
            <!-- File Upload | Drag & Drop OR With Click & Choose -->
            <div class="row clearfix">
              
					 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                       <form  action="" method="post" id="addinbox" name="addinbox"  enctype="multipart/form-data">
                       <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                            <h2 style="color: #24bcd3;margin-left: 8px;">
                                COMPOSE
                            </h2>
						
                    <div class="row clearfix" style="margin-top:20px; border-bottom:2px solid #f1f1f1">
					
				     <div class="col-md-12">
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon"style="width: 10%;">
                                           
                                            <label for="ig_checkbox">Subject</label>
                                        </span>
                                        <div class="form-line">
                                           
                                            <input type="text" class="form-control newlen" id="subject" name="subject"  placeholder="">
                                     
                                        </div>
                                    </div>
                                </div>
				      <div class="col-md-12">
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="width: 10%;">
                                           
                                           <label for="ig_checkbox">Message</label>
                                        </span>
                                        <div class="form-line">
                                            <textarea type="text"  id="message"  name="message" placeholder="Enter your message here."class="form-control newlen"  placeholder=""></textarea>
                                        </div>
                                    </div>
                                </div>
								
								
								 <div class="col-md-12">
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="width: 10%;">
                                           
                                            <label for="ig_checkbox">Attachment</label>
                                        </span>
                                        <div class="form-line" style="width: 34%;">
                                            <div class="file-upload">
										  <div class="file-select">
											<div class="file-select-button" id="fileName">Choose File</div>
											<div class="file-select-name" id="noFile">No file chosen...</div> 
											<input type="file" id="file" name="attachment[]">
										  </div>
										</div>
                                        </div>
                                    </div>
                                </div>
								
							 </div>
							 <div class="row clearfix" style="margin-top:20px">
							 <div>
							  <h2 style="color: #24bcd3;margin-left: 8px;">
                                ADD RECIPITENT
                            </h2>
							</div>
				       			<ul class="col-md-6 newwidth" style="margin-top:15px">
                                    <li class="input-group ">
                                        <span class="input-group-addon">
                                            <label for="ig_checkbox">Project Name:</label>
                                        </span>
                                          <div id="selectproject">
												<select  id="filer_project_ids" name="filter_project_ids[]" multiple>
						                        	<%if(project_list != null){
						                        		for(ProjectData projectData : project_list){
						                        		%>
						                        	<option value="<%out.print(projectData.getId()); %>"><%out.print(projectData.getName()); %></option>
						                        	<%} }%>
						                      	</select>
			                   			  </div>
                                    </li>
                                </ul>
				     <ul class="col-md-6 newwidth" style="margin-top:15px">
                                    <li class="input-group  form-line">
                                        <span class="input-group-addon">
                                            <label for="ig_checkbox">Building Name:</label>
                                        </span>
                                        <div id="selectbuilding">
							  <div class="col-sm-12">
								  <select id="filer_building_ids" name="filter_building_ids[]" multiple></select>
							 </div>
							 <div class="messageContainer"></div> 
						</div>
                                      
                                    </li>
                                </ul>
								<div class="row clearfix">
								
								 <div class="col-md-6 newwidth">
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon">
                                           
                                            <label for="ig_checkbox">Flat No. & Buyer Name</label>
                                        </span>
                                        <div class="form-line">
                                           <div class="col-sm-12">
									<div>
									  <select id="filter_buyer_id" name="filter_buyer_id[]" multiple></select>
								 	</div>
								 	<div class="messageContainer"></div>
							  </div>
                                        </div>
										
                                    </div>
									<br/>
										 <div class="button-demo">
                                <button type="submit" class="btn btn-success  waves-effect" style="font-size: 22px;margin-left: 100px;">submit</button>
                               
                            </div>
                                </div>
								
								</div>
								 
                                    
							 </div>
							 </form>
                      </div>
						
                </div>
				   </div>
              
            <!-- #END# File Upload | Drag & Drop OR With Click & Choose -->
         </div>
        </div>
        </section>
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