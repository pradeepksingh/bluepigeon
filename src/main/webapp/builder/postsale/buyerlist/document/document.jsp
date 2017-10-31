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
 	int primary_buyer_id=0;
 	String buyerName = null;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
			empId=builder.getId();;
			if(builder_id > 0){
				if (request.getParameterMap().containsKey("flat_id")) {
					flat_id = Integer.parseInt(request.getParameter("flat_id"));
					buyers = new BuyerDAO().getFlatBuyersByFlatId(flat_id);
					project_list = new ProjectDAO().getActiveProjectsByBuilderId(builder_id);
					buyerUploadDocuments = new BuyerDAO().getBuyerUploadDocumentsByBuyerId(buyers.get(0).getId());
					inboxMessageList = new ProjectDAO().getBookedBuyerList(empId);
					buyerData = new ProjectDAO().getAllBuyersByBuilderEmployee(builder);
					for(Buyer buyer :buyers) {
						if(buyer.getIsPrimary()) {
							primary_buyer_id = buyer.getId();
							buyerName = buyer.getName();
						}
					}
				}
			}
		}
		
   }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>POSTSALE Document</title>

    <!-- Favicon-->
    <link rel="icon" href="../../favicon.ico" type="image/x-icon">

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

    <!-- Custom Css -->
    <link href="../../../css/POSTSALE_Document.css" rel="stylesheet">

    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
	
	<style>
/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 12px 20px;
    <!-- margin: 8px 0; -->
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
}

/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn,.signupbtn {float:left;width: 36%;
background: #24bcd3;
border-radius: 5px;}

