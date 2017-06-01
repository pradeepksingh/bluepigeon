<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	session = request.getSession(false);
	Builder builder = new Builder();
	int builder_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			builder_id = builder.getId();
		}
   }
	List<Buyer> buyerList = new BuyerDAO().getAllBuyerByBuilderId(builder_id);
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
                          <h3>Manage Buyer</h3>
<!-- 						<div class="row re white-box"> -->
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 								<select class="form-control"> -->
<!-- 												<option>Buyer Name</option> -->
<!-- 												<option>Kumar</option> -->
<!-- 												<option>ganga</option> -->
<!-- 								</select>	    -->
<!-- 							</div> -->
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 								<select class="form-control"> -->
<!-- 												<option>City</option> -->
<!-- 												<option>Pune</option> -->
<!-- 												<option>Mumbai</option> -->
<!-- 								</select> -->
<!-- 							</div> -->
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 							    <select class="form-control"> -->
<!-- 												<option>Locality</option> -->
<!-- 												<option>S.B Road</option> -->
<!-- 												<option>Kothrud</option> -->
<!-- 								</select>	   -->
<!-- 							</div> -->
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 							    <select class="form-control"> -->
<!-- 												<option>Status</option> -->
<!-- 												<option>1</option> -->
<!-- 												<option>2</option> -->
<!-- 								</select>	    -->
<!-- 							</div> -->
<!-- 						</div> -->
						
                            <div class="table-responsive">
                                <table id="btlBuyer" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <td>No.</td>
                                            <td>Project</td>
											<td>Buyer Name</td>
											<td>Email</td>
											<td>Phone</td>
                                            <td>Building Name</td>
                                            <td>Flat No.</td>
                                            <td>Action</td>
                                        </tr>
                                         <tr>
                                            <th>No.</th>
                                            <th>Project Name</th>
											<th>Buyer Name</th>
											<th>Email</th>
											<th>Phone</th>
                                            <th>Building Name</th>
                                            <th>Flat No.</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <%
                                       		if(buyerList != null){
                                       			int i=1;
                                       			for(Buyer buyer: buyerList){
                                       %>
                                       		<tr>
                                       		<td><% out.print(i); %></td>
                                       		<td><% out.print(buyer.getBuilderProject().getName()); %></td>
                                       		<td><% out.print(buyer.getName()); %></td>
                                       		<td><% out.print(buyer.getEmail()); %></td>
                                       		<td><% out.print(buyer.getMobile()); %></td>
                                       		<td><% out.print(buyer.getBuilderBuilding().getName()); %></td>
                                       		<td><% out.print(buyer.getBuilderFlat().getFlatNo()); %></td>
                                       		<td><a href=""><span class="btn btn-success pull-left btn-sm btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Manage</span></a></td>
                                       		</tr>
                                       <% i++;}
                                       }%>
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
    $('#btlBuyer').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });
    </script>
     <script type="text/javascript">
    $(document).ready(function() {
        // Setup - add a text input to each footer cell
        $('#btlBuyer thead td').each( function () {
            var title = $(this).text();
            $(this).html( '<input type="text" placeholder="Search '+title+'" class="inputbox" />' );
        } );
     
        // DataTable
        var table = $('#btlBuyer').DataTable();
     
        // Apply the search
        table.columns().every(function (index) {
            $('#btlBuyer thead  td:eq(' + index + ') input').on('keyup change', function () {
                table.column($(this).parent().index() + ':visible')
                    .search(this.value)
                    .draw();
            });
        });
    } );
    

    </script>
</body>
</html>