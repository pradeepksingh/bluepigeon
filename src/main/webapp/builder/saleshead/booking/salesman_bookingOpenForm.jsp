<%@page import="org.bluepigeon.admin.model.BuilderBuildingFlatTypeRoom"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalInfo"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectProjectType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />

<%
	int p_user_id = 0;
	int project_id=0;
	int access_id=0;
	int building_size_list =0;
	int floor_size_list = 0;
	BuilderFloor builderFloor = null;
	int building_id = 0;
	int floor_id = 0;
	int emp_id =0;
	List<BookingFlatList> bookingFlatList = null;
	List<BuilderFloor> floorList = null;
	List<BuilderBuilding> builderBuildingList = null;
	BuilderProject projectList = null;
	List<BuilderBuilding> buildingList = null;
	List<FlatListData> flatListDatas = null;
	BookingFlatList bookingFlatList2 = null;
	int flat_size = 0;
	String image  = "";
	List<ProjectImageGallery> imageGaleries = new ArrayList<ProjectImageGallery>();
	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
	
	java.net.URI location1 = null;
	session = request.getSession(false);
	
	BuilderEmployee builder = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			p_user_id = builder.getBuilder().getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			emp_id = builder.getId();
			if(access_id == 5){
				try{
					if (request.getParameterMap().containsKey("project_id")) {
						project_id = Integer.parseInt(request.getParameter("project_id"));
						projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
						builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
						building_id = builderBuildingList.get(0).getId();
						
						flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,0);
						bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,0,0);
						if(bookingFlatList2 != null){
							if(bookingFlatList2.getImage() != null){
								image = bookingFlatList2.getImage();
							}
						}
					flat_size = flatListDatas.size();
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				if(builderBuildingList != null && builderBuildingList.size() > 0){
					building_id = builderBuildingList.get(0).getId(); 
					building_size_list = builderBuildingList.size();
					floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id);
					if(floorList != null && floorList.size() > 0){
						floor_id = floorList.get(0).getId();
						floor_size_list = floorList.size();
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
<!--     <link rel="stylesheet" href="../../css/bootstrap-multiselect.css"> -->
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
 <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <!-- color CSS -->
<link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <link rel="stylesheet" type="text/css" href="../../css/booking.css">
     <link rel="stylesheet" type="text/css" href="../../css/newbookinglist.css">
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
<!--     <script src="../../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script> -->
 <script type="text/javascript" src="../../js/selectize.min.js"></script>
<!--     <script src="../../js/bootstrap-multiselect.js"></script> -->
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
      <div id="sidebar1"> 
       	<%@include file="../../partial/sidebar.jsp"%>
      </div>
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking"  class="btn11 btn-submit waves-effect waves-light m-t-10">Booking</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-info waves-effect waves-light m-t-10">Cancellation</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads"  class="btn11 btn-info waves-effect waves-light m-t-10">Leads</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">Campaign</button>
		                </div>
	                </div>
               <!-- row -->
                <!--.row -->
                  <div class="row re">
                    <div class="col-md-4 col-sm-4 col-xs-12">
                       <select id="filter_building_id" name="filter_building_id">
	                             <%
	                             if(builderBuildingList != null ){
	                             for(BuilderBuilding builderBuilding2 : builderBuildingList){ %>
	                     		<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName()); %></option>
	                     		<%} }%>
	                     </select>
                     </div>
                     <div class="col-md-4 col-sm-4 col-xs-12">
                        <select id="filter_floor_id" name="filter_floor_id">
                			<option value="0">All Floor</option>
                			<%
                			if(floorList != null){
                			for(BuilderFloor builderFloors : floorList){ %>
                			<option value="<%out.print(builderFloors.getId()); %>"><%out.print(builderFloors.getName()); %></option>
                			<%}}%>
                		</select>
                     </div>
                     <div class="col-md-4 col-sm-4 col-xs-12">
						<select id="evenOrodd" name="evenOrodd">
                			<option value="0">Even & Odd</option>
                			<option value="1">EVEN</option>
                			<option value="2">ODD</option>
                		</select>
                     </div>
                    </div>
                    <!-- row -->
                    
                <div class="white-box">
                 <div class="row" id="flatdetails">
                    <div class="col-md-8 col-sm-6 col-xs-12  bg1">
                        <div class="white-box">
                         <% if(flatListDatas !=null){
	            					String active = "";
	            					for(int i=0;i<flatListDatas.size();i++){ 
	              						for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){ %>
                           <!-- floor 1 -->
	                          <ul class="nav nav-pills custom-button-nav">
	                          <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){ 
		               	 						for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
		                      						if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")){
		             			%>
		             			<li class=""><a data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" data-value="<% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" class="book-flat-button btn-info" href="" onclick="toggleFlat(this,1);"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
		             			<% }else if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("hold")){
			             		%>
			             		<li class=""><a data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" data-value="<% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" class="book-flat-button yellowcolor yell" href="" onclick="toggleFlat(this,2);"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
			             		<% }else{%>
		     					<li class=""><a  data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>);" href="" class="book-flat-button"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
		 					<%
		 			   				}
          						}
         					}
        		 			%>
							 </ul>
					 		 <hr>
	    					<%
	    							}
	         					}
	     					 }
	     					%>
						 </div>
                    </div>
                    <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>" />
                    <input type="hidden" id="sel-flat-id" value="0"/>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                     <div class="bg1">
                       <div class="tab-content">
					     <div id="home" class="tab-pane fade in active">
						   <% if(bookingFlatList2 != null){
					     		if(bookingFlatList2.getFlatStatus() == 1){
					     	if(bookingFlatList2.getImage()!="" && bookingFlatList2.getImage() != null){ %>
						     <img src="${baseUrl}/<%out.print(bookingFlatList2.getImage()); %>" alt="Flat image" class="custom-img" data-toggle="modal" data-target="#myModal<%out.print(bookingFlatList2.getFlatId());%>">
						     <%} %>
						      <hr><br>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Flat Type</p>
						          <p><b><%out.print(bookingFlatList2.getFlatType()); %></b></p>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Carpet Area</p>
						          <p><b><%out.print(bookingFlatList2.getCarpetArea()); %> SQ/FT</b></p>
						        </div>
						      </div>
						      <%for(BuilderBuildingFlatTypeRoom bookingFlatList3 : bookingFlatList2.getBuilderBuildingFlatTypeRooms()){ %>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom"><% out.print(bookingFlatList3.getRoomName());%></p>
						          <p><b><%out.print(bookingFlatList3.getLength()); %> * <%out.print(bookingFlatList3.getBreadth()); %> 
						          <%if(bookingFlatList3.getLengthUnit() == 1) out.print("Feet"); 
						          	if(bookingFlatList3.getLengthUnit() == 2) out.print("Meter");
						          	if(bookingFlatList3.getLengthUnit() == 3) out.print("Inch");
						          	if(bookingFlatList3.getLengthUnit() == 4) out.print("Yard");
						          %></b></p>
						        </div>
						      </div>
						      <%} %>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Balcony</p>
						          <p><b><%out.print(bookingFlatList2.getBalcony()); %></b></p>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom"><%if(bookingFlatList2.getRoomName() != null){out.print(bookingFlatList2.getRoomName()); }%> Size</p>
						          <p><b><%out.print(bookingFlatList2.getLength()+" x "+bookingFlatList2.getBreadth()+" "+bookingFlatList2.getAreaUint()); %></b></p>
						        </div>
						      </div>
						      <button type="button" onclick="showFlat(<%out.print(bookingFlatList2.getFlatId()); %>)" class="button">Book Now</button>
						       <%}
						     	if(bookingFlatList2.getFlatStatus() == 2 &&  bookingFlatList2.getIsDeleted() != null && bookingFlatList2.getIsDeleted() == 0){
					     	%>	
					       <div class="user-profile">
					         <%if(bookingFlatList2.getBuyerPhoto()!="" && bookingFlatList2.getBuyerPhoto() != null){ %>
							     <img src="${baseUrl}/<%out.print(bookingFlatList2.getBuyerPhoto()); %>" alt="Buyer image" class="custom-img">
							   <%}%>	
					          <img src="../../images/camera_icon.PNG" alt="camera " class="camera"/>
					          <p><b><%out.print(bookingFlatList2.getBuyerName()); %></b></p>
					          <p class="p-custom"><%out.print(bookingFlatList2.getBuildingName()); %>,<%out.print(" "+bookingFlatList2.getFlatNo()); %>, <%out.print(" "+bookingFlatList2.getProjectName()); %></p>
					          <hr>
					       </div>
						      <div class="row custom-row user-row">
						        <p class="p-custom">Mobile No.</p>
						        <p><b><%if(bookingFlatList2.getBuyerMobile()!=null){out.print(bookingFlatList2.getBuyerMobile());} %></b></p>
						        <p class="p-custom">Email</p>
						        <p><b><%if(bookingFlatList2.getBuyerEmail()!=null){out.print(bookingFlatList2.getBuyerEmail()); }%></b></p>
						        <p class="p-custom">PAN</p>
						        <p><b><%if(bookingFlatList2.getBuyerPanNo()!=null){out.print(bookingFlatList2.getBuyerPanNo());} %></b></p>
						        <p class="p-custom">Aadhaar card no.</p>
						        <p><b><%if(bookingFlatList2.getBuyerAadhaarNumber()!=null){out.print(bookingFlatList2.getBuyerAadhaarNumber());} %></b></p>
						        <p class="p-custom">Permanent Address</p>
						        <p><b><%if(bookingFlatList2.getBuyerPermanentAddress()!= null){out.print(bookingFlatList2.getBuyerPermanentAddress()); }%></b></p>
						        <p class="p-custom">Current Address</p>
						        <p><b><%if(bookingFlatList2.getBuyerCurrentAddress()!=null){out.print(bookingFlatList2.getBuyerCurrentAddress());} %></b></p>
						        <hr>
						      </div>
						      <button type="button" onclick="showBuyerDetails(<%out.print(bookingFlatList2.getFlatId()); %>)" class="button red">Cancel</button>
						      <%}} %>
					    </div>
					  </div>
                    </div>
                  </div>
                </div>
                <div class="unholdsection center">
                     <button class="un-hold" id="unhold">Unhold</button>
                </div>
           		<div class="holdsection center">
             		<button class="hold" id="hold">Hold</button>
           		</div>
              </div>
           </div>
          </div>
          <!-- modal pop up -->
        
        <div class="modal fade" id="zoomimg"  role="dialog">
		   <div class="modal-dialog inbox">
		      <div class="modal-content">
		        <div class="modal-body">
		        <div class="carousel-inner" id="flatList">
		        <% if(bookingFlatList2 != null){
					     		if(bookingFlatList2.getFlatStatus() == 1){%>
		           <div class="row">
					  <div class="col-md-10 col-sm-10 col-xs-10">
					  </div>
					  <div class="col-md-2 col-sm-2 col-xs-2">
					     <img src="../../images/error.png" alt="cancle" data-dismiss="modal">
					  </div>
				    </div>
				  	<div class="row">
				  	  <div class="col-sm-7 col-md-7 col-xs-7">
				  	  <%if(bookingFlatList2.getImage()!="" && bookingFlatList2.getImage() != null){ %>
						     <img src="${baseUrl}/<%out.print(bookingFlatList2.getImage()); %>" alt="Flat image" class="custom-img" >
					  <%} %>
				  	  </div>
				  	  <div class="col-sm-5 col-md-5 col-xs-5">
				  	    <div class="row custom-row">
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Flat Type</p>
						      <p><b><%out.print(bookingFlatList2.getFlatType()); %></b></p>
						    </div>
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Carpet Area</p>
						      <p><b><%out.print(bookingFlatList2.getCarpetArea()); %> <%out.print(bookingFlatList2.getCarpetAreaunit()); %></b></p>
						   </div>
						</div>
						 <div class="row custom-row">
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Flat Type</p>
						      <p><b><%out.print(bookingFlatList2.getFlatType()); %></b></p>
						    </div>
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Carpet Area</p>
						      <p><b>500 SQ/FT</b></p>
						   </div>
						</div>
						 <div class="row custom-row">
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Flat Type</p>
						      <p><b>1BHK</b></p>
						    </div>
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Carpet Area</p>
						      <p><b>500 SQ/FT</b></p>
						   </div>
						</div>
						 <div class="row custom-row">
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Flat Type</p>
						      <p><b>1BHK</b></p>
						    </div>
						   <div class="col-md-6 col-sm-6 col-xs-6">
						      <p class="p-custom">Carpet Area</p>
						      <p><b>500 SQ/FT</b></p>
						   </div>
						</div>
				  	  </div>
				  	  </div>
				  	  <%}} %>
				   </div>
			  	</div>
		 	  </div>
            </div>
		  </div>
       <!--  modal pop up ends -->
        </div>
    <!-- /.container-fluid -->
   <div id="sidebar1"> 
	     <%@include file="../../partial/footer.jsp"%>
	  </div> 
  </body>
