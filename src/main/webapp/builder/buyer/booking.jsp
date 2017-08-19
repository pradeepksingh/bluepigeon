<%@page import="org.bluepigeon.admin.data.FlatListData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.data.BookingFlatList"%>
<%@page import="org.bluepigeon.admin.model.BuilderFloor"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.bluepigeon.admin.model.BuilderBuilding"%>
<%@page import="org.bluepigeon.admin.data.BuildingData"%>
<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalInfo"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationInfoDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenityInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectProjectType"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenityInfo"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfigurationInfo"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="java.util.List"%>
<%
	int p_user_id = 0;
	int project_id=0;
	int access_id=0;
	int building_size_list =0;
	int floor_size_list = 0;
	BuilderFloor builderFloor = null;
	int building_id = 0;
	int floor_id = 0;
	List<BookingFlatList> bookingFlatList = null;
	List<BuilderFloor> floorList = null;
	List<BuilderBuilding> builderBuildingList = null;
	BuilderProject projectList = null;
	List<BuilderBuilding> buildingList = null;
	List<FlatListData> flatListDatas = null;
	BookingFlatList bookingFlatList2 = null;
	int flat_size = 0;
	String image  = "";
	List<ProjectImageGallery> imageGaleries = new ArrayList<ProjectImageGallery>();
	List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
	project_id = Integer.parseInt(request.getParameter("project_id"));
	projectList = new ProjectDAO().getBuilderActiveProjectById(project_id);
	List<BuilderProjectAmenityInfo> projectAmenityInfos = new BuilderProjectAmenityInfoDAO().getBuilderProjectAmenityInfo(project_id);
	List<BuilderProjectProjectType> projectProjectTypes = new BuilderProjectProjectTypeDAO().getBuilderProjectProjectTypes(project_id);
	List<BuilderProjectPropertyType> projectPropertyTypes = new BuilderProjectPropertyTypeDAO().getBuilderProjectPropertyTypes(project_id);
	List<BuilderProjectPropertyConfigurationInfo> projectConfigurationInfos = new BuilderProjectPropertyConfigurationInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	List<BuilderProjectApprovalInfo> projectApprovalInfos = new BuilderProjectApprovalInfoDAO().getBuilderProjectPropertyConfigurationInfos(project_id);
	
	session = request.getSession(false);
	
	BuilderEmployee builder = new BuilderEmployee();
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			p_user_id = builder.getBuilder().getId();
			access_id = builder.getBuilderEmployeeAccessType().getId();
			//buildingList =  new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
			builderBuildingList = new ProjectDAO().getBuilderActiveProjectBuildings(project_id);
			building_id = builderBuildingList.get(0).getId();
			flatListDatas = new ProjectDAO().getFlatDetails(project_id,building_id,floor_id,0);
			bookingFlatList2 = new ProjectDAO().getFlatdetails(project_id,building_id,0,0);
			image = bookingFlatList2.getImage();
			flat_size = flatListDatas.size();
		
			//building_id = builderBuildingList.get(0).getId();
			//floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id);
			//floor_size_list = floorList.size();
			if(builderBuildingList != null && builderBuildingList.size() > 0){
				building_id = builderBuildingList.get(0).getId(); 
				building_size_list = builderBuildingList.size();
				floorList = new ProjectDAO().getActiveFloorsByBuildingId(building_id);
				if(floorList != null && floorList.size() > 0){
					floor_id = floorList.get(0).getId();
					floor_size_list = floorList.size();
				}
			}
		}
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
   <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <link href="../css/custom.css" rel="stylesheet">
