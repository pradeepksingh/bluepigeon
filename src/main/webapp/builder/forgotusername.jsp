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
<!-- color CSS -->
 <script src="plugins/bower_components/jquery/dist/jquery.min.js"></script>
</head>
<body>
<!-- Preloader -->
<div class="preloader">
  <div class="cssload-speeding-wheel"></div>
</div>
<section id="wrapper" class="login-register">
<!-- Top Navigation -->
         <div id="header">
	       <%@include file="partial/loginheader.jsp"%>
      </div>
       
        <!-- Page Content -->
<div class="col-md-12">	
	<div class="col-md-8 loginbgimg">	
	
    </div>
 <div class="col-md-4">	
  <div class="login-box">
  <center>
    <div class="white-box padtop1" id="forgotusername">
      <form class="form-horizontal form-material" id="loginform" action="" method="post">
        <h2 class="box-title m-b-20">Forgot Username</h2>
        <br>
        <div class="form-group">
          <div class="col-xs-12">
            <input class="form-control"  id="contactno" type="text" required="" maxlength="10" placeholder="Enter your registered mobile number">
             <p id="error" class="nopadding" ></p>
          </div>
        </div>
        <div class="form-group text-center m-t-20">
          <div class="col-xs-12">
            <button class="btn btn-submit btn-lg btn-block text-uppercase waves-effect waves-light" id="forgotuserbtn" type="button">Submit</button>
          </div>
        </div>
      </form>
    </div>
   </center>
  </div>
 </div>
</div>
<div id="footer"> 
	   <%@include file="partial/footer.jsp"%>
</div> 
</section>

</body>
</html>
<script type="text/javascript">
function forgotUsername(){
	var html = "";
		$.post('${baseUrl}/webapi/validatebuilder/builder/contact/',{contactno: $("#contactno").val()}, function(data){
			var success = data.status;
			var status =parseInt(success);
			if(status==1){
				$('#error').empty();
				$("#forgotusername").empty();
				html='<div class="form-group">'
			         +' <div class="col-xs-12">'
			         +'<p>'+data.message+'</p>'
			         +'<p>Please click here  for <a href="${baseUrl}/builder/index.jsp" class="btn btn-submit">login</a></p>'
			         +'</div>'
			         +'</div>';
				$("#forgotusername").html(html);
			}else{
				$('#error').empty();
				$('#error').append(data.message);
			}
		},'json');
}
	$('#forgotuserbtn').click(function(){
		forgotUsername();
	});
	
	$("#contactno").keydown(function (e) {
		if (e.keyCode == 13) {
			forgotUsername();
			return false;
		}
	});
</script>
 