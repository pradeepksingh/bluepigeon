<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<!DOCTYPE html>  
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" type="image/png" sizes="16x16" href="plugins/images/favicon.png">
<title>Blue Pigeon</title>
<!-- Bootstrap Core CSS -->
<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- animation CSS -->
<link href="css/animate.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="css/style.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
<link href="css/custom1.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<!-- color CSS -->
<link href="css/colors/default.css" id="theme"  rel="stylesheet">

 <script src="plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script>
    $(function() {
     
        $("#header").load("partial/loginheader.jsp");

        $("#footer").load("partial/footer.jsp");
    });
    </script>
 
</head>
<body>
<!-- Preloader -->
<div class="preloader">
  <div class="cssload-speeding-wheel"></div>
</div>
<section id="wrapper" class="login-register">
<!-- Top Navigation -->
        <div id="header"></div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
      
        <!-- Left navbar-header end -->
        <!-- Page Content -->
<div class="col-md-12">	
	<div class="col-md-8 loginbgimg">	
	
    </div>
 <div class="col-md-4">	
  <div class="login-box">
  <center>
    <div class="white-box padtop1">
	
	
	
      <form class="form-horizontal form-material" id="loginform" action="">
        <h2 class="box-title m-b-20">Blue Pigeon</h2>
        <br>
        <div class="form-group ">
          <div class="col-xs-12">
            <input class="form-control" name="bname" id="bname" type="text" required="" placeholder="Username">
            <p id="error" class="nopadding" ></p>
          </div>
        </div>
        <div class="form-group">
          <div class="col-xs-12">
            <input class="form-control" name="bpassword" id="bpassword" type="password" required="" placeholder="Password">
              <p id="perror" class="nopadding" ></p>
          </div>
        </div>
        <!-- <div class="form-group">
          <div class="col-md-12">
            <div class="checkbox checkbox-primary pull-left p-t-0">
              <input id="checkbox-signup" type="checkbox">
              <label for="checkbox-signup"> Remember me </label>
            </div>
           </div>
        </div> -->
        <div class="form-group text-center m-t-20">
          <div class="col-xs-12">
            <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light"id="blogin" type="button">Log In</button>
          </div>
        </div>
      </form>
    </div>
  </center> 
 </div>
  </div>
 </div>
</section>
</body>

</html>

<script type="text/javascript">
function login(){
	$.post('${baseUrl}/webapi/validate/builder',{email: $("#bname").val(), password: $("#bpassword").val()}, function(data){
		var success = data.status;
		var status =parseInt(success);
		if(status==1) {
			$("#perror").empty();
			$('#error').empty();
			window.location.href="../builder/project/list.jsp";	
		} else if(status == 0) {
			$("#perror").empty();
			$('#error').empty();
			window.location.href="changepassword.jsp";
		} else {
			$('#error').empty();
			$('#perror').empty();
			var str = data.message;
			var e =  str.includes("email");
			if(e){
				$('#error').empty();
				$('#error').append(data.message);
			}else{
				$('#perror').empty();
				$('#perror').append(data.message);
			}
		}
	},'json');
}
$('#blogin').click(function(){
	login();
});
	
	
$("#bpassword").keydown(function (e) {
	if (e.keyCode == 13) {
		login();
	}
});
</script>
