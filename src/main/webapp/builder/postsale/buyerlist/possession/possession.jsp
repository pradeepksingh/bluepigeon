<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.data.InboxBuyerData"%>
<%@page import="java.util.Date"%>
<%@page import="org.bluepigeon.admin.data.InboxMessageData"%>
<%@page import="org.bluepigeon.admin.model.BuyerUploadDocuments"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<ProjectData> project_list = null;
	int builder_id = 0;
	int flat_id=0;
	List<Buyer> buyers = new ArrayList<Buyer>();
	List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
	List<InboxMessageData> inboxMessageList = null;
	int empId=0;
 	Date date = new Date();
 	List<InboxBuyerData> buyerData = null;
 	List<BuyerPayment> buyerPayments = new ArrayList<BuyerPayment>();
 	int primary_buyer_id=0;
 	String buyerName = null;
 	int access_id=0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			empId=builder.getId();
			access_id= builder.getBuilderEmployeeAccessType().getId();
			if(builder_id > 0 && access_id==6){
				if (request.getParameterMap().containsKey("flat_id")) {
					flat_id = Integer.parseInt(request.getParameter("flat_id"));
					buyers = new BuyerDAO().getFlatBuyersByFlatId(flat_id);
					project_list = new ProjectDAO().getAssigProjects(empId);
					buyerPayments = new BuyerDAO().getBuyerPaymentsByBuyerId(buyers.get(0).getId());
					inboxMessageList = new ProjectDAO().getBookedBuyerList(empId);
					buyerData = new ProjectDAO().getAllBuyersByBuilderEmployee(builder);
					for(Buyer buyer :buyers) {
						if(buyer.getIsPrimary()) {
							primary_buyer_id = buyer.getId();
							buyerName = buyer.getName();
						}
					}
				}
			}else{
				response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
			}
		}
		
   }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>Postsale_PaymentSataus-schedule</title>

    <!-- Favicon-->
   <link rel="icon" type="image/png" href="../../../plugins/images/favicon.png" sizes="16x16">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

    <!-- Bootstrap Core Css -->
          <link href="../../../css/postsaleDocbootstrap.min.css" rel="stylesheet">
    <link href="../../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../../css/style.css" rel="stylesheet">
    <link href="../../../css/common.css" rel="stylesheet">
      <link href="../../../css/jquery.multiselect.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../../css/postsaledocument.css">
    <link href="../../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
      <link rel="stylesheet" type="text/css" href="../../../css/bootstrap-datetimepicker.min.css" />
       <link rel="stylesheet" type="text/css" href="../../../css/bootstrap-datetimepicker.css" />
    <!-- jQuery -->
    <script src="../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../../../js/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../../../js/selectize.min.js"></script>
     <script src="../../../js/jquery.form.js"></script>
      <script src="../../../js/Moment.js"></script>
    <script src="../../../js/bootstrapValidator.min.js"></script>
     <script src="../../../js/bootstrap-datepicker.min.js"></script>
      <script src="../../../js/bootstrap-datetimepicker.js"></script>
       <script src="../../../js/bootstrap-datetimepicker.min.js"></script>
    <!-- Custom Css -->
    <link href="../../../css/Postsale_Grand_possession.css" rel="stylesheet">
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        <%@include file="../../../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        <%@include file="../../../partial/sidebar.jsp"%>
        </div>
    	<section class="content" style="margin-top:60px;padding-top:10px">
			<div class="container-fluid">
				<div class="row clearfix">
					<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                    	<div class="button-demo">
							<button type="button" id="postsaledocument" class="btn btn-default waves-effect" style="width: 100%; font-size:20px">DOCUMENT</button>
						</div>
                	</div>
                	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                    	<div class="button-demo">
                            <button type="button" id="postsalepaymentstatus" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">PAYMENT STATUS</button>
						</div>
                	</div>
				 	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                    	<div class="button-demo">
                        	<button type="button" id="postsaleprojectstatus" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">PROJECT STATUS</button>
						</div>
                	</div>
				 	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                    	<div class="button-demo">
                        	<button type="button" id="postsalepossession" class="btn btn-success waves-effect" style="width: 100%;font-size:20px">POSSESSION</button>
						</div>
                	</div>
            	</div>
            	<div class="row clearfix" style="background: white;">
                	<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    	<div class="card" style="border: 2px solid #24bcd3;">
                       		<div class="body">
                       			<form action="" method="post" id="buyerpossession" name="buyerpossession"  enctype="multipart/form-data" >
                       			<input type="hidden" id="buyer_id" name="buyer_id" value="<%out.print(primary_buyer_id);%>"/>
                       			<input type="hidden" id="flat_id" name="flat_id" value="<%out.print(flat_id); %>"/>
					    		<div class="row clearfix" >
                            		<div class="col-md-6">
                                    	<div class="input-group input-group-lg">
                                        	<span class="input-group-addon"style="width: 0%;">
                                            	<label for="ig_checkbox">DATE</label>
                                        	</span>
                                       		<div class="form-line">
                                            	<input id="pdate" name="pdate" class="datepicker form-control form-control1" placeholder="Please choose a date..." data-dtp="dtp_oCfuf" type="text">
                                        	</div>
                                    	</div>
                                	</div>
				      				<div class="col-md-6">
                                    	<div class="input-group input-group-lg">
                                        	<span class="input-group-addon" style="width: 0%;">
                                            	<label for="ig_checkbox">TIME</label>
                                        	</span>
                                        	<div class="form-line">
                                             	<input type="text" id="ptime" name="ptime" class="timepicker form-control form-control1" placeholder="Please choose a time...">
											 </div>
                                    	</div>
                                	</div>
								 	<div class="col-md-12">
                                    	<div class="input-group input-group-lg">
                                        	<span class="input-group-addon" style="width: 17%;">
                                            	<label for="ig_checkbox">Upload Document</label>
                                        	</span>
                                        	<div class="form-line">
                                            	<div class="file-upload">
										  			<div class="file-select">
														<div class="file-select-button" id="fileName">Choose File</div>
														<div class="file-select-name" id="noFile">No file chosen...</div> 
														<input type="file" name="possesstionfile[]" id="possessionfile">
										  			</div>
												</div>
                                        	</div>
                                    	</div>
                               	 	</div>
								 	<div class="col-md-12">
                                    	<div class="input-group input-group-lg">
                                        	<span class="input-group-addon" style="width: 17%;">
                                            	<label for="ig_checkbox">Region Of Delay</label>
                                        	</span>
                                        	<div class="form-line">
                                            	<textarea rows="1" class="form-control form-control1 no-resize" id="reason" name="reason" placeholder="reason for delay..." ></textarea>
                                        	</div>
                                    	</div>
										<br/>
										<div class="row clearfix" >
											<div class="col-md-4"></div>
											<div class="col-md-4">
										 		<div class="button-demo">
                                					<button type="submit" class="btn btn-success  waves-effect">submit</button>
                                				</div>
											</div>
                            			</div>
                                	</div>
								</div>
								</form>
							  </div>
							</div>
                 		</div>
						<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                    		<div class="card" style="border: 2px solid #24bcd3;">
                       			<div class="body">
                       			<%	if(buyers!=null){
                       				for(Buyer buyer : buyers){ %>
					    			<div class="row clearfix">
                        				<div class="col-lg-12 col-xs-12">
											<p style="float:right"><%if(buyer.getIsPrimary()) {%>Owner<%}else {%>Co-Owner<%} %></p>	
                       						<div class="col-lg-12 col-xs-12">
												<div class="user-info">
													<div class="image"> 
													<%if(buyer.getPhoto() != null){
														%>
														<img src="${baseUrl}/<% out.print(buyer.getPhoto()); %>" alt="User" style="border-radius: 50%;margin-left: 36px;" width="68" height="48">
													<%}else{ %>
														<img src="../../images/user.png" alt="User" style="border-radius: 50%;margin-left: 36px;" width="68" height="48">
														<%} %>
													</div>
												</div> 
												<h4 style="text-align:center; "><%out.print(buyer.getName()); %></h4>	
											</div> 
				   						</div>
					     				<div class="col-lg-12 col-xs-12"style=" border-top: 2px solid #ddd4d4;">
						 					<p style="float:left">Mobile</p><br/><h5><%out.print(buyer.getMobile()); %></h5>	
						  					<p style="float:left">Email</p><br/><h5><%out.print(buyer.getEmail()); %></h5>	
						   					<p style="float:left">PAN</p><br/><h5><%out.print(buyer.getPancard()); %></h5>	
						    				<p style="float:left">Aadhaar card no.</p><br/><h5><%out.print(buyer.getAadhaarNumber()); %></h5>	
							 				<p style="float:left">Perm. Address</p><br/><h5><%out.print(buyer.getAddress()); %></h5>
							 				<p style="float:left">Current Address</p><br/><h5><%out.print(buyer.getCurrentAddress()); %></h5>	
						 				</div>
                        			</div>
                        			<div class="col-lg-12 col-xs-12"style=" border-top: 2px solid #ddd4d4;"></div>
                        			<%}} %>
								</div>
						 	</div>
                        </div>
             		</div>
        		</div>
    		</section>
		</div>
