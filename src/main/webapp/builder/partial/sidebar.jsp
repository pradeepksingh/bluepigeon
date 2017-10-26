<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%
	session = request.getSession(false);
	BuilderEmployee builder_new = new BuilderEmployee();
	int builder_new_id = 0;
	int emp_access_id =0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder_new  = (BuilderEmployee)session.getAttribute("ubname");
			builder_new_id = builder_new.getId();
			emp_access_id = builder_new.getBuilderEmployeeAccessType().getId();
				if(builder_new != null){
%>
<div class="navbar-default sidebar" role="navigation">
	<div class="sidebar-nav navbar-collapse slimscrollsidebar">
    	<ul class="nav" id="side-menu">
            <li class="sidebar-search hidden-sm hidden-md hidden-lg">
             input-group
             	<div class="input-group custom-search-form">
                	<input type="text" class="form-control" placeholder="Search...">
                		<span class="input-group-btn">
            				<button class="btn btn-default" type="button"> <i class="fa fa-search"></i> </button>
            			</span> 
            	</div>
<!--                         input-group -->
            </li>
            <li class="user-pro">
            	<a href="#" class="waves-effect"><img src="${baseUrl }/builder/plugins/images/users/d1.jpg" alt="user-img" class="img-circle"> <span class="hide-menu"><%out.print(builder_new.getName()); %></span></a>
            </li>
            <li class="nav-small-cap m-t-10">--Main Menu--</li>
            <li> <a href="${baseUrl }/builder/dashboard.jsp" class="waves-effect"><i class="ti-dashboard p-r-10">
            </i> <span class="hide-menu">Dashboard</span></a> </li>
           	<% if(emp_access_id == 1 ){ %>
            <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> CEO<span class="fa arrow"></span></span></a>
				<ul class="nav nav-second-level">
					<li> <a href="${baseUrl }/builder/ceo/inbox/inbox.jsp">Inbox</a></li>
                    <li> <a href="${baseUrl }/builder/datanalytics/data_analytics.jsp">Data Analytics</a></li>
                    <li> <a href="${baseUrl }/builder/ceo/employeeslist.jsp">Employees</a></li>
                     <li> <a href="${baseUrl }/builder/leads/leadlist.jsp">Leads</a></li>
                    <li> <a href="${baseUrl }/builder/ceo/addleads.jsp">Add Leads</a></li>
            	</ul>
            </li>
            <%}%>
			<%if( emp_access_id == 6){ %>
            <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class="ti-layout fa-fw"></i>
            <span class="hide-menu"> Buyer<span class="fa arrow"></span></span></a>
                 <ul class="nav nav-second-level">
                     <li> <a href="javascript:void(0)">Manage</a></li>
                     <li> <a href="javascript:void(0)">Cancellation</a></li>
                 </ul>
            </li>
            <% }%>
            <%if(emp_access_id ==2){ %>
            <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="/" class=""></i>
            <span class="hide-menu"> ADMIN<span class=""></span></span></a>
				<ul class="nav nav-second-level">
                	<li> <a href="${baseUrl }/builder/employee/addemployee.jsp">Add Employee</a></li>
                    <li> <a href="${baseUrl }/builder/employee/list.jsp">Employees</a></li>
                    <li> <a href="${baseUrl }/builder/documents/documents.jsp">Add Document</a></li>
<%--                     <li> <a href="${baseUrl }/builder/inbox/inbox.jsp">Inbox</a></li> --%>
                    <li> <a href="${baseUrl }/builder/project/newproject.jsp">Project Start Request</a></li>
                </ul>
           </li>
           <%} %>
           <% if(emp_access_id == 7){ %>
           <li> <a href="javascript:void(0);" class="waves-effect"><!-- <i class="ti-layout fa-fw"></i--><span class="hide-menu"> Salesman<span class="fa arrow"></span></span></a>
				<ul class="nav nav-second-level">
					<li> <a href="${baseUrl }/builder/inbox/inbox.jsp">Inbox</a></li>
                    <li> <a href="${baseUrl }/builder/leads/leadlist.jsp">Leads</a></li>
                    <li> <a href="${baseUrl }/builder/buyer/Salesman-Buyer-list.jsp">Buyer List</a></li>
                    <li> <a href="${baseUrl }/builder/cancellation/Salesman-Cancellation-list.jsp">Cancellation List</a></li>
                    <li> <a href="${baseUrl }/builder/leads/Salesman_add_lead.jsp">Add Lead</a></li>
                    <li> <a href="${baseUrl }/builder/datanalytics/data_analytics.jsp">Data Analytics</a></li>
                </ul>
           </li>
           <%} %>
           <%if(emp_access_id==4){ %>
		   <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu">Project Head<span class="fa arrow"></span></span></a>
                <ul class="nav nav-second-level">
					<li> <a href="${baseUrl }/builder/inbox/inbox.jsp">Inbox</a></li>
                    <li> <a href="${baseUrl }/builder/assignprojects/assign_salesman.jsp">Assign SalesHead</a></li>
                    <li> <a href="${baseUrl }/builder/leads/leadlist.jsp">Leads</a></li>
                    <li> <a href="${baseUrl }/builder/buyer/Salesman-Buyer-list.jsp">Buyer List</a></li>
                    <li> <a href="${baseUrl }/builder/cancellation/Salesman-Cancellation-list.jsp">Cancellation List</a></li>
                    <li> <a href="${baseUrl }/builder/datanalytics/data_analytics.jsp">Data Analytics</a></li>
                    <li> <a href="${baseUrl }/builder/sales/projectlist.jsp">Project Details</a></li>
                    <li> <a href="${baseUrl }/builder/leads/Salesman_add_lead.jsp">Add Leads</a></li>
                </ul>
           </li>
           <% }%>
           <%if(emp_access_id==5){ %>
           <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> Sales<span class="fa arrow"></span></span></a>
           		<ul class="nav nav-second-level">
					<li> <a href="${baseUrl }/builder/inbox/inbox.jsp">Inbox</a></li>
                    <li> <a href="${baseUrl }/builder/assignprojects/assign_salesman.jsp">Assign Salesman</a></li>
                    <li> <a href="${baseUrl }/builder/leads/leadlist.jsp">Leads</a></li>
                    <li> <a href="${baseUrl }/builder/buyer/Salesman-Buyer-list.jsp">Buyer List</a></li>
                    <li> <a href="${baseUrl }/builder/cancellation/Salesman-Cancellation-list.jsp">Cancellation List</a></li>
                    <li> <a href="${baseUrl }/builder/leads/Salesman_add_lead.jsp">Add Lead</a></li>
                    <li> <a href="${baseUrl }/builder/datanalytics/data_analytics.jsp">Data Analytics</a></li>
                    <li> <a href="${baseUrl }/builder/sales/source.jsp">Add Source</a></li>
                </ul>
           </li>
           <% }%>
           <%if(emp_access_id==3 ){ %>
           <li> <a href="javascript:void(0);" class="waves-effect"><i class="ti-layout fa-fw"></i><span class="hide-menu"> Marketing<span class="fa arrow"></span></span></a>
                <ul class="nav nav-second-level">
                    <li> <a href="${baseUrl }/builder/inbox/inbox.jsp">Inbox</a></li>
                      <li> <a href="${baseUrl }/builder/datanalytics/data_analytics.jsp">Data Analytics</a></li>
                     <li> <a href="${baseUrl }/builder/sales/source.jsp">Add Source</a></li>
                      <li> <a href="${baseUrl }/builder/campaign/campaignlist.jsp">Campaign List</a></li>
                      <li> <a href="${baseUrl }/builder/campaign/newcampaign.jsp">New Campaign</a></li>
                </ul>
           </li>
           <%} %>
           <% if(emp_access_id==6){%>
           <li> <a href="javascript:void(0);" class="waves-effect"><i data-icon="F" class="linea-icon linea-software fa-fw"></i><span class="hide-menu"> Inventory<span class="fa arrow"></span></span></a>
           		<ul class="nav nav-second-level">
                	<li> <a href="${baseUrl }/builder/agreement/list.jsp">Agreement</a></li>
                    <li> <a href="${baseUrl }/builder/demandletters/list.jsp">Demand Letter Release</a></li>
                    <li> <a href="${baseUrl }/builder/possession/list.jsp">Allot Possession</a></li>
               </ul>
           </li>
           <%} %>

		</ul>
	</div>
</div>
<%
        }
   	}
}
%>