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
 <% 
 	int p_user_id = 0; 
 	int project_id=0; 
 	int access_id=0; 
 	int emp_id = 0;
 	int building_size_list =0; 
 	int floor_size_list = 0; 
 	BuilderFloor builderFloor = null; 
 	int building_id = 0; 
	int floor_id = 0; 
	int flat_id = 0;
	String floor_status_name = "";
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
 	project_id = Integer.parseInt(request.getParameter("project_id")); 
 	projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
 	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id); 
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id); 
 	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id); 
 	List<BuilderProjectApprovalInfo> projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id); 
	
 	session = request.getSession(false); 
	
 	BuilderEmployee builder = new BuilderEmployee(); 
 	if(session!=null) 
 	{ 
 		if(session.getAttribute("ubname") != null) 
 		{ 
 			builder  = (BuilderEmployee)session.getAttribute("ubname"); 
 			p_user_id = builder.getBuilder().getId(); 
 			emp_id = builder.getId();
 			access_id = builder.getBuilderEmployeeAccessType().getId(); 
 			//buildingList =  new ProjectDAO().getBuilderActiveProjectBuildings(project_id); 
 			builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id); 
 			building_id = builderBuildingList.get(0).getId(); 
			flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,0); 
 			bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,floor_id,0); 
 			if(bookingFlatList2 != null){
 				if( bookingFlatList2.getImage() != null){
 					image = bookingFlatList2.getImage(); 
 				}
 			}
 			flat_size = flatListDatas.size(); 
		
			//building_id = builderBuildingList.get(0).getId(); 
			//floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id); 
 			//floor_size_list = floorList.size(); -->
 			if(builderBuildingList != null && builderBuildingList.size() > 0){ 
				building_id = builderBuildingList.get(0).getId();  
				building_size_list = builderBuildingList.size(); 
 				floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id); 
 				if(floorList != null && floorList.size() > 0){ 
					floor_id = floorList.get(0).getId();
					floor_size_list = floorList.size(); 
 				} 
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
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
   <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
