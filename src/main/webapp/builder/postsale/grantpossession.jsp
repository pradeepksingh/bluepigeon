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
	int empId = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			empId = builder.getId();
			if(builder_id > 0){
				project_list = new ProjectDAO().getAssigProjects(empId);
			}
		}
		
   }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>Postsale GRANT POSSESSION</title>

    <!-- Favicon-->
    <link rel="icon" href="../favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

    <!-- Bootstrap Core Css -->
    <link href="../css/postsaleDocbootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
      <link href="../css/jquery.multiselect.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/postsaleagreement.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-datetimepicker.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../js/selectize.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
      <script src="../js/Moment.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <!-- Custom Css -->
    <link href="../css/PostalSale_Aggrement.css" rel="stylesheet">

    <!-- Custom Css -->
<!--     <link href="../../css/Postsale_Passession.css" rel="stylesheet"> -->

    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
<!--     <link href="../../css/themes/all-themes.css" rel="stylesheet" /> -->
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
    		<section class="content" style="margin-top:60px;">
        <div class="container-fluid">
           
              <h3 style="font-weight:lighter"> GRANT POSSESSION</h3> 
            <!-- Color Pickers -->
              
            <!-- #END# Color Pickers -->
            <!-- File Upload | Drag & Drop OR With Click & Choose -->
            <div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<form class="addlead1" name="addpossession" id="addpossession" action="" method="post" enctype="multipart/form-data">
	                    <div class="card">
	                        <div class="header">
	                            <h2 style="color: #24bcd3;margin-left: 8px;">
	                                POSSESSION
	                            </h2>
								<div class="row clearfix" style="margin-top:20px; border-bottom:2px solid #f1f1f1">
									<div class="col-md-6">
	                                    <div class="input-group input-group-lg">
	                                        <span class="input-group-addon"style="width: 0%;">
	                                            <label for="ig_checkbox">DATE</label>
	                                        </span>
	                                        <div class="form-line">
	                                        	<div>
	                                            	<input type="text" id="pdate" name="pdate" class="datepicker form-control form-control1" placeholder="">
	                                            </div>
	                                            <div class="messageContainer"></div> 
	                                        </div>
	                                    </div>
	                                </div>
					      			<div class="col-md-6">
	                                    <div class="input-group input-group-lg">
	                                        <span class="input-group-addon" style="width: 0%;">
	                                            <label for="ig_checkbox">TIME</label>
	                                        </span>
	                                        <div class="form-line">
	                                        	<div>
	                                            	<input type="text" id="ptime" name="ptime" class="timepicker form-control form-control1"  placeholder="">
	                                            </div>
	                                            <div class="messageContainer"></div> 
	                                        </div>
	                                    </div>
	                                </div>
									<div class="col-md-4"></div>
									<div class="col-md-4">
										<div class="input-group input-group-lg">
	                                        <span class="input-group-addon" style="width: 27%;">
	                                            <label for="ig_checkbox">Upload Document</label>
	                                        </span>
	                                        <div class="form-line">
	                                             <div class="file-upload">
											  		<div class="file-select">
														<div class="file-select-button" id="fileName">Choose File</div>
														<p class="file-select-name" id="filepossession">No file chosen...</p>
														<input type="file" name="doc_url[]" onchange="getPossessionFileData(this);" id="doc_url">
													</div>
												</div>
	                                        </div>
	                                    </div>
									 </div>
									 <div class="col-md-12"></div>
								</div>
								<div class="row clearfix" style="margin-top:20px">
									<div>
								  		<h2 style="color: #24bcd3;margin-left: 8px;">
	                                		ADD RECIPITENT
	                            		</h2>
									</div>
					               	<ul class="col-md-6" style="margin-top:15px">
	                                    <li class="input-group " id="selectproject">
	                                        <span class="input-group-addon">
	                                            <label for="ig_checkbox">Project Name:</label>
	                                        </span>
	                                        <select id="filer_project_ids" name="filer_project_ids[]" class="form-control show-tick form-control1" multiple >
											<%if(project_list != null){
						                    	for(ProjectData projectData : project_list){
						                    %>
						                    	<option value="<%out.print(projectData.getId()); %>"><%out.print(projectData.getName()); %></option>
						                    <%} }%>
											</select>
	                                    </li>
	                                    <div class="messageContainer"></div> 
	                                </ul>
					     			<ul class="col-md-6" style="margin-top:15px">
	                                    <li class="input-group " id="selectbuilding">
	                                        <span class="input-group-addon">
	                                            <label for="ig_checkbox">Building Name:</label>
	                                        </span>
	                                        <select id="filer_building_ids" name="filer_building_ids[]" class="form-control show-tick form-control1" multiple></select>
	                                    </li>
	                                    <div class="messageContainer"></div> 
	                                </ul>
									<div class="row clearfix">
										<div class="col-md-3"></div>
									 	<div class="col-md-6">
	                                    	<div class="input-group input-group-lg" id="selectbuyer">
	                                        	<span class="input-group-addon">
	                                           		<label for="ig_checkbox">Flat No. & Buyer Name</label>
	                                        	</span>
	                                        	<div class="">
	                                           		<select id="flat_buyer_ids" name="flat_buyer_ids[]" class="form-control show-tick form-control1" multiple></select>
	                                        	</div>
	                                    	</div>
											<br/>
											<div class="button-demo">
	                                			<button type="submit" class="btn btn-success  waves-effect" style="font-size: 22px;margin-left: 100px;">submit</button>
	                            			</div>
	                                	</div>
									 	<div class="col-md-3"></div>
									</div>
								 </div>
	                      	</div>
	                	</div>
	                </form>
				</div>
         	</div>
        </div>
    </section>
</div>
</div>
<div id="sidebar1"> 
	<%@include file="../partial/footer.jsp"%>
</div> 
</body>
</html>
<script>
$('#pdate').datepicker({
	autoclose:true,
	format: "dd MM yyyy"
});

$('#ptime').datetimepicker({
    format: 'LT',
    stepping: 1
});
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
$('#flat_buyer_ids').multiselect({
    columns: 1,
    placeholder: 'Flat No. & Buyer Name',
    search: true,
    selectAll: true
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
	var buyerhtml="<option value=''>Enter Flat No and buyer Name</option>";
	 $("#selectbuilding .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	 });
	// alert(ids);
	if(ids !=""){
	 ajaxindicatorstart("Loading...");
		$.get("${baseUrl}/webapi/builder/flatbuyer/data/"+ids,{},function(data){
			$("#flat_buyer_ids").multiselect('loadOptions',data);
			  $("#flat_buyer_ids").multiselect('reload');
			  ajaxindicatorstop();
		});
	}
}

$('#addpossession').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	atime: {
            validators: {
                notEmpty: {
                    message: 'Please select time and is required.'
                }
            }
        },
        adate: {
            validators: {
                notEmpty: {
                    message: 'Please select date and is required.'
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
	 		url : '${baseUrl}/webapi/buyer/newpossession/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addpossession').ajaxSubmit(options);
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
        location.reload();
      //  window.location.href = "${baseUrl}/builder/leads/leadlist.jsp";
        ajaxindicatorstop();
  	}
}

function getPossessionFileData(myFile){
	  var file = myFile.files[0];  
	   var filename = file.name;
	   $("#filepossession").empty();
	   $("#filepossession").html(filename);
}
</script>