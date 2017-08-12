<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int project_id = 0;
	int building_id = 0;
	int floor_id =	0;
	int evenOrodd = 0;
	List<FlatListData> flatListDatas = null;
	BookingFlatList bookingFlatList2 = null;
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	//evenOrodd = Integer.parseInt(request.getParameter("evenOrodd"));
	if(request.getParameter("floor_id") != null && request.getParameter("floor_id") != ""){
		if(Integer.parseInt(request.getParameter("floor_id")) > 0){
			floor_id = Integer.parseInt(request.getParameter("floor_id"));
		}
	}
	try{
		if(project_id > 0 || building_id > 0 || floor_id > 0 || evenOrodd > 0){
			flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,evenOrodd);
			bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,floor_id,evenOrodd);
		}
	}catch(Exception e){
		
	}
%>
 <% if(flatListDatas !=null && bookingFlatList2 !=null){ %>
    <div class="col-md-8 col-sm-6 col-xs-12  bg1">
          <div class="white-box" >
	                       
          <% for(int i=0;i<flatListDatas.size();i++){ %>
              <!-- floor 1 -->
              <ul class="nav nav-pills">
              <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().size();floor_size++){ %>
              <% for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
            	    if(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus() == "available"){
            	  %>
<li class=""><a data-toggle="pill" href="#home"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
<%}else{%>
<li style="color:#4dcfcf;"><a data-toggle="pill" href="#home"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
<%}}}%>

</ul>
<hr>
              <%} %>
<!-- floor 1 -->
<!-- floor 2 -->
          </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                     <div class="bg1">
                       <div class="tab-content">
                       
					     <div id="home" class="tab-pane fade in active">
					     	<% if(bookingFlatList2.getImage()!="" && bookingFlatList2.getImage() != null){ %>
						     <img src="${baseUrl}/builder/<%out.print(bookingFlatList2.getImage()); %>" alt="Project image" class="custom-img">
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
						          <span><b><%out.print(bookingFlatList2.getLength()+" x "+bookingFlatList2.getBreadth()+" "+bookingFlatList2.getAreaUint()); %></b></span>
						        </div>
						      </div>
						      <button type="button" onclick="javascript:showFlat(<%out.print(bookingFlatList2.getFlatId()); %>)" class="button">Book Now</button>
					     </div>
					  </div>
                    </div>
                  </div>
      				<%} %>