<!--     <link rel="stylesheet" type="text/css" href="../css/cancellation.css"> -->
<!-- 	 <link rel="stylesheet" type="text/css" href="../css/custom7.css"> -->
	  <link rel="stylesheet" type="text/css" href="../css/cancellation-top.css">
	   <link rel="stylesheet" type="text/css" href="../css/newcancellationlist.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script type="text/javascript" src="../js/selectize.min.js"></script>
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
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="booking" class="btn11 btn-info waves-effect waves-light m-t-10">BOOKING</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="cancellation" class="btn11 btn-submit waves-effect waves-light m-t-10">CANCELLATION</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="leads" class="btn11 btn-info waves-effect waves-light m-t-10">LEADS</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" id="campaign" class="btn11 btn-info waves-effect waves-light m-t-10">CAMPAIGN</button>
		                </div>
	                </div>
               <!-- row -->
                <!--.row -->
                  <div class="row re">
                    <div class="col-md-4 col-sm-4 col-xs-12">
                        <select id="filter_building_id" name="filter_building_id">
                        		<option value="0"></option>
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
                  <input type="hidden" id="project_id" name="project_id" value="<%out.print(project_id);%>"/>  
                  <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id); %>"/>
                 <div class="white-box">
                   <div class="row" id="cancalflat">
                      <div class="col-md-8 col-sm-6 col-xs-12  bg1">
                         <div class="white-box">
                           <!-- floor 1 -->
                            <% if(flatListDatas !=null){
 	            					String active = ""; 
 	            					for(int i=0;i<flatListDatas.size();i++){  
	              						for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){ %> 
	                          
							      <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){  %>
							      <ul class="nav nav-pills custom-button-nav"> 
               	 						<%for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){ 
 							     if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("booked")) {%>
 							     
 							     <li class="grey item"><a  data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="javascript:showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>)" href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
 							      
 							     <%} else if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")) {%>
 		              					
               	 					 <li class="" style="pointer-events:none;"><a  data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" disabled href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>	
               	 						<%}
               	 						} 
 		            		 			%> 
 										</ul> 
					 					<hr> 
 	    					<% }
 	    							} %>
 	    							
 	         					<%} 
 	     					 } 
                          
 	     					%> 
						 </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                     <div class="bg1">
                       <div class="tab-content">
                       		<div id="home" class="tab-pane fade in active">
							<% if(bookingFlatList2 != null){
								if((access_id==5 || access_id==7) && bookingFlatList2.getFlatStatus() == 2 &&  bookingFlatList2.getIsDeleted() != null && bookingFlatList2.getIsDeleted() == 0 && (bookingFlatList2.getIsApproved()==false) && (bookingFlatList2.getCancelStatus() == 0)){
					     	%>				   
						       <div class="user-profile">
						      <%if(bookingFlatList2.getBuyerPhoto()!="" && bookingFlatList2.getBuyerPhoto() != null){ %>
							     <img src="${baseUrl}/<%out.print(bookingFlatList2.getBuyerPhoto()); %>" alt="Buyer image" class="custom-img">
							   <%}%>	
						          <img src="../images/camera_icon.PNG" alt="camera " class="camera"/>
						          <p><b><%out.print(bookingFlatList2.getBuyerName()); %></b></p>
						          <p class="p-custom"><%out.print(bookingFlatList2.getBuildingName()); %>-<%out.print(bookingFlatList2.getFlatNo()); %>, <%out.print(bookingFlatList2.getProjectName()); %></p>
						          <hr>
						       </div>
							   <div class="row custom-row user-row">
							        <p class="p-custom">Mobile Nomm.</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerMobile()); %></b></p>
							        <p class="p-custom">Email</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerEmail()); %></b></p>
							        <p class="p-custom">PAN</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPanNo()); %></b></p>
							        <p class="p-custom">Adhar card no.</p>
							        <p><b></b></p>
							        <p class="p-custom">Permanent Address</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPermanentAddress()); %></b></p>
							        <p class="p-custom">Current Address</p>
							        <p><b></b></p>
							        <hr>
							   </div>
						      <button type="button" onclick="showFlats(<%out.print(bookingFlatList2.getFlatId()); %>)" class="button red">Cancel</button>
						      <%}
								if(access_id == 5 &&  bookingFlatList2.getFlatStatus() == 2 &&  bookingFlatList2.getIsDeleted() != null && bookingFlatList2.getIsDeleted() == 0 && !bookingFlatList2.getIsApproved() && (bookingFlatList2.getCancelStatus() == 1) ){%>
						     	 <div class="user-profile">
						      <%if(bookingFlatList2.getBuyerPhoto()!="" && bookingFlatList2.getBuyerPhoto() != null){ %>
							     <img src="${baseUrl}/<%out.print(bookingFlatList2.getBuyerPhoto()); %>" alt="Buyer image" class="custom-img">
							   <%}%>	
						          <img src="images/camera_icon.PNG" alt="camera " class="camera"/>
						          <p><b><%out.print(bookingFlatList2.getBuyerName()); %></b></p>
						          <p class="p-custom"><%out.print(bookingFlatList2.getBuildingName()); %>-<%out.print(bookingFlatList2.getFlatNo()); %>, <%out.print(bookingFlatList2.getProjectName()); %></p>
						          <hr>
						       </div>
							   <div class="row custom-row user-row">
							        <p class="p-custom">Mobile No.</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerMobile()); %></b></p>
							        <p class="p-custom">Email</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerEmail()); %></b></p>
							        <p class="p-custom">PAN</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPanNo()); %></b></p>
							        <p class="p-custom">Aadhaar card no.</p>
							        <p><b><% if(bookingFlatList2.getBuyerAadhaarNumber()!=null){out.print(bookingFlatList2.getBuyerAadhaarNumber());} %></b></p>
							        <p class="p-custom">Permanent Address</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPermanentAddress()); %></b></p>
							        <p class="p-custom">Current Address</p>
							        <p><b><%if(bookingFlatList2.getBuyerCurrentAddress()!=null){out.print(bookingFlatList2.getBuyerCurrentAddress());} %></b></p>
							        <hr>
							   </div>
						     	
						     	 <div class="row custom-row user-row red">
						         <p>Reason of Cancellation</p>
						         <p><b><%out.print(bookingFlatList2.getCancelReason()); %></b></p>
						         <p>Amount <input type="text" id="cancelAmount" name="cancelAmount" placeholder="cncellation charges" value="<%out.print(bookingFlatList2.getCharges()); %>" /></p>
						       </div>
						      <button type="button" onclick="updateCancel(<%out.print(bookingFlatList2.getCancellationId()); %>);" class="button red">Approve</button>
						     <%	}
					     	} %>
					    </div>
					  </div>
                    </div>
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
$("#booking").click(function(){
	window.location.href="${baseUrl}/builder/buyer/salesman_bookingOpenForm.jsp?project_id="+<%out.print(project_id);%>;
});
$("#campaign").click(function(){
	window.location.href="${baseUrl}/builder/campaign/Salesman_campaign.jsp?project_id="+<%out.print(project_id);%>;
});
$("#leads").click(function(){
	window.location.href="${baseUrl}/builder/leads/Salesman_leads.jsp?project_id="+<%out.print(project_id);%>
});
<% if(flatListDatas !=null){%>
$(document).ready(function () {
		 <%for(int i=0;i<flatListDatas.size();i++){
			 for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){
				 for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){
				 	for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
				 		if(bookingFlatList2 != null){
               	  			if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId() == bookingFlatList2.getFlatId()){
	 %>
    $("#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>").click(function (e) {
        e.preventDefault();
    });
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').trigger('click');
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').addClass("red");
    
    <%						}
               	  		}
				 	}
				}
			}
		}
	 %>
});
<% } %>
function showFlats(id){
	window.location.href="${baseUrl}/builder/cancellation/Salesman_cancelation_form_open3.jsp?flat_id="+id;
}
function activeInactiveFlats(){
	$('.nav li a').click(function(e) {
        $('.nav li.active').removeClass('active');
        $('.nav li.red').removeClass('red').addClass('grey');
        var $parent = $(this).parent();
        if($parent.hasClass('grey')){
        	$parent.removeClass('grey');
	        $parent.addClass('active');
	        $parent.addClass('red');
	        e.preventDefault();
        }
    });
}
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() != '' ){
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
				
			},'json');
			//window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+value;
			
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

		if(($("#filter_building_id").val() != '') || ($("#filter_floor_id").val() != '' )){
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
		$.get("${baseUrl}/builder/cancellation/cancelflat.jsp?project_id="+<%out.print(project_id);%>+"&building_id="+no+"&floor_id="+$("#filter_floor_id").val()+"&evenOrodd="+$("#evenOrodd").val(),{ }, function(data){
			if($.trim(data)){
				$("#cancalflat").html(data);
			}else{
				$("#cancalflat").html("<span class='text-danger'>Sorry No Flat found.</span>");
			}
		},'html');
}
	