/* Add padding to container elements */
.container {
    padding: 16px;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 34%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
    position: absolute;
    right: 35px;
    top: 15px;
    color: #000;
    font-size: 40px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: red;
    cursor: pointer;
}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
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

			<section class="content" style="margin-top:60px;">
        		<div class="container-fluid">
               		<div class="row clearfix">
			    		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" class="btn btn-success waves-effect" style="width: 100%; ">DOCUMENT</button>
							</div>
                		</div>
                		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                     		<div class="button-demo">
                                <button type="button" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">PAYMENT STATUS</button>
							</div>
                		</div>
				 		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">PROJECT STATUS</button>
							</div>
                		</div>
				 		<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" >
                      		<div class="button-demo">
                                <button type="button" class="btn btn-default waves-effect" style="width: 100%;font-size:20px">POSSESSION</button>
							</div>
                		</div>
            		</div>
            		<div class="row clearfix" style="background: white;">
                		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    		<div class="card" style="border: 2px solid #24bcd3;">
                       			<div class="body">
					    			<div class="row clearfix" >
                               			<ul class="nav nav-tabs">
							   				<li class="col-lg-3 col-xs-12 listpstsale1 active">
							   					<a data-toggle="tab" href="#General">General</a>
							   				</li>
							   				<li class="col-lg-3 col-xs-12 listpstsale1">
							   					<a data-toggle="tab" href="#DemandLetter">Demand Letter</a>
							   				</li>
							   				<li class="col-lg-3 col-xs-12 listpstsale1">
							   					<a data-toggle="tab" href="#Paymentreceipt">Payment receipt</a>
							   				</li>
							   				<li class="col-lg-3 col-xs-12 listpstsale1">
							   					<a data-toggle="tab" href="#inboxMessage">Message</a>
							   				</li>
							   			</ul>
									</div>
							 		<div class="tab-content">
							  			<div class="row clearfix tab-pane fade in active" id="General" >
							  				<div class="row" id="gendocupload">
												<%if(buyerUploadDocuments != null){
													int a=buyerUploadDocuments.size();
							  						for(BuyerUploadDocuments buyerUploadDocuments2:buyerUploadDocuments){
							  						if(buyerUploadDocuments2.getDocType()==1){
							  				      	
							  					%>
							  					<ul >
								   					<li  class="col-lg-4 col-xs-12" style="list-style: none;">
								    					<a href=""><img src="../../../images/docpdf.png" alt="User" width="150px"/></a>
														<br/><h5><% out.print(buyerUploadDocuments2.getName());%></h5>
								   					</li>
								   				</ul>
							   					<%}}}%>
							  				</div>
											<div class="button-demo row">
							       				<li class="col-lg-4 col-xs-12" style="list-style: none;"></li>
							   					<li class="col-lg-4 col-xs-12" style="list-style: none;">
							   						<button type="button" class="btn btn-success waves-effect" onclick="openGeneralDoc();" style="width: 100%; ">Upload</button>
							  	 				</li>
											</div>
										</div>
							 			<div class="row clearfix tab-pane fade" id="DemandLetter" >
							 				<div class="row" id="demanddocupload">
                             				<%if(buyerUploadDocuments != null){
							  				int a=buyerUploadDocuments.size();
							  				for(BuyerUploadDocuments buyerUploadDocuments2:buyerUploadDocuments){
							  					if(buyerUploadDocuments2.getDocType()==2){
							  				
							  				%>
							  				<ul>
							   					<li  class="col-lg-4 col-xs-12" style="list-style: none;">
							    					<a href=""><img src="../../../images/docpdf.png" alt="User" width="150px"/></a>
													<br/><h5><% out.print(buyerUploadDocuments2.getName());%></h5>
							   					</li>
							   				</ul>
							   				<%}}}%>
							   				</div>
											<div class="button-demo row">
                                				<li class="col-lg-2 col-xs-12" style="list-style: none;"></li>
							   					<li class="col-lg-4 col-xs-12" style="list-style: none;">
							   						<button type="button" class="btn btn-success waves-effect" onclick="openDemandLetter();" style="width: 100%; ">Upload</button>
							  	 				</li>
							   					<li class="col-lg-2 col-xs-12" style="list-style: none;text-align: center; margin-top:8px">
							  						Or
							   					</li>
							   					<li class="col-lg-3 col-xs-12" style="list-style: none;">
							  						<button type="button" class="btn btn-success waves-effect" onclick="autogenerateDemandLetter();" style="width: 100%; ">Generate</button>
							   					</li>
											</div>
										</div>
							 			<div class="row clearfix tab-pane fade" id="Paymentreceipt" >
							 				<div class="row" id="paymentdocupload">
                             				<%if(buyerUploadDocuments != null){
							  				int a=buyerUploadDocuments.size();
							  				for(BuyerUploadDocuments buyerUploadDocuments2:buyerUploadDocuments){
							  					if(buyerUploadDocuments2.getDocType()==3){
							  				%>
							  					<ul>
								   					<li  class="col-lg-4 col-xs-12" style="list-style: none;">
								    					<a href=""><img src="../../../images/docpdf.png" alt="User" width="150px"/></a>
														<br/><h5><%out.print(buyerUploadDocuments2.getName());%></h5>
								   					</li>
								   				</ul>
							   				<%}}}%>
							   				</div>
											<div class="button-demo row">
                                				<li class="col-lg-4 col-xs-12" style="list-style: none;"></li>
							   					<li class="col-lg-4 col-xs-12" style="list-style: none;">
							   						<button type="button" onclick="openPayment();" class="btn btn-success waves-effect" style="width: 100%; ">Upload</button>
							   					</li>
											</div>
										</div>
							 			<div class="row clearfix tab-pane fade" id="inboxMessage">
							 			<div id="replymsg">
							 			  <%
											SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
	                   						SimpleDateFormat dt2 = new SimpleDateFormat("h:m a");
							 				if(inboxMessageList != null){
							 				for(InboxMessageData inboxMessageList1:inboxMessageList){
							 				%>
							 				<ul class="col-lg-12" style="box-shadow: 0 2px 5px rgba(0, 0, 0, 0.16), 0 2px 10px rgba(0, 0, 0, 0.12);">
							 				 	<a href="javascript:getInboxMsg(<%out.print(inboxMessageList1.getId());%>);">
								   					<li class="col-lg-2 col-xs-12" style="list-style: none;">
								   					<%if(inboxMessageList1.getImage()!=null && inboxMessageList1.getImage() !="") {%>
								    					<img src="${baseUrl}/<%out.print(inboxMessageList1.getImage());%>" alt="User" style="border-radius: 50%;margin-top: 20px;" width="68px" height="48px">
								    					<%}else{ %>
								    					<img src="../../../images/user.png" alt="User" style="border-radius: 50%;margin-top: 20px;" width="58px" height="38px">
								    					<%} %>
								   					</li>
								   					<li class="col-lg-8 col-xs-12" style="list-style: none;text-align: left;">
								 						<p><b><%out.print(inboxMessageList1.getName()); %></b></p>
								 						<p style="font-size: 13px;"><% if(inboxMessageList1.getDate() != null) { out.print(dt1.format(inboxMessageList1.getDate()));} %><span style="margin-left:10px"><% if(inboxMessageList1.getDate() != null) { out.print(dt2.format(inboxMessageList1.getDate()));} %></span></p>
								  						<p><%out.print(inboxMessageList1.getSubject()); %></p>
								   					</li>
								   					<li class="col-lg-2 col-xs-12" style="list-style: none;">
								  						<img src="../../../images/status-green.png" alt="User" style="margin-top: 20px;" width="58px" height="38px">
								    				</li>
							   					</a>
							   				</ul>
							   				<%}} %>
							   				</div>
											<div class="button-demo">
                                				<li class="col-lg-2 col-xs-12" style="list-style: none;"></li>
							   					<li class="col-lg-8 col-xs-12" style="list-style: none;"></li>
							   					<li class="col-lg-2 col-xs-12" style="list-style: none;">
							  						<a href="javascript:openMessageModal();"><img src="../../../images/addnew.png" alt="User" style="border-radius: 50%;margin-top: 20px;" width="58px" height="38px"></a>
							   					</li>
											</div>
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
<div id="newmessage" class="modal col-lg-7" >
	<span  class="close" title="Close Modal">×</span>
	<form class="modal-content animate" action="" method="post" id="addinbox" name="addinbox"  enctype="multipart/form-data" >
		<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(empId);%>"/>
		<div class="col-lg-12" style="background:white" >
			<div class="row clearfix" >
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>To</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<input type="hidden" id="filter_buyer_id" name="filter_buyer_id[]" value="<%out.print(primary_buyer_id);%>" />
					<input type="text" placeholder="" readonly value="<%out.print(buyerName); %>" required>
                </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Subject</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<div>
						<input type="text" placeholder="Enter subject" id="subject" name="subject"  required>
					</div>
					<div class="messageContainer"></div>
                    </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Message</b></label>
				</div>
				<div class="col-lg-6" >
					<div>
						<textarea placeholder="Enter your message here" name="message" id="message" style="heigth:150px;width:240px;" required></textarea>
					</div>
					<div class="messageContainer"></div>
				</div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Attaches</b></label>
				</div>
				<div class="col-lg-4">
					<div class="file-upload">
						<div class="file-select">
							<div class="file-select-button" id="fileName">Choose File</div>
							<div class="file-select-name" id="noFile">No file chosen...</div> 
							<input type="file" name="attachment[]" id="chooseFile">
					 	</div>
					</div>
                </div>
				<button type="submit" class="signupbtn">Send</button>
			</div>
		</div>
	</form>
