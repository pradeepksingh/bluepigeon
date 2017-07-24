<%@page import="org.bouncycastle.crypto.engines.ISAACEngine"%>
<%@page import="org.bluepigeon.admin.data.CancellationList"%>
<%@page import="org.bluepigeon.admin.dao.CancellationDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.data.BuildingList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.CancellationDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	List<CancellationList> cancellation_list = null;
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<City> cityList = new CityNamesImp().getCityNames();
	int builder_uid = 0;
	int access_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_uid = builder.getBuilder().getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
		}
   	}
	if(builder_uid > 0){
		cancellation_list = new CancellationDAO().getCancellationByBuilderEmployee(builder);
		int builder_size = cancellation_list.size();
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
    <link href="../css/custom.css" rel="stylesheet">
    <link href="../css/custom1.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
  
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
   
    </head>

<body class="fix-sidebar">
    <!-- Preloader -->
   
    <div id="wrapper">
        <div id="header">
	    	<%@include file="../partial/header.jsp"%>
        </div>
        <div id="sidebar1"> 
       		<%@include file="../partial/sidebar.jsp"%>
    	</div>
    </div>
<div id="page-wrapper">
            <div class="container-fluid">
                <!-- /row -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box"><br>
                          <h3>Manage Cancellation</h3>
							  <%if(access_id == 1|| access_id==2 || access_id == 4||access_id==5 || access_id == 7){ %>
						  <a href="${baseUrl}/builder/cancellation/new.jsp"> <span class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">New Cancellation</span></a>
						  <%} %>
                          <br><br><br>
                            <div class="table-responsive">
                                <table id="tblCancellation" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <td>Sr No.</td>
                                            <td>Buyer</td>
                                             <td>Project</td>
                                             <td>Building</td>
                                            <td>Flat No</td>
                                            <td>status</td>
                                              <%if(access_id == 1|| access_id==2 || access_id == 4||access_id==5){ %>
                                            <td>Action</td>
											<%} %>
                                        </tr>
                                        <tr>
                                            <th>Sr No.</th>
                                            <th>Buyer Name</th>
                                             <th>Project Name</th>
                                             <th>Building Name</th>
                                            <th>Flat No</th>
                                            <th>status</th>
                                              <%if(access_id == 1|| access_id==2 || access_id == 4||access_id==5){ %>
                                            <th>Action</th>
                                            <%} %>
                                        </tr>
                                    </thead>
                                    <tbody>
                                	<%
                                  	if(cancellation_list != null){
                                    	int i=1;
                                      	for(CancellationList cancellationList : cancellation_list) {
                                     		try{
                                  	%>
									<tr>
										<td><%out.print(i);%></td>
										<td>
											<% out.print(cancellationList.getBuyerName()); %>
										</td>
										<td>
											<% out.print(cancellationList.getProjectName()); %>
										</td>
										
										<td>
											<% out.print(cancellationList.getBuildingName()); %>
										</td>
										<td>
											<% out.print(cancellationList.getFlatNo());
											%>
										</td>
										<td>
											<%if(cancellationList.isApproved() && cancellationList.getStatus()==2) {
												out.print("Approved by Admin");
											} else if(cancellationList.getStatus() == 0) {
												out.print("Waiting for approval");
											}
											%>
										</td>
										<%if(access_id == 1|| access_id==2 || access_id == 4||access_id==5){ %>
										<td>
											<% if(!cancellationList.isApproved() && cancellationList.getStatus()==0) { %>
												<a href="javascript:approve(<% out.print(cancellationList.getFlatId());%>)"><span class="btn btn-info pull-left btn-sm btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Approve</span></a>
												<a href="javascript:cancel(<% out.print(cancellationList.getFlatId());%>)"><span class="btn btn-danger pull-left btn-sm btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Cancel</span></a>
									 		<% } %>
										</td>
										<% } %>
										<%
                                     		} catch(Exception e){
    											e.printStackTrace();
    										}
										i++;
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
<!--     <script src="../../cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script> -->
<!--     <script src="../../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script> -->
<!--     <script src="../../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script> -->
    <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
      <script src="../cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
    <!-- end - This is for export functionality only -->
    <script>
    $(document).ready(function() {
//         $('#myTable').DataTable();
//         $(document).ready(function() {
//             var table = $('#example').DataTable({
//                 "columnDefs": [{
//                     "visible": false,
//                     "targets": 2
//                 }],
//                 "order": [
//                     [2, 'asc']
//                 ],
//                 "displayLength": 25,
//                 "drawCallback": function(settings) {
//                     var api = this.api();
//                     var rows = api.rows({
//                         page: 'current'
//                     }).nodes();
//                     var last = null;
//                     api.column(2, {
//                         page: 'current'
//                     }).data().each(function(group, i) {
//                         if (last !== group) {
//                             $(rows).eq(i).before(
//                                 '<tr class="group"><td colspan="5">' + group + '</td></tr>'
//                             );
//                             last = group;
//                         }
//                     });
//                 }
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
//         });
//     });
    $('#tblCancellation').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });
    </script>
    <script type="text/javascript">
    $(document).ready(function() {
        // Setup - add a text input to each footer cell
        $('#tblCancellation thead td').each( function () {
            var title = $(this).text();
            $(this).html( '<input type="text" placeholder="Search '+title+'" class="inputbox" />' );
        } );
     
        // DataTable
        var table = $('#tblCancellation').DataTable();
     
        // Apply the search
        table.columns().every(function (index) {
            $('#tblCancellation thead  td:eq(' + index + ') input').on('keyup change', function () {
                table.column($(this).parent().index() + ':visible')
                    .search(this.value)
                    .draw();
            });
        });
    } );
    
    <%if(access_id == 1|| access_id==2 || access_id == 4||access_id==5){%>
    function approve(id){
    	var flag = confirm("Are you sure ? You want to Approve Cancelation ?");
    	if(flag){
    		$.get("${baseUrl}/webapi/cancellation/approve/"+id, { }, function(data){
	 			alert(data.message);
	 			if(data.status == 1) {
	 				window.location.reload();
	 			}
    		});
    	}
    }
    function cancel(id){
    	alert(id);
    	var flag = confirm("Are you sure ? You want to Approve Cancelation ?");
    	if(flag){
    		$.get("${baseUrl}/webapi/cancellation/cancel/"+id, { }, function(data){
	 			alert(data.message);
	 			if(data.status == 1) {
	 				window.location.reload();
	 			}
    		});
    	}
    }
   <% }%>
    
    </script>
</body>
</html>