function showFlatwithImage(id){
	$("#home").empty();
	var htmlFlat ="";
	if( id != ''){
		$.get("${baseUrl}/webapi/project/building/floor/flat/detail/",{flat_id : id,emp_id:$("#emp_id").val()},function(data){
			var image = '';
			if(data.buyerPhoto != ''){
				image = '${baseUrl}/'+data.buyerPhoto;
			}
			if(data.flatStatus == 2 &&  data.isDeleted  == 0 && (data.isApproved==false) && (data.cancelStatus == 0) ){
      htmlFlat ='<div class="user-profile">'
		          +'<img src="'+image+'" alt="User Image" class="custom-img">'
		          +'<img src="../images/camera_icon.PNG" alt="camera " class="camera"/>'
		          +'<p><b>'+data.buyerName+'</b></p>'
		          +'<p class="p-custom">'+data.buildingName+'-'+data.flatNo+', '+data.projectName+'</p>'
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
			        +'<p><b></b></p>'
			        +'<p class="p-custom">Permanent Address</p>'
			        +'<p><b>'+data.buyerPermanentAddress+'</b></p>'
			        +'<p class="p-custom">Current Address</p>'
			        +'<p><b>'+data.buyerCurrentAddress+'</b></p>'
			        +'<hr>'
			      +'</div>'
			      +'<button type="button" onclick="showFlats('+data.flatId+')" class="button red">Cancel</button>';
			     
		}
  	if(data.flatStatus == 2 &&  data.isDeleted  == 0 && (data.isApproved==false) && (data.cancelStatus == 1) ){
        htmlFlat ='<div class="user-profile">'
	          +'<img src="'+image+'" alt="User Image" class="custom-img">'
	          +'<img src="../images/camera_icon.PNG" alt="camera " class="camera"/>'
	          +'<p><b>'+data.buyerName+'</b></p>'
	          +'<p class="p-custom">'+data.buildingName+'-'+data.flatNo+', '+data.projectName+'</p>'
	          +'<hr>'
	       	  +'</div>'
		      +'<div class="row custom-row user-row">'
		      +'<p class="p-custom">Mobile No Ajax.</p>'
		      +'<p><b>'+data.buyerMobile+'</b></p>'
		      +'<p class="p-custom">Email</p>'
		      +'<p><b>'+data.buyerEmail+'</b></p>'
		      +'<p class="p-custom">PAN</p>'
		      +'<p><b>'+data.buyerPanNo+'</b></p>'
		      +'<p class="p-custom">Adhar card no.</p>'
		      +'<p><b></b></p>'
		      +'<p class="p-custom">Permanent Address</p>'
	          +'<p><b>'+data.buyerPermanentAddress+'</b></p>'
	          +'<p class="p-custom">Current Address</p>'
	          +'<p><b>'+data.buyerCurrentAddress+'</b></p>'
	          +'<hr>'
	      	  +'</div>'
			  +'<div class="row custom-row user-row red">'
		      +'<p>Reason of Cancellation</p>'
		      +'<p><b>'+data.cancelReason+'</b></p>'
		      +'<p>Amount <input type="text" id="cancel_amount" name="cancel_amount" placeholder="cncellation charges" value="'+data.charges+'" /></p>'
		  	  +'</div>'
		 	  +'<button type="button" onclick="updateCancel('+data.cancellationId+');" class="button red">Approve</button>';
  	}
      			$("#home").append(htmlFlat);
		   
		},'json');
		activeInactiveFlats();
	}
	
}

function updateCancel(id){
	alert("id "+id);
	if($("#cancel_amount").val() != '' && $("#cancel_amount").val() > 0){
		var flag = confirm("Are you sure ? You want to Delete Buyer ?");
		if(flag){
			$.post("${baseUrl}/webapi/project/cancel/primarybuyer/remove/", { id:id, cancel_amount:$("#cancel_amount").val()}, function(data){
	 			alert(data.message);
	 			if(data.status == 1) {
	 				window.location.reload();
	 			}
			});
		}
	}
}
</script>
