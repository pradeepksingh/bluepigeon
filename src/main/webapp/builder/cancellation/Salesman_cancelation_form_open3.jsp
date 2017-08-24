<%@page import="org.bluepigeon.admin.data.BuyerBuildingList"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
 <%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
 <%@page import="org.bluepigeon.admin.model.BuilderFloor"%> 
 <%@page import="java.util.Date"%> 
 <%@page import="java.text.SimpleDateFormat"%> 
 <%@page import="java.text.DateFormat"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderBuilding"%> 
 <%@page import="org.bluepigeon.admin.data.BuildingData"%> 
 <%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%> 
 <%@page import="java.util.ArrayList"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalInfo"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalInfoDAO"%>
 <%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationInfoDAO"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyTypeDAO"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderProjectProjectTypeDAO"%> 
 <%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityInfoDAO"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyType"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProjectProjectType"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityInfo"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%> 
 <%@page import="org.bluepigeon.admin.dao.ProjectDAO"%> 
 <%@page import="org.bluepigeon.admin.model.BuilderProject"%> 
 <%@page import="org.bluepigeon.admin.model.Builder"%>
 <%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%> 
 <%@page import="org.bluepigeon.admin.model.Locality"%>
 <%@page import="java.util.List"%> 
 <% 
 	int emp_id = 0; 
 	int access_id=0; 
 	int building_size_list =0; 
 	int floor_size_list = 0; 
 	BuilderFloor builderFloor = null; 
	int flat_id = 0;
	String floor_status_name = "";
 	List<BuilderFloor> floorList = null; 
 	List<BuilderBuilding> builderBuildingList = null;
 	BuilderProject projectList = null;
 	List<BuilderBuilding> buildingList = null;
	List<FlatListData> flatListDatas = null; 
	Buyer buyer = null;
 	int flat_size = 0;
 	int project_id = 0;
 	int building_id = 0;
 	String image  = ""; 
 	String buildingName = "";
 	String flatNo = "";
 	String projectName = "";
 	String buyerName = "";
 	String buyerMobile = "";
 	String buyerEmail="";
 	String buyerPan = "";
 	String locality = "";
 	int builder_id = 0;
 	String buyerPermanentAddress = "";
 	List<ProjectImageGallery> imageGaleries = new ArrayList<ProjectImageGallery>(); 
 	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList(); 
 	flat_id = Integer.parseInt(request.getParameter("flat_id")); 
 	buyer = new ProjectDAO().getBuyerByFlatId(flat_id);
	int isPrimary = 0;
 	session = request.getSession(false); 
	
 	BuilderEmployee builder = new BuilderEmployee(); 
 	if(session!=null) 
 	{ 
 		if(session.getAttribute("ubname") != null) 
 		{ 
 			builder  = (BuilderEmployee)session.getAttribute("ubname"); 
 			emp_id = builder.getId(); 
 			builder_id = builder.getBuilder().getId();
 			access_id = builder.getBuilderEmployeeAccessType().getId(); 
 			//buildingList =  new ProjectDAO().getBuilderActiveProjectBuildings(project_id); 
 			if(buyer != null){
 				buyerName = buyer.getName();
 				projectName = buyer.getBuilderProject().getName();
 				buildingName = buyer.getBuilderBuilding().getName();
 				flatNo = buyer.getBuilderFlat().getFlatNo();
 				locality = buyer.getBuilderProject().getLocalityName();
 				buyerPan = buyer.getPancard();
 				buyerMobile = buyer.getMobile();
 				buyerEmail = buyer.getEmail();
 				project_id = buyer.getBuilderProject().getId();
 				building_id = buyer.getBuilderFlat().getId();
 				image = buyer.getPhoto();
 				if(buyer.getIsPrimary())
 					isPrimary = 1;
 			}
 			
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
    <link rel="stylesheet" type="text/css" href="../css/custom6.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
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
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">Booking</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-submit waves-effect waves-light m-t-10">Cancellation</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads" class="btn11 btn-info waves-effect waves-light m-t-10">Leads</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">Campain</button>
		                </div>
	                </div>
               <!-- row -->
                 <div class="white-box">
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12  bg1">
                         <div class="white-box cancellation-page">
                           <h2><% out.print(buildingName); %>, <% out.print(flatNo); %>, <%out.print(projectName); %>, <%out.print(locality); %></h2>
                          <form id="newcancellation" name="newcancellation" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="is_primary" id="is_primary" value="<%out.print(isPrimary);%>"/>
                            <input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id); %>" />
	                         <input type="hidden" name="project_id" id="project_id" value="<%out.print(project_id);%>"/>
	                         <input type="hidden" name="building_id" id="building_id" value="<%out.print(building_id);%>"/>
	                         <input type="hidden" name="flat_id" name="flat_id" value="<%out.print(flat_id);%>"/>
 	                         <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
						    <div class="form-group row">
						        <label for="example-text-input" class="col-5 col-form-label">Buyer Name</label>
						        <div class="col-7">
						        	<div>
						            	<input class="form-control"  autocomplete="off" id="buyer_name" name="buyer_name" value="<%out.print(buyerName); %>"  type="text" >
						            </div>
						            <div class="messageContainer"></div>
						        </div>
						         
						    </div>
						    <div class="form-group row">
						        <label for="example-search-input" class="col-5 col-form-label">Buyer PAN Card</label>
						        <div class="col-7">
						        	<div>
						            	<input class="form-control" autocomplete="off" type="text" value="<%out.print(buyerPan); %>" id="pan_card" name="pan_card">
						            </div>
						             <div class="messageContainer"></div>
						        </div>
						        
						    </div>
						    <div class="form-group row">
						        <label for="example-search-input" class="col-5 col-form-label">Buyer Contact</label>
						        <div class="col-7">
						        	<div>
						            	<input class="form-control" autocomplete="off" type="text" value="<%out.print(buyerMobile);%>" id="buyer_contact" name="buyer_contact" >
						           </div>
						            <div class="messageContainer"></div>
						        </div>
						         
						    </div>
						   
						    <div class="form-group row">
						        <label for="example-tel-input" class="col-5 col-form-label">Reason of Cancellation</label>
						        <div class="col-7">
						        	<div>
						            	<input class="form-control" autocomplete="off" type="text" value="" id="reason" name="reason">
						            </div>
						            <div class="messageContainer"></div>
						        </div>
						    </div>
						    <div class="form-group row">
						        <label for="example-tel-input" class="col-5 col-form-label">Project</label>
						        <div class="col-7">
						            <input class="form-control" autocomplete="off" type="text" name="project_name" id="project_name" value="<%out.print(projectName); %>" disabled >
						        </div>
						    </div>
						    <div class="form-group row">
						        <label for="example-tel-input"  class="col-5 col-form-label">Building</label>
						        <div class="col-7">
						            <input class="form-control"name="building_name" id="building_name" value="<%out.print(buildingName); %>" disabled autocomplete="off" type="text" value="" id="">
						        </div>
						        <div class="messageContainer"></div>
						    </div>
						    <div class="form-group row">
						        <label for="example-tel-input" class="col-5 col-form-label">Flat</label>
						        <div class="col-7">
						            <input class="form-control" name="flat_number" id="flat_number" value="<%out.print(flatNo); %>" disabled autocomplete="off" type="text" value="" id="">
						        </div>
						         <div class="messageContainer"></div>
						    </div>
						    <div class="form-group row">
						        <label for="example-tel-input" class="col-5 col-form-label">Cancellation Charges</label>
						        <div class="col-7">
						        	<div>
						            	<input class="form-control" autocomplete="off" type="text" id="charges" name="charges" value="" >
						            </div>
						            <div class="messageContainer"></div>
						        </div>
						    </div>
						    <div class="center">
						      <button type="submit" class="btn btn-success waves-effect waves-light m-r-10">Cancel</button>
						    </div>
						</form>
                        </div>
                     </div>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                         <div class="bg1">
                            <div>
					           <div class="user-profile">
					           <%if(image != null && image != ""){ %>
						          <img src="${baseUrl }/bluepigeon/"+<%out.print(image); %> alt="User Image" class="custom-img">
						          <%}else{ %>
						          <img src="" alt="User Image" class="custom-img">
						           <%} %>
						          <img src="../images/camera_icon.PNG" alt="camera " class="camera"/>
						          <p><b><%out.print(buyerName); %></b></p>
						          <p class="p-custom"><%out.print(buildingName); %>-<%out.print(flatNo); %>, <%out.print(projectName); %></p>
						          <hr>
					            </div>
						        <div class="row custom-row user-row">
							        <p class="p-custom">Mobile No.</p>
							        <p><b><%out.print(buyerMobile); %></b></p>
							        <p class="p-custom">Email</p>
							        <p><b><%out.print(buyerEmail); %></b></p>
							        <p class="p-custom">PAN</p>
							        <p><b><%out.print(buyerPan); %></b></p>
							        <p class="p-custom">Adhar card no.</p>
							        <p><b></b></p>
							        <p class="p-custom">Permanent Address</p>
							        <p><b><%out.print(buyer.getAddress()); %></b></p>
							        <p class="p-custom">Current Address</p>
							        <p><b></b></p>
							        <hr>
						        </div>
					      </div>
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
  </body>
</html>
<script>
$('#newcancellation').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	
//     	project_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Project is required and cannot be empty'
//                 }
//             }
//         },
        
//         building_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'building is required and cannot be empty'
//                 }
//             }
//         },
//         flat_id : {
//             validators: {
//                 notEmpty: {
//                     message: 'flat is required and cannot be empty'
//                 }
//             }
//         },
    	buyer_name: {
            validators: {
                notEmpty: {
                    message: 'Buyer name is required and cannot be empty'
                }
            }
        },
        buyer_contact: {
        	validators: {
            	notEmpty: {
                    message: 'The Mobile is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[7-9][0-9]{9}$',
                    message: 'Invalid Mobile Number'
                }
            }
        },
        pan_card: {
            validators: {
                notEmpty: {
                    message: 'Buyer pancard is required and cannot be empty'
                }
            }
        },
        reason: {
            validators: {
                notEmpty: {
                    message: 'Reason is required and cannot be empty'
                }
            }
        },
        charges: {
            validators: {
                notEmpty: {
                    message: 'Charges is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	console.log("Hi you are in cancellation");
	//alert("Hello");
	addCancellation();
});

function addCancellation() {
	//alert("Hello again");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showCancellationRequest,
	 		success :  showCancellationResponse,
	 		url : '${baseUrl}/webapi/cancellation/save',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#newcancellation').ajaxSubmit(options);
}

function showCancellationRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showCancellationResponse(resp, statusText, xhr, $form){
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
       // alert(resp.message);
        window.location.href = "${baseUrl}/builder/cancellation/Salesman_booking_new2.jsp?project_id="+$("#project_id").val();
  	}
}

$("#booking").click(function(){
	window.location.href = "${baseUrl}/builder/buyer/booking.jsp?project_id="+$("#project_id").val();
});
$("#camcellation").click(function(){
	window.location.href = "${baseUrl}/builder/cancellation/Saleman_booking_new2.jsp?project_id="+$("#project_id").val();
});

$("#campaign").click(function(){
	window.location.href = "${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+$("#project_id").val();
});
</script>