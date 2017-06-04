<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
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
 	List<ProjectData> builderProjects =null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
		}
		if(builder_id > 0){
			builderProjects = new ProjectDAO().getActiveProjectsByBuilderId(builder_id);
		}
		if(builderProjects.size()>0)
	    	project_size = builderProjects.size();
	 	if(builderPropertyTypes.size()>0)
	 		type_size = builderPropertyTypes.size();
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
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
   <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
  
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
       <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
    
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Add Lead</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
             
        

                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                             <h4 class="page-title">Add Lead Details</h4><br>
                                <ul class="nav tabs-horizontal">
                                    <li class="tab nav-item" aria-expanded="false">
                                        <a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"></a>
                                    </li>
                                </ul>
                                
                              <div class="tab-content"> 
                              
                               <div id="vimessages" class="tab-pane active" aria-expanded="false">
                                <div class="col-12">
                               	<form id="addlead" name="addlead" class="form-horizontal" action="" method="post">
                                <input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id); %>" />
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Interested In*</label>
                                    <div class="col-3">
                                       <select name="project_id" id="project_id" class="form-control">
						                 	   	<option value="0">Select Project</option>
						                  	   	<% for(int i=0; i < project_size ; i++){ %>
												<option value="<% out.print(builderProjects.get(i).getId());%>"><% out.print(builderProjects.get(i).getName());%></option>
											  	<% } %>
								       	  	</select>
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Building*</label>
                                    <div class="col-3">
                                       <select name="building_id" id="building_id" class="form-control">
						                 	   	<option value="0">Select Building</option>
								       	  	</select>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Flat*</label>
                                    <div class="col-3">
                                      <select name="flat_id" id="flat_id" class="form-control">
						                 	   	<option value="0">Select Flat</option>
								       	  	</select>
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Lead Name</label>
                                    <div class="col-3">
										<input type="text" id="name" name="name" placeholder="Enter lead name" class="form-control" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Contact</label>
                                    <div class="col-3">
                                       <input type="text" id="mobile" name="mobile" placeholder="Enter lead phone number" class="form-control" />
                                    </div>
                                    <label for="example-tel-input" class="col-3 col-form-label">Email</label>
                                    <div class="col-3">
                                         <input type="text" id="email" name="email" placeholder="Enter lead email" class="form-control" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Source</label>
                                    <div class="col-3">
                                       <select name="source" id="source" class="form-control">
							                    <option value="0">Select Source</option>
							                    <option value="1">App</option>
							                    <option value="2">Website</option>
							                    <option value="3">Google</option>
							                    <option value="4">Facebook</option>
							                </select>
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Area</label>
                                    <div class="col-3">
                                      <input type="text" id="area" name="area" placeholder="Enter lead area" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">City</label>
                                    <div class="col-3">
                                       <!--  <input class="form-control" type="text" value="City" id="example-search-input">-->
                                       <input type="text" id="city" name="city" placeholder="Enter City" class="form-control" />
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Discount offered</label>
                                    <div class="col-3">
                                       <input type="text" id="discount_offered" name="discount_offered" placeholder="Enter Discount" class="form-control" />
                                    </div>
                                </div>
                                <div class="offset-sm-5 col-sm-7">
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">SAVE</button>
                                 </div>
                               </form>
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
        <!-- /#page-wrapper -->
    
    <!-- /#wrapper -->
    </div>
    <script type="text/javascript">
$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/project/building/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].flatNo+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
						
				
$('#addlead').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	name: {
            validators: {
                notEmpty: {
                    message: 'Lead name is required and cannot be empty'
                }
            }
        },
        mobile: {
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
        email: {
        	validators: {
            	notEmpty: {
                    message: 'The Email is required and cannot be empty'
                },
                regexp: {
                    regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                    message: 'The value is not a valid email address'
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
        city: {
            validators: {
                notEmpty: {
                    message: 'City Name is required and cannot be empty'
                }
            }
        },
        area: {
            validators: {
                notEmpty: {
                    message: 'Locality Name is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addLead();
});

function addLead() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/add',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addlead').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/leads/list.jsp";
  	}
}
</script>
    
</body>
</html>