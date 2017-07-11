<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignList"%>
<%
List<CampaignList> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int session_id = 0;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		session_id = builder.getBuilder().getId();
	}
	}
if(session_id > 0){
	campaignLists = new CampaignDAO().getActiveCampaignListByBuilderId(session_id); 
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
                          <center><h1>Manage Campaign</h1></center> 
                           <br>
                            <a href="${baseUrl}/builder/campaign/new.jsp"> <span class="btn btn-danger pull-right m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Add Campaign</span></a>
                           <br><br><br>
                            <div class="table-responsive">
                                <table id="tblCampaign" class="table table-striped">
                                    <thead>
                                        <tr>
                                          	<td>Campaign Title</td>
                                           	<td>Start Date</td>
                                            <td>Campaign Type</td>
                                            <td>Actions</td>
                                        </tr>
                                        <tr>
                                          	<th>Campaign Title</th>
                                           	<th>Start Date</th>
                                            <th>Campaign Type</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        if(campaignLists != null){
                                       		for(CampaignList campaignList : campaignLists){
                                        %>
                                        <tr>
                                            <td><% out.print(campaignList.getTitle()); %></td>
                                            <td><% out.print(campaignList.getSetdate()); %></td>
                                            <td><% 
					                 	   	    if(campaignList.getCampaignType() ==1)
                                            		out.print("New Project");
					                 	   	    if(campaignList.getCampaignType() == 2)
					                 	   	    	out.print("New Property");
					                 	   	    if(campaignList.getCampaignType() == 3)
					                 	   	    	out.print("Offers");
					                 	   	    if(campaignList.getCampaignType() == 4)
					                 	   	    	out.print("Event");
					                 	   	    if(campaignList.getCampaignType() == 5)
					                 	   	    	out.print("Referral");
                                            %></td>
                                            <td class="alignRight">
<%--                                             	<a href="${baseUrl}/admin/leads/edit.jsp?lead_id=<% out.print(campaignList.getCampaignId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a> --%>
													<a href="javascript:deleteCampaign(<% out.print(campaignList.getCampaignId());%>)" class="btn btn-danger icon-btn btn-xs"><i class="fa fa-delete"></i>Delete</a>
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
          <div id="sidebar1"> 
		       <%@include file="../partial/footer.jsp"%>
			</div> 
        </div>
        <!-- /#page-wrapper -->
    
<!--     <script src="../plugins/bower_components/datatables/jquery.dataTables.min.js"></script> -->
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
    $('#tblCampaign').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });
    </script>
     <script type="text/javascript">
    $(document).ready(function() {
        // Setup - add a text input to each footer cell
        $('#tblCampaign thead td').each( function () {
            var title = $(this).text();
            $(this).html( '<input type="text" placeholder="Search '+title+'" class="inputbox" />' );
        } );
     
        // DataTable
        var table = $('#tblCampaign').DataTable();
     
        // Apply the search
        table.columns().every(function (index) {
            $('#tblCampaign thead  td:eq(' + index + ') input').on('keyup change', function () {
                table.column($(this).parent().index() + ':visible')
                    .search(this.value)
                    .draw();
            });
        });
    } );
    
function deleteCampaign(id) {
	var b=$("#offer").val();
	var flag = confirm("Are you sure ? You want to delete Campaign ?");
	if(flag) {
		$.get("${baseUrl}/webapi/project/campaign/delete/"+id, { }, function(data){
			alert(data.message);
			if(data.status == 1) {
				window.location.reload();
			}
		});
	}
}
    </script>
</body>
</html>

        