</div>
<div id="generaldoc" class="modal col-lg-7" >
	<span onclick="document.getElementById('generaldoc').style.display='none'" class="close" title="Close Modal">×</span>
	<form class="modal-content animate" action="" id="generaldocform" name="generaldocname" method="post" enctype="multipart/form-data">
	<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
	<input type="hidden" id="doc_type" name="doc_type" value="1"/>
	<input type="hidden" name="doc_id[]" value="0" />
		<div class="col-lg-12" style="background:white" >
			<div class="row clearfix" >
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Document Name</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<div>
						<input type="text" placeholder="Enter doc name" name="doc_name[]"  required>
					</div>
					<div class="messageContainer"></div>
                </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Upload Document</b></label>
				</div>
				<div class="col-lg-4">
					<div class="file-upload">
						<div class="file-select">
							<div class="file-select-button" id="fileName">Choose File</div>
							<div class="file-select-name" id="noFile">No file chosen...</div> 
							<input type="file" name="doc_url[]" id="chooseFile">
						</div>
					</div>
                 	</div>
				<button type="submit" class="signupbtn">Submit</button>
			</div>
		</div>
	</form>
</div>
<div id="demandlettermodel" class="modal col-lg-7" >
	<span onclick="document.getElementById('demandlettermodel').style.display='none'" class="close" title="Close Modal">×</span>
	<form class="modal-content animate" action="" id="demanddocform" name="demanddocform"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
	<input type="hidden" name="doc_id[]" value="0" />
	<input type="hidden" name="doc_type" id="doc_type" value="2"/>
		<div class="col-lg-12" style="background:white" >
			<div class="row clearfix" >
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Document Name</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<div>
						<input type="text" placeholder="Enter doc name" name="doc_name[]"  required>
					</div>
					<div class="messageContainer"></div>
                </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Upload Document</b></label>
				</div>
				<div class="col-lg-4">
					<div class="file-upload">
						<div class="file-select">
							<div class="file-select-button" id="fileName">Choose File</div>
							<div class="file-select-name" id="noFile">No file chosen...</div> 
							<input type="file" name="doc_url[]" id="chooseFile">
						</div>
					</div>
                </div>
				<button type="submit" class="signupbtn">Submit</button>
			</div>
		</div>
	</form>
