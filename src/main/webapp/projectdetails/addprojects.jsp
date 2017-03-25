<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject" %>
<%@page import="java.util.List"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
List<BuilderProject> builder_list = new ProjectDetailsDAO().getBuilderProjectList();
int builder_size=builder_list.size();
%>
			<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Create Project</a></li>
				<li class="active">Add Project</li>
			</ul>
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>
					Project List
					<a href="${baseUrl}/projectdetails/newproject.jsp" class="btn btn-primary btn-sm pull-right" role="button" data-toggle="modal"><i class="fa fa-plus"></i> New Project</a>
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
                                            <th>Status</th>
                                            <th class="alignRight">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<%
                                        for(int i=0; i < builder_size; i++){
                                        %>
                                        <tr>
                                            <td><% out.print(builder_list.get(i).getName()); %></td>
                                            <td><% if(builder_list.get(i).getStatus() == 1) { out.print("<span class='label label-success'>Active</span>"); } else { out.print("<span class='label label-warning'>Inactive</span>"); } %></td>
                                            <td class="alignRight">
                                            	<a href="javascript:editProject(<% out.print(builder_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-pencil"></i></a>
                                            	<a href="javascript:editProjects(<% out.print(builder_list.get(i).getId()); %>);" class="btn btn-success btn-xs icon-btn"><i class="fa fa-eye"></i></a>
<%--                                             	<a href="javascript:deleteBuildingAmenity(<% out.print(amenity_list.get(i).getId()); %>);" class="btn btn-danger btn-xs icon-btn"><i class="fa fa-trash-o"></i></a> --%>
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
<%@include file="../footer.jsp"%>
		<!-- inline scripts related to this page -->
		<script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript">
			function editProject(id){
				window.location.href = "${baseUrl}/projectdetails/editproject.jsp?project_id="+id;
			}
			function editProjects(id){
				window.location.href = "${baseUrl}/projectconfigtabs.jsp?project_id="+id;
			}
		</script>
	</body>
</html>
