<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
 	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
 	List<BuilderProject> builderProjects = new ProjectLeadDAO().getProjectList();
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	if(builderProjects.size()>0)
    	project_size = builderProjects.size();
 	if(builderPropertyTypes.size()>0)
 		type_size = builderPropertyTypes.size();
   	session = request.getSession(false);
   	
   Builder builder = new Builder();
 	int p_user_id = 0;
 	List<City> city_list = new CityNamesImp().getCityNames();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			p_user_id = builder.getId();
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
     <!-- color CSS -->
    <link href="../css/colors/megna.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
   <script src="../js/jquery.form.js"></script>
  <script src="../js/bootstrapValidator.min.js"></script>
   <script src="../js/bootstrap-datepicker.min.js"></script>
     <script> 
 
$(function(){
$("#sidebar1").load("../partial/sidebar.jsp");
  $("#header").load("../partial/header.jsp"); 

  $("#footer").load("../partial/footer.jsp"); 
});
</script>
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
        <!-- Top Navigation -->
        <div id="header"></div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
       <div id="sidebar1"> </div>
    
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">New Campaign</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
             
        

                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                             <!-- <h4 class="page-title">Add New Project</h4>
                             <br>-->
                                <ul class="nav tabs-horizontal">
                                    <li class="tab nav-item" aria-expanded="false">
                                        <a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"><span>+ New Campaign</span></a>
                                    </li>
                                     <li class="tab nav-item">
                                        <a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages1"><span>Select Recipients</span></a>
                                    </li>
                                </ul>
                                
                                 <form id="addcampaign" name="addcampaign" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
                              <div class="tab-content"> 
                              
                               <div id="vimessages" class="tab-pane active" aria-expanded="false">
                                <div class="col-12">
                               
                                	 <input type="hidden" id="builder_id" name="builder_id" value="<%out.print(p_user_id); %>" />
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Campaign Title*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="title" name="title">
                                    </div>
                                     <label for="example-search-input" class="col-3 col-form-label">Terms</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="terms" name="terms">
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Campaign Type*</label>
                                    <div class="col-3">
                                      <select name="campaign_type" id="campaign_type" class="form-control">
						                 	   	<option value="">Select Campaign</option>
						                 	   	<option value="1">New Project</option>
						                 	   	<option value="2">New Property</option>
						                 	   	<option value="3">Offers</option>
						                 	   	<option value="4">Event</option>
						                 	   	<option value="5">Referral</option>
								       	  	</select>
                                    </div>
                                     <label for="example-search-input" class="col-3 col-form-label">Valid Till</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="set_date" name="set_date">
                                    </div>
                                </div>
                              
                               
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Content</label>
                                    <div class="col-3">
                                         <input class="form-control" type="text" id="content" name="content">
                                    </div>
                                </div>
                                
                                <div class="offset-sm-5 col-sm-7">
                                        <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="show();">Save</button>
                                 </div>
                              
                               </div>
                              </div>
                              
                             <div id="vimessages1" class="tab-pane" aria-expanded="false">
                            
                                 
                                  <div class="form-group row">
                                       <label for="example-search-input" class="col-3 col-form-label">City</label>
                                    <div class="col-3">
                                      <select name="city_id" id="city_id" class="form-control">
							                    <option value="0">Select City</option>
							                     <% for(City city : city_list){ %>
												<option value="<% out.print(city.getId());%>"><% out.print(city.getName());%></option>
												<% } %>
							                </select>
                                    </div>
                                    
                                    <label for="example-search-input" class="col-3 col-form-label">Project*</label>
                                    <div class="col-3">
                                        <select name="project_id" id="project_id" class="form-control">
							                    <option value="0">Select Project</option>
							                </select>
                                    </div>
                                
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Building</label>
                                    <div class="col-3">
                                        <select name="building_id" id="building_id" class="form-control">
							                    <option value="0">Select Building</option>
							                </select>
                                    </div>
                                    
                                     <label for="example-search-input" class="col-3 col-form-label">flat</label>
                                    <div class="col-3">
                                          <select name="flat_id" id="flat_id" class="form-control">
							                    <option value="0">Select Flat</option>
							                </select>
                                    </div>
                                    
                                </div>
                              
                               
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Recipient Type</label>
                                    <div class="col-3">
                                        <select name="recipient_type_id" id="recipient_type_id" class="form-control">
							                    <option value="0">Select Recipient Type</option>
							                     <option value="1">Lead</option>
							                     <option value="2">Buyer</option>
							                </select>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <div class="col-12">
                                        <center><label for="example-search-input" class="col-form-label">Recipients Name</label></center><br>
                                       <div id="appendbuyer" class="col-3"></div>
                                    </div>
                                    <input type="hidden" name="added_by" id="added_by" value="1"/>
                                     <!--  <div class="col-4">
                                        <center><label for="example-search-input" class="col-form-label">Project</label></center><br>
                                        <input class="form-control" type="text" value="project" id="example-search-input">
                                    </div>
                                     <div class="col-4">
                                        <center><label for="example-search-input" class="col-form-label">Select</label></center><br>
                                        <input class="form-control" type="text" value="Select" id="example-search-input">
                                    </div>-->
                                </div>
                                 
                                 <div class="form-group row">                        
	                                 <div class="col-4">
	                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10" style="float: right;">Save</button>
	                                 </div>
	                                  <div class="col-4">
	                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10" style="float: right;">Publish</button>
	                                 </div>
                                 </div>
                                 
                                
                               </div>

                                
                             </div>
                              </form>  
                        </div>

                        </div>
                    </div>
                </div>
                
                
                <!-- /.row -->
                <!-- .row -->
               
                <!-- /.row -->
                <!-- .row -->
                
                <!-- .right-sidebar -->
                <div class="right-sidebar" style="overflow: visible;">
                    <div class="slimScrollDiv" style="position: relative; overflow-x: visible; overflow-y: hidden; width: auto; height: 100%;"><div class="slimscrollright" style="overflow: hidden; width: auto; height: 100%;">
                        <div class="rpanel-title"> Service Panel <span><i class="ti-close right-side-toggle"></i></span> </div>
                        <div class="r-panel-body">
                            <ul>
                                <li><b>Layout Options</b></li>
                                <li>
                                    <div class="checkbox checkbox-info">
                                        <input id="checkbox1" type="checkbox" class="fxhdr">
                                        <label for="checkbox1"> Fix Header </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="checkbox checkbox-warning">
                                        <input id="checkbox2" type="checkbox" checked="" class="fxsdr">
                                        <label for="checkbox2"> Fix Sidebar </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="checkbox checkbox-success">
                                        <input id="checkbox4" type="checkbox" class="open-close">
                                        <label for="checkbox4"> Toggle Sidebar </label>
                                    </div>
                                </li>
                            </ul>
                            <ul id="themecolors" class="m-t-20">
                                <li><b>With Light sidebar</b></li>
                                <li><a href="javascript:void(0)" theme="default" class="default-theme">1</a></li>
                                <li><a href="javascript:void(0)" theme="green" class="green-theme">2</a></li>
                                <li><a href="javascript:void(0)" theme="gray" class="yellow-theme">3</a></li>
                                <li><a href="javascript:void(0)" theme="blue" class="blue-theme">4</a></li>
                                <li><a href="javascript:void(0)" theme="purple" class="purple-theme">5</a></li>
                                <li><a href="javascript:void(0)" theme="megna" class="megna-theme working">6</a></li>
                                <li><b>With Dark sidebar</b></li>
                                <br>
                                <li><a href="javascript:void(0)" theme="default-dark" class="default-dark-theme">7</a></li>
                                <li><a href="javascript:void(0)" theme="green-dark" class="green-dark-theme">8</a></li>
                                <li><a href="javascript:void(0)" theme="gray-dark" class="yellow-dark-theme">9</a></li>
                                <li><a href="javascript:void(0)" theme="blue-dark" class="blue-dark-theme">10</a></li>
                                <li><a href="javascript:void(0)" theme="purple-dark" class="purple-dark-theme">11</a></li>
                                <li><a href="javascript:void(0)" theme="megna-dark" class="megna-dark-theme">12</a></li>
                            </ul>
                            <ul class="m-t-20 chatonline">
                                <li><b>Chat option</b></li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/varun.jpg" alt="user-img" class="img-circle"> <span>Varun Dhavan <small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/genu.jpg" alt="user-img" class="img-circle"> <span>Genelia Deshmukh <small class="text-warning">Away</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/ritesh.jpg" alt="user-img" class="img-circle"> <span>Ritesh Deshmukh <small class="text-danger">Busy</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/arijit.jpg" alt="user-img" class="img-circle"> <span>Arijit Sinh <small class="text-muted">Offline</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/govinda.jpg" alt="user-img" class="img-circle"> <span>Govinda Star <small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/hritik.jpg" alt="user-img" class="img-circle"> <span>John Abraham<small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/john.jpg" alt="user-img" class="img-circle"> <span>Hritik Roshan<small class="text-success">online</small></span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)"><img src="../plugins/images/users/pawandeep.jpg" alt="user-img" class="img-circle"> <span>Pwandeep rajan <small class="text-success">online</small></span></a>
                                </li>
                            </ul>
                        </div>
                    </div><div class="slimScrollBar" style="background: rgb(220, 220, 220); width: 5px; position: absolute; top: 0px; opacity: 0.4; display: block; border-radius: 7px; z-index: 99; right: 1px;"></div><div class="slimScrollRail" style="width: 5px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div>
                </div>
                <!-- /.right-sidebar -->
            </div>
            <!-- /.container-fluid -->
            <footer class="footer text-center"> 2017 Â© Blue Pigeon</footer>
        
        <!-- /#page-wrapper -->
    
    <!-- /#wrapper -->
    