</div>
<div id="genratedemandlettermodel" class="modal col-lg-7" >
	<span onclick="document.getElementById('genratedemandlettermodel').style.display='none'" class="close" title="Close Modal">×</span>
	<form class="modal-content animate" action="" id="genratedemanddocform" name="genratedemanddocform"  method="post" enctype="multipart/form-data">
	<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
	<input type="hidden" name="doc_id[]" value="0" />
	<input type="hidden" name="doc_type" id="doc_type" value="2"/>
		<div class="col-lg-12" style="background:white" >
			<div class="row clearfix" >
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Document Name</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<div>
						<input type="text" placeholder="Enter doc name" name="doc_name[]"  required>
					</div>
					<div class="messageContainer"></div>
                </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Upload Document</b></label>
				</div>
				<div class="col-lg-4">
					<div class="file-upload">
						<div class="file-select">
							<div class="file-select-button" id="fileName">Choose File</div>
							<div class="file-select-name" id="noFile">No file chosen...</div> 
							<input type="file" name="doc_url[]" id="chooseFile">
						</div>
					</div>
                </div>
				<button type="submit" class="signupbtn">Submit</button>
			</div>
		</div>
	</form>
</div>
<div id="paymentrecipetdoc" class="modal col-lg-7" >
	<span onclick="document.getElementById('paymentrecipetdoc').style.display='none'" class="close" title="Close Modal">×</span>
	<form class="modal-content animate" action="" id="paymentdocform" method="post" name="paymentdocform" enctype="multipart/form-data">
	<input type="hidden" name="buyer_id" id="buyer_id" value="<%out.print(primary_buyer_id);%>" />
	<input type="hidden" name="doc_id[]" value="0" />
	<input type="hidden" name="doc_type" id="doc_type" value="3"/>
		<div class="col-lg-12" style="background:white" >
			<div class="row clearfix" >
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Document Name</b></label>
				</div>
				<div class="col-lg-6" style="margin: 9px;">
					<div>
						<input type="text" placeholder="Enter doc name" name="doc_name[]"  required>
					</div>
					<div class="messageContainer"></div>
                </div>
				<div class="col-lg-4" style="margin-top:17px">
					<label><b>Upload Document</b></label>
				</div>
				<div class="col-lg-4">
					<div class="file-upload">
						<div class="file-select">
							<div class="file-select-button" id="fileName">Choose File</div>
							<div class="file-select-name" id="noFile">No file chosen...</div> 
							<input type="file" name="doc_url[]" id="chooseFile">
						</div>
					</div>
                </div>
				<button type="submit" class="signupbtn">Submit</button>
			</div>
		</div>
	</form>
</div>
<div class="modal col-lg-7"  id="replymessagemodal"></div>
  <!-- Jquery Core Js -->
<script>
// Get the modal

function openGeneralDoc(){
	$("#generaldoc").modal('show');
	$('#generaldocform').bootstrapValidator({
		container: function($field, validator) {
			return $field.parent().next('.messageContainer');
	   	},
		feedbackIcons: {
		    validating: 'glyphicon glyphicon-refresh'
		},
		excluded: ':disabled',
		fields: {
			'doc_name[]': {
		        validators: {
		            notEmpty: {
		                message: 'Please enter document name'
		            }
		        }
		    }
		}
	}).on('success.form.bv', function(event,data) {
			// Prevent form submission
	event.preventDefault();
		saveGeneralDoc();
	}).on('error.form.bv',function(event,data){
		event.preventDefault();
	});
	
}

