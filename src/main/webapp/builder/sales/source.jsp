<%@page import="org.bluepigeon.admin.model.Source"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="java.util.List"%>
<%
int p_user_id = 0;
List<Source> sourceList = null;
List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		p_user_id = builder.getBuilder().getId();
	    sourceList = new ProjectDAO().getSourceListByBuilderId(p_user_id);
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
    <link rel="stylesheet" type="text/css" href="../css/saleshead.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-multiselect.css">
     <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
  	<script src="../js/jquery.form.js"></script>
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
           <div class="container-fluid cancellation-lead">
               <!-- row -->
                  <h1>Add Source</h1>
              <div class="white-box">
                   <div class="sales-lead-bg">
                   <!-- buyer information end -->
                   <form id="addsource" name="addsource" method="post"  action="" enctype="multipart/form-data">
	                 <div class="row style1">
	                 	
	                 		<input type="hidden" value="<%out.print(p_user_id); %>" name="builder_id" id="builder_id" />
		                   	<div class="col-md-10 col-sm-9 col-xs-12 row">
		                      <div class="col-md-3 col-sm-3 col-xs-4">
		                        <h4>Source Name</h4>
		                      </div>
		                      <div class="col-md-9 col-sm-9 col-xs-8">
		                        <input type="text" class="input1" id="name" name="name"/>
		                      </div>
		                   </div>
		                   <div class="col-md-2 col-sm-3 col-xs-12">
		                     <button type="button" name="addsource" onclick="addSource();" class="button12">Add</button>
		                   </div>
	                 </div>
	                  </form>
	                 <div id="response"></div>
	                 <div class="border-lead1">
	                    <h4 class="font1">Source List</h4>
	                    <%
	                    if(sourceList != null){
	                    for(Source source : sourceList){ %>
		                    <div class="row">
			                    <div class="col-md-10 col-sm-10 col-xs-8">
			                       <h4><%out.print(source.getName()); %></h4>
			                    </div>
			                     <div class="col-md-1 col-sm-1 col-xs-2">
			                       <img src="../images/glyphicons-31-pencil.png" class="imgsmall"/>
			                    </div>
			                     <div class="col-md-1 col-sm-1 col-xs-2">
			                       <img src="../images/glyphicons-17-bin.png" class="imgsmall"/>
			                    </div>
			                </div>
		                  <hr>
		                  <%}} %>
	                </div>
	               <!-- buyer information end -->
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
function addSource() {
	
	if($("#name").val() != ""){
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/source/add',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addsource').ajaxSubmit(options);
	}else{
		alert("Please Enter Source Name")
	}
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
		//$("#response").html(resp.message);
		$("#response").show();
		alert(resp.message);
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        //$("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/builder/sales/source.jsp";
  	}
}
</script>
