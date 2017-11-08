<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%
List<CampaignListNew> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int builder_id = 0;
int access_id = 0;
int projectId = 0;
int emp_id=0;
List<City> city_list = null;
BuilderProject builderProject = null;
String projectName ="";
String cityName = "";
String localityName ="";
List<ProjectData> builderProjects = null;
int cityId = 0;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		builder_id = builder.getBuilder().getId();
		emp_id = builder.getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		builderProjects = new ProjectDAO().getActiveProjectsByBuilderEmployees(builder);
		city_list = new CityNamesImp().getCityNames();
					
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
    <link href="../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/jquery.multiselect.css">
   
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/newcampaign.css">
     <link rel="stylesheet" type="text/css" href="../css/selectize.css" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../js/jquery.form.js"></script>
 <script src="../js/jquery.multiselect.js"></script>
   
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
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid addlead">
               <!-- /.row -->
               <div class="row"></div>
	            <h1>New Campaign</h1>
               <!-- row -->
               <div class="white-box">
               <div class="bg11">
                   <form class="addlead1" id="addcampaign" name="addcampaign" action="" method="post" enctype="multipart/form-data">
                   		<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
                     	<input type="hidden" id="project_id" name="project_id" value=""/>
                     	<input type="hidden" id="city_id" name="city_id" value=""/>
                     	<input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_id);%>"/>
	                    <div class="row">
		                    <div class="col-md-6 col-sm-12 col-xs-12">
		                         <div class="form-group row">
									<label for="example-text-input" class="col-sm-5 col-form-label">Project  Name</label>
									  <div class="col-sm-7">
										  <select id="filter_project_id" name="filter_project_id">
					                         <%
					                         if(builderProjects!=null){
					                         	for(ProjectData projectData:builderProjects){%>
					                         	<option value="<%out.print(projectData.getId());%>"><%out.print(projectData.getName()); %></option>		
					                         	<%}
					                         }
					                         %>
					                        </select>
									  </div>
								  </div>
								  <div class="form-group row">
									 <label for="example-search-input" class="col-sm-5 col-form-label">City</label>
										<div class="col-sm-7">
										   <input class="form-control  form-control1" type="text" name="city_name" id="city_name" placeholder="Pune">
										 </div>
								    </div>
		                            <div class="form-group row">
									 <label for="example-search-input" class="col-sm-5 col-form-label">Campaign Type</label>
										<div class="col-sm-7">
											<div>
										    	<textarea id="campaign_type" name="campaign_type" placeholder="Get Maruti Suzuki free on your next booking!"></textarea>
										    </div>
										    <div class="messageContainer"></div>
										</div>
								    </div>
								    <div class="form-group row">
							           <label for="example-tel-input" class="col-sm-5 col-form-label">T&#38;C*</label>
								         <div class="col-sm-7">
								         	<div>
								         		<textarea id="tc" class="todolist" name="tc" placeholder="Terms and conditions"></textarea>
									     	</div>
									     	<div class="messageContainer"></div>
									     </div>
								    </div>
								    <div class="form-group row">
							           <label for="example-tel-input" class="col-sm-5 col-form-label">Start Date</label>
								         <div class="col-sm-7">
								         	<div>
												<input type="text" id="start_date" name="start_date">
										    </div>
											<div class="messageContainer"></div>
		 								</div>
								    </div>
						       </div>
		                       <div class="col-md-6 col-sm-12 col-xs-12">
		                          <div class="form-group row">
									<label for="example-text-input" class="col-sm-5 col-form-label"> Locality</label>
									  <div class="col-sm-7">
										 <input class="form-control form-control1" type="text" name="locality_name" id="locality_name"  placeholder="Kothrud">
									  </div>
								  </div>
								   <div class="form-group row">
							           <label for="example-tel-input" class="col-sm-5 col-form-label">Campaign Title</label>
								         <div class="col-sm-7">
									         <div>
									         	<input class="form-control  form-control1" type="text"  id="title" name="title"  placeholder="Enter Campaign title">
										     </div>
										      <div class="messageContainer"></div>
									     </div>
								    </div>
									<div class="form-group row">
										<label for="example-search-input  form-control1" class="col-sm-5 col-form-label">Offer code</label>
										<div class="col-sm-7">
										 	<div>
										   		<input class="form-control  form-control1" type="text" id="offer" name="offer" placeholder="Enter offer details">
										   	</div>
										    <div class="messageContainer"></div>
										</div>
									</div>
								    <div class="form-group row">
									   	<label for="example-text-input" class="col-sm-5 col-form-label"> Upload Image</label>
										<div class="col-sm-7">
											<div class="file-upload">
										   		<p class="file-name"> text.png </p>
										    	<label for="uploadfile" class="btn">Choose File</label>
										   		<input type="file" id="uploadfile" name="uploadimg[]">
											</div>
									  	</div>
								    </div>
								    <div class="form-group row">
										<label for="example-text-input" class="col-sm-5 col-form-label"> End Date</label>
									 	<div class="col-sm-7">
									  		<div>
												<input type="text" id="end_date" name="end_date">
											</div>
											<div class="messageContainer"></div>
										</div>
								  	</div>
								 </div>
							</div>
							<div class="row">
								<div class="center">
							  	     <a href="#demo" class="btn11 apadding" data-toggle="collapse"> Preview </a>
							  	     <button type="button" class="btn11" data-toggle="modal" data-target="#myModal">Recipients +</button>
							  	 </div>
							</div>
								<!-- collapse starts-->
						    <div id="demo" class="collapse preview">
						      <div class="image" id="campimg">
