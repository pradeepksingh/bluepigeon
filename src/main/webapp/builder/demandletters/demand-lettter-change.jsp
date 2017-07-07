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
 	List<BuilderProject> builderProjects = new ProjectLeadDAO().getProjectList();
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
 	if(builderProjects.size()>0)
    	project_size = builderProjects.size();
 	if(builderPropertyTypes.size()>0)
 		type_size = builderPropertyTypes.size();
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
    <link rel="icon" type="image/png" sizes="16x16" href="plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <link href="../plugins/bower_components/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="../cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
  
  <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
   <script src="../js/jquery.form.js"></script>
  <script src="../js/bootstrapValidator.min.js"></script>
   <script src="../js/bootstrap-datepicker.min.js"></script>
	   <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
   
    
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
     </div>
    
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Change Demand Letter Status</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
             
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                               <div id="vimessages" class="tab-pane active" aria-expanded="false">
                                <div class="col-12">
                               <form id="adddemandletter" name="adddemandletter" action="" method="post" enctype="multipart/form-data">
                                  <input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id); %>" />
                                 <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Project</label>
                                    <div class="col-3">
                                        <select name="project_id" id="project_id" class="form-control">
						                 	   	<option value="0">Select Project</option>
						                  	   	<% for(int i=0; i < project_size ; i++){ %>
												<option value="<% out.print(builderProjects.get(i).getId());%>"><% out.print(builderProjects.get(i).getName());%></option>
											  	<% } %>
								       	  	</select>
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Building</label>
                                    <div class="col-3">
                                          <select name="building_id" id="building_id" class="form-control">
						                 	   	<option value="0">Select Building</option>
								       	  	</select>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                 <label for="example-search-input" class="col-3 col-form-label">Flat</label>
                                    <div class="col-3">
                                       <select name="flat_id" id="flat_id" class="form-control">
						                 	   	<option value="0">Select Flat</option>
								       	  	</select>
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Buyer Name*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" value="" id="buyer_name" name="buyer_name">
                                    </div>
                                                                  </div>
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Buyer Pan Card*</label>
                                    <div class="col-3">
                                          <input class="form-control" type="text" value="" id="pan_card" name="pan_card">
                                    </div>
                                     <label for="example-tel-input" class="col-3 col-form-label">Buyer Contact</label>
                                    <div class="col-3">
                                      <input class="form-control" type="text" value="" id="buyer_contact" name="buyer_contact" >
                                    </div>
                                   
                                </div>
                                
                                 <div class="form-group row">
                                     <label for="example-text-input" class="col-3 col-form-label">Demand Name</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" value="" id="demand_name" name="demand_name">
                                         
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Amount</label>
                                    <div class="col-3">
                                    	 <input class="form-control" type="text" value="" id="amount" name="amount">
                                    </div>
                                  
                                </div>

                                <div class="form-group row">
                                     <label for="example-tel-input" class="col-3 col-form-label">Payment Status</label>
                                    <div class="col-3">
                                         <select class="form-control" id="payment_status" name="payment_status">
										  <option value="">Select</option>
										  <option value="1">Pending</option>
										  <option value="2">Completed</option>
										</select>
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Payment Method</label>
                                    <div class="col-3">
                                        <select class="form-control" id="payment_method" name="payment_method">
										  <option value="">Select</option>
										  <option value="1">CHEQUE</option>
										  <option value="2">CASH</option>
										  <option value="3">DD</option>
										  <option value="4">NEFT</option>
										  <option value="5">IMPS</option>
										  <option value="6">RTGS</option>
										</select>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Transaction Reference Id</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" value="" id="trans_refid" name="trans_refid">
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Payment Date</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" value="" id="last_date" name="last_date">
                                    </div>
                                </div>
                                
                                 <div class="form-group row">                        
	                                 <div class="col-4">
	                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10" style="float: right;">Update</button>
	                                 </div>
	                                  <div class="col-4">
	                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10" style="float: right;">Save</button>
	                                 </div>
                                 </div>
                                
                               </form>
                               </div>
                              </div>
                              
                                
                        </div>

                        </div>
                    </div>
                </div>
                
                
                <!-- /.row -->
                <!-- .row -->
               
                <!-- /.row -->
                <!-- .row -->
                
                <!-- .right-sidebar -->
                <!-- /.right-sidebar -->
            </div>
            <div id="sidebar1"> 
	      		<%@include file="../partial/footer.jsp"%>
			</div> 
        <!-- /#page-wrapper -->
    
    <!-- /#wrapper -->
    
</body>
</html>
<script type="text/javascript">
$('#last_date').datepicker({
	format: "dd MM yyyy"
});

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

$("#flat_id").change(function(){
	$.get("${baseUrl}/webapi/cancellation/buyer/"+$("#flat_id").val(),{ }, function(data){
// 		alert(data.name);
// 		alert(data.mobile);
// 		alert(data.pancard);
		$("#buyer_name").val(data.name);
		$("#buyer_contact").val(data.mobile);
		$("#pan_card").val(data.pancard);
		
	},'json');
});
						
				
$('#adddemandletter').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
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
        
        project_id: {
            validators: {
                notEmpty: {
                    message: 'Project is required and cannot be empty'
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
        demand_name: {
            validators: {
                notEmpty: {
                    message: 'Demand name is required and cannot be empty'
                }
            }
        },
        amount: {
            validators: {
                notEmpty: {
                    message: 'Amount is required and cannot be empty'
                }
            }
        },
       payment_method : {
            validators: {
                notEmpty: {
                    message: 'Payment method is required and cannot be empty'
                }
            }
        },
        trans_refid: {
            validators: {
                notEmpty: {
                    message: 'Transaction referance id is required and cannot be empty'
                }
            }
        },
        last_date: {
            validators: {
                notEmpty: {
                    message: 'Payment date is required and cannot be empty'
                }
            }
        }
        
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addDemandletter();
});

function addDemandletter() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/demand/save1',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#adddemandletter').ajaxSubmit(options);
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
       // alert(resp.message);
        window.location.href = "${baseUrl}/builder/demandletters/list.jsp";
  	}
}
</script>