<!--     <link rel="stylesheet" type="text/css" href="../css/custom2.css"> -->
    <link rel="stylesheet" type="text/css" href="../css/topbutton.css">
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
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
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row">
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" class="btn11 btn-submit waves-effect waves-light  m-t-10">Booking</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" class="btn11 top-white-box  waves-effect waves-light m-t-10">Cancellation</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" class="btn11 top-white-box waves-effect waves-light m-t-10">Leads</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3 col-xs-3">
		                    <button type="submit" class="btn11 top-white-box  waves-effect waves-light m-t-10">Campain</button>
		                </div>
	                </div>
               <!-- row -->
                <!--.row -->
                  <div class="row">
          			<div class="col-md-4 col-sm-6 col-xs-12">
	                     <select id="filter_building_id" name="filter_building_id">
	                             <%
	                             if(builderBuildingList != null ){
	                             for(BuilderBuilding builderBuilding2 : builderBuildingList){ %>
	                     		<option value="<% out.print(builderBuilding2.getId());%>" <% if(builderBuilding2.getId() == building_id) { %>selected<% } %>><% out.print(builderBuilding2.getName()); %></option>
	                     		<%} }%>
	                     </select>
                	</div>
                	<div class="col-md-4 col-sm-6 col-xs-12">
                
                		<select id="filter_floor_id" name="filter_floor_id">
                			<option value="0"></option>
                			<%
                			if(floorList != null){
                			for(BuilderFloor builderFloors : floorList){ %>
                			<option value="<%out.print(builderFloors.getId()); %>"><%out.print(builderFloors.getName()); %></option>
                			<%}}%>
                		</select>
                	</div>
                	<div class="col-md-4 col-sm-6 col-xs-12">
                
                		<select id="evenOrodd" name="evenOrodd">
                			<option value="0">Even & Odd</option>
                			<option value="1">EVEN</option>
                			<option value="2">ODD</option>
                		</select>
                	</div>
           		</div>
                    <!-- row -->
                    
                <div class="white-box">
                 <div class="row" id="flatdetails">
                    <div class="col-md-8 col-sm-6 col-xs-12  bg1">
                        <div class="white-box" >
	                         <% if(flatListDatas !=null){
	            					String active = "";
	            					for(int i=0;i<flatListDatas.size();i++){ 
	              						for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){ %>
	                		 			<ul class="nav nav-pills">
	                		 			<% for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){ 
		               	 						for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
		                      						if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getFlatStaus().equalsIgnoreCase("available")){
		             					%>
					 	 					<li class="item"><a data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="javascript:showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>);" href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
					 					<%}else{%>
					     					<li class="grey"><a class="grey" data-toggle="pill" id="<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>" onclick="javascript:showFlatwithImage(<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId()); %>)" href=""><% out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getName());%></a></li>
					 					<%
					 			   				}
		              						}
		             					}
		            		 			%>
										</ul>
					 					<hr>
	    					<%
	    							}
	         					}
	     					 }
	     					%>
						    <!-- floor 1 -->
						     <!-- floor 2 -->
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12">
                     <div class="bg1">
                       <div class="tab-content">
					     <div id="home" class="tab-pane fade in active">
					     	<% if(bookingFlatList2 != null){
					     	if(bookingFlatList2.getImage()!="" && bookingFlatList2.getImage() != null){ %>
						     <img src="${baseUrl}/<%out.print(bookingFlatList2.getImage()); %>" alt="Flat image" class="custom-img">
						     <%} %>
						      <hr><br>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Flat Type</p>
						          <span><b><%out.print(bookingFlatList2.getFlatType()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Carpet Area</p>
						          <span><b><%out.print(bookingFlatList2.getCarpetArea()); %> SQ/FT</b></span>
						        </div>
						      </div>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bedrooms</p>
						          <span><b><%out.print(bookingFlatList2.getBedroom()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Bathroom</p>
						          <span><b><%out.print(bookingFlatList2.getBathroom()); %></b></span>
						        </div>
						      </div>
						      <div class="row custom-row">
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom">Balcony</p>
						          <span><b><%out.print(bookingFlatList2.getBalcony()); %></b></span>
						        </div>
						        <div class="col-md-6 col-sm-6 col-xs-6">
						          <p class="p-custom"><%if(bookingFlatList2.getRoomName() != null){out.print(bookingFlatList2.getRoomName()); }%> Size</p>
						          <span><b><%out.print(bookingFlatList2.getLength()+" x "+bookingFlatList2.getBreadth()+" "+bookingFlatList2.getAreaUint()); %></b></span>
						        </div>
						      </div>
						      <button type="button" onclick="javascript:showFlat(<%out.print(bookingFlatList2.getFlatId()); %>)" class="btn-change">Book Now</button>
						      <%} %>
					     </div>
					  </div>
                    </div>
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
</html>
<script>
function activeInactiveFlats(){
	$('.nav li a').click(function(e) {
        $('.nav li.active').removeClass('active');
        var $parent = $(this).parent();
        if($parent.hasClass('.nav-pills')){
	        $parent.addClass('active');
	        e.preventDefault();
        }
    });
}

<% if(flatListDatas !=null){%>
$(document).ready(function () {
		 <%for(int i=0;i<flatListDatas.size();i++){
			 for(int j=0;j<flatListDatas.get(i).getBuildingListDatas().size();j++){
				 for(int floor_size = 0; floor_size<flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().size();floor_size++){
				 	for(int flat_count=0;flat_count < flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().size();flat_count++){
               	  		if(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId() == bookingFlatList2.getFlatId()){
	 %>
    $("#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>").click(function (e) {
        e.preventDefault();
    });
    $('#<%out.print(flatListDatas.get(i).getBuildingListDatas().get(j).getFloorListDatas().get(floor_size).getFlatStatusDatas().get(flat_count).getId());%>').trigger('click');
    
    <%					}
               	  	}
				 }
			}
		}
	 %>
});
<% } %>
function showFlat(id){
	alert(id);
}

function showFlatwithImage(id){
	$("#home").empty();
	var htmlFlat ="";
	if(id > 0 && id != ''){
		$.get("${baseUrl}/webapi/project/building/floor/flat/detail/",{flat_id : id},function(data){
			var image = '';
			if(data.image != ''){
				image = '${baseUrl}/'+data.image;
			}
			htmlFlat ='<img src="'+image+'" alt="Project image" class="custom-img">'
	 	      +'<hr>'
	 	      +'<div class="row custom-row">'
	 	        +'<div class="col-md-6 col-sm-6 col-xs-6">'
	 	          +'<p class="p-custom">Flat Type</p>'
	 	          +'<span><b>'+data.flatType+'</b></span>'
	 	        +'</div>'
	 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
	 	          +'<p class="p-custom">Carpet Area</p>'
	 	          +'<span><b>'+data.carpetArea+' SQ/FT</b></span>'
	 	        +'</div>'
	 	      +'</div>'
	 	      +'<div class="row custom-row">'
	 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
	 	          +'<p class="p-custom">Bedrooms</p>'
	 	          +'<span><b>'+data.bedroom+'</b></span>'
	 	        +'</div>'
	 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
	 	          +'<p class="p-custom">Bathroom</p>'
	 	         +' <span><b>'+data.bathroom+'</b></span>'
	 	        +'</div>'
	 	      +'</div>'
	 	      +'<div class="row custom-row">'
	 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
	 	         +' <p class="p-custom">Balcony</p>'
	 	         +' <span><b>'+data.balcony+'</b></span>'
	 	        +'</div>'
	 	        +'<div class="col-md-6 col-sm-6 col-xs-6">'
	 	         +' <p class="p-custom">Bedroom Size</p>'
	 	          +'<span><b>'+data.length+' '+data.areaUint+' * '+data.breadth+' '+data.areaUint+' </b></span>'
	 	        +'</div>'
	 	      +'</div>'
	 	      +'<button type="button" onclick="showFlat('+data.flatId+');" class="btn-change">Book Now</button>';
	    
	 	 $("#home").append(htmlFlat);
		},'json');
		activeInactiveFlats();
	}
}
$select_building = $("#filter_building_id").selectize({
	persist: false,
	 onChange: function(value) {
		if($("#filter_building_id").val() > 0 || $("#filter_building_id").val() != '' ){
			$.get("${baseUrl}/webapi/project/building/floor/list/",{ building_id: value }, function(data){
				getFlatDetails();
				var html = '<option value="">Enter Floor Name</option>';
				if(data != ""){
					$(data).each(function(index){
						html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
					});
					$select_floor[0].selectize.destroy();
					$("#filter_floor_id").html(html);
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value) {
							 if(value > 0 || value != '' ){
								//	window.location.href = "${baseUrl}/builder/project/building/floor/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+value;
								 getFlatDetails();
								}
						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("0");
					   	 }
					    }
					});
				}else{
					
					$select_floor[0].selectize.destroy();
					$("#filter_floor_id").html("");
					$("#floorDetailsTab").hide();
					$("#floorDetailsTab1").html("<span class='text-danger'>Sorry No floor found..</span>");
					$("#floorDetailstab1").show();
					$select_floor = $("#filter_floor_id").selectize({
						persist: false,
						 onChange: function(value) {

						 },
						 onDropdownOpen: function(value){
					   	 var obj = $(this);
							var textClear =	 $("#filter_floor_id :selected").text();
					   	 if(textClear.trim() == "Enter Floor Name"){
					   		 obj[0].setValue("0");
					   	 }
					    }
					});
				}
				
			},'json');
			//window.location.href = "${baseUrl}/builder/project/building/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+value;
			
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_building_id :selected").text();
    	 if(textClear.trim() == "Enter Building Name"){
    		 obj[0].setValue("0");
    	 }
     }
});
<%if(building_size_list > 0){%>
	select_building = $select_building[0].selectize;
<%}%>

