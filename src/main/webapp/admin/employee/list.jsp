<%@page import="org.bluepigeon.admin.dao.AdminUserDAO"%>
<%@page import="org.bluepigeon.admin.data.PropertyManagerList"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignList"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.model.BuilderLead"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject" %>
<%@page import="java.util.List"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
List<PropertyManagerList> campaignLists = null;
campaignLists = new AdminUserDAO().getProperyManagers();
%>
			<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Employee</li>
				<li class="active">List</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Employees List 
					<a href="${baseUrl}/admin/employee/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Employee</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="managertable">
                                    <thead>
                                        <tr>
                                            <th>Manager</th>
                                           	<th>Contact</th>
                                            <th>Email</th>
                                            <th>BP Role Type</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(PropertyManagerList propertyManagerList : campaignLists){
                                        %>
                                        <tr>
                                            <td><% out.print(propertyManagerList.getName()); %></td>
                                            <td><% out.print(propertyManagerList.getContact()); %></td>
                                            <td><% out.print(propertyManagerList.getEmail()); %></td>
                                            <td><%
                                            out.print(propertyManagerList.getRoleName()); %></td>
                                            <td class="alignRight">
<%--                                             	<a href="${baseUrl}/admin/leads/edit.jsp?lead_id=<% out.print(campaignList.getCampaignId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a> --%>
                                            </td>
                                            
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
               </form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
		<!-- inline scripts related to this page -->
		<link href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
		<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
	</body>
</html>