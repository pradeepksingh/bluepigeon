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
    <link rel="stylesheet" type="text/css" href="../css/addcampaign.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/jquery.form.js"></script>
  	<script src="../js/bootstrapValidator.min.js"></script>
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
//     document.getElementById("uploadBtn").change = function () {
//         document.getElementById("uploadFile").value = this.value;
//     };

    </script>
     
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <form id="addcampaign" name="addcampaign" class="form-horizontal" action="" method="post" enctype="multipart/form-data" >
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
           <div class="container-fluid">
               <!-- /.row -->
	            <div class="row bspace bspace1">
		           <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10">Campaign</button>
		           <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10">New Campaign +</button>
		         </div>
               <!-- row -->
                  <div class="white-box">
                     <div class="bg11 bg12">
                     	
                        <div class="row ">
					 	   <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
						 	   <label> Project Name<span class="text-danger">*</span></label> <input type="text" id="project_name" name="prjecct_name" placeholder="Enter Project Name"/><br>
						 	    <div class="messageContainer"></div>
						 	   <label>City<span class="text-danger">*</span></label> <input type="text" id="city" name="city' placeholder="Enter City Name"/><br>
						 	    <div class="messageContainer"></div>
						 	   <label> Campaign Title<span class="text-danger">*</span></label>  <input type="text" id="title" name="title" placeholder="New project/ referral"/><br>
						 	    <div class="messageContainer"></div>
						 	   <label>Content<span class="text-danger">*</span></label> <input type="text" id="content" name="content" placeholder="Enter content"/><br>
						 	    <div class="messageContainer"></div>
					 	    </div>
					 	    <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
						 	    <label> Locality<span class="text-danger">*</span></label> <input type="text" id="locality" name="locality" placeholder="Pimple Saudagar"/><br>
						 	     <div class="messageContainer"></div>
						 	    <label>Campaign Type<span class="text-danger">*</span></label> <textarea  id="campaign_type" name="campaign_type" placeholder="Get Maruti suzuki free on your next booking"/></textarea><br>
						 	     <div class="messageContainer"></div>
						 	    <label> Offer<span class="text-danger">*</span></label>  <input type="text" id="offer" name="offer" placeholder="Enter offer details"/><br>
						 	     <div class="messageContainer"></div>
						 	    <label>Upload Image<span class="text-danger">*</span></label><input id="uploadFile" placeholder="Choose File" />
							    <div class="fileUpload btn newbutton">
								  <span>Choose file</span>
								  <input id="uploadBtn" type="file" class="upload" />
								</div><br>
								 <div class="messageContainer"></div>
					 	     </div>
					 	     <div class="inline1">
					 	         <button type="button" href="#demo" data-toggle="collapse"> 
 								    Preview
 								 </button>
					 	        <button type="button" data-toggle="modal" data-target="#myModal">Recipients +</button>
					 	        <div class="smallsection">
					 	           <div id="demo" class="collapse">
					 	             <div class="projectsection">
	                                    <div class="image">
		                                   <img src="../plugins/images/Untitled-1.png" alt="Project image">
		                                   <div class="overlay">
					                          <div class="row">
						                          <div class="col-md-10 col-sm-10 col-xs-10">
						                              <h3>Park Royale, Pimple Saudagar, Pune</h3>
							                       </div>
							                        <div class="col-md-2 col-sm-2 col-xs-2">
							                          <img src="../images/error.png" alt="cancle" class="icon1 close1">
							                        </div>
						                        </div>
						                        <h3 class="center-tag"><br>
						                           Get MARUTI SUZUKI FREE <br>
						                           <span>on your next booking</span>
												</h3>
					                        </div>
	                           			 </div>
				                       </div>
			                       </div>
 							    </div>
 							  </div>
					      </div>
					      
					   </div>
				  </div>
              </div>
           </div>
        </div>
  <!-- Modal of Recipients +-->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
           <div class="row">
			  <div class="col-md-10 col-sm-10 col-xs-10">
				<h3>Add Recipients</h3>
			  </div>
			  <div class="col-md-2 col-sm-2 col-xs-2">
				<img src="images/error.png" alt="cancle" data-dismiss="modal">
			  </div>
			</div>
	  		<div class="row bg12">
	  		   <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
	  		     <label> User Type</label>
	  		       <select id="multiple-checkboxes" name="user_type[]" multiple="multiple">
	  		          <option  class="mycheckbox" value="0">Select All</option>
			          <option  class="mycheckbox" value="1">admin</option>
			          <option  class="mycheckbox" value="2">Builder</option>
	    		   </select><br>
			      <label>Project</label>
			       <select id="multiple-checkboxes-2" name="project[]" multiple="multiple">
				        <option value="php">Select All</option>
				        <option value="javascript">JavaScript</option>
				        <option value="java">Java</option>
				        <option value="sql">SQL</option>
				        <option value="jquery">Jquery</option>
				        <option value=".net">.Net</option>
				    </select>
					<br>
			      <label> Name</label> 
			       <select id="multiple-checkboxes-3"  name="name[]" multiple="multiple">
			            <option value="php">Select All</option>
				        <option value="php">PHP</option>
				        <option value="javascript">JavaScript</option>
				        <option value="java">Java</option>
				        <option value="sql">SQL</option>
				        <option value="jquery">Jquery</option>
				        <option value=".net">.Net</option>
				    </select>
				    <br>
			   </div>
	  		   <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
	  		      <label>City</label> 
	  		       <select id="multiple-checkboxes-4" name="city_id[]" multiple="multiple">
	  		            <option value="php">Select All</option>
				        <option value="php">PHP</option>
				        <option value="javascript">JavaScript</option>
				        <option value="java">Java</option>
				        <option value="sql">SQL</option>
				        <option value="jquery">Jquery</option>
				        <option value=".net">.Net</option>
				    </select>
	  		      <br>
			      <label>Building</label> 
			       <select id="multiple-checkboxes-5" name="building_id[]" multiple="multiple">
			            <option value="php">Select All</option>
				        <option value="php">PHP</option>
				        <option value="javascript">JavaScript</option>
				        <option value="java">Java</option>
				        <option value="sql">SQL</option>
				        <option value="jquery">Jquery</option>
				        <option value=".net">.Net</option>
				    </select>
			      <br>
	  		   </div>
	  		</div>
	  		<div class="center">
	  		   <button type="submit" id="publish" class="button1">Publish</button>
	  		</div>
         </div>
 	  </div>
   </div>
  </div>
 </form>
    <!-- /.container-fluid -->
    <footer id="footer"> </footer>
  </body>