$select_floor = $("#filter_floor_id").selectize({
	persist: false,
	 onChange: function(value) {

		if(($("#filter_building_id").val() > 0 && $("#filter_building_id").val() != '') && ($("#filter_floor_id").val() > 0 && $("#filter_floor_id").val() != '' )){
			//window.location.href = "${baseUrl}/builder/project/building/floor/edit.jsp?project_id="+$("#project_id").val()+"&building_id="+$("#filter_building_id").val()+"&floor_id="+value;
			getFlatDetails();
		}
	 },
	 onDropdownOpen: function(value){
   	 var obj = $(this);
		var textClear =	 $("#filter_floor_id :selected").text();
   	 if(textClear.trim() == "Enter Floor Name"){
   		 obj[0].setValue("0");
   	 }
    }
});

<% if(floor_size_list > 0){%>
  select_floor = $select_floor[0].selectize;
<%}%>

$select_eveOrodd = $("#evenOrodd").selectize({
	persist: false,
	onChange: function(value){
		if(value > 0 && value != ''){
			getFlatDetails();
		}
	},
	onDropdownOpen: function(value){
		var obj = $(this);
		var textClear = $("#evenOrodd:selected").text();
		if(textClear.trim() == "Even & Odd"){
			obj[0].setValue("0");
		}
	}
});

