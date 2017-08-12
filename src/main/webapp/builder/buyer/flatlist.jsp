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
	project_id = Integer.parseInt(request.getParameter("project_id"));
	building_id = Integer.parseInt(request.getParameter("building_id"));
	//evenOrodd = Integer.parseInt(request.getParameter("evenOrodd"));
	if(request.getParameter("floor_id") != null && request.getParameter("floor_id") != ""){
		if(Integer.parseInt(request.getParameter("floor_id")) > 0){
			floor_id = Integer.parseInt(request.getParameter("floor_id"));
		}
	}
	flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,evenOrodd);
	
%>
 <% if(flatListDatas !=null){
      for(int i=0;i<flatListDatas.size();i++){ %>
                    <!-- floor 1 -->
      <ul class="nav nav-pills">
      <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().size();floor_size++){ %>
      <% 	for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
               if(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus() == "available"){
      %>
     			<li class=""><a data-toggle="pill" href="#home"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
   				<%}else{%>
	   			<li style="color:#4dcfcf;"><a data-toggle="pill" href="#home"><% out.print(flatListDatas.get(i).getBuildingListDatas().get(i).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
   	<%
   				}
            }
      	}
      %>
   </ul>
   <hr>
<%	}
   } 
%>
      
      
      