</html>
<script>

$('#unhold').click(function(){
	var ids = $("#sel-flat-id").val();
		ajaxindicatorstart("Please wait while, we update status ...");
		$.get("${baseUrl}/webapi/builder/flat/markunhold/"+ids,{},function(data){
			ajaxindicatorstop();
			$("#"+ids).removeClass("holdcolor");
			$("#"+ids).removeClass("yellowcolor yell");
			$("#"+ids).addClass("btn-info");
		},'json');
   	$(".holdsection").hide(".holdsection");
   	$(".unholdsection").hide(".unholdsection");
   	var id = $("#sel-flat-id").val();
	showFlatwithImage(id,$("#emp_id").val());
	});
$('#hold').click(function(){
	var ids = $("#sel-flat-id").val();
		ajaxindicatorstart("Please wait while, we update status ...");
		$.get("${baseUrl}/webapi/builder/flat/markhold/"+ids,{},function(data){
			ajaxindicatorstop();
			$("#"+ids).removeClass("holdcolor");
			$("#"+ids).removeClass("btn-info");
			if($("#"+ids).hasClass("yell")) {
				$("#"+ids).addClass("yellowcolor");
    		} else {
    			$("#"+ids).addClass("yellowcolor yell");
    		}
		},'json');
   	$(".holdsection").hide(".holdsection");
   	var id = $("#sel-flat-id").val();
   	showFlatwithImage(id,$("#emp_id").val());
	});


