<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%
	List<PossessionList> possession_list = null;
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
		possession_list = new PossessionDAO().getAllPossessionByBuilderId(builder_uid);
		int possession_size = possession_list.size();
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
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
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
    <!-- color CSS -->
    <link href="../css/colors/megna.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
   
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script>
    $(function() {
        $("#sidebar1").load("../partial/sidebar.jsp");
        $("#header").load("../partial/header1.jsp");

        $("#footer").load("../partial/footer.html");
    });
    </script>
   
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
                          <center><h1>Manage Possession</h1></center> 
                           <br>
                          <a href=""> <span class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Add </span></a>
                           <br><br><br>
                            <div class="table-responsive">
                                <table id="myTable" class="table table-striped">
                                    <thead>
                                        <tr>
                                         <th>No.</th>
                                            <th>Project Name</th>
                                            <th>Building Name</th>
                                            <th>Flat No.</th>
                                            <th>Buyer Name</th>
                                            <th>Action</th>
                                           
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <%
                                       	if(possession_list != null){
                                       		for(PossessionList possessionList : possession_list) { %>
									<tr>
										<td>
											<% out.print(possessionList.getProjectName()); %> 
										</td>
										<td>
											<% out.print(possessionList.getBuildingName()); %>
 										</td> 
 										<td> 
 											<% out.print(possessionList.getFlatNo()); %> 
										</td>
										<td> 
 											<% out.print(possessionList.getBuyerName()); %> 
										</td>
										<td>
<%--  											<a href="${baseUrl}/admin/buyer/possession/edit.jsp?possession_id=<% out.print(agreementList.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a> --%>
										</td>
									</tr>
 									<% 
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
            <footer id="footer">  </footer>
        </div>
        <!-- /#page-wrapper -->
    </div>
    
    <script src="../plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
    <!-- start - This is for export functionality only -->
    <script src="../cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
    <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
    
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

        