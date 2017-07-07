<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployeeAccessType"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%
	List<ProjectData> project_list = null;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	int builder_uid = 0;
	int emp_id = 0;
	BuilderEmployee builderEmployee = null;
	BuilderDetailsDAO builderDetailsDAO  = null;
	List<BuilderEmployeeAccessType> access_list = null;
	List<City> cityList = null;
	List<Locality> localityList = null;
	emp_id = Integer.parseInt(request.getParameter("emp_id"));
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_uid = builder.getBuilder().getId();
			if(builder_uid > 0){
				project_list = new ProjectDAO().getActiveProjectsByBuilderId(builder_uid);
				int builder_size = project_list.size();
			    builderEmployee = new BuilderDetailsDAO().getBuilderEmployeeById(emp_id);
				builderDetailsDAO = new BuilderDetailsDAO();
				access_list = builderDetailsDAO.getBuilderAccessList(builder.getBuilderEmployeeAccessType().getId());
				cityList = new CityNamesImp().getCityActiveNames();
				localityList = new LocalityNamesImp().getLocalityActiveList();
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
       <div id="header">
        <%@include file="../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
       <div id="sidebar1"> 
       <%@include file="../partial/sidebar.jsp"%>
       </div>
   </div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Update Employee</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                                <ul class="nav tabs-horizontal">
                                    <li class="tab nav-item" aria-expanded="false">
                                        <a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"></a>
                                    </li>
                                </ul>
                               <div class="tab-content"> 
                               		<div id="vimessages" class="tab-pane active" aria-expanded="false">
                                		<div class="col-12">
                               				<form id="addemployee" name="addemployee" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
                                				<input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_uid); %>" />
                                 				<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>" />
                                				<div class="form-group row">
                                    				<label for="example-text-input" class="col-3 col-form-label">Name*</label>
                                    				<div class="col-3">
                                        				<input class="form-control" type="text" value="<%out.print(builderEmployee.getName()); %>" id="name" name="name">
                                    				</div>
                                  					<div class="messageContainer"></div>
                                    				<label for="example-text-input" class="col-3 col-form-label">Contact*</label>
                                    				<div class="col-3">
                                        				<input class="form-control" type="text" value="<%out.print(builderEmployee.getMobile()); %>" id="contact" name="contact">
                                    				</div>
                                    				<div class="messageContainer"></div>
                                				</div>
                                				<div class="form-group row">
                                    				<label for="example-search-input" class="col-3 col-form-label">Email*</label>
                                    				<div class="col-3">
                                        				<input class="form-control" type="text" value="<%out.print(builderEmployee.getEmail()); %>" id="email" name="email">
                                    				</div>
                                    				<label for="example-search-input" class="col-3 col-form-label">Current Address</label>
                                    				<div class="col-3">
														<textarea rows="" cols="" class="form-control" id="address" name="address"><%if(builderEmployee.getCurrentAddress() != null){out.print(builderEmployee.getCurrentAddress());} %></textarea>
                                    				</div>
                                				</div>
                                 				<div class="form-group row">
                                    				<label for="example-tel-input" class="col-3 col-form-label">Permanent Address</label>
                                    				<div class="col-3">
                                        				<textarea rows="" cols="" class="form-control" id="address1" name="address1"><%if(builderEmployee.getPermanentAddress() != null){out.print(builderEmployee.getPermanentAddress());} %></textarea>
                                    				</div>
                                    				<label for="example-tel-input" class="col-3 col-form-label">Designation</label>
                                    				<div class="col-3">
                                        				<input class="form-control" type="text" value="<%if(builderEmployee.getDesignation() != null){out.print(builderEmployee.getDesignation());}%>" name="designation" id="designation">
                                    				</div>
                                				</div>
                                				<div class="form-group row">
                                    				<label for="example-tel-input" class="col-3 col-form-label">Access Type</label>
                                    				<div class="col-3">
                                         				<select class="form-control" name="access" id="access">
					                                          <option value="0">Select Access</option>
															  <% for (BuilderEmployeeAccessType access : access_list) { %>
															  <option value="<%out.print(access.getId());%>" <%if(access.getId() == builderEmployee.getBuilderEmployeeAccessType().getId()){%>selected<%} %>> <% out.print(access.getName()); %> </option>
															  <% } %>
														</select>
				                                    </div>
                                    				<label for="example-tel-input" class="col-3 col-form-label">Employee ID</label>
                                    				<div class="col-3">
                                         				<input class="form-control" type="text" value="<%if(builderEmployee.getEmployeeId() != null){out.print(builderEmployee.getEmployeeId());} %>" id="empid" name="empid">
                                    				</div>
                                				</div>
                                				<div class="form-group row">
                                    				<label for="example-text-input" class="col-3 col-form-label">Project</label>
                                    				<div class="col-3">
                                       				<select class="form-control" name="project" id="project">
				                                          <option value="0">Select Project</option>
														  <%
														  if( builderEmployee.getBuilderProject() != null){
														  for (ProjectData project : project_list) { %>
														  <option value="<%out.print(project.getId());%>" <%if(project.getId() == builderEmployee.getBuilderProject().getId()) {%>selected<%} %>> <% out.print(project.getName()); %> </option>
														  <% }} %>
													</select>
                                    			</div>
                                    			<label for="example-text-input" class="col-3 col-form-label">Area</label>
			                                    <div class="col-3">
			                                      <select name="area" id="area" class="form-control">
														<option value="0"> Select Area </option>
														<%for(Locality locality: localityList){ %>
														<option value="<%out.print(locality.getId()); %>" <%if(locality.getId() == builderEmployee.getLocality().getId()){ %>selected<%} %>><%out.print(locality.getName()); %></option>
														<%} %>
												 </select>
			                                   </div>
                                			</div >
                                			<div class="form-group row">
                                   		 		<label for="example-search-input" class="col-3 col-form-label">City</label>
                                    			<div class="col-3">
			                                      <select name="city" id="city" class="form-control">
														<option value="0"> Select City </option>
														<% for(City city :cityList){%>
														<option value="<%out.print(city.getId()); %>" <%if(city.getId() == builderEmployee.getCity().getId()){ %>selected<%} %>><%out.print(city.getName()); %></option>
														<%}%>
												  </select>
			                                   </div>
                                			</div>
                                			<div class="offset-sm-5 col-sm-7">
                                        		<button type="submit" class="btn btn-info waves-effect waves-light m-t-10">Update</button>
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
         <div id="sidebar1"> 
      		<%@include file="../partial/footer.jsp"%>
	  </div> 
