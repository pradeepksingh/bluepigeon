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
			if(builder_id > 0 && access_id ==6){
				if (request.getParameterMap().containsKey("flat_id")) {
					flat_id = Integer.parseInt(request.getParameter("flat_id"));
					buyers = new BuyerDAO().getFlatBuyersByFlatId(flat_id);
					project_list = new ProjectDAO().getActiveProjectsByBuilderId(builder_id);
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
    <link rel="icon" href="../../../favicon.ico" type="image/x-icon">
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
     <link rel="stylesheet" type="text/css" href="../../../css/selectize.css" />
    <!-- jQuery -->
    <script src="../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../../../js/jquery.multiselect.js"></script>
    <script type="text/javascript" src="../../../js/selectize.min.js"></script>
     <script src="../../../js/jquery.form.js"></script>
    <script src="../../../js/bootstrapValidator.min.js"></script>
     <script src="../../../js/bootstrap-datepicker.min.js"></script>

    <!-- Custom Css -->
    <link href="../../../css/POSTSALE_Document.css" rel="stylesheet">

    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
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
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
    		<section class="content" style="margin-top:70px;">
        		<div class="container-fluid">
               		<div class="row clearfix">
                		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" id="postsaledocument" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">DOCUMENT</button>
							</div>
                		</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" id="postsalepaymentstatus" class="btn btn-success waves-effect" style="width: 100%; ">PAYMENT STATUS</button>
							</div>
                		</div>
				 		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" id="postsaleprojectstatus" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">PROJECT STATUS</button>
							</div>
                		</div>
				 		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" id="postsalepossession" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">POSSESSION</button>
							</div>
                		</div>
            		</div>
            		<div class="row clearfix" style="background: white;">
                		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    		<div class="card" style="border: 2px solid #24bcd3;">
                       			<div class="body">
					    			<div class="row clearfix" >
                               			<ul class="nav nav-tabs">
							   				<li class="col-lg-3 col-xs-12 active" style="list-style: none;">
							   					<a data-toggle="tab" href="#PaymentSchedule"> Payment Schedule</a>
							   				</li>
							   				<li class="col-lg-3 col-xs-12" style="list-style: none;">
							   					<a data-toggle="tab" href="#Paid">Paid</a>
							  		 		</li>
							   			</ul>
									</div>
							 		<div class="tab-content">
							     		<div class="row clearfix tab-pane fade in active" id="PaymentSchedule" >
								 			<div class="row clearfix" style="margin-top:20px">
                               					<ul >
							   						<li class="col-lg-3 col-xs-12 listpstsale">
							   							<a>Stage</a>
							   						</li>
													<li class="col-lg-3 col-xs-12 listpstsale">
														<a>Date</a>
													</li>
													<li class="col-lg-3 col-xs-12 listpstsale">
														<a>Amount</a>
													</li>
													
							   					</ul>
											</div>
											<%if(buyerPayments.size() >0){
											    for(BuyerPayment buyerPayment : buyerPayments){
												%>
							   				<ul class="col-lg-12" style="margin-bottom: 13px;border-bottom: 2px solid beige;">
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align:center">
							    					<p style="color: aqua;font-weight: 600;"><%out.print(buyerPayment.getMilestone()); %></p>
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align:center;">
													<p><%if(buyerPayment.getScheduleDate()!=null)out.print(buyerPayment.getScheduleDate());%></p>
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align:center;">
                          							<p><%out.print(Math.round( buyerPayment.getAmount())); %></p>
							    				</li>
							    				<li class="col-lg-3 col-xs-12" style="list-style: none;text-align:center">
							 						<select class="form-control show-tick" >
														<option value="0" <%if(buyerPayment.isPaid()==false) {%>selected<%} %>>Not Paid</option>
														<option value="1" <%if(buyerPayment.isPaid()==true){ %>selected<%} %>>Paid</option>
													</select>
							    				</li>
							   				</ul>
							   				<%}} %>
										</div>
										<div class="row clearfix tab-pane fade" id="Paid">
								 			<ul >
							   					<li class="col-lg-3 col-xs-12 " style="list-style: none;">
							   						<a>Amount</a>
							   					</li>
							   					<li class="col-lg-3 col-xs-12 " style="list-style: none;">
							   						<a>Date</a>
							   					</li>
							   					<li class="col-lg-3 col-xs-12 " style="list-style: none;">
							   						<a>Transition No</a>
							   					</li>
							   					<li class="col-lg-3 col-xs-12 " style="list-style: none;">
							   						<a>Transition Type</a>
							   					</li>
							   				</ul>
							   				<%if(buyerPayments.size() >0){
											    for(BuyerPayment buyerPayment : buyerPayments){
							   					%>
                             				<ul class="col-lg-12" style="margin-top: 20px;border-bottom: 2px solid beige;">
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;">
							    					<input type="text"  class="timepicker form-control" placeholder="Rs.5,00,00">
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align: left;">
													<input type="text" onchange="opendate(paied<%out.print(buyerPayment.getId()); %>)" id="paied<%out.print(buyerPayment.getId()); %>" value="<%if(buyerPayment.getPaieddate()!=null){out.print(buyerPayment.getPaieddate());} %>" class=" datedisplay form-control" placeholder="28-8-2017">
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;">
                           							<input type="text" class="form-control" placeholder="1012548">
							    				</li>
												<li class="col-lg-3 col-xs-12" style="list-style: none;">
							 						<select class="form-control show-tick" >
														<option value="1">Net Banking</option>
														<option value="2">By Cash</option>
														<option value="3">By Check</option>
													</select>
							    				</li>
							   				</ul>
							   				<%}} %>
							   				<ul class="col-lg-12" style="margin-bottom: 13px;border-bottom: 2px solid beige;">
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;">
							    					<p style="color: aqua;font-weight: 600;">Rs. 5,00,000</p>
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align: left;">
													<p>Pending (till date)</p>
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;"></li>
												<li class="col-lg-3 col-xs-12" style="list-style: none;"></li>
							   				</ul>
							   				<ul class="col-lg-12" style="margin-bottom: 13px;border-bottom: 2px solid beige;">
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;">
							    					<p style="color: aqua;font-weight: 600;">Rs. 5,00,000</p>
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;text-align: left;">
													<p>Net Pending(bss)</p>
							  					 </li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;"></li>
												<li class="col-lg-3 col-xs-12" style="list-style: none;"></li>
							   				</ul>
										</div>
									</div>
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
            <!-- #END# File Upload | Drag & Drop OR With Click & Choose -->
        		</div>
   			</section>
		</div>
	</div>
<div id="sidebar1"> 
	<%@include file="../../../partial/footer.jsp"%>
</div> 
</body>
</html>
<script>

function opendate(id){
	//alert("ID :: "+id.value);
	
}




$('.datedisplay').datepicker({
	autoclose:true,
	format: "dd MM yyyy"
});



$("#postsaledocument").click(function(){
	window.location.href = "${baseUrl}/builder/postsale/buyerlist/document/document.jsp?flat_id=<%out.print(flat_id);%>";
});


$("#postsaleprojectstatus").click(function(){
	 window.location.href = "${baseUrl}/builder/postsale/buyerlist/projectstatus/projectstatus.jsp?flat_id=<%out.print(flat_id);%>";
});

$("#postsalepossession").click(function(){
	 window.location.href = "${baseUrl}/builder/postsale/buyerlist/possession/possession.jsp?flat_id=<%out.print(flat_id);%>";
});
</script>