</body>
</html>

<script type="text/javascript">
$('#set_date').datepicker({
	format: "dd MM yyyy"
});

$("#city_id").change(function(){
	$.get("${baseUrl}/bluepigeon/webapi/campaign/projectlist/"+$("#city_id").val(),{ }, function(data){
		var html = '<option value="0">Select Project</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].projectId+'">'+data[index].projectName+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		checkbox+='</div>';
		$("#project_id").html(html);
 		$("#appendbuyer").html(checkbox);
	},'json');
});

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/campaign/building/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].buildingId+'">'+data[index].buildingName+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		$("#building_id").html(html);
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/bluepigeon/webapi/campaign/building/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
			html = html + '<option value="'+data[index].flatId+'">'+data[index].flatNo+'</option>';
			$(data[index].buyer).each(function(key, value){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+value.id+'" />'+'&nbsp;'+value.name
				checkbox +='</div>';
			});
		});
		$("#flat_id").html(html);
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});

$("#flat_id").change(function(){
	$.get("${baseUrl}/bluepigeon/webapi/campaign/flat/buyer/names/"+$("#flat_id").val(),{ }, function(data){
		var checkbox = '<div class="col-sm-10">';
		$("#appendbuyer").empty();
		$(data).each(function(index){
				checkbox += '<div class="col-sm-4"><input type="checkbox" id="recipient" name="buyer_name[]" value="'+data[index].id+'" />'+'&nbsp;'+data[index].name
				checkbox +='</div>';
		});
		checkbox+='</div>';
		$("#appendbuyer").html(checkbox);
	},'json');
});

$('#addcampaign').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	title: {
            validators: {
                notEmpty: {
                    message: 'Lead name is required and cannot be empty'
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
        set_date:{
        	 excluded: false,
             validators: {
                 notEmpty: {
                     message: 'The date is required'
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
        project_id: {
            validators: {
                notEmpty: {
                    message: 'Project is required and cannot be empty'
                }
            }
        },
        city_id: {
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
	addCampaign();
});
function addCampaign() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/bluepigeon/webapi/campaign/save1',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addcampaign').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/bluepigeon/builder/campaign/new-campaign.jsp";
  	}
}


function show()
{
	$("#vimessages1").show();
	$("#vimessages").hide();
}
</script>
