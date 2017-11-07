<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployeeAccessType"%>
<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="java.util.Date"%>
<%@page import="org.bluepigeon.admin.data.InboxMessageData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.model.InboxMessage"%>
<%@page import="org.bluepigeon.admin.data.InboxBuyerData"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.model.Source"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
 	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
	int roleId = 0;
	int builderId = 0;
	String keyword = "";
	List<BuilderEmployeeAccessType> builderEmployeeAccessTypes = null;
 	List<EmployeeList> employeeLists = null;
 	int empId = 0;
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	Date date = new Date();
   	if (request.getParameterMap().containsKey("builder_id")) {
   		builderId = Integer.parseInt(request.getParameter("builder_id"));
   		if(builderId != 0) {
   			roleId = Integer.parseInt(request.getParameter("role_id"));
   			keyword = request.getParameter("keyword");
   			employeeLists = new ProjectDAO().getBuilderEmployeeList(builderId,roleId,keyword);
   		}
   	}
   
%>
<%if(employeeLists != null){
	for(EmployeeList employeeList : employeeLists){
%>
<div class="col-md-4">
	<div class="white-box1">
		<div class="user-profile center">
			<%if(employeeList.getImage()!=null){ %>
	        <img src="${baseUrl}/<% out.print(employeeList.getImage());%>" alt="User Image" class="custom-img">
	        <%}else{ %>
			<img src="../plugins/images/Untitled-1.png" alt="User Image" class="custom-img">
			<%} %>
			<p><b><%out.print(employeeList.getName()); %></b></p>
			<p class="p-custom"><%out.print(employeeList.getAccess()); %></p>
  			<br>
		</div>
		<div class="row custom-row user-row">
			<p class="p-custom">Mobile No.</p>
			<p><b><%out.print(employeeList.getMobileNo()); %></b></p>
			<p class="p-custom">Email</p>
			<p><b><%out.print(employeeList.getEmail()); %></b></p>
	    </div>
    </div>
</div>
 <%}} %>