</body>
</html>
<script type="text/javascript">
$("#project").change(function(){
	var a=$("#project").val();
	//alert(a);
	$.get("${baseUrl}/webapi/employee/projectarea/list",{ project: $("#project").val() }, function(data){
	//	alert(data);
		var html = '<option value="">Select City</option>';
		$(data).each(function(index){
			html = html + '<option value="'+data[index].cityId+'">'+data[index].cityName+'</option>';
		});
		$("#city").html(html);
		
		var html1 = '<option value="">Select Area</option>';
		$(data).each(function(index){
			html1 = html1 + '<option value="'+data[index].areaId+'">'+data[index].areaName+'</option>';
		});
		$("#area").html(html1);
	},'json');
});


$('#addemployee').bootstrapValidator({
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
                    message: 'Name is required and cannot be empty'
                }
            }
        },
        contact:{
        	validators:{
        		notEmpty: {
        			message:'Contact is required and cannot be empty'
        		}
        	}
        },
        email:{
        	 excluded: false,
             validators: {
            	 notEmpty: {
                     message: 'Email is required and cannot be empty'
                 },
                 regexp: {
                     regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                     message: 'The value is not a valid email address'
                 }
             }
        },
        address:{
        	validators:{
        		notEmpty:{
        			message: 'Current address is required and cannot be empty'
        		}
        	}
        },
        address1:{
        	validators:{
        		notEmpty:{
        			message: 'Permenant is required and cannot be empty'
        		}
        	}
        },
        designation:{
        	validators:{
        		notEmpty:{
        			message: 'Designation is required and cannot be empty'
        		}
        	}
        },
        access: {
            validators: {
                notEmpty: {
                    message: 'Access type is required and cannot be empty'
                }
            }
        },
        empid: {
            validators: {
                notEmpty: {
                    message: 'Empoyee id is required and cannot be empty'
                }
            }
        }
        ,
        project: {
            validators: {
                notEmpty: {
                    message: 'Project is required and cannot be empty'
                }
            }
        }
        
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateEmployee();
});
function updateEmployee() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/employee/builder/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addemployee').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/employee/list.jsp";
  	}
}

</script>