<%@page import="org.bluepigeon.admin.model.AllotProject"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
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
	int builder_size =0;
	List<City> cityList = null;
	BuilderDetailsDAO builderDetailsDAO = null;
	int emp_id =0;
	int access_id = 0;
	BuilderEmployee builderEmployee = new BuilderEmployee();
	List<BuilderEmployeeAccessType> access_list  = null;
	List<Locality> localityList = null;
	List<AllotProject> allotProjects = null;
	int city_size = 0;
	int area_size = 0;
	List<EmployeeRole> updateemployeeRoles = null;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_uid = builder.getBuilder().getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder_uid > 0 && access_id == 2){
				if (request.getParameterMap().containsKey("emp_id")) {
					emp_id = Integer.parseInt(request.getParameter("emp_id"));
					builderEmployee = new BuilderDetailsDAO().getBuilderEmployeeById(emp_id);
					project_list = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
				    builder_size = project_list.size();
				    builderDetailsDAO = new BuilderDetailsDAO();
				    access_list = builderDetailsDAO.getBuilderAccessList();
				    cityList = new CityNamesImp().getCityActiveNames();
				    localityList = new LocalityNamesImp().getLocalityActiveList();
				    allotProjects = new BuilderDetailsDAO().getAllotedrojectsByEmpId(emp_id);
				    updateemployeeRoles = new BuilderDetailsDAO().getEmployeeRolesByEmployee(emp_id);
				    city_size = cityList.size();
				    area_size = localityList.size();
				}
			}else{
				response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
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
    <link href="../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/newstyle.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
     <link href="../css/jquery.multiselect.css" rel="stylesheet">
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/adminaddemployee.css">
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/newjquery.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
	<script src="../js/bootstrapValidator.min.js"></script>
	<style>
	.selectize-input, .selectize-control.single .selectize-input.input-active {
	background:#fafafa;
	}
	.selectize-input.full {
    background-color: #fafafa;
}
	</style>
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
        <div id="page-wrapper">
           <div class="container-fluid addlead">
               <!-- /.row -->
	            <h1>Update Employee</h1>
               <!-- row -->
				<div class="white-box">
					<div class="bg11">
                 		<div class="spacer">
                   			<h3> Update Employee</h3>
						</div>
                  		<form class="addlead1" id="updateemployee" name="updateemployee" action="" method="post" enctype="multipart/form-data">
                  			<input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_uid); %>" />
                            <input type="hidden" id="reporting_id" name="reporting_id" value="<%out.print(builderEmployee.getId());%>"/>
                            <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>" />
                    		<div class="row">
                    			<div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                        			<div class="form-group row">
										<label for="example-text-input" class="col-sm-5 col-form-label"> Name</label>
										<div class="col-sm-7">
											<div>
								 				<input class="form-control  form-control1" type="text" id="name" name="name" value="<%out.print(builderEmployee.getName()); %>"  placeholder="employee name">
											</div>
											<div class="messageContainer"></div>
							  			</div>
						  			</div>
						   			<div class="form-group row">
							 			<label for="example-search-input" class="col-sm-5 col-form-label">Email ID</label>
							 			<div class="col-sm-7">
											<div>
								   				<input class="form-control  form-control1" type="text" id="email" name="email" value="<%out.print(builderEmployee.getEmail()); %>" placeholder="employee email id">
											</div>
											<div class="messageContainer"></div>
							 			</div>
						   			</div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-sm-5 col-form-label">Permanent Address</label>
										  <div class="col-sm-7">
										  	<div>
										     	<textarea placeholder="Enter permanents address" id="address1" name="address1"><%out.print(builderEmployee.getPermanentAddress()); %></textarea>
										  	</div>
										  	<div class="messageContainer"></div>
										</div>
									 </div>
									 <div class="form-group row">
									  <label for="example-search-input" class="col-sm-5 col-form-label">Access Type</label>
										<div class="col-sm-7">
											<div id="accessrole">
												 <select  id="accessid" name="accessid[]" multiple>
							                     <%if(access_list != null){
			                        					for(BuilderEmployeeAccessType builderEmployeeAccessType : access_list){
			                        						String is_selected ="";
			                        						for(EmployeeRole employeeRole : updateemployeeRoles){
			                        							if(employeeRole.getBuilderEmployeeAccessType().getId()==builderEmployeeAccessType.getId()){
			                        								is_selected = "selected";
			                        							}
			                        						}
			                        			 %>
			                        				<option value="<%out.print(builderEmployeeAccessType.getId()); %>"  <%out.print(is_selected); %>><%out.print(builderEmployeeAccessType.getName()); %></option>
			                        			<%}} %>
						                        </select>
											</div>
										</div>
								    </div>
								    <div class="form-group row">
									  <label for="example-search-input" class="col-sm-5 col-form-label">Project </label>
										<div class="col-sm-7">
											<div id="assignproject">
											    <select  id="projects" name="projects[]" multiple>
						                         <% if(project_list!=null){
													for(ProjectData project : project_list){
													String is_selected = "";	
														for(AllotProject allotProject : allotProjects){
															if(allotProject.getBuilderProject().getId() == project.getId())
																is_selected = "selected";
														}
												%>
												<option value="<%out.print(project.getId());%>" <%out.print(is_selected); %> > <% out.print(project.getName()); %> </option>
												<%}} %>
						                        </select>
						                     </div>
										 </div>
								    </div>
								    <div class="form-group row">
							   			<label for="example-search-input" class="col-sm-5 col-form-label">Area</label>
										<div class="col-sm-7">
											<div>
										   		<select name="area_id" id="area_id">
													<option value="0"> Select Area </option>
													<%if(localityList !=null){
													for(Locality locality: localityList){ %>
													<option value="<%out.print(locality.getId()); %>" <%if(locality.getId() == builderEmployee.getLocality().getId()){ %>selected<%} %>><%out.print(locality.getName()); %></option>
													<%}} %>
												</select>
					                     	</div>
					                     	<div class="messageContainer"></div>
										</div>
							  		</div>
		                            <div class="form-group row">
							           <label for="example-tel-input" class="col-sm-5 col-form-label">Aadhaar Card No. </label>
								         <div class="col-sm-7">
								         	<div>
									       		<input class="form-control  form-control1" type="text" id="aadhaar" name="aadhaar" value="<%if(builderEmployee.getAadhaarNumber() != null){out.print(builderEmployee.getAadhaarNumber());} %>" placeholder="">
									     	</div>
									     	<div class="messageContainer"></div>
									     </div>
								    </div>
						       </div>
								<div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
									<div class="form-group row">
										<label for="example-text-input" class="col-sm-5 col-form-label"> Contact</label>
										<div class="col-sm-7">
									  		<div>
											 	<input class="form-control form-control1" type="text" id="contact" name="contact"  value="<%out.print(builderEmployee.getMobile()); %>" placeholder="">
											</div>
											<div class="messageContainer"></div>
										</div>
							   		</div>
							   		<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Current Address</label>
									 	<div class="col-sm-7">
											<div>
										     	<textarea placeholder="Enter current address" id="address" name="address"><%out.print(builderEmployee.getCurrentAddress()); %></textarea>
										  	</div>
										  	<div class="messageContainer"></div>
									 	</div>
							   		</div>
							   		<div class="form-group row">
		   					  			<label for="example-text-input" class="col-sm-5 col-form-label">Designation</label>
		      							<div class="col-sm-7">
		      								<div>
			    								<input class="form-control form-control1" type="text" name="designation" id="designation"  value="<%out.print(builderEmployee.getDesignation()); %>" placeholder="">
		      								</div>
		      								<div class="messageContainer"></div>
		      							</div>
		 							</div>
		  							<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Employee ID</label>
										<div class="col-sm-7">
											<div>
		   										<input class="form-control  form-control1" type="text"  id="empid" name="empid" value="<%out.print(builderEmployee.getEmployeeId()); %>" placeholder="">
		 									</div>
		 									<div class="messageContainer"></div>
		 								</div>
							   		</div>
							   		<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">City</label>
										<div class="col-sm-7">
											<div>
											    <select name="city_id" id="city_id">
													<option value="0"> Select City </option>
													<% 
													if(cityList != null){
													for(City city :cityList){%>
													<option value="<%out.print(city.getId()); %>" <%if(city.getId() == builderEmployee.getCity().getId()){ %>selected<%} %>><%out.print(city.getName()); %></option>
													<%}}%>
												</select>
											</div>
											<div class="messageContainer"></div>
										 </div>
								    </div>
								  	<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Pan Card No.</label>
										<div class="col-sm-7">
											<div>
											 	<input class="form-control  form-control1" type="text" id="pancard" name="pancard" value="<%if(builderEmployee.getPancard()!=null){out.print(builderEmployee.getPancard());} %>" placeholder="">
											 </div>
											 <div class="messageContainer"></div>
										</div>
								  	</div>
								  	<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Upload Photo</label>
										<div class="col-sm-7">
											<div>
											 	<div class="file-upload">
										   			<p class="file-name"></p>
										    		<label for="empphoto" class="btn">Choose File</label>
										   			<input type="file" id="empphoto" name="empphoto[]" >
												</div>
											</div>
											<div class="messageContainer"></div>
										</div>
										<div class="col-sm-6"></div>
										<div class="col-sm-6">
										<%if(builderEmployee.getPhoto() != null){ %>
										<img alt="builder logo" src="${baseUrl}/<% out.print(builderEmployee.getPhoto()); %>" width="200px;">
										<%} %>
										</div>
								 	</div>
								</div>
							</div>
						<div class="row">
							<div class="center">
				    			<button type="submit" class="btn11">Update</button>
							</div>
						</div>
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
</html>
<script type="text/javascript" src="../js/selectize.min.js"></script>
 <script>
 $('#accessid').multiselect({
     columns: 1,
     placeholder: 'Select Access Role',
     search: true,
     selectAll: true
 });
 $('#projects').multiselect({
     columns: 1,
     placeholder: 'Select Projects',
     search: true,
     selectAll: true
 });

 
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
  
  $select_city = $("#city_id").selectize({
		persist: false,
		 onChange: function(value) {
			if( $("#city_id").val() != '' ){
				$.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#city_id").val() }, function(data){
					var html = '<option value="0">Select Area</option>';
					$(data).each(function(index){
						html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
					});
					$select_area[0].selectize.destroy();
					$("#area_id").html(html);
					$select_area = $("#area_id").selectize({
						persist: false,
						 onChange: function(value) {

						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#area_id :selected").text();
					   	 if(textClear.trim() == "Enter Area Name"){
					   		 obj[0].setValue("");
					   	 }
					    }
					});
					
				},'json');
			}
		 },
		 onDropdownOpen: function(value){
	    	 var obj = $(this);
			var textClear =	 $("#city_id :selected").text();
	    	 if(textClear.trim() == "Enter City Name"){
	    		 obj[0].setValue("");
	    	 }
	     }
	});
	<%if(city_size > 0){%>
		select_city = $select_city[0].selectize;
	<%}%>

	$select_area = $("#area_id").selectize({
		persist: false,
		 onChange: function(value) {

		 },
		 onDropdownOpen: function(value){
	   	 var obj = $(this);
			var textClear =	 $("#area_id :selected").text();
	   	 if(textClear.trim() == "Enter Area Name"){
	   		 obj[0].setValue("");
	   	 }
	    }
	});
  <% if(area_size > 0){%>
  	select_area = $select_area[0].selectize;
  <%}%>
  
	$('#updateemployee').bootstrapValidator({
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
	                },
	                regexp: {
                        regexp: '^[a-zA-Z0-9_\.]+$',
                        message: 'The username can only consist of alphabetical, number, dot and underscore'
                    }
	            }
	        },
	        contact:{
	        	validators:{
	        		 notEmpty: {
	                     message: 'The Mobile is required.'
	                 },
	                 regexp: {
	                     regexp: '^[7-9][0-9]{9}$',
	                     message: 'Invalid Mobile Number'
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
	        pancard:{
	        	 excluded: false,
	             validators: {
	            	 notEmpty: {
	                     message: 'PAN card required and cannot be empty'
	                 },
	                 regexp: {
	                     regexp: '^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
	                     message: 'Invalid PAN Card Number'
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
	        'accessid[]': {
	            validators: {
	                notEmpty: {
	                    message: 'Access type is required and cannot be empty'
	                }
	            }
	        },
	       
	        aadhaar:{
	        	validators:{
	        		notEmpty:{
	        			message: 'Aadhaar Number is required and cannot be empty'
	        		},
	        		 numeric: {
	                  	message: 'Aadhaar Number is invalid',
	                     thousandsSeparator: '',
	                     decimalSeparator: '.'
	               	},
	               	stringLength:{
	               		max:12,
	               		min:12,
	               		message:'Aadhaar Number is invalid'
	               	}
	        	}
	        	
	        },
	        city_id:{
	        	validators: {
	                notEmpty: {
	                    message: 'City is required and cannot be empty'
	                }
	            },
           area_id:{
            	validators: {
                    notEmpty: {
                        message: 'Area is required and cannot be empty'
                    }
                }
            }
		}
	}
}).on('success.form.bv', function(event,data) {
		// Prevent form submission
		event.preventDefault();
	  updateEmployee();
	}).on('error.form.bv', function(event,data) {
		// Prevent form submission
		event.preventDefault();
		alert("Error..");
		//addEmployee();
	});
	function updateEmployee() {
//	 	 $('#addemployee').submit(function(){
//	          var multipleoptions = $('#project > option:selected');
//	          if(multipleoptions.length == 0){
//	              alert('no value selected');
//	              return false;
//	          }
//	    });
		var options = {
		 		target : '#updateresponse', 
		 		beforeSubmit : showUpdateRequest,
		 		success :  showUpdateResponse,
		 		url : '${baseUrl}/webapi/employee/newupdate',
		 		semantic : true,
		 		dataType : 'json'
		 	};
	   	$('#updateemployee').ajaxSubmit(options);
	}

	function showUpdateRequest(formData, jqForm, options){
		$("#updateresponse").hide();
	   	var queryString = $.param(formData);
		return true;
	}
	   	
	function showUpdateResponse(resp, statusText, xhr, $form){
		if(resp.status == '0') {
			$("#updateresponse").removeClass('alert-success');
	       	$("#updateresponse").addClass('alert-danger');
			$("#updateresponse").html(resp.message);
			$("#updateresponse").show();
			 alert(resp.message);
	  	} else {
	  		$("#updateresponse").removeClass('alert-danger');
	        $("#updateresponse").addClass('alert-success');
	        $("#updateresponse").html(resp.message);
	        $("#updateresponse").show();
	        alert(resp.message);
	        window.location.href = "${baseUrl}/builder/admin/employeeslist.jsp";
	  	}
	}
	
  </script>