function toggleFlat(input,status) {
	if($(input).hasClass("yellowcolor")){
		$(".unholdsection").show();
		$(".holdsection").hide();
	} else if($(input).hasClass("holdcolor")){
		$(".holdsection").hide();
		$(".unholdsection").hide();
	} else {
		$(".holdsection").show();
		$(".unholdsection").hide();
	}
	var flatid = $(input).attr('data-value');
	$("#sel-flat-id").val(flatid);
	if(status == 1) {
		showFlatwithImage(flatid);
	} else if(status == 2) {
		showFlatwithImage(flatid);
	}
}


$("#cancellation").click(function(){
	ajaxindicatorstart("Loading...");	
	window.location.href="${baseUrl}/builder/saleshead/cancellation/Salesman_booking_new2.jsp?project_id="+<%out.print(project_id);%>
});
$("#campaign").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/saleshead/campaign/Salesman_campaign.jsp?project_id="+<%out.print(project_id);%>
});
$("#leads").click(function(){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/saleshead/leads/Salesman_leads.jsp?project_id="+<%out.print(project_id);%>
});
function activeInactiveFlats(){
	$('.nav li a').click(function(e) {
        $('.nav li.active').removeClass('active');
        
        var $parent = $(this).parent();
        if($parent.hasClass('grey')){
        	$parent.removeClass('grey');
	        $parent.addClass('active');
	        $parent.addClass('grey');
	        e.preventDefault();
        }
        
    });
}