<!-- 			                       <img id="blah" src="../plugins/images/Untitled-1.png" alt="Project image"> -->
			                        <img id="blah" src="#" alt="Project image">
			                       <div class="overlay">
				                       <div class="row">
					                       <div class="col-md-6 col-sm-9 col-xs-9 left">
						                       <h3 id="cprojectname"></h3>
						                        <br>
							                    <div class="bottom">
							                      <h4><span>T&amp;C</span></h4>
							                      <h6>Duration</h6>
							                      <h4 id="campdate"></h4>
							                    </div>
					                        </div>
					                        <h3 class="center-tag" id="camptitle"></h3>
					                        <div class="col-md-6 col-sm-3 col-xs-3 right">
						                       <div class="right">
						                            <button type="button" class="close" data-dismiss="modal">
			                                           <img id="closeimg" src="../images/error.png" alt="close" class="close-img">
			                                         </button>
						                        </div>
					                       </div>
				                       </div>
		                           </div>
		                       </div>
							</div>
						   		 <!-- collapse ends-->
						   		 <!-- Modal of Recipients +-->
  							<div class="modal fade" id="myModal" role="dialog">
    							<div class="modal-dialog">
      								<div class="modal-content">
        								<div class="modal-body">
		           							<div class="row">
					  							<div class="col-md-10 col-sm-10 col-xs-10">
													<h3>Add Recipients</h3>
					  							</div>
					  							<div class="col-md-2 col-sm-2 col-xs-2">
													<a href=""><img src="../images/error.png" alt="cancle" data-dismiss="modal"></a>
					  							</div>
											</div>
		  									<div class="row">
			  									<div class="col-sm-6">
			  										<div class="form-group row">
			  											<label class="col-sm-4"> User Type</label>
				  										<div class="col-sm-8" id="selectbuyers">
			  												<select  name="user_type[]" id="user_type" multiple="multiple">
				          										<option  value="1">Buyers</option>
				        										<option  value="2">Leads</option>
				        										<option  value="3">Staffs</option>
				 		  									</select>
			  											</div>
			  										</div>
			  									</div>
			   		 							<div class="col-sm-6">
			   		 								<div class="form-group row">
			   		 									<label class="col-sm-4">City</label> 
			   		 									<div class="col-sm-8" id="selectcity">
									   		 				<select id="city_names" name="city_names[]" multiple="multiple">
										 		           <%if(city_list!=null){ 
										 		           		for(City city : city_list){
										 		           %>
																<option value="<%out.print(city.getId());%>"><%out.print(city.getName()); %></option>
										 		           <%}} %>
													    	</select>
			   		 									</div>
			   		 								</div>
			   		 							</div>
		       								</div>	
		  									<div class="row">
			  									<div class="col-sm-6">
			  										<div class="form-group row">
			  				 							<label class="col-sm-4">Project</label>
		  				 								<div class="col-sm-8" id="selectProjects">
		  				 	 								<select id="project_ids" name="project_ids[]" multiple="multiple"></select>
		  				 								</div>
			  										</div>
			  									</div>
			  									<div class="col-sm-6">
			  										<div class="form-group row">
					     								<label class="col-sm-4">Building</label> 
					     								<div class="col-sm-8" id="selectbuildings">
					     									<select id="building_ids" name="building_ids[]" multiple="multiple"></select>
					     								</div>
					     							</div>
			  									</div>
											</div>
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group row">
					      								<label class="col-sm-4"> Name</label> 
					      								<div class="col-sm-8">
					       									<select id="buyer_ids"  name="buyer_ids[]" multiple="multiple"></select>
					          							</div>
						  							</div>
		  										</div>
	  												<input type="hidden" id="h_project_ids" name="h_project_ids[]" />
  											</div>
  											<div class="row">
	  											<div class="center">
	  		   										<button type="submit" id="publish" class="button1">Publish</button>
	  											</div>
  											</div>
        						 		</div>
 	  								</div>
								</div>
							</div>
						</form>
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
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<script src="../js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="../js/selectize.min.js"></script>
<script>
$(document).ready(function(){
	   $("#closeimg").click(function(){
	       $(".collapse").removeClass("in");
	   });
	});
