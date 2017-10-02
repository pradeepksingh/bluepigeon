
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
					flatListDatas = new ProjectDAO().getFlatDetails(projectId,building_id,0,0); 
		 			bookingFlatList2 = new ProjectDAO().getFlatBookeddetails(projectId,building_id,0,0);  
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
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/projectheadinventory.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../bootstrap/dist/js/bootstrap-3.3.7.min.js"></script>
    <script type="text/javascript" src="../js/selectize.min.js"></script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
        <%@include file="../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        <%@include file="../partial/sidebar.jsp"%>
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
						        <button class="btn btn-default btn231" id="search_buyer" type="button" style="padding:10px;border:1px solid #00bfd6;"><img src="../images/search.png"/></button>
						      </div>
						    </div>
					     </form>
                       </div>
                  </div>
               <!-- row -->
               <div class="white-box">
                <div class="blue-bg">
                   <div class="floor1">
                   
                    <% if(flatListDatas !=null){
 	            					String active = ""; 
 	            					for(int i=0;i<flatListDatas.size();i++){  
	              						for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){ %> 
	                          
							      <% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){  %>
                   
                   <%for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){ 
 							     if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("booked")) {%>
                         <a href="#"><button style="pointer-events:none;" class="book-flat-button" onclick="toggle(this);"><%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName()); %> <br> <%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></button></a>
                        <%} else if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")) {%>
                       <a href="#"> <button class="flat-button btn-info" onclick="toggle(this);">101 <br> FullName FullSernameOFOwner</button></a>
                       <%}
               	 						} 
 		            		 			%> 
 		            		 			<% }
 	    							} %>
 	    							
 	         					<%} 
 	     					 } 
                          
 	     					%> 
                   </div>
                    <div class="floor2">
                       <a href="#"> <button class="flat-button btn-info"  onclick="toggle(this);">201 <br> FullName FullSernameOFOwner</button></a>
                       <a href="#"><button class="book-flat-button"  onclick="toggle(this);">202 <br> name of flat</button></a>
                       <a href="#"><button class="flat-button btn-info"  onclick="toggle(this);">203 <br> name of flat</button> </a>
                       <a href="#"><button class="book-flat-button"  onclick="toggle(this);">204 <br> name of flat</button></a>
                       <a href="#"> <button class="flat-button btn-info"  onclick="toggle(this);">205 <br> name of flat</button> </a>
                       <a href="#"> <button class="flat-button btn-info"  onclick="toggle(this);">206 <br> name of flat</button> </a>
                   </div>
                   <div class="unholdsection center">
                     <button class="un-hold " onclick="toggle(this);" id="unhold">Unhold</button>
                   </div>
                   <div class="holdsection center">
                     <button class="hold" onclick="toggle(this);" id="hold">Hold</button>
                   </div>
                </div>
               
               </div>
            </div>
          </div>
        </div>
    <!-- /.container-fluid -->
    <div id="sidebar1"> 
	     <%@include file="../partial/footer.jsp"%>
	  </div> 
  </body>
     <script>
     $select_building = $("#filter_building_id").selectize({
    		persist: false,
    		 onChange: function(value) {
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
       $('.btn-info1').addClass("btn-info");
       $('.btn-info1').addClass("flat-button");
 	   $('.btn-info1').removeClass("holdcolor");
       $('.btn-info1').removeClass("btn-info1");
       $('.btn-info1').removeClass("yellowcolor");
       $(".holdsection").hide(".holdsection");
	   $(".unholdsection").hide(".unholdsection");
  		});
     $('#hold').click(function(){
 	   $('.holdcolor').addClass("yellowcolor");
 	   $('.holdcolor').addClass("btn-info1");
       $('.holdcolor').removeClass("holdcolor");
	   $(".holdsection").hide(".holdsection");
      });
  </script>
  <script>
    $('.yellowcolor').click(function() {
      $('.yellowcolor').addClass("holdcolor");
      $('.yellowcolor').addClass("btn-info");
      $('.yellowcolor').removeClass("yellowcolor");
		});
  </script>
   <script>
	    $('.flat-button').click(function() {
          $(this).removeClass("flat-button");
          $(this).removeClass("btn-info");
		  $(this).addClass("holdcolor");
		});
	 </script>
	 <script>
    function toggle(a){
	   if($(a).hasClass("yellowcolor")){
           $('.yellowcolor').removeClass("yellowcolor");
           $('.yellowcolor').addClass("holdcolor");
		   $(".unholdsection").show(".unholdsection");
		   $(".holdsection").hide(".holdsection");
		}
	   else{
		   $(".holdsection").show(".holdsection");
 		   $(".unholdsection").hide(".unholdsection");
	   }
	}
    
    $("#project_status_btn").click(function(){
    	window.location.href="${baseUrl}/builder/sales/projectstatus.jsp?project_id=<% out.print(projectId);%>";
    });
    $("#inventory_btn").click(function(){
    	window.location.href="${baseUrl}/builder/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
    });
    $("#revenue_btn").click(function(){
    	window.location.href="${baseUrl}/builder/revenue/projectrevenue.jsp?project_id=<% out.print(projectId);%>";
    });
	</script>
</html>