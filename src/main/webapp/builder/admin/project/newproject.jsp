
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
   <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/custom10.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../../js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="../../css/bootstrap-multiselect.css">
    
        
		<script type="text/javascript">
		    $(document).ready(function() {
		        $('#multiple-checkboxes').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-2').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-3').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-4').multiselect();
		    });
		    $(document).ready(function() {
		        $('#multiple-checkboxes-5').multiselect();
		    });
		</script>
		<script type="text/javascript">
		$("#select").click(function(){
		    $("li").addClass("active");
		});
		</script>
</head>

    <!-- Preloader -->
    
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
         <%@include file="../../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        	<%@include file="../../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid addlead">
               <div class="white-box">
                Project Start Request Page..
               </div>
            </div>
          </div>
        </div>
    <!-- /.container-fluid -->
   <div id="sidebar1"> 
       	   		<%@include file="../../partial/footer.jsp"%>
      		</div>
</html>