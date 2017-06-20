  <%@page import="org.bluepigeon.admin.model.Source"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.model.BuilderLead"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
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
 	
	int source_id = 0;
    int builder_id = 0;
	source_id = Integer.parseInt(request.getParameter("source_id"));
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	Source source = null;
   
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
		}
		if(builder_id > 0){
			source = new ProjectDAO().getSourceById(source_id).get(0);
			
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
    <title>Blue Piegon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/custom.css" rel="stylesheet">
    <link href="../css/custom1.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
   <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
  
<script type="text/javascript">
    $('input[type=checkbox]').click(function(){
    if($(this).is(':checked')){
          var tb = $('<input type=text />');    
          $(this).after(tb)  ;
    }
    else if($(this).siblings('input[type=text]').length>0){
        $(this).siblings('input[type=text]').remove();
    }
})
</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
      <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Update Source</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                             <h4 class="page-title">Edit Source</h4>
                              <div class="tab-content"> 
                              
                             
                                <div class="col-12">
                               	<form id="updatesource" name="updatesource" class="form-horizontal" action="" method="post"  enctype="multipart/form-data">
                                <input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id); %>" />
                                 <input type="hidden" name="uid" id="uid" value="<% out.print(source_id); %>" />
                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Source Name</label>
                                    <div class="col-3">
                                       <input type="text" id="uname" name="uname" value="<%if(source.getName() != null){out.print(source.getName());} %>"placeholder="Enter source name" class="form-control" />
                                    </div>
                                   
                                </div>                                                        
                                <div class="offset-sm-5 col-sm-7">
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">Update</button>
                                 </div>
                                
                               </form>
                               </div>
                              
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
        
        <!-- /#page-wrapper -->
    
    <!-- /#wrapper -->
    </div>
</body>
</html>
   <script type="text/javascript">
				
$('#updatesource').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	name: {
            validators: {
                notEmpty: {
                    message: 'Source name is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateSource();
});

function updateSource() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/source/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatesource').ajaxSubmit(options);
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
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/builder/sales/source-list.jsp";
  	}
}
</script>