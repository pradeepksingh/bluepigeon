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
<!-- color CSS -->
<link href="css/colors/default.css" id="theme"  rel="stylesheet">

 <script src="plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script>
    $(function() {
     
        $("#header").load("partial/recoverheader.jsp");

        $("#footer").load("partial/footer.html");
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
       
        <!-- Page Content -->
  <div class="login-box">
    <div class="white-box">
      <form class="form-horizontal form-material" id="loginform" action="">
        <h3 class="box-title m-b-20">Change Password</h3>
        
        <div class="form-group">
          <div class="col-xs-12">
            <input class="form-control" id="opassword" type="password" required="" placeholder="Old Password">
          </div>
        </div>
         <div class="form-group">
          <div class="col-xs-12">
            <input class="form-control" id="npassword" type="password" required="" placeholder="New Password">
          </div>
        </div>
         <div class="form-group">
          <div class="col-xs-12">
            <input class="form-control" id="cpassword" type="password" required="" placeholder="Confirm Password">
          </div>
        </div>
        <div class="form-group text-center m-t-20">
          <div class="col-xs-12">
            <button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" id="updatepassword" type="button">Reset Password</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</section>
</body>
</html>
<script type="text/javascript">
function changePassword(){
	if($("#npassword").val() == $("#cpassword").val()){
		$.post('webapi/validate/builder/password/',{oldpassword: $("#opassword").val(), password: $("#npassword").val()}, function(data){
			var success = data.status;
			var status =parseInt(success);
			if(status==1)
				{
				$('#error').empty();
					window.location.href="../builder/project/list.jsp";	
				}
			
			else if(status == 0)
				{
					$('#error').empty();
					window.location.href="changepassword.jsp";
				}
			else
				{
			$('#error').empty();
		
			$('#error').append(data.message);
				}
			
		},'json');
	}
	else{
		alert("Password does not match the confirm password");
	}
}
	$('#updatepassword').click(function(){
		changePassword();
	});
</script>
<!--    <form class="form-horizontal" id="recoverform" action=""> -->
<!--         <div class="form-group "> -->
<!--           <div class="col-xs-12"> -->
<!--             <h3>Recover Password</h3> -->
<!--             <p class="text-muted">Enter your Email and instructions will be sent to you! </p> -->
<!--           </div> -->
<!--         </div> -->
<!--         <div class="form-group "> -->
<!--           <div class="col-xs-12"> -->
<!--             <input class="form-control" type="text" required="" placeholder="Email"> -->
<!--           </div> -->
<!--         </div> -->
<!--         <div class="form-group text-center m-t-20"> -->
<!--           <div class="col-xs-12"> -->
<!--             <button class="btn btn-primary btn-lg btn-block text-uppercase waves-effect waves-light" type="submit">Reset</button> -->
<!--           </div> -->
<!--         </div> -->
<!--       </form> -->