function saveGeneralDoc(){
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#generalresponse', 
	 		beforeSubmit : showAddGenDocumentRequest,
	 		success :  showAddGenDocumentResponse,
	 		url : '${baseUrl}/webapi/buyer/update/gendoc',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#generaldocform').ajaxSubmit(options);
}

function showAddGenDocumentRequest(formData, jqForm, options){
	$("#generalresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddGenDocumentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#generalresponse").removeClass('alert-success');
       	$("#generalresponse").addClass('alert-danger');
		$("#generalresponse").html(resp.message);
		$("#generalresponse").show();
		alert(resp.message);
		ajaxindicatorstop();
  	} else {
  		$("#generalresponse").removeClass('alert-danger');
        $("#generalresponse").addClass('alert-success');
        $("#generalresponse").html(resp.message);
        $("#generalresponse").show();
        alert(resp.message);
      	$.get('${baseUrl}/builder/postsale/buyerlist/document/partialgendoc.jsp?buyer_id=<% out.print(primary_buyer_id);%>',{},function(data) {
   	    	$("#gendocupload").html(data);
   	    	ajaxindicatorstop();
   	    },'html');
      	$("input[name='doc_name[]']").val('');
      	$("#generaldoc").modal('hide');
  	}
}
function autogenerateDemandLetter(){
	$("#genratedemandlettermodel").modal('show');
	
}

function openDemandLetter(){
	$("#demandlettermodel").modal('show');
	$('#demanddocform').bootstrapValidator({
		container: function($field, validator) {
			return $field.parent().next('.messageContainer');
	   	},
		feedbackIcons: {
		    validating: 'glyphicon glyphicon-refresh'
		},
		excluded: ':disabled',
		fields: {
			'doc_name[]': {
		        validators: {
		            notEmpty: {
		                message: 'Please enter document name'
		            }
		        }
		    }
		}
	}).on('success.form.bv', function(event,data) {
			// Prevent form submission
		event.preventDefault();
		saveDemandDoc();
		
	}).on('error.form.bv',function(event,data){
		event.preventDefault();
		//alert("Error during submit data");
	});
}

function saveDemandDoc(){
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#demandresponse', 
	 		beforeSubmit : showAddDemandDocumentRequest,
	 		success :  showAddDemandDocumentResponse,
	 		url : '${baseUrl}/webapi/buyer/update/gendoc',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#demanddocform').ajaxSubmit(options);
}

function showAddDemandDocumentRequest(formData, jqForm, options){
	$("#demandresponse").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddDemandDocumentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#demandresponse").removeClass('alert-success');
       	$("#demandresponse").addClass('alert-danger');
		$("#demandresponse").html(resp.message);
		$("#demandresponse").show();
		alert(resp.message);
		ajaxindicatorstop();
  	} else {
  		$("#demandresponse").removeClass('alert-danger');
        $("#demandresponse").addClass('alert-success');
        $("#demandresponse").html(resp.message);
        $("#demandresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
    	$.get('${baseUrl}/builder/postsale/buyerlist/document/partialdemanddoc.jsp?buyer_id=<% out.print(primary_buyer_id);%>',{},function(data) {
   	    	$("#demanddocupload").html(data);
   	    	ajaxindicatorstop();
   	    },'html');
      	$("input[name='doc_name[]']").val('');
      	$("#demandlettermodel").modal('hide');
  	}
}

function openPayment(){
	$("#paymentrecipetdoc").modal('show');
	$('#paymentdocform').bootstrapValidator({
		container: function($field, validator) {
			return $field.parent().next('.messageContainer');
	   	},
		feedbackIcons: {
		    validating: 'glyphicon glyphicon-refresh'
		},
		excluded: ':disabled',
		fields: {
			'doc_name[]': {
		        validators: {
		            notEmpty: {
		                message: 'Please enter document name'
		            }
		        }
		    }
		}
	}).on('success.form.bv', function(event,data) {
			// Prevent form submission
	event.preventDefault();
	savePaymentDoc();
	}).on('error.form.bv',function(event,data){
		event.preventDefault();
	});
}

