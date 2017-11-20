<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.model.Campaign"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.NewLeadList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
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
	int city_size = 0;
	int projectId = 0;
	int emp_id =0 ;
	int access_id = 0;
 	List<BuilderEmployee> salesmanList = null;
 	List<Source> sourceList = null;
 	BuilderProject builderProject = null;
 	List<NewLeadList> newLeadLists = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	List<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos =null;
   	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			emp_id = builder.getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			if(builder_id > 0 && access_id ==5){
				sourceList = new ProjectDAO().getAllSourcesByBuilderId(builder_id);
				salesmanList = new BuilderDetailsDAO().getBuilderSalesman(builder);
				if (request.getParameterMap().containsKey("project_id")) {
					projectId = Integer.parseInt(request.getParameter("project_id")); 
					builderProject = new ProjectDAO().getBuilderActiveProjectById(projectId);
				 	builderProjectPropertyConfigurationInfos = new ProjectDAO().getPropertyConfigByProjectId(projectId);
				 	newLeadLists = new ProjectDAO().getNewLeadList(projectId,builder);
				 	if(builderPropertyTypes != null){
					 	if(builderPropertyTypes.size()>0)
					 		type_size = builderPropertyTypes.size();
					}
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
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
     <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="../../css/jquery.multiselect.css" />
    <!-- Menu CSS -->

    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
 <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <!-- Custom CSS -->

    <link href="../../css/style.css" rel="stylesheet">

    <!-- color CSS -->

    <link rel="stylesheet" type="text/css" href="../../css/salemanaddleadpopup.css">
    
<!--       <link rel="stylesheet" type="text/css" href="../css/Salesman_leads.css"> -->

    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />

    <!-- jQuery -->

    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../../js/jquery.multiselect.js"></script>
     <script src="../../js/jquery.form.js"></script>
      <script type="text/javascript" src="../../js/selectize.min.js"></script>
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
		</script>
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
         <%@include file="../../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1">
        <%@include file="../../partial/sidebar.jsp"%>
         </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">BOOKING</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">CANCELLATION</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads" class="btn11 btn-lead waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">CAMPAIGN</button>
		                </div>
	                </div>
               <!-- row -->
                   <div class="row">
                      <div class="col-md-8 col-sm-6 col-xs-12">
                         <div class="navbar-form lead-search" role="search">
                          <input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
						    <div class="input-group add-on">
						      <input class="form-control" placeholder="Search" name="srchlead" id="srchlead" type="text">
						      <div class="input-group-btn">
						        <button id="searchleads" class="btn btn-default" type="button"><img src="../../images/search.png"/></button>
						      </div>
						    </div>
					     </div>
                       </div>
                       <%if(access_id == 7){ %>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="submit" class="btn11 btn-lead waves-effect waves-light m-t-10" data-toggle="modal" data-target="#myModal1">New Lead +</button>
                      </div>
                      <%} %>
                      <%if(access_id == 5){ %>
                      <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 lead-button">
                         <button type="button"  id="addnewleadbtn" class="btn11 btn-lead waves-effect waves-light m-t-10" >New Lead +</button>
                      </div>
                      <%} %>
                 </div>
                 <div class="white-box">
                   <div class="lead-bg">
                   <!-- buyer information end -->
	                 <div class="row blue-border">
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Name</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Phone no.</h2>
	                   </div>
	                   <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h2>Email Id</h2>
	                   </div>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Source</h2>
	                   </div>
	                   <%if(access_id == 7){ %>
	                   <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Status</h2>
	                   </div>
	                   <%} %>
	                   <%if(access_id == 5){ %>
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h2>Assign Salesman</h2>
	                   </div>
	                   <%} %>
	                 </div>
	                 <div id="newleads">
	                 <%
	                 if(newLeadLists != null && newLeadLists.size() > 0){
	                 for(NewLeadList newLeadList : newLeadLists){ %>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getLeadName()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getPhoneNo()); %></h4>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getEmail()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getSource()); %></h4>
	                    </div>
	                    <%if(access_id == 7){ %>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="javascript:changeLeadStatus(1,<%out.print(newLeadList.getId());%>)">No Response</a></li>
						      <li><a href="javascript:changeLeadStatus(2,<%out.print(newLeadList.getId());%>)">Call Again</a></li>
						      <li><a href="javascript:changeLeadStatus(3,<%out.print(newLeadList.getId());%>)">Email Sent</a></li>
						      <li><a href="javascript:changeLeadStatus(4,<%out.print(newLeadList.getId());%>)">Visit Again</a></li>
						      <li><a href="javascript:changeLeadStatus(5,<%out.print(newLeadList.getId());%>)">Visit Complete</a></li>
						      <li><a href="javascript:changeLeadStatus(6,<%out.print(newLeadList.getId());%>)">Follow up</a></li>
						      <li><a href="javascript:changeLeadStatus(7,<%out.print(newLeadList.getId());%>)">Booked</a></li>
						      <li><a href="javascript:changeLeadStatus(8,<%out.print(newLeadList.getId());%>)">Not interested</a></li>
						    </ul>
						  </div>
	                    </div>
	                    <%} %>
	                    <% if(access_id == 5){%>
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						  		<select id="select_salesman" class="select_salesman" name="select_salesman" data-style="form-control">
							   <% if(salesmanList != null ){
	                    		for(BuilderEmployee salesman : salesmanList){%>
							        <option value="<%out.print(salesman.getId());%>"><%out.print(salesman.getName()); %></option>
							    <% }}%>
							  	</select>
						  </div>
	                    </div>
	                    <%} %>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                     <img src="../../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline laststatusnam">
	                      <h5>Last States: <b id="laststatusname<%out.print(newLeadList.getId());%>"><%
	                      if(newLeadList.getLeadStatus() == 1)
	                      	out.print("No Response");
	                      if(newLeadList.getLeadStatus() == 2)
	                    	  out.print("Call Again");
	                      if(newLeadList.getLeadStatus() == 3)
	                    	  out.print("Email Sent");
	                      if(newLeadList.getLeadStatus() == 4)
	                    	  out.print("Visit Schedule");
	                      if(newLeadList.getLeadStatus() == 5)
	                    	  out.print("Visit Complete");
	                      if(newLeadList.getLeadStatus() == 6)
	                    	  out.print("Follow Up");
	                      if(newLeadList.getLeadStatus() == 7)
	                    	  out.print("Booked");
	                      if(newLeadList.getLeadStatus() == 8)
	                    	  out.print("Not Interested");
	                      %></b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                     <h6><%out.print(newLeadList.getSalesheadName()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6> <% if(newLeadList.getMin()>0 && newLeadList.getMax()==0 ){
	                    	 out.print("Greater than Rs"+newLeadList.getMin()+" Lakh");
	                     }else if(newLeadList.getMin() == 0 && newLeadList.getMax() >0){
	                    	 out.print("upto Rs"+newLeadList.getMax()+ "Lakh");
	                     }else{                    
		                     out.print("Rs "+newLeadList.getMin());%> -<%out.print(newLeadList.getMax()+" Lakh");
	                     } %> </h6>
	                    </div>
	                     <div class="col-md-3 col-sm-2 col-xs-6 inline">
	                      <h6>
	                      <%out.print(newLeadList.getConfigName());
	                      %>
	                      </h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6><%out.print(newLeadList.getSource()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b><% if(newLeadList.getStrDate() != null){ out.print(newLeadList.getStrDate());} %></b></h6>
	                    </div>
	                 </div>
	               </div>
	               <%} }%>
	            </div>
	               <!-- buyer information end -->
                </div>
			</div>
		</div>
	</div>
        <!-- Modal -->
		
    </div>
    <!-- /.container-fluid -->
   <div id="sidebar1"> 
       	 <%@include file="../../partial/footer.jsp"%>
    </div>
  </body>
</html>
<script>
$("#booking").click(function(){
	ajaxindicatorstart("Loading...");
	 window.location.href="${baseUrl}/builder/saleshead/booking/salesman_bookingOpenForm.jsp?project_id="+$("#project_id").val();
});
$("#cancellation").click(function(){
	ajaxindicatorstart("Loading...");
	 window.location.href="${baseUrl}/builder/saleshead/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(projectId);%>
});
$("#campaign").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/saleshead/campaign/Salesman_campaign.jsp?project_id="+<%out.print(projectId);%>
});