<% if(flatListDatas !=null){%>
$(window).load(function () {
		 <%for(int i=0;i<flatListDatas.size();i++){
			 if(flatListDatas.get(i) != null){
			 	for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){
				 	for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){
				 		for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
				 			if(bookingFlatList2 != null){
               	  			if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId() == bookingFlatList2.getFlatId()){
	 %>
    /*$("#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>").click(function (e) {
        e.preventDefault();
    });*/
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').trigger('click');
  //  $("#hold").hide();
    //$("#unhold").hide();
    //showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>);
    $("#sel-flat-id").val(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>);
    
    <%							}
				 			}
               	  		}
				 	}
				}
			}
		}
	 %>
});
<% } %>
function showFlat(id){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/saleshead/booking/Salesman_booking_form3.jsp?flat_id="+id;
}
function showBuyerDetails(flatId){
	ajaxindicatorstart("Loading...");
	window.location.href="${baseUrl}/builder/saleshead/booking/edit_booking_form.jsp?flat_id="+flatId;
}
function showFlatwithImage(id){
	$(".holdcolor").each(function(){
		$(this).removeClass("holdcolor");
	});
	$("#"+id).addClass("holdcolor");
	var flatdetails = "";
	$("#home").empty();
	var htmlFlat ="";
	if(id != ''){
		ajaxindicatorstart("Loading...");
		$.get("${baseUrl}/webapi/project/building/floor/flat/detail/",{flat_id : id,emp_id:$("#emp_id").val()},function(data){
			if(data.flatStatus == 1){
				var image = '';
				if(data.image != ''){
					image = '${baseUrl}/'+data.image;
				}
				htmlFlat ='<button class="full white" onclick="showImagewithDetails('+data.flatId+');"><img src="'+image+'" alt="Project image" class="flat-img"></button>'
		 	      		+'<hr>'
		 	      		+'<div class="row custom-row">'
		 	        	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Flat Type</p>'
		 	          	+'<p><b>'+data.flatType+'</b></p>'
		 	        	+'</div>'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Carpet Area</p>'
		 	          	+'<p><b>'+data.carpetArea+' SQ/FT</b></p>'
		 	       	 	+'</div>'
		 	      		+'</div>'
		 	      		+'<div class="row custom-row">'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Bedrooms</p>'
		 	          	+'<p><b>'+data.bedroom+'</b></p>'
		 	        	+'</div>'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Bathroom</p>'
		 	         	+'<p><b>'+data.bathroom+'</b></p>'
		 	        	+'</div>'
		 	      		+'</div>'
		 	      		+'<div class="row custom-row">'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	         	+'<p class="p-custom">Balcony</p>'
		 	         	+'<p><b>'+data.balcony+'</b></p>'
		 	        	+'</div>'
		 	        	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	         	+'<p class="p-custom">Bedroom Size</p>'
		 	          	+'<span><b>'+data.length+' '+data.areaUint+' * '+data.breadth+' '+data.areaUint+' </b></span>'
		 	        	+'</div>'
		 	      		+'</div>'
		 	      		+'<button type="button" onclick="showFlat('+data.flatId+');" class="btn-change">Book Now</button>';
				$(".holdsection").show();
			   	$(".unholdsection").hide();
				}
			else if(data.flatStatus == 2){
				var image = '';
				if(data.buyerPhoto != ''){
					image = '${baseUrl}/'+data.buyerPhoto;
				}
	      			htmlFlat ='<div class="user-profile">'
				          +'<img src="'+image+'" alt="User Image" class="custom-img">'
				          +'<img src="../../images/camera_icon.PNG" alt="camera" class="camera"/>'
				          +'<p><b>'+data.buyerName+'</b></p>'
				          +'<p class="p-custom">'+data.buildingName+', '+data.flatNo+', '+data.projectName+'</p>'
				          +'<hr>'
				       	  +'</div>'
					      +'<div class="row custom-row user-row">'
					      +'<p class="p-custom">Mobile No.</p>'
					      +'<p><b>'+data.buyerMobile+'</b></p>'
					      +'<p class="p-custom">Email</p>'
					      +'<p><b>'+data.buyerEmail+'</b></p>'
					      +'<p class="p-custom">PAN</p>'
					      +'<p><b>'+data.buyerPanNo+'</b></p>'
					      +'<p class="p-custom">Adhar card no.</p>'
					      +'<p><b>'+data.buyerAadhaarNumber+'</b></p>'
					      +'<p class="p-custom">Permanent Address</p>'
					      +'<p><b>'+data.buyerPermanentAddress+'</b></p>'
					      +'<p class="p-custom">Current Address</p>'
					      +'<p><b>'+data.buyerCurrentAddress+'</b></p>'
					      +'<hr>'
					      +'</div>'
					      +'<button type="button" onclick="showBuyerDetails('+data.flatId+')" class="button">Edit</button>';
	      			$(".holdsection").hide();
	    		   	$(".unholdsection").hide();
			}
			else if(data.flatStatus == 3){
				var image = '';
				if(data.image != ''){
					image = '${baseUrl}/'+data.image;
				}
				console.log("flat status :: "+data.flatStatus);
				console.log("image :: "+image);
				htmlFlat ='<button class="full white" onclick="showImagewithDetails('+data.flatId+');"><img src="'+image+'" alt="Project image" class="flat-img"></button>'
		 	      		+'<hr>'
		 	      		+'<div class="row custom-row">'
		 	        	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Flat Type</p>'
		 	          	+'<p><b>'+data.flatType+'</b></p>'
		 	        	+'</div>'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Carpet Area</p>'
		 	          	+'<p><b>'+data.carpetArea+' SQ/FT</b></p>'
		 	       	 	+'</div>'
		 	      		+'</div>'
		 	      		+'<div class="row custom-row">'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Bedrooms</p>'
		 	          	+'<p><b>'+data.bedroom+'</b></p>'
		 	        	+'</div>'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	          	+'<p class="p-custom">Bathroom</p>'
		 	         	+'<p><b>'+data.bathroom+'</b></p>'
		 	        	+'</div>'
		 	      		+'</div>'
		 	      		+'<div class="row custom-row">'
		 	       		+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	         	+'<p class="p-custom">Balcony</p>'
		 	         	+'<p><b>'+data.balcony+'</b></p>'
		 	        	+'</div>'
		 	        	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		 	         	+'<p class="p-custom">Bedroom Size</p>'
		 	          	+'<p><b>'+data.length+' '+data.areaUint+' * '+data.breadth+' '+data.areaUint+' </b></p>'
		 	        	+'</div>'
		 	      		+'</div>'
		 	      		+'<p class="text-center" style="font-size:15px;"><b>Flat is on hold</b></p>';
				$(".holdsection").hide();
			   	$(".unholdsection").show();
				}
	 	 $("#home").append(htmlFlat);
	 	ajaxindicatorstop();
		},'json');
		//ajaxindicatorstop();
		activeInactiveFlats();
	}
}

