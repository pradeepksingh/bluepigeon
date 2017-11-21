<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 	int building_size_list =0; 
 	int floor_size_list = 0; 
 	BuilderFloor builderFloor = null; 
 	int building_id = 0; 
	int floor_id = 0; 
	int flat_id = 0;
	int nflatid = 0;
	String floor_status_name = "";
 	List<BookingFlatList> bookingFlatList = null;
 	List<BuilderFloor> floorList = null; 
 	List<BuilderBuilding> builderBuildingList = null;
 	BuilderProject projectList = null;
 	List<BuilderBuilding> buildingList = null;
	List<FlatListData> flatListDatas = null; 
	BookingFlatList bookingFlatList2 = null; 
 	int flat_size = 0;
 	int evenOrodd = 0;
 	int emp_id=0;
 	String image  = ""; 
 	List<ProjectImageGallery> imageGaleries = new ArrayList<ProjectImageGallery>(); 
 	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
 	session = request.getSession(false); 
 	BuilderEmployee builder = new BuilderEmployee(); 
 	if(session!=null) 
 	{ 
 		if(session.getAttribute("ubname") != null) 
 		{ 
 			builder  = (BuilderEmployee)session.getAttribute("ubname"); 
 			p_user_id = builder.getBuilder().getId(); 
 			access_id = builder.getBuilderEmployeeAccessType().getId(); 
 			emp_id=builder.getId();
 		
	 			if (request.getParameterMap().containsKey("project_id")) {
				 	project_id = Integer.parseInt(request.getParameter("project_id")); 
				 	building_id = Integer.parseInt(request.getParameter("building_id"));
					evenOrodd = Integer.parseInt(request.getParameter("evenOrodd"));
					if(request.getParameter("floor_id") != null && request.getParameter("floor_id") != ""){
						if(Integer.parseInt(request.getParameter("floor_id")) > 0){
							floor_id = Integer.parseInt(request.getParameter("floor_id"));
						}
					}
			 	}
	 			if (request.getParameterMap().containsKey("flat_id")) {
				 	nflatid = Integer.parseInt(request.getParameter("flat_id")); 
	 			}
	 			builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id); 
	 			projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
	 			try{
					flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,evenOrodd); 
		 			bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,floor_id,evenOrodd); 
		 			image = bookingFlatList2.getBuyerPhoto(); 
		 			flat_size = flatListDatas.size(); 
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
 			
 		} 
 	} 
 %>
  <% if(flatListDatas !=null && bookingFlatList2 != null){%>
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
 							      
 							     <%} else if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")||flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("hold")) {%>
 		              					
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
                    <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
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
							        <p class="p-custom">Mobile No.</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerMobile()); %></b></p>
							        <p class="p-custom">Email</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerEmail()); %></b></p>
							        <p class="p-custom">PAN</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPanNo()); %></b></p>
							        <p class="p-custom">Aadhaar card no.</p>
							        <p><b><%if(bookingFlatList2.getBuyerAadhaarNumber() != null){out.print(bookingFlatList2.getBuyerAadhaarNumber()); }%></b></p>
							        <p class="p-custom">Permanent Address</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPermanentAddress()); %></b></p>
							        <p class="p-custom">Current Address</p>
							        <p><b><%if(bookingFlatList2.getBuyerCurrentAddress() != null){ out.print(bookingFlatList2.getBuyerCurrentAddress()); }%></b></p>
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
                  <%} %>
                  <% if(flatListDatas !=null && nflatid == 0){%>
                 
		 <%for(int i=0;i<flatListDatas.size();i++){
			 for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){
				 for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){
				 	for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
				 		if(bookingFlatList2 != null){
               	  			if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("booked")){
               	  			if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId() == bookingFlatList2.getFlatId()){
	 %>
	  <script type="text/javascript">
	  $(window).load(function () {
    $("#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>").click(function (e) {
        e.preventDefault();
    });
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').trigger('click');
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').addClass("active");
});
    </script>
    <%						}
               	  		}
               	  	}
				 }
			}
		}
	}
	%>
<%}%>		