$('#configuration').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true
});
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
        select_source:{
        	validators: {
            	notEmpty: {
                    message: 'The source is required and cannot be empty'
                }
        	}
        },
        'configuration[]':{
        	validators: {
            	notEmpty: {
                    message: 'The configurations are required and cannot be empty'
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
	 		url : '${baseUrl}/webapi/project/lead/new1',
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
        window.location.href = "${baseUrl}/builder/saleshead/leads/Salesman_leads.jsp?project_id="+$("#project_id").val();
        ajaxindicatorstop();
  	}
}
<%if(access_id == 7){%>
function changeLeadStatus(value,id){
	ajaxindicatorstart("Loading...");
	$("#laststatusname"+id).val('');
	$.post("${baseUrl}/webapi/builder/changeleadAuthority",{value:value,id:id},function(data){
		if(data != ""){
			if(data.status==1){
				alert(data.message);
				if(data.data.value == 1){  
					 $("#laststatusname"+data.id).html("No Response");
				}
				if(data.data.value == 2){ 
					
					$("#laststatusname"+data.id).html("Call Again");
				}
				if(data.data.value == 3){ 
					$("#laststatusname"+data.id).html("Email Sent");
				}
				if(data.data.value == 4){
					$("#laststatusname"+data.id).html("Visit Schedule");
				}
				if(data.data.value == 5){
					$("#laststatusname"+data.id).html("Visit Complete");
					
				}
				if(data.data.value == 6){ 
					$("#laststatusname"+data.id).html("Follow up");
				}
				
				if(data.data.value == 7){
					$("#laststatusname"+data.id).html("Booked");
				}
				if(data.data.value == 8){
					$("#laststatusname"+data.id).html("Not Interested");
				}
				else{ 
					$("#leadstatusname"+data.id).html("");
				}
						
			}
		}
		//}
		 ajaxindicatorstop();
		
	});
}
<%}%>
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
<%if(access_id == 5){%>
$("#addnewleadbtn").click(function(){
	openAddLead(<%out.print(projectId);%>);
});
function openAddLead(id){
	window.location.href="${baseUrl}/builder/saleshead/leads/Saleshead_add_lead.jsp?project_id="+<%out.print(projectId);%>
}
<%}%>
function toggleDropDown() {
  if (validateDropDownInputs() &&
    parseInt(min_input.val()) > 0 &&
    parseInt(max_input.val()) > 0) {
    // auto close if two values are valid
    dropDownControl.dropdown('toggle');
  }
}
}
$("#srchlead").keydown(function (e) {
	if (e.keyCode == 13) {
		searchLeads();
	}
});
setuinvestRangeDropDownList(
$('.investRange .min_value'),
$('.investRange .max_value'),
$('.investRange .freeformPrice .min_input'),
$('.investRange .freeformPrice .max_input'),
$('.investRange .btnClear'),
$('.investRange .dropdown-toggle'));
$("#searchleads").click(function(){
	searchLeads();
});
function searchLeads(){
	$("#newleads").empty();
	ajaxindicatorstart("Please wait while.. we search ...");
    $.get("${baseUrl}/builder/saleshead/leads/Salesman_partialeads.jsp?project_id=<%out.print(projectId);%>&emp_id=<%out.print(emp_id);%>&keyword="+$('#srchlead').val(),{},function(data) {
    	$("#newleads").html(data);
    	ajaxindicatorstop();
    },'html');
}
</script>