function showImagewithDetails(id){
	if( id != ''){
		ajaxindicatorstart("Loading...");
		$.get("${baseUrl}/webapi/project/building/floor/flat/detail/",{flat_id : id, emp_id:$("#emp_id").val()},function(data){
			if(data.flatStatus == 1){
				$("#flatList").empty();
				var image = '';
				if(data.image != ''){
					image = '${baseUrl}/'+data.image;
				}
	 		flatdetails = '<div class="row">'
			+'<div class="col-md-10 col-sm-10 col-xs-10">'
			+'</div>'
			+'<div class="col-md-2 col-sm-2 col-xs-2">'
			+'<a href=""><img src="../../images/error.png" alt="cancle" data-dismiss="modal"></a>'
			+'</div>'
		    +'</div>'
		  	+'<div class="row">'
		  	+'<div class="col-sm-7 col-md-7 col-xs-7">'
			+'<img src="'+image+'" alt="Flat image" class="custom-img" >'
		  	+'</div>';
		  	flatdetails +='<div class="col-sm-5 col-md-5 col-xs-5">';
		  	flatdetails	+='<div class="row custom-row">'
			  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
			  	+'<p class="p-custom">Flat Type</p>'
			  	+'<p><b>'+data.flatType+'</b></p>'
			  	+'</div>'
			  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
			  	+'<p class="p-custom">Carpet Area</p>'
			  	+'<p><b>'+data.carpetArea+' '+data.areaUint+'</b></p>'
			  	+'</div>'
			  	+'</div>'
			  	+'<div class="row custom-row">';
		  	$(data.builderBuildingFlatTypeRooms).each(function(index){
		  	if(data.builderBuildingFlatTypeRooms[index].lengthUnit ==1){
		  		unitname = "Feet";
		  	}else if(data.builderBuildingFlatTypeRooms[index].lengthUnit ==2){
		  		unitname = "Meter";
		  	}else if(data.builderBuildingFlatTypeRooms[index].lengthUnit ==3){
		  		unitname = "inch";
		  	}else if(data.builderBuildingFlatTypeRooms[index].lengthUnit ==4){
		  		unitname = "Yard";
		  	}
		  		flatdetails +='<div class="col-md-6 col-sm-6 col-xs-6">'
			  	+'<p class="p-custom">'+data.builderBuildingFlatTypeRooms[index].roomName+'</p>'
			  	+'<p><b>'+data.builderBuildingFlatTypeRooms[index].length+' x '+data.builderBuildingFlatTypeRooms[index].breadth+' '+unitname+'</b></p>'
			  	+'</div>';
		  	});
		  	flatdetails +='</div>'
		$("#flatList").append(flatdetails);
	  	$('#zoomimg').modal('show');
			}
			if( data.flatStatus == 3){
				$("#flatList").empty();
				console.log("Data :: flat status :: "+data.flatStatus)
				var image = '';
				if(data.image != ''){
					image = '${baseUrl}/'+data.image;
				}
	 		flatdetails = '<div class="row">'
			+'<div class="col-md-10 col-sm-10 col-xs-10">'
			+'</div>'
			+'<div class="col-md-2 col-sm-2 col-xs-2">'
			+'<a href=""><img src="../../images/error.png" alt="cancle" data-dismiss="modal"></a>'
			+'</div>'
		    +'</div>'
		  	+'<div class="row">'
		  	+'<div class="col-sm-7 col-md-7 col-xs-7">'
			+'<img src="'+image+'" alt="Flat image" class="custom-img" >'
		  	+'</div>'
		  	+'<div class="col-sm-5 col-md-5 col-xs-5">'
		  	+'<div class="row custom-row">'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Flat Type</p>'
		  	+'<p><b>'+data.flatType+'</b></p>'
		  	+'</div>'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Carpet Area</p>'
		  	+'<p><b>'+data.carpetArea+' '+data.carpetAreaUnit+'</b></p>'
		  	+'</div>'
		  	+'</div>'
		  	+'<div class="row custom-row">'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Flat Type</p>'
		  	+'<p><b>1BHK</b></p>'
		  	+'</div>'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Carpet Area</p>'
		  	+'<p><b>500 SQ/FT</b></p>'
		  	+'</div>'
		  	+'</div>'
		  	+'<div class="row custom-row">'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Flat Type</p>'
		  	+'<p><b>1BHK</b></p>'
		  	+'</div>'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Carpet Area</p>'
		  	+'<p><b>500 SQ/FT</b></p>'
		  	+'</div>'
		  	+'</div>'
		  	+'<div class="row custom-row">'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Flat Type</p>'
		  	+'<p><b>1BHK</b></p>'
		  	+'</div>'
		  	+'<div class="col-md-6 col-sm-6 col-xs-6">'
		  	+'<p class="p-custom">Carpet Area</p>'
		  	+'<p><b>500 SQ/FT</b></p>'
		  	+'</div>'
		  	+'</div>'
		  	+'</div>'
		  	+'</div>';
		$("#flatList").append(flatdetails);
	  	$('#zoomimg').modal('show');
			}
			ajaxindicatorstop();
		},'json');
	}
}
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() != '' ){
			ajaxindicatorstart("Loading...");
			$.get("${baseUrl}/webapi/project/building/floor/list/",{ building_id: value }, function(data){
				getFlatDetails();
				var html = '<option value="0">All Floor</option>';
				if(data != ""){
					$(data).each(function(index){
						html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
					});
					$select_floor[0].selectize.destroy();
					$("#filter_floor_id").html(html);
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value) {
							 if( value != '' ){
								 getFlatDetails();
								}
						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("0");
					   		obj[0].setTest("All Floor");
					   	 }
					    }
					});
				}else{
					
					$select_floor[0].selectize.destroy();
					$("#filter_floor_id").html("");
					$("#floorDetailsTab").hide();
					$("#floorDetailsTab1").html("<span class='text-danger'>Sorry No floor found..</span>");
					$("#floorDetailstab1").show();
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value) {

						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("0");
					   		obj[0].setTest("All Floor");
					   	 }
					    }
					});
				}
				ajaxindicatorstop();
			},'json');
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_building_id :selected").text();
    	 if(textClear.trim() == "Enter Building Name"){
    		 obj[0].setValue("0");
    	 }
     }
});
<%if(building_size_list > 0){%>
	select_building = $select_building[0].selectize;
<%}%>

