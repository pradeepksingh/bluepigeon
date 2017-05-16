<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.EmployeeList"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.data.BuildingList"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>

<%
	int project_size = 0;
	int type_size = 0;
	int city_size = 0;
	List<EmployeeList> employeeLists = null;
	List<ProjectData> builderProjects = null; 
	List<BuilderPropertyType> builderPropertyTypes = new ProjectLeadDAO().getBuilderPropertyType();
	
	session = request.getSession(false);
	
	Builder builder = new Builder();
	int p_user_id = 0;
	List<City> city_list = new CityNamesImp().getCityNames();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			p_user_id = builder.getId();
		}
		if(p_user_id>0){
			builderProjects = new ProjectDAO().getProjectsByBuilderId(p_user_id);
			employeeLists = new BuilderDetailsDAO().getBuilderEmployeeList(p_user_id);
		}
	}
	if(builderProjects.size()>0)
		project_size = builderProjects.size();
	if(builderPropertyTypes.size()>0)
		type_size = builderPropertyTypes.size();
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
                          <h3>Manage Employees</h3>
						<div class="row re white-box">
							<div class="col-md-3 col-sm-6 col-xs-12">
								<select name="city_id" id="city_id" class="form-control">
				                    <option value="0">Select City</option>
							                     <% for(City city : city_list){ %>
												<option value="<% out.print(city.getId());%>"><% out.print(city.getName());%></option>
												<% } %>
						         </select>   
							</div>
<!-- 							<div class="col-md-3 col-sm-6 col-xs-12"> -->
<!-- 							   <select name="searchlocalityId" id="searchlocalityId" class="form-control"> -->
<!-- 				                    <option value="0">Locality</option> -->
<!-- 							   </select> -->
<!-- 							</div> -->
							<div class="col-md-3 col-sm-6 col-xs-12">
								<select name="project_id" id="project_id" class="form-control">
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
                                            <th>Sr No.</th>
                                            <th>Employee Name</th>
                                             <th>Designation</th>
                                             <th>Access Type</th>
                                           	 <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <%
                                     if(employeeLists != null){
                                    	  int i=1;
                                      	for(EmployeeList employeeList: employeeLists) { %>
									<tr>
										<td><%out.print(employeeList.getCount());%></td>
										<td>
											<%out.print(employeeList.getName()); %>
										</td>
										<td>
											<%out.print(employeeList.getDesgnation()); %>
										</td>
										
										<td>
											<%out.print(employeeList.getAccess()); %>
										</td>
										<td>
											<!-- <a href="${baseUrl}/builder/buyer/agreement/edit.jsp?agreement_id=<% out.print(employeeList.getId());%>" class="btn btn-success icon-btn btn-xs"><i class="fa fa-pencil"></i> Edit</a>-->
										</td>
										<% 	
											i++;} 
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

    
    function getDataTable(){
    	$.post("${baseUrl}/webapi/project/building",{city_id: $("#city_id").val(),project_id : $("#project_id").val()},function(data){
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
    	    	row.push(data[index].name);
    	    	row.push(data[index].designation);
    	    	row.push(data[index].access);
    	    	row.push(status);
    	    	row.push(vieworder);
    	    	oTable.fnAddData(row);
    	    	count++;
    	    });
    	},'json');
    }
    
    $("#city_id").change(function(){
    	$.get("${baseUrl}/webapi/employee/emp/list/"+$("#city_id").val(),{ }, function(data){
    		var html = '<option value="0">Select Project</option>';
    		$(data).each(function(index){
    			html = html + '<option value="'+data[index].projectId+'">'+data[index].projectName+'</option>';
    		
    		});
    		$("#project_id").html(html);
     	
    	},'json');
    	getDataTable();
    });
    </script>
</body>
</html>