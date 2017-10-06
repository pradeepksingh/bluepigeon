<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.data.BuilderFlatList"%>
<%
int projectId = 0;
int building_id = 0;
String keyword = "";
List<BuilderFlatList> flats = null;
if (request.getParameterMap().containsKey("project_id")) {
	projectId = Integer.parseInt(request.getParameter("project_id"));
	if(projectId != 0) {
		building_id = Integer.parseInt(request.getParameter("building_id"));
		keyword = request.getParameter("keyword");
		flats = new ProjectDAO().getProjectFlatListByBuilder(projectId, building_id, keyword);
	}
}
SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
Date date = new Date();
%>
<% if(flats !=null){ %>
<div class="floor1">
<% int floor_no = -100; %>
<% for(BuilderFlatList flat :flats) { %>
<% if(floor_no != -100 && flat.getFloorNo() != floor_no) { %>
    </div>
    <div class="floor2">
    <% } %>
    	<a href="javascript:return false;"><button <% if(flat.getFlatStatus().equalsIgnoreCase("booked") || flat.getFlatStatus().equalsIgnoreCase("hold") || flat.getFlatStatus().equalsIgnoreCase("available")) { %>style="pointer-events:none;"<% } %> class="<% if(flat.getFlatStatus().equalsIgnoreCase("booked")) { %>book-flat-button <%} if(flat.getFlatStatus().equalsIgnoreCase("available")) { %>flat-button<% } %> <% if(flat.getFlatStatus().equalsIgnoreCase("hold")) { %> yellowcolor yell<% } %>"><% out.print(flat.getFlatNo()); %></button></a>
<% floor_no = flat.getFloorNo(); %>
<% } %>
</div>
<% } %>
	                   	