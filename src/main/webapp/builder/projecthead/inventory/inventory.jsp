
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.BuilderFlatList"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%
List<CampaignListNew> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int session_id = 0;
int access_id = 0;
List<BuilderBuilding> builderBuildingList = null;
int projectId = 0;
int building_id = 0;
List<FlatListData> flatListDatas = null; 
BookingFlatList bookingFlatList2 = null; 
List<BuilderFlatList> flats = null;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		session_id = builder.getBuilder().getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		if(session_id > 0){
			if (request.getParameterMap().containsKey("project_id")) {
				projectId = Integer.parseInt(request.getParameter("project_id"));
				if(projectId != 0) {
					builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(projectId);
					building_id = builderBuildingList.get(0).getId(); 
		 			flats = new ProjectDAO().getProjectFlatListByBuilder(projectId, building_id, "");
				}
			}
		}
	}

}
SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
Date date = new Date();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/projectheadinventory.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
     <link rel="stylesheet" type="text/css" href="../../css/selectize.css" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/selectize.min.js"></script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        <%@include file="../../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        <%@include file="../../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid">
               <!-- /.row -->
	                    <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="project_status_btn">Project Status</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-submit waves-effect waves-light m-t-10" id="inventory_btn">Inventory</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="revenue_btn">Revenue</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="campaign_btn">Campaign</button>
		                </div>
	                </div>
	               <div class="row">
                       <div class="col-md-4 col-lg-4 col-sm-4 col-xs-12" style="padding-top:8px;">
	                        <select id="filter_building_id" name="filter_building_id"  data-style="form-control" >
	                         	<option value="0">Enter Building Name</option>
	                        <% if(builderBuildingList != null){ 
	                        		for(BuilderBuilding builderBuilding : builderBuildingList){
	                        %>
	                          	<option value="<% out.print(builderBuilding.getId());%>" <% if(builderBuilding.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding.getName()); %></option>
	                        <%} }%>
	                        </select>
                       </div>
                       <div class="col-md-8 col-lg-8 col-sm-8 col-xs-12">
                         <form class="navbar-form lead-search" method="post" role="search">
						    <div class="input-group add-on wdth100">
						      <input class="form-control textinput" placeholder="Search by Name or Number" autocomplete="off" name="srch-term" id="srch-term" type="text" style="width:90%;">
						      <div class="input-group-btn wdth10 pull-right">
						        <button class="btn btn-default btn231" id="search_buyer" type="button" style="padding:10px;border:1px solid #00bfd6;"><img src="../../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                  </div>
               <!-- row -->
           		<div class="white-box">
               	 	<div class="blue-bg">
               	 		<div id="flat_landing_area">
	               	 		<% if(flats !=null){ %>
	                   		<div class="floor1">
	                   		<% int floor_no = -100; %>
	                    	<% for(BuilderFlatList flat :flats) { %>
	                    	<% if(floor_no != -100 && flat.getFloorNo() != floor_no) { %>
	                         </div>
	                         <div class="floor2">
	                         <% } %>
	                         	<a href="javascript:return false;"><button <% if(flat.getFlatStatus().equalsIgnoreCase("booked")) { %>style="pointer-events:none;"<% } %> class="book-flat-button <% if(flat.getFlatStatus().equalsIgnoreCase("available")) { %>btn-info<% } %> <% if(flat.getFlatStatus().equalsIgnoreCase("hold")) { %> yellowcolor yell<% } %>" onclick="toggleFlat(this);" data-value="<% out.print(flat.getId()); %>"><% out.print(flat.getFlatNo()); %><br><% if(flat.getBuyerName() != null) { out.print(flat.getBuyerName());} else { %>&nbsp;<% } %></button></a>
	                   		<% floor_no = flat.getFloorNo(); %>
	                   		<% } %>
	                   		</div>
	                   		<% } %>
                   		</div>
                   		<div class="unholdsection center">
                     		<button class="un-hold" id="unhold">Unhold</button>
                   		</div>
                   		<div class="holdsection center">
                     		<button class="hold" id="hold">Hold</button>
                   		</div>
                	</div>
               	</div>
            </div>
       	</div>
   	</div>
    <!-- /.container-fluid -->
    <div id="sidebar1"> 
	     <%@include file="../../partial/footer.jsp"%>
	  </div> 
  </body>
