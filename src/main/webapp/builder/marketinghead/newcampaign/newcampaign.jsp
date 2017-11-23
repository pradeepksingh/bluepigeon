<%@page import="org.bluepigeon.admin.data.NameList"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.CampaignDAO"%>
<%@page import="org.bluepigeon.admin.data.CampaignListNew"%>
<%
List<CampaignListNew> campaignLists = null;
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int builder_id = 0;
int access_id = 0;
int projectId = 0;
int emp_id=0;
//List<City> city_list = null;
BuilderProject builderProject = null;
String projectName ="";
String cityName = "";
String localityName ="";
List<NameList> cityname =null;
int cityId = 0;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		builder_id = builder.getBuilder().getId();
		emp_id = builder.getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		if(builder.getBuilderEmployeeAccessType().getId()==3){
			if(builder_id > 0){
				if (request.getParameterMap().containsKey("project_id")) {
					projectId = Integer.parseInt(request.getParameter("project_id"));
					if(projectId != 0) {
						campaignLists = new CampaignDAO().getMyCampaignsByProjectId(projectId);
						cityname = new CampaignDAO().getCityData(projectId);
					}
				}
			}
		}else{
			response.sendRedirect(request.getContextPath()+"/builder/dashboard.jsp");
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
    <link href="../../bootstrap/dist/css/newbootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../css/common.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/jquery.multiselect.css">
    <!-- color CSS -->
     <link rel="stylesheet" type="text/css" href="../../css/addcampaign.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../../js/jquery.form.js"></script>
     <script src="../../js/jquery.multiselect.js"></script>
<!--     <script src="../../js/bootstrap-multiselect.js"></script> -->
<!--     <link rel="stylesheet" href="../../css/bootstrap-multiselect.css"> -->
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
        <div id="sidebar1"> 
         <%@include file="../../partial/sidebar.jsp"%>
        </div>
        <!-- Page Content -->
        <div id="page-wrapper">
           <div class="container-fluid">
               <!-- /.row -->
	          <div class="row bspace">
	                <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" id="marketing_campaign" class="btn11 btn-info waves-effect waves-light m-t-10" >Campaign</button>
	                </div>
	                 <div class="col-md-3 col-sm-3 col-lg-3">
	                    <button type="button" id="marketing_newcampaign" class="btn11 btn-submit waves-effect waves-light m-t-10">New Campaign +</button>
	                </div>
	          </div>
               <!-- row -->
                  <form id="addcampaign" name="addcampaign" class="form-horizontal" action="" method="post" enctype="multipart/form-data" >
                  <div class="white-box">
                     <div class="bg11 bg12">
                     	<input type="hidden" id="emp_id" name="emp_id" value="<%out.print(emp_id);%>"/>
                     	<input type="hidden" id="project_id" name="project_id" value="<%out.print(projectId);%>"/>
                     	<input type="hidden" id="city_id" name="city_id" value="<%out.print(cityId);%>"/>
                     	<input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_id);%>"/>
                        <div class="row ">
					 	   <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
						 	   <label> Project Name<span class="text-danger">*</span></label>
						 	    <input type="text" id="project_name" name="prjecct_name" readonly value="<%if(projectName != "")out.print(projectName); %>" placeholder="Enter Project Name"/><br>
						 	    <div class="messageContainer"></div>
						 	   <label>City<span class="text-danger">*</span></label> <input type="text" id="city" readonly value="<%if(cityName != "")out.print(cityName); %>" name="city' placeholder="Enter City Name"/><br>
						 	    <div class="messageContainer"></div>
						 	    <div>
						 	   <label> Campaign Title<span class="text-danger">*</span></label> 
						 	  
						 	    <input type="text" id="title" name="title"  placeholder="Enter Campaign title"/>
						 	    </div>
						 	    <div class="messageContainer"></div>
						 	    <div>
						 	   <label>T&#38;C<span class="text-danger">*</span></label>  <textarea id="tc" class="todolist" name="tc" rows="10" placeholder="Terms and conditions"></textarea>
						 	   </div>
						 	    <div class="messageContainer"></div>
						 	      <label>Start Date<span class="text-danger">*</span></label> <input type="text" id="start_date" name="start_date"><br>
						 	    <div class="messageContainer"></div>
					 	    </div>
					 	    <div class="col-md-6 col-sm-6 col-xs-12 col-lg-6">
						 	    <label> Locality<span class="text-danger">*</span></label> <input type="text" id="locality" name="locality" value="<%if(localityName != "")out.print(localityName); %>" placeholder="Pimple Saudagar"/><br>
						 	     <div class="messageContainer"></div>
						 	    <label>Campaign Type<span class="text-danger">*</span></label> <textarea  id="campaign_type" name="campaign_type" placeholder="Get Maruti suzuki free on your next booking"/></textarea><br>
						 	     <div class="messageContainer"></div>
						 	    <label> Offer<span class="text-danger">*</span></label>  <input type="text" id="offer" name="offer" placeholder="Enter offer details"/><br>
						 	     <div class="messageContainer"></div>
						 	    <label>Upload Image<span class="text-danger">*</span></label><input id="uploadFile" placeholder="Choose File" />
							    <div class="fileUpload btn newbutton">
								  <span>Choose file</span>
								  <input id="uploadBtn" type="file" name="uploadimg[]" class="upload" />
								</div><br>
								 <div class="messageContainer"></div>
								 <label>End Date<span class="text-danger">*</span></label> <input type="text" id="end_date" name="end_date"><br>
						 	    <div class="messageContainer"></div>
					 	     </div>
					 	     </div>
					 	     <div class="inline1">
					 	         <button type="button" href="#demo" data-toggle="collapse"> 
 								    Preview
 								 </button>