<div id="sidebar1"> 
	<%@include file="../../../partial/footer.jsp"%>
</div> 
</body>
</html>
<<script type="text/javascript">
$('#pdate').datepicker({
	autoclose:true,
	format: "dd MM yyyy"
}).on('change',function(e){
	 $('#buyerpossession').data('bootstrapValidator').revalidateField('pdate');
});

$('#ptime').datetimepicker({
    format: 'LT',
    stepping: 1
});
$("#postsaledocument").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href = "${baseUrl}/builder/postsale/buyerlist/document/document.jsp?flat_id=<%out.print(flat_id);%>";
});
$("#postsaleprojectstatus").click(function(){
	ajaxindicatorstart("Loading...");
	 window.location.href = "${baseUrl}/builder/postsale/buyerlist/projectstatus/projectstatus.jsp?flat_id=<%out.print(flat_id);%>";
});
$("#postsalepaymentstatus").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href = "${baseUrl}/builder/postsale/buyerlist/paymentstatus/paymentstatus.jsp?flat_id=<%out.print(flat_id);%>";
 });
 
$('#buyerpossession').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
	feedbackIcons: {
	    validating: 'glyphicon glyphicon-refresh'
	},
	excluded: ':disabled',
	fields: {
		pdate: {
			validators: {
                callback: {
                    message: 'Wrong Possession Date',
                    callback: function (value, validator) {
                        var m = new moment(value, 'DD MMM YYYY', true);
                        if (!m.isValid()) {
                            return false;
                        } else {
                        	return true;
                        }
                    }
                }
            }
	    },
	    ptime:{
	    	 validators: {
		         notEmpty: {
		             message: 'Please select time'
		       }
		   }
	   }
	}
}).on('success.form.bv', function(event,data) {
		// Prevent form submission
event.preventDefault();
savePossesion();
}).on('error.form.bv',function(event,data){
	event.preventDefault();
});
function savePossesion() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/possession/add',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#buyerpossession').ajaxSubmit(options);
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
        //window.location.href = "${baseUrl}/builder/possession/list.jsp";
  	}
}
</script>
