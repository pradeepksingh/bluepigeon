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
	List<BuilderEmployeeAccessType> access_list  = null;
	int city_size = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_uid = builder.getBuilder().getId();
			if(builder_uid > 0){
				project_list = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
			    builder_size = project_list.size();
			    
			    builderDetailsDAO = new BuilderDetailsDAO();
			    access_list = builderDetailsDAO.getBuilderAccessList();
			    cityList = new CityNamesImp().getCityActiveNames();
			    city_size = cityList.size();
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
	            <h1>Add Employee</h1>
               <!-- row -->
				<div class="white-box">
					<div class="bg11">
                 		<div class="spacer">
                   			<h3>+ New Employee</h3>
						</div>
                  		<form class="addlead1" id="addemployee" name="addemployee" action="" method="post" enctype="multipart/form-data">
                  			<input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_uid); %>" />
                            <input type="hidden" id="reporting_id" name="reporting_id" value="<%out.print(builder.getId());%>"/>
                    		<div class="row">
                    			<div class="col-md-6 col-sm-12 col-xs-12 padding-left-right">
                        			<div class="form-group row">
										<label for="example-text-input" class="col-sm-5 col-form-label"> Name</label>
										<div class="col-sm-7">
											<div>
								 				<input class="form-control  form-control1" type="text" id="name" name="name"  placeholder="employee name">
											</div>
											<div class="messageContainer"></div>
							  			</div>
						  			</div>
						   			<div class="form-group row">
							 			<label for="example-search-input" class="col-sm-5 col-form-label">Email ID</label>
							 			<div class="col-sm-7">
											<div>
								   				<input class="form-control  form-control1" type="text" id="email" name="email" placeholder="employee email id">
											</div>
											<div class="messageContainer"></div>
							 			</div>
						   			</div>
									<div class="form-group row">
									   <label for="example-search-input" class="col-sm-5 col-form-label">Permanent Address</label>
										  <div class="col-sm-7">
										  	<div>
										     	<textarea placeholder="Enter permanents address" id="address1" name="address1"></textarea>
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
			                        			 %>
			                        				<option value="<%out.print(builderEmployeeAccessType.getId()); %>"><%out.print(builderEmployeeAccessType.getName()); %></option>
			                        			<%} }%>
						                        </select>
											</div>
										</div>
								    </div>
								    <div class="form-group row">
									  <label for="example-search-input" class="col-sm-5 col-form-label">Project </label>
										<div class="col-sm-7">
											<div id="assignproject">
											    <select  id="projects" name="projects[]" multiple>
						                          <% 
						                          if(project_list != null){
						                          for (ProjectData project : project_list) { %>
														<option value="<%out.print(project.getId());%>"> <% out.print(project.getName()); %> </option>
												  <% }} %>
						                        </select>
						                     </div>
										 </div>
								    </div>
								    <div class="form-group row">
									 <label for="example-search-input" class="col-sm-5 col-form-label">City</label>
										<div class="col-sm-7">
											<div>
											    <select name="city_id" id="city_id">
													<option value=""> Select City </option>
													<% 
													if(cityList != null){
													for(City city : cityList){ %>
													<option value="<%out.print(city.getId());%>"><%out.print(city.getName()); %></option>
													<% }} %>
												</select>
											</div>
											<div class="messageContainer"></div>
										 </div>
								    </div>
		                            <div class="form-group row">
							           <label for="example-tel-input" class="col-sm-5 col-form-label">Aadhaar Card No. </label>
								         <div class="col-sm-7">
								         	<div>
									       		<input class="form-control  form-control1" type="text" id="aadhaar" name="aadhaar" placeholder="">
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
											 	<input class="form-control form-control1" type="text" id="contact" name="contact"  placeholder="">
											</div>
											<div class="messageContainer"></div>
										</div>
							   		</div>
							   		<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Current Address</label>
									 	<div class="col-sm-7">
											<div>
										     	<textarea placeholder="Enter current address" id="address" name="address"></textarea>
										  	</div>
										  	<div class="messageContainer"></div>
									 	</div>
							   		</div>
							   		<div class="form-group row">
		   					  			<label for="example-text-input" class="col-sm-5 col-form-label">Designation</label>
		      							<div class="col-sm-7">
		      								<div>
			    								<input class="form-control form-control1" type="text" name="designation" id="designation"  placeholder="">
		      								</div>
		      								<div class="messageContainer"></div>
		      							</div>
		 							</div>
		  							<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Employee ID</label>
										<div class="col-sm-7">
											<div>
		   										<input class="form-control  form-control1" type="text"  id="empid" name="empid" placeholder="">
		 									</div>
		 									<div class="messageContainer"></div>
		 								</div>
							   		</div>
							   		<div class="form-group row">
							   			<label for="example-search-input" class="col-sm-5 col-form-label">Area</label>
										<div class="col-sm-7">
											<div>
										   		<select name="area_id" id="area_id"></select>
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
								 	</div>
								  	<div class="form-group row">
										<label for="example-search-input" class="col-sm-5 col-form-label">Pan Card No.</label>
										<div class="col-sm-7">
											<div>
											 	<input class="form-control  form-control1" type="text" id="pancard" name="pancard" placeholder="">
											 </div>
											 <div class="messageContainer"></div>
										</div>
								  	</div>
								</div>
							</div>
						<div class="row">
							<div class="center">
				    			<button type="submit" class="btn11">Save</button>
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
	                    message: 'minimum one project must be selected'
	                }
	            }
	        },
	        empid:{
	        	validators: {
	                notEmpty: {
	                    message: 'Employee Id is required and cannot be empty'
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
		addEmployee();
	});
	function addEmployee() {
//	 	 $('#addemployee').submit(function(){
//	          var multipleoptions = $('#project > option:selected');
//	          if(multipleoptions.length == 0){
//	              alert('no value selected');
//	              return false;
//	          }
//	    });
		var options = {
		 		target : '#response', 
		 		beforeSubmit : showAddRequest,
		 		success :  showAddResponse,
		 		url : '${baseUrl}/webapi/employee/save2',
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
	        window.location.href = "${baseUrl}/builder/admin/employeeslist.jsp";
	  	}
	}
	
  </script>