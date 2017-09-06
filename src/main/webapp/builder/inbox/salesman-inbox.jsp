

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
    <link rel="stylesheet" type="text/css" href="../css/custom10.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-multiselect.css">
    <script>
    $(function() {
        $("#sidebar1").load("../partial/sidebar.jsp");
        $("#header").load("../partial/header.jsp");
   	    $("#footer").load("../partial/footer.jsp");
    });
    </script>
    <script>
    function uploadFile(target) {
    	document.getElementById("file-name").innerHTML = target.files[0].name;
    }
    </script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid inbox">
               <!-- row -->
                <h1>Inbox</h1>
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12">
                         <form class="navbar-form lead-search" role="search">
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search" name="srch-term" id="srch-term" type="text">
						      <div class="input-group-btn">
						        <button class="btn btn-default" type="submit"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-info waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal2">Compose</button>
                      </div>
                 </div>
                 <div class="white-box">
	               <div class="bg11">
	                 <!-- inbox -->
	                  <div class="border-lead1">
		                  <div class="row">
		                    <div class="col-md-2 col-sm-2 col-xs-2 user">
		                      <img src="../images/user.png" alt="user profile"  class="img-responsive"/>
		                    </div>
		                    <div class="col-md-9 col-sm-9 col-xs-9 left1">
		                      <h3>Builder Name</h3>
		                      <div class="inline">
		                          <h6>25th July 2017</h6>
		                          <h6>11:20 pm</h6>
		                      </div>
		                      <p>Open spaces to breath Pure, Unique</p>
		                    </div>
		                    <div class="col-md-1 col-sm-1 col-xs-1 arrow">
		                       <img src="../images/status-green.png" alt="status"  class="img-responsive"/>
		                    </div>
		                  </div>
	                  </div>
	                 <!-- inbox ends -->
	                  <!-- inbox -->
	                  <div class="border-lead1">
		                  <div class="row">
		                    <div class="col-md-2 col-sm-2 col-xs-2 user">
		                      <img src="../images/user.png" alt="user profile"  class="img-responsive"/>
		                    </div>
		                    <div class="col-md-9 col-sm-9 col-xs-9 left1">
		                      <h3>Builder Name</h3>
		                      <div class="inline">
		                          <h6>25th July 2017</h6>
		                          <h6>11:20 pm</h6>
		                      </div>
		                      <p>Open spaces to breath Pure, Unique</p>
		                    </div>
		                    <div class="col-md-1 col-sm-1 col-xs-1 arrow">
		                       <img src="../images/status-green.png" alt="status"  class="img-responsive"/>
		                    </div>
		                  </div>
	                  </div>
	                 <!-- inbox ends -->
	                  <!-- inbox -->
	                  <div class="border-lead1">
		                  <div class="row">
		                    <div class="col-md-2 col-sm-2 col-xs-2 user">
		                      <img src="../images/user.png" alt="user profile"  class="img-responsive"/>
		                    </div>
		                    <div class="col-md-9 col-sm-9 col-xs-9 left1">
		                      <h3>Builder Name</h3>
		                      <div class="inline">
		                          <h6>25th July 2017</h6>
		                          <h6>11:20 pm</h6>
		                      </div>
		                      <p>Open spaces to breath Pure, Unique</p>
		                    </div>
		                    <div class="col-md-1 col-sm-1 col-xs-1 arrow">
		                       <img src="../images/status-red.png" alt="status"  class="img-responsive"/>
		                    </div>
		                  </div>
	                  </div>
	                 <!-- inbox ends -->
	              </div>
               </div>
            </div>
       </div>
       <!-- modal pop up -->
        <div class="modal fade" id="myModal2" role="dialog">
		   <div class="modal-dialog inbox">
		      <div class="modal-content">
		        <div class="modal-body">
		           <div class="row">
					  <div class="col-md-10 col-sm-10 col-xs-10">
					    <h3>Compose</h3>
				      </div>
					  <div class="col-md-2 col-sm-2 col-xs-2">
					     <img src="../images/error.png" alt="cancle" data-dismiss="modal">
					   </div>
				    </div>
				  	<div class="row">
				  	   <form class="addlead1 addlead">
		                     <div class="">
		                         <div class="form-group row">
									<label for="example-text-input" class="col-5 col-form-label"> Name</label>
									  <div class="col-7">
										 <input class="form-control" type="text" value="" id="" placeholder="">
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-5 col-form-label">Message</label>
										<div class="col-7">
										  <textarea>
										  
										  </textarea>
										 </div>
								    </div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-5 col-form-label">Attachment</label>
										  <div class="col-7">
										     <div class="inputfile-box">
											   <input type="file" id="file" class="inputfile" onchange='uploadFile(this)'>
											   <label for="file">
											     <span id="file-name" class="file-box"></span>
											     <span class="file-button">
											      <i class="fa fa-upload" aria-hidden="true"></i>
											      Select File
											     </span>
											  </label>
											</div>
										  </div>
									 </div>
		                         </div>
		                     <div class="center">
		                        <br>
							  	<button type="button" class="button1">Save</button>
							 </div>
		                </form>	
				   </div>
			  	</div>
		 	  </div>
            </div>
		  </div>
       <!--  modal pop up ends -->
    </div>
    <!-- /.container-fluid -->
    <footer id="footer"> </footer>
  </body>
</html>
