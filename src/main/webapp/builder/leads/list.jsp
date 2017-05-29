<%@page import="org.bluepigeon.admin.model.BuilderLead"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%
	List<BuilderLead> project_list = null;
	session = request.getSession(false);
	Builder builder = new Builder();
	int builder_uid = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			builder_uid = builder.getId();
		}
   	}
	if(builder_uid > 0){
		project_list = new ProjectDAO().getBuilderLeadByBuilderId(builder_uid);
		int builder_size = project_list.size();
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <link href="../plugins/bower_components/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="../cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
      <link href="../css/custom.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
  
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
	   <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
   
    </head>

<body class="fix-sidebar">
    <!-- Preloader -->
   
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header"></div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
     </div>
<div id="page-wrapper">
            <div class="container-fluid">
              
                <!-- /row -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box"><br>
                          <center><h1>Manage Leads</h1></center> <br>
                          <a href="${baseUrl}/builder/leads/new.jsp"> <span class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Add New Lead</span></a>
                          <br><br><br>
                            <div class="table-responsive">
                                <table id="myTable" class="table table-striped">
                                    <thead>
                                        <tr>
                                        	<th>Sr. No</th>
                                         	<th>Name</th>
                                            <th>Builder Name</th>
                                            <th>City Name</th>
                                            <th>Locality</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                      if(project_list != null){
                                    	  int i=0;
                                      	for(BuilderLead project : project_list) { %>
									<tr>
									<td>
											<% out.print(i); %>
										</td>
										<td>
											<% out.print(project.getName()); %>
										</td>
										<td>
											<% out.print(project.getBuilderProject().getName()); %>
										</td>
										<td>
											<% out.print(project.getMobile()); %>
										</td>
										<td>
											<% out.print(project.getEmail()); %>
										</td>
										<td>
											<% if(project.getStatus() == 0) { %>
											<span class='label label-warning'>Inactive</span>
											<% } else { %>
											<span class='label label-success'>Active</span>
											<% 	
											   }
											%>
										</td>
										<td>
										<a href="${baseUrl}/builder/leads/edit.jsp?lead_id=<% out.print(project.getId());%>"> <span class="btn btn-success pull-center m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Edit</span></a>
										</td>
										<% 	i++;
											} 
                                      	}
										%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
               </div>
            </div>
            <!-- /.container-fluid -->
         	<div id="sidebar1"> 
	      		<%@include file="../partial/footer.jsp"%>
			</div> 
        </div>
        <!-- /#page-wrapper -->
    
    <script src="../plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
    <!-- start - This is for export functionality only -->
    <script src="../cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
    <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
    <script src="../cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
    <script src="../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
    <script src="../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
    <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
    <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
    <!-- end - This is for export functionality only -->
    <script>
    $(document).ready(function() {
        $('#myTable').DataTable();
        $(document).ready(function() {
            var table = $('#example').DataTable({
                "columnDefs": [{
                    "visible": false,
                    "targets": 2
                }],
                "order": [
                    [2, 'asc']
                ],
                "displayLength": 25,
                "drawCallback": function(settings) {
                    var api = this.api();
                    var rows = api.rows({
                        page: 'current'
                    }).nodes();
                    var last = null;

                    api.column(2, {
                        page: 'current'
                    }).data().each(function(group, i) {
                        if (last !== group) {
                            $(rows).eq(i).before(
                                '<tr class="group"><td colspan="5">' + group + '</td></tr>'
                            );

                            last = group;
                        }
                    });
                }
            });

            // Order by the grouping
            $('#example tbody').on('click', 'tr.group', function() {
                var currentOrder = table.order()[0];
                if (currentOrder[0] === 2 && currentOrder[1] === 'asc') {
                    table.order([2, 'desc']).draw();
                } else {
                    table.order([2, 'asc']).draw();
                }
            });
        });
    });
    $('#example23').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });
    </script>
</body>
</html>