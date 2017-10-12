<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.NewLeadList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
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
	int projectId = 0;
	int emp_id =0 ;
	int access_id = 0;
 	List<BuilderEmployee> salesmanList = null;
 	List<Source> sourceList = null;
 	BuilderProject builderProject = null;
 	List<NewLeadList> newLeadLists = null;
 	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
   	session = request.getSession(false);
   	BuilderEmployee builder = new BuilderEmployee();
   	int builder_id = 0;
   	String keyword = "";
   	int empId = 0;
   	List<BuilderProjectPropertyConfigurationInfo> builderProjectPropertyConfigurationInfos =null;
	if (request.getParameterMap().containsKey("project_id")) {
		projectId = Integer.parseInt(request.getParameter("project_id")); 
		empId = Integer.parseInt(request.getParameter("emp_id"));
		keyword = request.getParameter("keyword");
		builder = new BuilderDetailsDAO().getBuilderEmployeeById(empId);
		salesmanList = new BuilderDetailsDAO().getBuilderSalesman(builder);
	 	newLeadLists = new ProjectDAO().getNewLeadList(projectId,empId,keyword);
	 	
	}
   	if(newLeadLists != null && newLeadLists.size() > 0){
		for(NewLeadList newLeadList : newLeadLists){ %>
	                 <div class="border-lead">
	                  <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getLeadName()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getPhoneNo()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getEmail()); %></h4>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                     <h4><%out.print(newLeadList.getSource()); %></h4>
	                    </div>
	                    <%if(access_id == 7){ %>
	                     <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Follow up
						    <span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="javascript:changeLeadStatus(1,<%out.print(newLeadList.getId());%>)">No Response</a></li>
						      <li><a href="javascript:changeLeadStatus(2,<%out.print(newLeadList.getId());%>)">Call Again</a></li>
						      <li><a href="javascript:changeLeadStatus(3,<%out.print(newLeadList.getId());%>)">Email Sent</a></li>
						      <li><a href="javascript:changeLeadStatus(4,<%out.print(newLeadList.getId());%>)">Visit Again</a></li>
						      <li><a href="javascript:changeLeadStatus(5,<%out.print(newLeadList.getId());%>)">Visit Complete</a></li>
						      <li><a href="javascript:changeLeadStatus(6,<%out.print(newLeadList.getId());%>)">Follow up</a></li>
						      <li><a href="javascript:changeLeadStatus(7,<%out.print(newLeadList.getId());%>)">Booked</a></li>
						      <li><a href="javascript:changeLeadStatus(8,<%out.print(newLeadList.getId());%>)">Not interested</a></li>
						    </ul>
						  </div>
	                    </div>
	                    <%} %>
	                    <% if(access_id == 5){%>
	                    <div class="col-md-2 col-sm-2 col-xs-6">
	                      <div class="dropdown">
						  		<select id="select_salesman" class="select_salesman" name="select_salesman" data-style="form-control">
							   <% //if(salesmanList != null ){
	                    		for(BuilderEmployee salesman : salesmanList){%>
							        <option value="<%out.print(salesman.getId());%>"><%out.print(salesman.getName()); %></option>
							    <% }//}%>
							  	</select>
						  </div>
	                    </div>
	                    <%} %>
	                 </div>
	                 <hr>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <img src="../../images/Saleshead-added.PNG" />
	                     <h5>Added By :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Baget.PNG" />
	                     <h5>Budget:</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <img src="../../images/Configuration.PNG" />
	                      <h5>Configuration :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h5>Source :</h5>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline laststatusnam">
	                      <h5>Last States: <b id="laststatusname<%out.print(newLeadList.getId());%>"><%
	                      if(newLeadList.getLeadStatus() == 1)
	                      	out.print("No Response");
	                      if(newLeadList.getLeadStatus() == 2)
	                    	  out.print("Call Again");
	                      if(newLeadList.getLeadStatus() == 3)
	                    	  out.print("Email Sent");
	                      if(newLeadList.getLeadStatus() == 4)
	                    	  out.print("Visit Schedule");
	                      if(newLeadList.getLeadStatus() == 5)
	                    	  out.print("Visit Complete");
	                      if(newLeadList.getLeadStatus() == 6)
	                    	  out.print("Follow Up");
	                      if(newLeadList.getLeadStatus() == 7)
	                    	  out.print("Booked");
	                      if(newLeadList.getLeadStatus() == 8)
	                    	  out.print("Not Interested");
	                      %></b></h5>
	                    </div>
	                 </div>
	                 <div class="row">
	                    <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6><%out.print(newLeadList.getSalesheadName()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                     <h6> <% if(newLeadList.getMin()>0 && newLeadList.getMax()==0 ){
	                    	 out.print("Greater than Rs"+newLeadList.getMin()+" Lakh");
	                     }else if(newLeadList.getMin() == 0 && newLeadList.getMax() >0){
	                    	 out.print("upto Rs"+newLeadList.getMax()+ "Lakh");
	                     }else{                    
		                     out.print("Rs "+newLeadList.getMin());%> -<%out.print(newLeadList.getMax()+" Lakh");
	                     } %> </h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>
	                      <%out.print(newLeadList.getConfigName());
	                      %>
	                      </h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6><%out.print(newLeadList.getSource()); %></h6>
	                    </div>
	                     <div class="col-md-2 col-sm-2 col-xs-6 inline">
	                      <h6>Date: <b><% if(newLeadList.getStrDate() != null){ out.print(newLeadList.getStrDate());} %></b></h6>
	                    </div>
	                 </div>
	               </div>
<%
		}
	}
%>