function savePaymentDoc(){
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#paymentresponse', 
	 		beforeSubmit : showAddPaymentDocumentRequest,
	 		success :  showAddPaymentDocumentResponse,
	 		url : '${baseUrl}/webapi/buyer/update/gendoc',
	 		semantic : true,
	 		dataType : 'json'
	 	};
		$('#paymentdocform').ajaxSubmit(options);
	}

function showAddPaymentDocumentRequest(formData, jqForm, options){
$("#paymentresponse").hide();
	var queryString = $.param(formData);
return true;
}
	
function showAddPaymentDocumentResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#paymentresponse").removeClass('alert-success');
	   	$("#paymentresponse").addClass('alert-danger');
		$("#paymentresponse").html(resp.message);
		$("#paymentresponse").show();
		alert(resp.message);
		ajaxindicatorstop();
		} else {
		$("#paymentresponse").removeClass('alert-danger');
	    $("#paymentresponse").addClass('alert-success');
	    $("#paymentresponse").html(resp.message);
	    $("#paymentresponse").show();
	    alert(resp.message);
	  	$.get('${baseUrl}/builder/postsale/buyerlist/document/partialpaymentdoc.jsp?buyer_id=<% out.print(primary_buyer_id);%>',{},function(data) {
	    	$("#paymentdocupload").html(data);
	    	ajaxindicatorstop();
		},'html');
	  	$("input[name='doc_name[]']").val('');
	  	$("#paymentrecipetdoc").modal('hide');
	}
}


function openMessageModal(){
	$("#newmessage").modal('show');
	$('#addinbox').bootstrapValidator({
		container: function($field, validator) {
			return $field.parent().next('.messageContainer');
	   	},
	    feedbackIcons: {
	        validating: 'glyphicon glyphicon-refresh'
	    },
	    excluded: ':disabled',
	    fields: {
	    	'filter_buyer_id[]': {
	            validators: {
	                notEmpty: {
	                    message: 'Please select buyer'
	                }
	            }
	        },
	        
	        subject: {
	            validators: {
	                notEmpty: {
	                    message: 'Please enter subject'
	                }
	            }
	        },
	        message: {
	            validators: {
	                notEmpty: {
	                    message: 'Please enter message'
	                }
	            }
	        }
	    }
	}).on('success.form.bv', function(event,data) {
		// Prevent form submission
		event.preventDefault();
		addInboxMessage();
		
	});
}

function addInboxMessage() {
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#pricingresponse', 
	 		beforeSubmit : showPriceRequest,
	 		success :  showPriceResponse,
	 		url : '${baseUrl}/webapi/builder/inbox/new',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addinbox').ajaxSubmit(options);
}

function showPriceRequest(formData, jqForm, options){
	$("#pricingresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showPriceResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#pricingresponse").removeClass('alert-success');
       	$("#pricingresponse").addClass('alert-danger');
		$("#pricingresponse").html(resp.message);
		$("#pricingresponse").show();
		alert(resp.message);
		 ajaxindicatorstop();
  	} else {
  		$("#pricingresponse").removeClass('alert-danger');
        $("#pricingresponse").addClass('alert-success');
        $("#pricingresponse").html(resp.message);
        $("#pricingresponse").show();
        alert(resp.message);
        ajaxindicatorstop();
      //  window.location.href = "${baseUrl}/builder/inbox/inbox.jsp";
        $.get('${baseUrl}/builder/postsale/buyerlist/document/partialinbox.jsp?emp_id=<% out.print(empId);%>',{},function(data) {
	    	$("#replymsg").html(data);
	    	ajaxindicatorstop();
		},'html');
  	}
}


