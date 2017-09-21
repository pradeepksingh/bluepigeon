<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.Source"%>
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
	int access_id =0;
	int city_size = 0;
	int emp_id =0 ;
 	List<ProjectData> builderProjects =null;
 	List<Source> sourceList = null;
 	List<BuilderEmployee> salesmanList = null;
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
			access_id = builder.getBuilderEmployeeAccessType().getId();
			emp_id = builder.getId();
			if(builder_id > 0){
				builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
				sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
				if(access_id ==5){
					salesmanList = new BuilderDetailsDAO().getBuilderSalesman(builder);
				}
			}
			if(builderProjects.size()>0)
		    	project_size = builderProjects.size();
		 	if(builderPropertyTypes.size()>0)
		 		type_size = builderPropertyTypes.size();
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
    <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/salemanaddlead.css">
   
      <link rel="stylesheet" type="text/css" href="../css/jquery.multiselect.css" />
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/jquery.form.js"></script>
      <script type="text/javascript" src="../js/selectize.min.js"></script>
       <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
  
        
		<script type="text/javascript">
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-2').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-3').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-4').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-5').multiselect();
// 		    });
// 		    $select_project = $("#multiple-checkboxes-3").selectize({
// 		    	persist: false,
// 		    	 onChange: function(value) {
// 		    		alert(value);
// 		    	 },
// 		    	 onDropdownOpen: function(value){
// 		        	 var obj = $(this);
// 		    		var textClear =	 $("#multiple-checkboxes-3 :selected").text();
// 		        	 if(textClear.trim() == "Enter Project Name"){
// 		        		 obj[0].setValue("");
// 		        	 }
// 		         }
// 		    });

		    //select_project = $select_project[0].selectize;
		    
		   
		</script>
		<script type="text/javascript">