</html>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script>
$("#publish").click(function(){
	alert("Hello from Publish Button");
});
    $(document).ready(function(){
    
    $(".close1").click(function(){
        $(".collapse").collapse('hide');
    });
    });
    
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

$("#select").click(function(){
    $("li").addClass("active");
});


    $('#multiple-checkboxes').change(function(){
//         if(this.checked){
        	alert("hello");
        	if($(this).val() == 0){
           		 $('.mycheckbox').each(function(){
            		alert("Hello Again if all selected");
//                		this.checked = true;
               		$(".mycheckbox").prop('checked', $(this).prop("checked"));
            	});
//         	}
        }else{
        	alert("Hello Again from else")
             $('.mycheckbox').each(function(){
                this.checked = false;
            });
        }
    });
    
    $('.mycheckbox').on('click',function(){
        if($('.mycheckbox:checked').length == $('.mycheckbox').length){
        	alert("Hello again from if part");
            $('#multiple-checkboxes').prop('checked',true);
        }else{
        	alert("Hello again from else part");
            $('#multiple-checkboxes').prop('checked',false);
        }
    });

    
    function addCampaign() {
    	alert("Hello Afer Publish");
//     	var options = {
//     	 		target : '#response', 
//     	 		beforeSubmit : showAddRequest,
//     	 		success :  showAddResponse,
//     	 		url : '${baseUrl}/webapi/campaign/save1',
//     	 		semantic : true,
//     	 		dataType : 'json'
//     	 	};
//        	$('#addcampaign').ajaxSubmit(options);
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
    		window.location.reload();
      	} else {
      		$("#response").removeClass('alert-danger');
            $("#response").addClass('alert-success');
            $("#response").html(resp.message);
            $("#response").show();
            alert(resp.message);
            window.location.href = "${baseUrl}/builder/campaign/list.jsp";
      	}
    }
    
    $('#addcampaign').bootstrapValidator({
    	container: function($field, validator) {
    		return $field.parent().next('.messageContainer');
       	},
        feedbackIcons: {
            validating: 'glyphicon glyphicon-refresh'
        },
        excluded: ':disabled',
        fields: {
        	
        	project_name:{
        		validators:{
        			notEmpty:{
        				message: 'Project Name  is required and cannot be empty'
        			}
        		}
        	},	
        
        	title: {
                validators: {
                    notEmpty: {
                        message: 'Campaign name is required and cannot be empty'
                    }
                }
            },
            campaign_type:{
            	validators:{
            		notEmpty: {
            			message:'campaign type is required and cannot be empty'
            		}
            	}
            },
            set_date: {
                validators: {
                    callback: {
                        message: 'Wrong Campaign Date',
                        callback: function (value, validator) {
                            var m = new moment(value, 'DD MMM YYYY', true);
                            if (!m.isValid()) {
                                return false;
                            } else {
                            	return true;
                            	var options = {
//                             	 		target : '#response', 
//                             	 		beforeSubmit : showAddRequest,
//                             	 		success :  showAddResponse,
//                             	 		url : '${baseUrl}/webapi/campaign/save1',
//                             	 		semantic : true,
//                             	 		dataType : 'json'
//                             	 	};
//                                	$('#a          }
                        }
                    }
                }
            }
        }
    },
            content:{
            	validators:{
            		notEmpty:{
            			message: 'content is required and cannot be empty'
            		}
            	}
            },
            terms:{
            	validators:{
            		notEmpty:{
            			message: 'term is required and cannot be empty'
            		}
            	}
            },
            recipient_type_id:{
            	validators:{
            		notEmpty:{
            			message: 'recipient type is required and cannot be empty'
            		}
            	}
            },
            'project[]': {
                validators: {
                    notEmpty: {
                        message: 'Project is required and cannot be empty'
                    }
                }
            },
            city:{
            	validators:{
            		notEmpty:{
            			message : 'city Name is required and cannot be empty'
            		}
            	}
            },
            'city_id[]': {
                validators: {
                    notEmpty: {
                        message: 'City Name is required and cannot be empty'
                    }
                }
            }
        }
    }).on('success.form.bv', function(event,data) {
    	// Prevent form submission
    	event.preventDefault();
    	alert("Hello");
    	addCampaign();
    }).on('error.form.bv', function(event,data) {
    	// Prevent form submission
    	event.preventDefault();
    	alert("Hello");
    	//addCampaign();
    });
</Script>