<!--  								  <a href="#demo" class="btn11 apadding" data-toggle="collapse"> Preview </a> -->
					 	        <button type="button" data-toggle="modal" data-target="#myModal">Recipients +</button>
					 	        <div class="smallsection">
					 	           <div id="demo" class="collapse">
					 	             <div class="projectsection">
	                                    <div class="image" id="campimg">
		                                   <img id="blah" src="#" alt="Project image">
		                                   <div class="overlay">
					                          <div class="row">
						                          <div class="col-md-10 col-sm-10 col-xs-10">
						                              <h3><%out.print(projectName); %></h3>
							                       </div>
							                        <div class="col-md-2 col-sm-2 col-xs-2">
							                          <img id="closeimg" src="../../images/error.png" alt="cancle" class="icon1 close1">
							                        </div>
						                        </div>
						                        <h3 class="center-tag" id="camptitle"></h3>
					                        </div>
	                           			 </div>
				                       </div>
			                       </div>
 							    </div>
 							  </div>
					      </div>
					   </div>
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
											<a href=""><img src="../../images/error.png" alt="cancle" data-dismiss="modal"></a>
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
								 		           <%if(cityname!=null){ 
								 		           		for(NameList city : cityname){
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
    <!-- /.container-fluid -->
<div id="sidebar1"> 
   <%@include file="../../partial/footer.jsp"%>
</div> 
</body>
</html>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<!--  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script src="../../js/bootstrap-datepicker.min.js"></script>
<script>
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
	function saveCampaign() {
		ajaxindicatorstart("Please wait, while loading...");
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
    		ajaxindicatorstop();
      	} else {
      		$("#response").removeClass('alert-danger');
            $("#response").addClass('alert-success');
            $("#response").html(resp.message);
            $("#response").show();
            alert(resp.message);
            window.location.href = "${baseUrl}/builder/marketinghead/campaign/mycampaigns.jsp?project_id="+$("#project_id").val();
            ajaxindicatorstop();
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
                        message: 'Campaign name is required and cannot be empty'
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
                        message: 'Wrong Campaign Date',
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
                        message: 'Wrong Campaign Date',
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
            terms:{
            	validators:{
            		notEmpty:{
            			message: 'term is required and cannot be empty'
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
    
    $("#marketing_campaign").click(function(){
    	ajaxindicatorstart("Please wait while.. we load ...");
    	window.location.href="${baseUrl}/builder/marketinghead/campaign/mycampaigns.jsp?project_id=<% out.print(projectId);%>";
    });
    
   
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#uploadBtn").change(function(){
        readURL(this);
    });
    var inputBox = document.getElementById('title');

    inputBox.onkeyup = function(){
        document.getElementById('camptitle').innerHTML = inputBox.value;
    }
</Script>
<script>
$(document).ready(function(){
	   $("#closeimg").click(function(){
	       $(".collapse").removeClass("in");
	   });
	});
</script>