$select_floor = $("#filter_floor_id").selectize({
	persist: false,
	 onChange: function(value) {
		if(($( $("#filter_building_id").val() != '')  && $("#filter_floor_id").val() != '' )){
			//window.location.href = "${baseUrl}/builder/project/building/floor/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+value;
			getFlatDetails();
		}
	 },
	 onDropdownOpen: function(value){
   	 var obj = $(this);
		var textClear =	 $("#filter_floor_id :selected").text();
   	 if(textClear.trim() == "Enter Floor Name"){
   		 obj[0].setValue("0");
   		 obj[0].setTest("All Floor");
   	 }
    }
});

<% if(floor_size_list > 0){%>
  select_floor = $select_floor[0].selectize;
<%}%>

$select_eveOrodd = $("#evenOrodd").selectize({
	persist: false,
	onChange: function(value){
		if(value != ''){
			getFlatDetails();
		}
	},
	onDropdownOpen: function(value){
		var obj = $(this);
		var textClear = $("#evenOrodd:selected").text();
		if(textClear.trim() == "Even & Odd"){
			obj[0].setValue("0");
		}
	}
});



function getFlatDetails(){
	var no = $("#filter_building_id").val();
		$.get("${baseUrl}/builder/saleshead/booking/flatlist.jsp?project_id="+<%out.print(project_id);%>+"&building_id="+no+"&floor_id="+$("#filter_floor_id").val()+"&evenOrodd="+$("#evenOrodd").val(),{ }, function(data){
			if($.trim(data)){
				$("#flatdetails").html(data);
			}else{
				$("#flatdetails").html("<span class='text-danger'>Sorry No Flat found.</span>");
			}
		},'html');
}

</script>