// 		$("#select").click(function(){
// 		    $("li").addClass("active");
// 		});
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
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        	<%@include file="../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
       <div class="container">
               <div class="container-fluid addlead">
               <!-- /.row -->
	            <h1>Add Lead</h1>
               <!-- row -->
               <div class="white-box">
                 <div class="row bg11">
                   <form class="addlead1" id="addnewlead" name="addnewlead" action="" method="post"  enctype="multipart/form-data">
                  		<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
                     <div class="col-md-6 col-sm-6 col-xs-12">
                         <div class="form-group row">
							<label for="example-text-input" class="col-5 col-form-label">Name</label>
							  <div class="col-7">
							  		<div>
								 		<input class="form-control" type="text" id="leadname" name="leadname"  placeholder="Please enter name">
								 	</div>
								  	<div class="messageContainer"></div>
							  </div>
						  </div>
						  <div class="form-group row">
							 <label for="example-search-input" class="col-5 col-form-label">Email ID</label>
								<div class="col-7">
									<div>
								   		<input class="form-control" type="text" id="email" name="email" placeholder="Please enter email id">
								    </div>
								    <div class="messageContainer"></div>
							    </div>
						 </div>
							<div class="form-group row">
							   <label for="example-search-input" class="col-5 col-form-label">Configuration</label>
								  <div class="col-7">
								  		<div>
								      		<select id="configuration" name="configuration[]" multiple>	</select>
								     	</div>
								      	<div class="messageContainer"></div>
								  </div>
							 </div>
                            <div class="form-group row">
					           <label for="example-tel-input" class="col-5 col-form-label">Source</label>
						        <div class="col-7">
						         	<div>
							        <select id="source_id" name="source_id" >
							        <%
							        if(sourceList != null){
							        	for(Source source: sourceList){ %>
			                          	<option value="<%out.print(source.getId());%>"><%out.print(source.getName()); %></option>
			                        <%}}%>
			                        </select>
			                        </div>
			                        <div class="messageContainer"></div>
							    </div>
						    </div>
						    
				       </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                       <div class="form-group row">
							<label for="example-text-input" class="col-5 col-form-label">Phone No.</label>
							  <div class="col-7">
							  	<div>
								 	<input class="form-control" type="text" id="mobile" name="mobile" placeholder="Please enter mobile number">
							  	</div>
							  	<div class="messageContainer"></div>
							 </div>
					  </div>
					 <div class="form-group row">
							 <label for="example-search-input" class="col-5 col-form-label">Interested Project</label>
								<div class="col-7">
									<div>
								   		<select id="project_ids" name="project_ids[]" multiple>
									    <%if(builderProjects != null){
								    	  for(ProjectData projectData : builderProjects){%>
								      		<option value="<%out.print(projectData.getId());%>"><%out.print(projectData.getName()); %></option>
								      	 <%}} %>
									     </select>
								     </div>
								 </div>
						    </div>
							<div class="form-group row">
							    <label for="example-search-input" class="col-sm-5 col-form-label">Budget</label>
									 <button id="min-max-price-range" class="dropdown-toggle" href="#" data-toggle="dropdown">Budget<strong class="caret"></strong></button>
								      <div class="dropdown-menu col-sm-7" style="padding:10px;">
								            <div class="row">
								                <div class="col-xs-3">
								                    <input class="form-control price-label" placeholder="Min" id="minprice" name="minprice" data-dropdown-id="pricemin"/>
								                </div>
								                <div class="col-xs-2"> - </div>
								                <div class="col-xs-3">
								                    <input class="form-control price-label" placeholder="Max"id="maxprice" name="maxprice" data-dropdown-id="pricemax"/>
								                </div>
												<div class="clearfix"></div>
								                <ul id="pricemin" class="col-sm-12 price-range list-unstyled">
								                    <li  data-value="0">0</li>
								                    <li data-value="10">10</li>
								                    <li  data-value="20">20</li>
								                    <li  data-value="30">30</li>
								                    <li  data-value="40">40</li>
								                    <li  data-value="50">50</li>
								                    <li  data-value="60">60</li>
								                </ul>
								                <ul id="pricemax" class="col-sm-12 price-range text-right list-unstyled hide">
								                    <li  data-value="0">0</li>
								                    <li  data-value="10">10</li>
								                    <li  data-value="20">20</li>
								                    <li  data-value="30">30</li>
								                    <li  data-value="40">40</li>
								                    <li  data-value="50">50</li>
								                    <li  data-value="60">60</li>
								                </ul>
								            </div>
								     </div>
							 </div>
							 <%if(access_id ==5){ %>
							 
							 <div class="form-group row">
							 <label for="example-search-input" class="col-5 col-form-label">Assign Salesman</label>
								<div class="col-7">
									<div>
								   		<select id="assignsalemans" name="assignsalemans[]" multiple>
									    <%if(salesmanList != null){
								    	  for(BuilderEmployee  builderEmployee: salesmanList){%>
								      		<option value="<%out.print(builderEmployee.getId());%>"><%out.print(builderEmployee.getName()); %></option>
								      	 <%}} %>
									     </select>
								     </div>
								 </div>
						    </div>
						    <%} %>
						</div>
						<div class="center bcenter">
					  	   <button type="submit" id="save" class="button1">Save</button>
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
<script>
//$("#multiple-checkboxes-3").selectize();
// $select_project = $("#multiple-checkboxes-3").selectize({
// 	persist: false,
// 	 onChange: function(value) {
// 		alert(value);
// 	 },
// 	 onDropdownOpen: function(value){
//     	 var obj = $(this);
// 		var textClear =	 $("#multiple-checkboxes-3 :selected").text();
//     	 if(textClear.trim() == "Enter Configuration Name"){
//     		 obj[0].setValue("");
//     	 }
//      }
// });

$('#configuration').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true,
    //noneSelectedText: "Select",
    
}); 
//$('#multiple-checkboxes-3').style.margin-left="5px";
//$('#multiple-checkboxes-3').css({"padding-left":"10px !important"});

$('#project_ids').multiselect({
    columns: 1,
    placeholder: 'Select Project',
    search: true,
    selectAll: true
});


$('#assignsalemans').multiselect({
    columns: 1,
    placeholder: 'Select salesman',
    search: true,
    selectAll: true
});
//$("#save").click(function(){
// 	var projects = [];
// 	var  projectList = document.getElementById("#multiple-checkboxes-2");
	
