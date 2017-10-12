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
 	List<BuilderEmployee> saleheadList = null;
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
				if(access_id == 4 || access_id==1){
					saleheadList = new BuilderDetailsDAO().getBuilderSaleshead(builder);
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
		<style>
		.arrow{
color: #ccc;
    background-color: #ccc;
    display: inline-block;
    height: 1px;
    width: 12px;
    position: relative;
   
}     
.max_value{
    padding: 6px 6px 6px 12px;
}
            .price_Ranges {
                float: right;
                width: 50%;
            }
            .price_Ranges a {
                display: block;
                text-align: left;
                padding: 6px 0 6px 0;  
                color: #6f6e6e;
                font-weight: 500;
            }
            .price_Ranges a.max_value {
                padding-right: 12px;
                padding-left: 12px;
               margin-left: 30px;
            }
            .price_Ranges a.min_value {
                padding-right: 22px;
                    padding-left: 12px;
            }
            .price_Ranges a.disabled {
                pointer-events: none;
                cursor: default;
                color: #E5E4E2;
            }
            .price_Ranges a:hover {
               background: #00bfd6;
               color: #fff;
               cursor: pointer; 
    text-decoration: none;
            }
            .btnClear {
                clear: both;
                border-top: 1px solid #dadada;
                padding: 5px 0 0 0;
                text-align: center;
            }
            input.inputError,
            input.inputError:focus {
                border-color: #e2231a;
                background-color: white;
                color: #e2231a;
                box-shadow: inset 0 0 5px #F7BDBB;
                border-radius: 0;
            }
            .ms-options-wrap > .ms-options > ul li.selected label, .ms-options-wrap > .ms-options > ul label:hover {
    background-color: #00bfd6;
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

							<div class="span2 investRange">
								<label for="example-search-input" class="col-5 col-form-label">Budget</label>
							    <div class="btn-group">
							
							      <button id="min-max-price-range" class="form-control selectpicker select-btn  dropdown-toggle searchParams" href="#" data-toggle="dropdown" tabindex="6">
							        <div class="filter-option pull-left span_price">
							          <span id="price_range1"> </span> - <span id="price_range2">Price Range</span> </div>
							        <span class="bs-caret" style="float: right;"><span class="caret"></span></span>
							      </button>
							
							      <div class="dropdown-menu ddRange" role="menu" style="width: 295px;padding-top: 12px;">
							        <div class="rangemenu">
							          <div class="freeformPrice">
							            <div class="col-md-5">
							              <input name="minprice" id="minprice" type="text" class="min_input form-control" placeholder="Min Price">
							            </div>
							            <div class="col-md-2 "><span class="arrow"></span></div>
							            <div class="col-md-5">
							              <input name="maxprice" id="maxprice" type="text" class="max_input form-control" placeholder="Max Price">
							            </div>
							          </div>
							
							          <div class="price_Ranges rangesMax col-md-5">
							            <a class="max_value" value="" href="javascript:void(0)">Any Max</a>
							            <a class="max_value" value="1000000" href="javascript:void(0)">10 lakhs</a>
							            <a class="max_value" value="2500000" href="javascript:void(0)">25 lakhs</a>
							            <a class="max_value" value="5000000" href="javascript:void(0)">50 lakhs</a>
							            <a class="max_value" value="10000000" href="javascript:void(0)">1 cr</a>
							            <a class="max_value" value="50000000" href="javascript:void(0)">5 cr</a>
							            <a class="max_value" value="100000000" href="javascript:void(0)">10 cr</a>
							            <a class="max_value" value="500000000" href="javascript:void(0)">50 cr</a>
							            <a class="max_value" value="1000000000" href="javascript:void(0)">100 cr</a>
							            <a class="max_value" value="2000000000" href="javascript:void(0)">200 cr</a>
							            <a class="max_value" value="5000000000" href="javascript:void(0)">500 cr</a>
							          </div>
							          <div class="col-md-2"> </div>
							          <div class="price_Ranges rangesMin col-md-5">
							            <a class="min_value" value="" href="javascript:void(0)">Any Min</a>
							            <a class="min_value" value="1000000" href="javascript:void(0)">10 lakhs</a>
							            <a class="min_value" value="2500000" href="javascript:void(0)">25 lakhs</a>
							            <a class="min_value" value="5000000" href="javascript:void(0)">50 lakhs</a>
							            <a class="min_value" value="10000000" href="javascript:void(0)">1 cr</a>
							            <a class="min_value" value="50000000" href="javascript:void(0)">5 cr</a>
							            <a class="min_value" value="100000000" href="javascript:void(0)">10 cr</a>
							            <a class="min_value" value="500000000" href="javascript:void(0)">50 cr</a>
							            <a class="min_value" value="1000000000" href="javascript:void(0)">100 cr</a>
							            <a class="min_value" value="2000000000" href="javascript:void(0)">200 cr</a>
							            <a class="min_value" value="5000000000" href="javascript:void(0)">500 cr</a>
							          </div>
							        </div>
							        <div class="btnClear">
							          <a href="javascript:void(0)" class="btn btn-link">Clear</a>
							        </div>
							      </div>
							    </div>
							  </div>
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
        </div>
    <!-- /.container-fluid -->
   <div id="sidebar1"> 
       	   		<%@include file="../partial/footer.jsp"%>
      		</div>
  </body>
</html>
<script>
$('#configuration').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true,
    //noneSelectedText: "Select",
    
}); 
$('#project_ids').multiselect({
    columns: 1,
    placeholder: 'Select Project',
    search: true,
    selectAll: true
});
$('#min-max-price-range').click(function (event) {
   // setTimeout(function(){ $('.price-label').first().focus();	},0);    
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
	event.preventDefault();
	addLead();
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
        window.location.href = "${baseUrl}/builder/leads/leadlist.jsp";
        ajaxindicatorstop();
  	}
}
$("#project_ids").change(function(){
		var htmlconfig = "";
		ajaxindicatorstart("Loading...");
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
		  ajaxindicatorstop();
	  });
});
$('.dropdown-menu.ddRange')
.click(function(e) {
  e.stopPropagation();
});
function disableDropDownRangeOptions(max_values, minValue) {
if (max_values) {
  max_values.each(function() {
    var maxValue = $(this).attr("value");
    if (parseInt(maxValue) < parseInt(minValue)) {
      $(this).addClass('disabled');
    } else {
      $(this).removeClass('disabled');
    }
  });
}
}
function setuinvestRangeDropDownList(min_values, max_values, min_input, max_input, clearLink, dropDownControl) {
min_values.click(function() {
  var minValue = $(this).attr('value');
  min_input.val(minValue);
  document.getElementById('price_range1').innerHTML = minValue;
  disableDropDownRangeOptions(max_values, minValue);
  validateDropDownInputs();
});
max_values.click(function() {
  var maxValue = $(this).attr('value');
  max_input.val(maxValue);
  document.getElementById('price_range2').innerHTML = maxValue;
  toggleDropDown();
});
clearLink.click(function() {
  min_input.val('');
  max_input.val('');
  disableDropDownRangeOptions(max_values);
  validateDropDownInputs();
});
min_input.on('input',
  function() {
    var minValue = min_input.val();
    disableDropDownRangeOptions(max_values, minValue);
    validateDropDownInputs();
  });
max_input.on('input', validateDropDownInputs);
max_input.blur('input',
  function() {
    toggleDropDown();
  });
function validateDropDownInputs() {
  var minValue = parseInt(min_input.val());
  var maxValue = parseInt(max_input.val());
  if (maxValue > 0 && minValue > 0 && maxValue < minValue) {
    min_input.addClass('inputError');
    max_input.addClass('inputError');
    return false;
  } else {
    min_input.removeClass('inputError');
    max_input.removeClass('inputError');
    return true;
  }
}
function toggleDropDown() {
  if (validateDropDownInputs() &&
    parseInt(min_input.val()) > 0 &&
    parseInt(max_input.val()) > 0) {
    // auto close if two values are valid
    dropDownControl.dropdown('toggle');
  }
}
}
setuinvestRangeDropDownList(
$('.investRange .min_value'),
$('.investRange .max_value'),
$('.investRange .freeformPrice .min_input'),
$('.investRange .freeformPrice .max_input'),
$('.investRange .btnClear'),
$('.investRange .dropdown-toggle'));
</script>