</script>
<script>
$select_project = $("#filter_project_id").selectize({
	persist: false,
	 onChange: function(value) {
		if(value != "" && value > 0){
			ajaxindicatorstart("Please wait, while Loading...");
			 $.post("${baseUrl}/webapi/campaign/filter/project",{project_id: value},function(data){
				 	$("#city_name").val(data.name);
				 	$("#locality_name").val(data.localityName);
				 	$("#project_id").val(data.id);
				 	$("#city_id").val(data.cityId);
					 ajaxindicatorstop();
			});
		}
	 },
	 onDropdownOpen: function(value){
    	 var obj = $(this);
		var textClear =	 $("#filter_project_id :selected").text();
    	 if(textClear.trim() == "Enter Project Name"){
    		 obj[0].setValue("");
    	 }
     }
});
$('#start_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#addcampaign').data('bootstrapValidator').revalidateField('start_date');
});
$('#end_date').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#addcampaign').data('bootstrapValidator').revalidateField('end_date');
});
jQuery(function($) {
	$('input[type="file"]').change(function() {
	    if ($(this).val()) {
		    error = false;
	      var filename = $(this).val();
				$(this).closest('.file-upload').find('.file-name').html(filename);
	      if (error) {
	        parent.addClass('error').prepend.after('<div class="alert alert-error">' + error + '</div>');
	      }
	    }
	});
});
$('#user_type').multiselect({
     columns: 1,
     placeholder: 'Select User Type',
     search: true,
     selectAll: true,
     onControlClose : function(element){getProjectList(element);}
 });