function getInboxMsg(id){
//	$("#message").empty();
	var replymsg = '';
	ajaxindicatorstart("Loading...");
	$.post("${baseUrl}/webapi/builder/inbox/reply",{id: id},function(data){
		alert(data.message);
		replymsg = '<span onclick="document.getElementById(message).style.display=none" class="close" title="Close Modal">×</span>'
				+'<form class="modal-content animate" action="" method="post" id="addnewreply" name="addnewreply"  enctype="multipart/form-data">'
				+'<input type="hidden" id="emp_id" name="emp_id" value="'+data.empId+'" />'
		   		+'<input type="hidden" id="inbox_id" name="inbox_id" value="'+id+'" />'
		   		+'<div class="col-lg-12" style="background:white" >'
		 		+'<div class="row clearfix" >'
		 		+'<div class="col-lg-4" style="margin-top:17px">'
		 		+'<label><b>To</b></label>'
		 		+'</div>'
		 		+'<div class="col-lg-6" style="margin: 9px;">'
		 		+'<div>'
		 		+'<input type="text" placeholder="Enter buyer name" name="buyer_name" id="buyer_name" value="'+data.name+'" required>'
		 		+'</div>'
		 		+'<div class="messageContainer"></div>'
		 		+'</div>'
		 		+'<div class="col-lg-4" style="margin-top:17px">'
		 		+'<label><b>Subject</b></label>'
		 		+'</div>'
		 		+'<div class="col-lg-6" style="margin: 9px;">'
		 		+'<div>'
		 		+'<input type="text" placeholder="Enter subject" name="" value="RE: '+data.subject+'" required>'
		 		+'</div>'
		 		+'<div class="messageContainer"></div>'
		 		+'</div>'
		 		+'<div class="col-lg-4" style="margin-top:17px">'
		 		+'<label><b>Message</b></label>'
		 		+'</div>'
		 		+'<div class="col-lg-6" style="margin: 9px;">'
		 		+'<div>'
		 		+'<textarea type="text" placeholder="Enter message" name="message" id="message" required style="height:150px;width:240px;">'
		 		+'\n\n\n\n\n'+data.message
		 		+'</textarea>'
		 		+'</div>'
		 		+'<div class="messageContainer"></div>'
		 		+'</div>'
		 		+'<div class="col-lg-4" style="margin-top:17px">'
		 		+'<label><b>Upload Document</b></label>'
		 		+'</div>'
		 		+'<div class="col-lg-4">'
		 		+'<div class="file-upload">'
		 		+'<div class="file-select">'
		 		+'<div class="file-select-button" id="fileName">Choose File</div>'
		 		+'<div class="file-select-name" id="noFile">No file chosen...</div>' 
		 		+'<input type="file" name="attachment[]" id="chooseFile">'
		 		+'</div>'
		 		+'</div>'
		 		+'</div>'
		 		+'<button type="submit" class="signupbtn">Replay</button>'
		 		+'</div>'
		 		+'</div>'
		 		+'</form>';
		 	
    		$("#replymessagemodal").append(replymsg);
    		
			 ajaxindicatorstop();
			
			 $('#addnewreply').bootstrapValidator({
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
			                    message: 'Please select buyer'
			                }
			            }
			        },
			        subject: {
			            validators: {
			                notEmpty: {
			                    message: 'Please enter subject'
			                }
			            }
			        },
			        message: {
			            validators: {
			                notEmpty: {
			                    message: 'Please enter message'
			                }
			            }
			      	}
				}
			}).on('success.form.bv', function(event,data) {
					// Prevent form submission
				event.preventDefault();
					
				addReply();
					
			}).on('error.form.bv',function(event,data){
					event.preventDefault();
					alert("Error during submit data");
				});
	});
	 $("#replymessagemodal").modal('show');
}

function addReply() {
	ajaxindicatorstart("Loading...");
	var options = {
	 		target : '#replyresponse', 
	 		beforeSubmit : showReplyRequest,
	 		success :  showReplyResponse,
	 		url : '${baseUrl}/webapi/builder/inbox/new/reply',
	 		semantic : true,
	 		dataType : 'json'
	 		//return false;
	 	};
   	$('#addnewreply').ajaxSubmit(options);
   	//return false;
}
function showReplyRequest(formData, jqForm, options){
	$("#replyresponse").hide();
   	var queryString = $.param(formData);
	return true;
}

function showReplyResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#replyresponse").removeClass('alert-success');
       	$("#replyresponse").addClass('alert-danger');
		$("#replyresponse").html(resp.message);
		$("#replyresponse").show();
		alert(resp.message);
		//return false;
		 ajaxindicatorstop();
  	} else {
  		$("#replyresponse").removeClass('alert-danger');
        $("#replyresponse").addClass('alert-success');
        $("#replyresponse").html(resp.message);
        $("#replyresponse").show();
        alert(resp.message);
        //return false;
        ajaxindicatorstop();
        //window.location.href = "${baseUrl}/builder/inbox/inbox.jsp";
  	}
}
</script>
    