<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%
List<CampaignListNew> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int builder_id = 0;
int access_id = 0;
int projectId = 0;
int emp_id=0;
List<City> city_list = null;
BuilderProject builderProject = null;
String projectName ="";
String cityName = "";
String localityName ="";
List<ProjectData> builderProjects = null;
int cityId = 0;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		builder_id = builder.getBuilder().getId();
		emp_id = builder.getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
		city_list = new CityNamesImp().getCityNames();
					
				}
			
}
SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
Date date = new Date();
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
    <link href="../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/newcampaign.css">
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--     <script src="../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script> -->
   
     <script>
	  $( function() {
	    $( "#datepicker" ).datepicker();
	    } );
	  $( function() {
		    $( "#datepicker1" ).datepicker();
		 } );
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
         <%@include file="../partial/header.jsp"%>
        </div>
        <div id="sidebar1"> 
         <%@include file="../partial/sidebar.jsp"%>
        </div>
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid addlead">
               <!-- /.row -->
               <div class="row"></div>
	            <h1>New Campaign</h1>
               <!-- row -->
               <div class="white-box">
               <div class="bg11">
                   <form class="addlead1">
                    <div class="row">
                     <div class="col-md-6 col-sm-12 col-xs-12">
                         <div class="form-group row">
							<label for="example-text-input" class="col-sm-5 col-form-label">Project  Name</label>
							  <div class="col-sm-7">
								  <select class="selectpicker selectpicker1">
			                          <option>Select Project</option>
			                          <option>Project No-1</option>
			                          <option>Project No-2</option>
			                          <option>Project No-3</option>
			                          <option>Project No-4</option>
			                        </select>
							  </div>
						  </div>
						  <div class="form-group row">
							 <label for="example-search-input" class="col-sm-5 col-form-label">City</label>
								<div class="col-sm-7">
								   <input class="form-control  form-control1" type="text" value="" id="" placeholder="Pune">
								 </div>
						    </div>
                            <div class="form-group row">
					           <label for="example-tel-input" class="col-sm-5 col-form-label">Campaign Title</label>
						         <div class="col-sm-7">
						         	<input class="form-control  form-control1" type="text" value="" id="" placeholder="New project/referral">
							     </div>
						    </div>
						    <div class="form-group row">
					           <label for="example-tel-input" class="col-sm-5 col-form-label">T&#38;C*</label>
						         <div class="col-sm-7">
						         <textarea></textarea>
							     </div>
						    </div>
						    <div class="form-group row">
					           <label for="example-tel-input" class="col-sm-5 col-form-label">Start Date</label>
						         <div class="col-sm-7">
									<input type="text" id="datepicker">
 								</div>
						    </div>
				       </div>
                       <div class="col-md-6 col-sm-12 col-xs-12">
                          <div class="form-group row">
							<label for="example-text-input" class="col-sm-5 col-form-label"> Locality</label>
							  <div class="col-sm-7">
								 <input class="form-control form-control1" type="text" value="" id=""  placeholder="Kothrud">
							  </div>
						  </div>
						  <div class="form-group row">
							 <label for="example-search-input" class="col-sm-5 col-form-label">Campaign Type</label>
								<div class="col-sm-7">
								    <textarea placeholder="Get Maruti Suzuki free on your next booking!"></textarea>
								 </div>
						    </div>
							<div class="form-group row">
							   <label for="example-search-input  form-control1" class="col-sm-5 col-form-label">Offer</label>
								 <div class="col-sm-7">
								   <input class="form-control  form-control1" type="text" value="" id="" placeholder="">
								  </div>
							 </div>
						   <div class="form-group row">
							   <label for="example-text-input" class="col-sm-5 col-form-label"> Upload Image</label>
							  <div class="col-sm-7">
								 <div class="file-upload">
								   <p class="file-name"> text.png </p>
								    <label for="upload-1" class="btn">Choose File</label>
								   <input type="file" id="upload-1">
								</div>
							  </div>
						    </div>
						   <div class="form-group row">
							 <label for="example-text-input" class="col-sm-5 col-form-label"> End Date</label>
							  <div class="col-sm-7">
								 <input type="text" id="datepicker1">
							  </div>
						  </div>
						 </div>
						</div>
						<div class="row">
						   <div class="center">
					  	     <a href="#demo" class="btn11 apadding" data-toggle="collapse"> Preview </a>
					  	     <button type="button" class="btn11">Recipients +</button>
					  	  </div>
						</div>
						<!-- collapse starts-->
					    <div id="demo" class="collapse preview">
					      <div class="image">
		                       <img src="../plugins/images/Untitled-1.png" alt="Project image">
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-6 col-sm-9 col-xs-9 left">
					                       <h3>Rohan Lehare</h3>
					                        <br>
						                    <div class="bottom">
						                      <h4><span>T&amp;C</span></h4>
						                      <h6>Duration</h6>
						                      <h4>22 July 2017 to till date</h4>
						                    </div>
				                        </div>
				                        <h3 class="center-tag">
				                           Get MARUTI SUZUKI FREE <br>
				                           <span>on your next booking</span>
										</h3>
				                        <div class="col-md-6 col-sm-3 col-xs-3 right">
					                       <div class="right">
					                            <button type="button" class="close" data-dismiss="modal">
		                                           <img src="../images/error.png" alt="close" class="close-img">
		                                         </button>
					                        </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
					    </div>
					    <!-- collapse ends-->
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
    <script>
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
  
  </script>
</html>
