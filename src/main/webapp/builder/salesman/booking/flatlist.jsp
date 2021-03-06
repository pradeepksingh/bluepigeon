<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
 
<%
	int project_id = 0;
	int building_id = 0;
	int floor_id =	0;
	int evenOrodd = 0;
	int emp_id=0;
	String image  = "";
	List<FlatListData> flatListDatas = null;
	BookingFlatList bookingFlatList2 = null;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			emp_id = builder.getId();
		
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	evenOrodd = Integer.parseInt(request.getParameter("evenOrodd"));
	if(request.getParameter("floor_id") != null && request.getParameter("floor_id") != ""){
		if(Integer.parseInt(request.getParameter("floor_id")) > 0){
			floor_id = Integer.parseInt(request.getParameter("floor_id"));
		}
	}
	try{
		if(project_id > 0 && building_id > 0){
			flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,evenOrodd);
			bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,floor_id,evenOrodd);
			image = bookingFlatList2.getImage();
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	}
	}
%>
 <% if(flatListDatas !=null && bookingFlatList2 !=null){ %>
   <div class="col-md-8 col-sm-6 col-xs-12  bg1">
        <div class="white-box" >
	     <% if(flatListDatas !=null){
	            String active = "";
	            for(int i=0;i<flatListDatas.size();i++){ 
	              for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){ %>
	                <ul class="nav nav-pills">
	                <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){ 
		               	 for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
		               		if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")){
		             			%>
		             			<li class="item"><a data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>);" href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
		             			<% }else if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("booked") || flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("hold")){%>
		     					<li class="grey"><a  data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>);" href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
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
    <input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
         <div class="bg1">
              <div class="tab-content">
				  <div id="home" class="tab-pane fade in active">
				  <% if(bookingFlatList2 != null){ 
					 	if(bookingFlatList2.getFlatStatus() == 1){
				    	 if(bookingFlatList2.getImage()!="" && bookingFlatList2.getImage() != null){ %>
					   <img src="${baseUrl}/<%out.print( bookingFlatList2.getImage() ); %>" alt="flat image" class="custom-img">
			      <%} %>
				  		<hr><br>
						<div class="row custom-row">
						      <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Flat Type</p>
						          <span><b><%out.print(bookingFlatList2.getFlatType()); %></b></span>
						      </div>
						      <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Carpet Area</p>
						          <span><b><%out.print(bookingFlatList2.getCarpetArea()); %> SQ/FT</b></span>
						      </div>
					    </div>
						<div class="row custom-row">
						      <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bedrooms</p>
						          <span><b><%out.print(bookingFlatList2.getBedroom()); %></b></span>
						      </div>
						      <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bathroom</p>
						          <span><b><%out.print(bookingFlatList2.getBathroom()); %></b></span>
						      </div>
						</div>
						<div class="row custom-row">
						     <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Balcony</p>
						          <span><b><%out.print(bookingFlatList2.getBalcony()); %></b></span>
						     </div>
						     <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom"><%if(bookingFlatList2.getRoomName() != null){out.print(bookingFlatList2.getRoomName()); }%> Size</p>
						          <span><b><%out.print(bookingFlatList2.getLength()+" * "+bookingFlatList2.getBreadth()+" "+bookingFlatList2.getAreaUint()); %></b></span>
						     </div>
					    </div>
						      <button type="button" onclick="showFlat(<%out.print(bookingFlatList2.getFlatId()); %>)" class="btn-change">Book Now</button>
						      <%} 
					 	if(bookingFlatList2.getFlatStatus() == 2 &&  bookingFlatList2.getIsDeleted() != null && bookingFlatList2.getIsDeleted() == 0){
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
							        <p class="p-custom">Adhar card no.</p>
							        <p><b></b></p>
							        <p class="p-custom">Permanent Address</p>
							        <p><b><%out.print(bookingFlatList2.getBuyerPermanentAddress()); %></b></p>
							        <p class="p-custom">Current Address</p>
							        <p><b></b></p>
							        <hr>
							   </div>
						      <button type="button" onclick="showFlats(<%out.print(bookingFlatList2.getFlatId()); %>)" class="button red">Cancel</button>
						      <%}} %>
				  </div>
			</div>
        </div>
    </div>
      				<%} %>
      				<% if(flatListDatas !=null){%>
		<% for(int i=0;i<flatListDatas.size();i++){
			 for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){
				 for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){
				 	for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
				 		if(bookingFlatList2 != null){
              	  			if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId() == bookingFlatList2.getFlatId()){
	 %>
	 <script>

$(document).ready(function () {
   $("#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>").click(function (e) {
       e.preventDefault();
   });
   $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').trigger('click');
});
</script>
   <%						}
              	  		}
				 	}
				 }
			}
		}
	 %>

   <% } %>  				