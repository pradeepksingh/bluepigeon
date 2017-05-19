<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="java.util.List"%>
<%
	int building_id = 0;
	int p_user_id = 0;
	List<BuilderFloor> builderFloors = null;
	List<ProjectData> projectDatas = null;
	session = request.getSession(false);
	Builder adminuserproject = new Builder();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			adminuserproject  = (Builder)session.getAttribute("ubname");
			p_user_id = adminuserproject.getId();
		}
	}
	if (request.getParameterMap().containsKey("building_id")) {
		building_id = Integer.parseInt(request.getParameter("building_id"));
		if(building_id > 0) {
			builderFloors = new ProjectDAO().getBuildingFloors(building_id);
		}
	} else {
		builderFloors = new ProjectDAO().getAllFloorsByBuilderId(p_user_id);
		projectDatas = new ProjectDAO().getProjectsByBuilderId(p_user_id);
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
    <link rel="icon" type="image/png" sizes="16x16" href="../../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <link href="../../../plugins/bower_components/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- Menu CSS -->
    <link href="../../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link href="../../../css/colors/megna.css" id="theme" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
  
    <script src="../../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
   
    </head>

<body class="fix-sidebar">
    <!-- Preloader -->
   
    <div id="wrapper">
        <div id="header">
	    	<%@include file="../../../partial/header.jsp"%>
        </div>
        <div id="sidebar1"> 
       		<%@include file="../../../partial/sidebar.jsp"%>
    	</div>
    </div>
<div id="page-wrapper">
            <div class="container-fluid">
                <!-- /row -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box"><br>
                          <h3>Manage Floor</h3>
						<div class="row re white-box">
							<div class="col-md-3 col-sm-6 col-xs-12">
								<select name="searchprojectId" id="searchprojecttId" class="form-control">
				                    <option value="0">Select Project</option>
				                    <%
				                    if(projectDatas != null){
				                    for(int i=0; i < projectDatas.size() ; i++){ %>
									<option value="<% out.print(projectDatas.get(i).getId());%>"><% out.print(projectDatas.get(i).getName());%></option>
									<% 	
										}
				                    }
				                    %>
						         </select>   
							</div>
							<div class="col-md-3 col-sm-6 col-xs-12">
							   <select name="searchlocalityId" id="searchlocalityId" class="form-control">
				                    <option value="0">Locality</option>
							   </select>
							</div>
							<div class="col-md-3 col-sm-6 col-xs-12">
								<select name="searchprojectId" id="searchprojectId" class="form-control">
				                    <option value="0">Project</option>
								</select>
							</div>
							
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 							    <select class="form-control"> -->
<!-- 												<option>Status</option> -->
<!-- 												<option>1</option> -->
<!-- 												<option>2</option> -->
<!-- 								</select>	    -->
<!-- 							</div> -->
						</div>
						
                            <div class="table-responsive">
                                <table id="tblBuilding" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Builder Name</th>
                                             <th>Project Name</th>
                                             <th>Building Name</th>
                                            <th>status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <%
                                      if(builderFloors != null){
                                    	  int i=1;
                                    	  for(BuilderFloor builderFloor :builderFloors) { %>
      									<tr>
      										<th><%out.print(i); %>
      										<th><% out.print(builderFloor.getName()); %></th>
      										<th><% out.print(builderFloor.getBuilderBuilding().getName()); %></th>
      										<th><% out.print(builderFloor.getBuilderBuilding().getBuilderProject().getName()); %></th>
      										<th><% out.print(builderFloor.getBuilderFloorStatus().getName()); %></th>
      										<th>
      											<a href="${baseUrl}/builder/project/building/floor/edit.jsp?floor_id=<% out.print(builderFloor.getId());%>"><span class="btn btn-success pull-left m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Manage</span></a>
<%--       											<a href="${baseUrl}/admin/project/building/floor/updates.jsp?floor_id=<% out.print(builderFloor.getId());%>" class="btn btn-warning icon-btn btn-xs"><i class="fa fa-pencil"></i> Updates</a> --%>
      											<a href="${baseUrl}/builder/project/building/floor/flat/list.jsp?floor_id=<% out.print(builderFloor.getId());%>" ><span class="btn btn-success pull-left m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">Flat</span></a>
      										</th>
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
	      		<%@include file="../../../partial/footer.jsp"%>
			</div> 
        </div>
        <!-- /#page-wrapper -->
    
    <script src="../../plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
    <!-- start - This is for export functionality only -->
    <script src="../../cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
    <script src="../../cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
<!--     <script src="../../cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script> -->
<!--     <script src="../../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script> -->
<!--     <script src="../../cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script> -->
    <script src="../../cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
    <script src="../../cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
    <!-- end - This is for export functionality only -->
    <script>
    $(document).ready(function() {
        $('#tblBuilding').DataTable();
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
    
    function getDataTable(){
    	$.post("${baseUrl}/webapi/project/building",{city_id: $("#searchcitytId").val(), locality_id: $("#searchlocalityId").val(), project_id : $("#searchprojectId").val()},function(data){
    		var oTable = $("#tblBuilding").dataTable();
    	    oTable.fnClearTable();
    	    var count=1;
    	    $(data).each(function(index){
    		    var vieworder = '<a href="${baseUrl}/builder/project/edit.jsp?project_id='+data[index].id+'" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>';
    		    var status = '';
    		    if(data[index].status == 1) {
    		    	status = '<span class="label label-success">Active</span>';
    		    } else {
    		    	status = '<span class="label label-warning">Inactive</span>';
    		    }
    	    	var row = [];
    	    	row.push(count);
    	    	row.push(data[index].builderName);
    	    	row.push(data[index].projectName);
    	    	row.push(data[index].buildingName);
    	    	row.push(status);
    	    	row.push(vieworder);
    	    	oTable.fnAddData(row);
    	    	count++;
    	    });
    	},'json');
    }
    </script>
</body>
</html>