function getFlatDetails(){
 // alert($("#evenOrodd").val());
	var no = $("#filter_building_id").val();
// 	alert("Hello "+$("#filter_building_id").val()+" Floor No. "+$("#filter_floor_id").val());
// 	 $("#home").empty();
// 	var html = '<div id="home" class="tab-pane fade in active">'
//      +'<img src="plugins/images/Untitled-1.png" alt="Project image" class="custom-img">'
// 	      +'<hr>'
// 	      +'<div class="row custom-row">'
// 	        +'<div class="col-md-6 col-sm-6 col-xs-6">'
// 	          +'<p class="p-custom">Flat Type</p>'
// 	          +'<span><b>'+no+'BHK</b></span>'
// 	        +'</div>'
// 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
// 	          +'<p class="p-custom">Carpet Area</p>'
// 	          +'<span><b>500 SQ/FT</b></span>'
// 	        +'</div>'
// 	      +'</div>'
// 	      +'<div class="row custom-row">'
// 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
// 	          +'<p class="p-custom">Bedrooms</p>'
// 	          +'<span><b>1</b></span>'
// 	        +'</div>'
// 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
// 	          +'<p class="p-custom">Bathroom</p>'
// 	         +' <span><b>1</b></span>'
// 	        +'</div>'
// 	      +'</div>'
// 	      +'<div class="row custom-row">'
// 	       +' <div class="col-md-6 col-sm-6 col-xs-6">'
// 	         +' <p class="p-custom">Balcony</p>'
// 	         +' <span><b>2</b></span>'
// 	        +'</div>'
// 	        +'<div class="col-md-6 col-sm-6 col-xs-6">'
// 	         +' <p class="p-custom">Bedroom Size</p>'
// 	          +'<span><b>4.2 M * 3.2 M</b></span>'
// 	        +'</div>'
// 	      +'</div>'
// 	      +'<button type="button" class="button">Book Now</button>'
//    +'</div>';
// 	 $("#home").append(html);
	
	
		$.get("${baseUrl}/builder/buyer/flatlist.jsp?project_id="+<%out.print(project_id);%>+"&building_id="+no+"&floor_id="+$("#filter_floor_id").val()+"&evenOrodd="+$("#evenOrodd").val(),{ }, function(data){
			if($.trim(data)){
				$("#flatdetails").html(data);
			}else{
				$("#flatdetails").html("<span class='text-danger'>Sorry No Flat found.</span>");
			}
			//$("#editCountry").modal('show');
		},'html');
	
}

</script>