function getProjectList(element){
	 var ids = "";
	 $("#selectprojects .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	  });
}
$('#buyer_ids').multiselect({
    columns: 1,
    placeholder: 'Select Name',
    search: true,
    selectAll: true
});
$('#project_ids').multiselect({
    columns: 1,
    placeholder: 'Select Project',
    search: true,
    selectAll: true,
    onControlClose : function(element){getBuyerOrBuildingList(element);}
});
$('#building_ids').multiselect({
    columns: 1,
    placeholder: 'Select Building',
    search: true,
    selectAll: true,
    onControlClose : function(element){getBuyerList(element);}
});
$('#city_names').multiselect({
    columns: 1,
    placeholder: 'Select City',
    search: true,
    selectAll: true,
    onControlClose : function(element){getProjectList(element);}
    
});
function getProjectList(element){
	var ids = "";
	var emp_id = $("#emp_id").val();
	 $("#selectcity .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	 });
	  if(ids.length > 0){
		  ajaxindicatorstart("Please wait, while loading...");
		  $.get("${baseUrl}/webapi/builder/projectdata/"+ids+"/"+emp_id,{},function(data){
		    	 $('#project_ids').multiselect('loadOptions',data);
		    	 $('#project_ids').multiselect('reload');
		    	 ajaxindicatorstop();
			});
	 }else {
		 ajaxindicatorstart("Please wait, while loading...");
		  $.get("${baseUrl}/webapi/builder/projectdata/"+ids.length+"/"+emp_id,{},function(data){
		    	 $('#project_ids').multiselect('loadOptions',data);
		    	 $('#project_ids').multiselect('reload');
		    	 ajaxindicatorstop();
			});
	 }
}
function getBuyerOrBuildingList(element){
	var ids = "";
	var name_id = "";
	var building_ids = "";
	var val="";
	var name_ids = "";
	var emp_id = $("#emp_id").val();
	$("#selectProjects .ms-options li.selected input").each(function(index){
		 if(ids == ""){
			 ids = $(this).val();
		 }else{
			ids = ids +","+ $(this).val();
		 }
	});
	$("#selectbuyers .ms-options li.selected input").each(function(index){
		 if(name_id == ""){
			 name_id = $(this).val();
		 }else{
			 name_id = name_id +","+ $(this).val();
		 }
	});
	 
	$("#selectbuildings .ms-options li.selected input").each(function(index){
		 if(building_ids == ""){
			 building_ids = $(this).val();
		 }else{
			 building_ids = building_ids +","+ $(this).val();
		 }
	});
	if(ids.length>0 && name_id.length >0){
		ajaxindicatorstart("Please wait, while loading...");
		$.get("${baseUrl}/webapi/builder/buyerorbuilding/data/"+ids+"/"+name_id+"/"+emp_id,{},function(data){
			if(data != ""){
				$(data).each(function(index){
		 			val=data[index].typeId;
		 			$('input[name="h_project_ids[]"]').val(data[index].id);
	 			});
				if(val!=4){
		 			$('#building_ids').multiselect('loadOptions',"");
    	 			$('#building_ids').multiselect('reload');
		 			$('#buyer_ids').multiselect('loadOptions',data);
    	 			$('#buyer_ids').multiselect('reload');
				}else{
					$('#buyer_ids').multiselect('loadOptions',"");
    				$('#buyer_ids').multiselect('reload');
					$('#building_ids').multiselect('loadOptions',data);
    				$('#building_ids').multiselect('reload');
				}
			}else{
 				alert("Sorry No data found");
			}
 	 		ajaxindicatorstop();
		});
	 }else{
		$('#buyer_ids').multiselect('loadOptions',"");
		$('#buyer_ids').multiselect('reload');
		$('#building_ids').multiselect('loadOptions',"");
    	$('#building_ids').multiselect('reload');
	 }
}
function getBuyerList(element){
	var building_ids = "";
	$("#selectbuildings .ms-options li.selected input").each(function(index){
		if(building_ids == ""){
			building_ids = $(this).val();
	 	}else{
		 	building_ids = building_ids +","+ $(this).val();
	 	}
	});
	if(building_ids.length > 0){
		ajaxindicatorstart("Please wait, while loading...");
		$.get("${baseUrl}/webapi/builder/buyer/data/"+building_ids,{},function(data){
			if(data != ""){
				$('#buyer_ids').multiselect('loadOptions',data);
	 			$('#buyer_ids').multiselect('reload');
 			}else{
	 			alert("Sorry No data found");
 			}
  	 	ajaxindicatorstop();
		});
	 }else{
		$('#buyer_ids').multiselect('loadOptions',"");
	    $('#buyer_ids').multiselect('reload');
	 }
}
$('#addcampaign').bootstrapValidator({
   	container: function($field, validator) {
   		return $field.parent().next('.messageContainer');
      	},
       feedbackIcons: {
           validating: 'glyphicon glyphicon-refresh'
       },
       excluded: ':disabled',
       fields: {
       	project_name:{
       		validators:{
       			notEmpty:{
       				message: 'Project Name  is required and cannot be empty'
       			}
       		}
       	},	
       
       	title: {
               validators: {
                   notEmpty: {
                       message: 'Campaign title is required and cannot be empty'
                   }
               }
           },
           campaign_type:{
           	validators:{
           		notEmpty: {
           			message:'campaign type is required and cannot be empty'
           		}
           	}
           },
           start_date: {
               validators: {
                   callback: {
                       message: 'Wrong Campaign Start Date',
                       callback: function (value, validator) {
                           var m = new moment(value, 'DD MMM YYYY', true);
                           if (!m.isValid()) {
                               return false;
                           } else {
                           	return true;
                           }
                       }
                   }
               }
           },
           end_date: {
               validators: {
                   callback: {
                       message: 'Wrong Campaign End Date',
                       callback: function (value, validator) {
                           var m = new moment(value, 'DD MMM YYYY', true);
                           if (!m.isValid()) {
                               return false;
                           } else {
                           	return true;
                           }
                       }
                   }
               }
           },
           content:{
           	validators:{
           		notEmpty:{
           			message: 'content is required and cannot be empty'
           		}
           	}
           },
           tc:{
           	validators:{
           		notEmpty:{
           			message: 'terms & condition is required and cannot be empty'
           		}
           	}
           },
           offer:{
           	validators:{
           		notEmpty:{
           			message: 'offer is required and cannot be empty'
           		}
           	}
           },
           recipient_type_id:{
           	validators:{
           		notEmpty:{
           			message: 'recipient type is required and cannot be empty'
           		}
           	}
           },
           'project[]': {
               validators: {
                   notEmpty: {
                       message: 'Project is required and cannot be empty'
                   }
               }
           },
           city:{
           	validators:{
           		notEmpty:{
           			message : 'city Name is required and cannot be empty'
           		}
           	}
           },
           'city_id[]': {
               validators: {
                   notEmpty: {
                       message: 'City Name is required and cannot be empty'
                   }
               }
           }
       }
}).on('success.form.bv', function(event,data) {
   	// Prevent form submission
   	event.preventDefault();
   	saveCampaign();
}).on('error.form.bv', function(event,data) {
   	// Prevent form submission
   	event.preventDefault();
});
	 
function saveCampaign() {
   	var options = {
   	 		target : '#response', 
   	 		beforeSubmit : showAddRequest,
   	 		success :  showAddResponse,
   	 		url : '${baseUrl}/webapi/campaign/new/save',
   	 		semantic : true,
   	 		dataType : 'json'
   	 	};
      	$('#addcampaign').ajaxSubmit(options);
}
function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
	       	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
		alert(resp.message);
		window.location.reload();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href="${baseUrl}/builder/campaign/campaignlist.jsp";
  	}
}
	    
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
            $('#blah').attr('src', e.target.result);
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

$("#uploadfile").change(function(){
    readURL(this);
});
var inputBox = document.getElementById('title');

inputBox.onkeyup = function(){
    document.getElementById('camptitle').innerHTML = inputBox.value;
}

$("#start_date").on('change',function(){
	if($(this).val() != "" && $("#end_date").val() !=""){
		document.getElementById('campdate').innerHTML = $(this).val()+" to "+$("#end_date").val();
	}else if($(this).val() != "" && $("#end_date").val() ==""){
		document.getElementById('campdate').innerHTML =$(this).val()+" to till date";
	}
});
$("#end_date").on('change',function(){
	if( $("#start_date").val() != "" && $(this).val() !=""){
		document.getElementById('campdate').innerHTML = $("#start_date").val()+" to "+$(this).val();
	}else if($("#start_date").val() != "" && $(this).val() ==""){
		document.getElementById('campdate').innerHTML =$(this).val()+" to till date";
	}
});
document.getElementById('cprojectname').innerHTML = $("#filter_project_id :selected").text();
</script>
