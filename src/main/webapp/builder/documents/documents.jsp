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
	int emp_id = 0;
	int access_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder_id > 0){
				if(access_id == 6){
					project_list = new ProjectDAO().getAssigProjects(emp_id);
				}
				if(access_id == 2){
					project_list = new ProjectDAO().getActiveProjectsByBuilderId(builder_id);
				}else{
					response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
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
	            <h1>Add Document</h1>
               <!-- row -->
               <div class="white-box">
               <div class="bg11">
                  <form class="addlead1" name="addocument" id="addocument" action="" method="post" enctype="multipart/form-data">
                    <div class="spacer">
                      <h3>Add Document</h3>
                   </div>
                    <div class="row">
                     <div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                         <div class="form-group row">
							<label for="example-text-input" class="col-sm-5 col-form-label"> Document Type</label>
							  <div class="col-sm-7">
							  	<div>
								  <select id="doctype" name="doctype" class="selectpicker selectpicker1">
			                          <option value="">Select Document</option>
			                          <option value="1">Agreement Letter</option>
			                          <option value="2">Demand Letter</option>
			                          <option value="3">Possession Letter</option>
			                          <option value="4">Other</option>
			                       </select>
			                      </div>
			                      <div class="messageContainer"></div>
							  </div>
						  </div>
					</div>
                    <div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                       <div class="form-group row">
							<label for="example-text-input" class="col-sm-5 col-form-label"> Document Name</label>
							  <div class="col-sm-7">
								 <input class="form-control form-control1" type="text" value="" name="doc_name[]"  id="doc_name"  placeholder="">
							  </div>
						  </div>
						</div>
				   </div>
				    <div class="row center">
				       <div class="form-group row spacer1">
							<label for="example-search-input" class="col-sm-5 col-form-label">Upload Document</label>
							<div class="col-sm-7">
								<div>
									<div class="file-upload">
										<p class="file-name"></p>
									    <label for="doc_url" class="btn">Choose File</label>
									   	<input type="file" id="doc_url" name="doc_url[]">
									</div>
								</div>
								<div class="messageContainer"></div>
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
									<select  id="filer_project_ids" name="filter_project_ids[]" multiple>
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
				    <div class="row center">
				       <div class="form-group row spacer1">
							  <label for="example-search-input" class="col-sm-5 col-form-label">Flat No. &#38; Buyer Name</label>
								<div class="col-sm-7">
									<div>
									  <select id="flat_buyer_ids" name="flat_buyer_ids[]" multiple></select>
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
			$("#flat_buyer_ids").multiselect('loadOptions',data);
			  $("#flat_buyer_ids").multiselect('reload');
			  ajaxindicatorstop();
		});
	}
}

$('#flat_buyer_ids').multiselect({

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
  
  $('#addocument').bootstrapValidator({
		container: function($field, validator) {
			return $field.parent().next('.messageContainer');
	   	},
	    feedbackIcons: {
	        validating: 'glyphicon glyphicon-refresh'
	    },
	    excluded: ':disabled',
	    fields: {
	    	doctype: {
	            validators: {
	                notEmpty: {
	                    message: 'select Document is required.'
	                }
	            }
	        },
	        'filter_project_ids[]': {
	        	validators: {
	            	notEmpty: {
	                    message: 'Select at least one project'
	                }
	            }
	        },
	        
	        'filter_building_ids[]': {
	        	validators: {
	            	notEmpty: {
	                    message: 'Select at least one building from dropdown'
	                }
	            }
	        },
	        'flat_buyer_ids[]': {
	        	validators: {
	            	notEmpty: {
	                    message: 'Select at least one falt & buyer from dropwown'
	                }
	            }
	        }
	    }
	    
	}).on('success.form.bv', function(event,data) {
		// Prevent form submission
		event.preventDefault();
		uploadDocument();
	}).on('error.form.bv',function(event,data){
	});
  
	function uploadDocument() {
		ajaxindicatorstart("Loading...");
		var options = {
		 		target : '#response', 
		 		beforeSubmit : showAddRequest,
		 		success :  showAddResponse,
		 		url : '${baseUrl}/webapi/builder/save/newdoc',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#addocument').ajaxSubmit(options);
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
			 ajaxindicatorstop();
	  	} else {
	  		$("#response").removeClass('alert-danger');
	        $("#response").addClass('alert-success');
	        $("#response").html(resp.message);
	        $("#response").show();
	        alert(resp.message);
	      //  window.location.href = "${baseUrl}/builder/leads/leadlist.jsp";
	        ajaxindicatorstop();
	  	}
	}
	
// 	$("#filer_project_ids").change(function(){
// 		var htmlconfig = "";
// 		ajaxindicatorstart("Loading...");
// 		$.get("${baseUrl}/webapi/builder/building/data",{project_ids:$(this).val()},function(data){
// 			  $(data).each(function(index){
// 				  htmlconfig=htmlconfig+'<option value="'+data[index].id+'">'+data[index].name+'</option>';
// 			  });
// 			  $("#filer_building_ids").multiselect({
// 				    columns: 1,
// 				    placeholder: 'Select Building',
// 				    search: true,
// 				    selectAll: true,
// 				});
// 			  $("#filer_building_ids").html(htmlconfig);
// 			  $("#filer_building_ids").multiselect('reload');
// 			  ajaxindicatorstop();
// 		});
// 	});
	
// 	$("#filer_building_ids").change(function(){
// 		var htmlconfig = "";
// 		ajaxindicatorstart("Loading...");
// 		$.get("${baseUrl}/webapi/builder/flatbuyer/data",{building_ids:$(this).val()},function(data){
// 			  $(data).each(function(index){
// 				  htmlconfig=htmlconfig+'<option value="'+data[index].id+'">'+data[index].flatNumber+' & '+data[index].name+'</option>';
// 			  });
// 			  $("#flat_buyer_ids").multiselect({
// 				    columns: 1,
// 				    placeholder: 'Select Building',
// 				    search: true,
// 				    selectAll: true,
// 				});
// 			  $("#flat_buyer_ids").html(htmlconfig);
// 			  $("#flat_buyer_ids").multiselect('reload');
// 			  ajaxindicatorstop();
// 		});
//	});
</script>