// 	for(var i=0;i<projectList.options.length;i++){
// 		if(projectList[i].options[i].selected){
// 			alert("Value :: "+projectList[i].options[i].value);
// 			projects.push(projectList[i].options[i].value);
// 		}
// 	}
 // alert($("#multiple-checkboxes-2").val());
//   $("#multiple-checkboxes-2  option:selected").each(function(){
// 	  alert($(this).val());
//   })
//})

// $('#min-max-price-range').click(function (event) {
//     setTimeout(function(){ $('.price-label').first().focus();	},0);    
// });
// var priceLabelObj;
// $('.price-label').focus(function (event) {
//     priceLabelObj=$(this);
//     $('.price-range').addClass('hide');
//     $('#'+$(this).data('dropdownId')).removeClass('hide');
// });
// $(".price-range li").click(function(){    
//     priceLabelObj.attr('value', $(this).attr('data-value'));
//     var curElmIndex=$( ".price-label" ).index( priceLabelObj );
//     var nextElm=$( ".price-label" ).eq(curElmIndex+1);

//     if(nextElm.length){
//         $( ".price-label" ).eq(curElmIndex+1).focus();
//     }else{
//         $('#min-max-price-range').dropdown('toggle');
//     }
// });

$('#min-max-price-range').click(function (event) {
    setTimeout(function(){ $('.price-label').first().focus();	},0);    
});
var priceLabelObj;
$('.price-label').focus(function (event) {
    priceLabelObj=$(this);
    $('.price-range').addClass('hide');
    $('#'+$(this).data('dropdownId')).removeClass('hide');
});

$(".price-range li").click(function(){    
    priceLabelObj.attr('value', $(this).attr('data-value'));
    var curElmIndex=$( ".price-label" ).index( priceLabelObj );
    var nextElm=$( ".price-label" ).eq(curElmIndex+1);

    if(nextElm.length){
        $( ".price-label" ).eq(curElmIndex+1).focus();
    }else{
        $('#min-max-price-range').dropdown('toggle');
    }
});


$select_scorce = $("#source_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#select_id").val() > 0 || $("#source_id").val() != '' ){
			
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#source_id :selected").text();
    	 if(textClear.trim() == "Enter Source Name"){
    		 obj[0].setValue("0");
    	 }
     }
});
select_scorce = $select_scorce[0].selectize;

$('#addnewlead').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	leadname: {
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
//         project_id: {
//             validators: {
//                 notEmpty: {
//                     message: 'Project is required and cannot be empty'
//                 }
//             }
//         },
//         city: {
//             validators: {
//                 notEmpty: {
//                     message: 'City Name is required and cannot be empty'
//                 }
//             }
//         },
//         area: {
//             validators: {
//                 notEmpty: {
//                     message: 'Locality Name is required and cannot be empty'
//                 }
//             }
//         },
        pricemin:{
            validators: {
                notEmpty: {
                    message: 'min price is required and cannot be empty'
                }
            }
        } ,
        pricemax:{
            validators: {
                notEmpty: {
                    message: 'max price is required and cannot be empty'
                }
            }
        } 
    }
    
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	//alert("success...Find solution on google..");
	event.preventDefault();
	addLead();
}).on('error.form.bv',function(event,data){
	//alert("error...Find solution on google..");
});

function addLead() {
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/lead/addnew1',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addnewlead').ajaxSubmit(options);
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
		 ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
      //  window.location.href = "${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+$("#project_id").val();
        ajaxindicatorstop();
  	}
}

$("#project_ids").change(function(){
		var htmlconfig = "";
	  $.get("${baseUrl}/webapi/project/configdata",{project_ids:$(this).val()},function(data){
		  $(data).each(function(index){
			  htmlconfig=htmlconfig+'<option value="'+data[index].id+'">'+data[index].name+'</option>';
		  });
		  $("#configuration").multiselect({
			    columns: 1,
			    placeholder: 'Select Configuration',
			    search: true,
			    selectAll: true,
			});
		  $("#configuration").html(htmlconfig);
		  $("#configuration").multiselect('reload');
	  },'json');
});
</script>
