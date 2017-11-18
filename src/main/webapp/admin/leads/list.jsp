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
List<BuilderLead> builderLeads = null;
builderLeads = new ProjectDAO().getBuilderProjectLeads();
%>
			<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Leads</li>
				<li class="active">Manage leads</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project leads
					<a href="${baseUrl}/admin/leads/new.jsp" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Leads</a>
				</h1>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<form method="post" action="#" class="form-horizontal" id="submitForm" novalidate="novalidate">	
					<div id="myTabContent" class="tab-content">
                        <!--Contacts tab starts-->
                        <div class="tab-pane fade active in" id="contacts" aria-labelledby="contacts-tab">
                            <div class="contacts-list">
                                <table class="table table-striped table-bordered" id="projecttable">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                           	<th>Project</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                    	if(builderLeads != null){
                                        for(int i=0; i < builderLeads.size(); i++){
                                        	BuilderLead builderLead = builderLeads.get(i);
                                        	BuilderProject builderProject = builderLead.getBuilderProject();
                                        	//BuilderFlat builderFlat = builderLead.getBuilderFlat();
                                        	//BuilderBuilding builderBuilding = builderLead.getBuilderBuilding();
                                        %>
                                        <tr>
                                            <td><% out.print(builderLead.getName()); %></td>
                                            <td><% out.print(builderProject.getName()); %></td>
                                            <td><% out.print(builderLead.getMobile()); %></td>
                                            <td><% out.print(builderLead.getEmail()); %></td>
                                            <td><% if(builderLead.getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="${baseUrl}/admin/leads/edit.jsp?lead_id=<% out.print(builderLead.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>
                                            </td>
                                            
                                        </tr>
                                        <% }} %>
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
		<script type="text/javascript">
			function editProject(id){
				ajaxindicatorstart("Please wait while.. we load ...");
				window.location.href = "${baseUrl}/projectdetails/editproject.jsp?project_id="+id;
			}
			function editProjects(id){
				ajaxindicatorstart("Please wait while.. we load ...");
				window.location.href = "${baseUrl}/projectconfigtabs.jsp?project_id="+id;
			}
		</script>
	</body>
</html>