</html>
 <script>
     $select_building = $("#filter_building_id").selectize({
    		persist: false,
    		 onChange: function(value) {
    			 searchBuyer();
    		 },
    		 onDropdownOpen: function(value){
    	    	 var obj = $(this);
    			var textClear =	 $("#filter_building_id :selected").text();
    	    	 if(textClear.trim() == "Enter Building Name"){
    	    		 obj[0].setValue("");
    	    	 }
    	     }
    	});
    	<%if(builderBuildingList.size() > 0){%>
    		select_building = $select_building[0].selectize;
    	<%}%>
     
   	$('#unhold').click(function(){
   		var ids = "";
   		$(".holdcolor").each(function(){
   			if(ids == "") {
   				ids = $(this).attr('data-value');
   			} else {
   				ids = ids+","+$(this).attr('data-value');
   			}
   		});
   		ajaxindicatorstart("Please wait while, we update status ...");
   		$.get("${baseUrl}/webapi/builder/flat/markunhold/"+ids,{},function(data){
   			ajaxindicatorstop();
   			$(".holdcolor").each(function(){
   				$(this).removeClass("holdcolor");
   	    		$(this).removeClass("yellowcolor yell");
   	    		$(this).addClass("btn-info");
   	   		});
   		},'json');
       	$(".holdsection").hide(".holdsection");
	   	$(".unholdsection").hide(".unholdsection");
 	});
    $('#hold').click(function(){
    	var ids = "";
   		$(".holdcolor").each(function(){
   			if(ids == "") {
   				ids = $(this).attr('data-value');
   			} else {
   				ids = ids+","+$(this).attr('data-value');
   			}
   		});
   		ajaxindicatorstart("Please wait while, we update status ...");
   		$.get("${baseUrl}/webapi/builder/flat/markhold/"+ids,{},function(data){
   			ajaxindicatorstop();
   			$(".holdcolor").each(function(){
   				$(this).removeClass("holdcolor");
   				$(this).removeClass("btn-info");
   				if($(this).hasClass("yell")) {
   	    			$(this).addClass("yellowcolor");
   	    		} else {
   	    			$(this).addClass("yellowcolor yell");
   	    		}
   	   		});
   		},'json');
	   	$(".holdsection").hide(".holdsection");
   	});
  
    function toggleFlat(input) {
    	if($(input).hasClass("yellowcolor")){
    		$(input).removeClass("yellowcolor");
            $(input).addClass("holdcolor");
 		   	$(".unholdsection").show();
 		   	$(".holdsection").hide();
    	} else if($(input).hasClass("holdcolor")){
    		$(input).removeClass("holdcolor");
    		if($(input).hasClass("yell")) {
    			$(input).addClass("yellowcolor");
    		}
    		$(".holdsection").hide();
  		   	$(".unholdsection").hide();
    	} else {
    		$(input).addClass("holdcolor");
    		$(".holdsection").show();
  		   	$(".unholdsection").hide();
    	}
    }
    $("#search_buyer").click(function(){
    	searchBuyer();
    });
    
    $("#project_status_btn").click(function(){
    	ajaxindicatorstart("Please wait while.. we load ...");
    	window.location.href="${baseUrl}/builder/projecthead/projectstatus/projectstatus.jsp?project_id=<% out.print(projectId);%>";
    });
    $("#inventory_btn").click(function(){
    	ajaxindicatorstart("Please wait while.. we load ...");
    	window.location.href="${baseUrl}/builder/projecthead/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
    });
    $("#revenue_btn").click(function(){
    	ajaxindicatorstart("Please wait while.. we load ...");
    	window.location.href="${baseUrl}/builder/projecthead/revenue/projectrevenue.jsp?project_id=<% out.print(projectId);%>";
    });
    
    function searchBuyer(){
    	ajaxindicatorstart("Please wait while.. we search ...");
	    $.get("${baseUrl}/builder/projecthead/inventory/partialinventory.jsp?project_id=<% out.print(projectId);%>&building_id="+$('#filter_building_id').val()+"&keyword="+$('#srch-term').val(),{},function(data) {
	    	$("#flat_landing_area").html(data);
	    	ajaxindicatorstop();
	    },'html');
    }
    $("#srch-term").keydown(function(e){
    	if(e.keyCode == 13){
    		e.preventDefault();
    		searchBuyer();
    	}
    });
</script>