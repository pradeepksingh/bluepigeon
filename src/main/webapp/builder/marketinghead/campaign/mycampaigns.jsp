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
int session_id = 0;
int access_id = 0;
int projectId = 0;
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		session_id = builder.getBuilder().getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		if(builder.getBuilderEmployeeAccessType().getId()==3){
			if(session_id > 0){
				if (request.getParameterMap().containsKey("project_id")) {
					projectId = Integer.parseInt(request.getParameter("project_id"));
					if(projectId != 0) {
						campaignLists = new CampaignDAO().getMyCampaignsByProjectId(projectId);
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
    <link href="../../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <link href="../../css/common.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/projectheadcampaign.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
     <script src="../../js/jquery.form.js"></script>
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
		                    <button type="button" id="marketing_campaign" class="btn11 btn-submit waves-effect waves-light m-t-10" id="project_status_btn">Campaign</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" id="marketing_newcampaign" class="btn11 btn-info waves-effect waves-light m-t-10" id="inventory_btn">New Campaign +</button>
		                 </div>
	                </div>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                   <%if(campaignLists != null) { %>
                   <% for(CampaignListNew campaign:campaignLists) { %>
                   		<input type="hidden" id="campid<%out.print(campaign.getId()); %>" name="campid" value="<%out.print(campaign.getId());%>" />
                   		<input type="hidden" id="campenddate<%out.print(campaign.getId()); %>" name="campenddate" value="<%if(campaign.getEndDate()!=null){out.print(dt1.format(campaign.getEndDate()));}else{out.print("");}%>" />
                   		<input type="hidden" id="campstartdate<%out.print(campaign.getId()); %>" name="campstartdate" value="<%if(campaign.getStartDate()!=null){out.print(dt1.format(campaign.getStartDate()));}else{out.print("");}%>" />
                       <div class="col-md-6 col-sm-6 col-xs-12 projectsection">
	                       <div class="image">
		                       <img src="${baseUrl}/<% out.print(campaign.getImage());%>" alt="Project image">
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-7 col-sm-7 col-xs-7 left">
					                       <h3><% out.print(campaign.getName()); %></h3>
					                        <br>
						                    <div class="bottom">
						                      <h4><span>T&C</span></h4>
						                      <h6>Duration</h6>
						                      <h4><% if(campaign.getStartDate() != null){ out.print(dt1.format(campaign.getStartDate()));} %> to <%if(campaign.getEndDate() != null){out.print(dt1.format(campaign.getEndDate())); }else{out.print("till date");}%></h4>
						                    </div>
				                        </div>
				                        <h3 class="center-tag">
				                           <% if(campaign.getContent() != null && campaign.getContent() != "")out.print(campaign.getContent()); %> <BR>
										</h3>
				                        <div class="col-md-5 col-sm-5 col-xs-5 right">
					                       <div class="right">
					                       	<a href="javascript:openEditModal('<%out.print(campaign.getId());%>','<%out.print(campaign.getTerms());%>');"><i class="fa fa-pencil"></i></a>
					                       <% if(campaign.getEndDate() != null){
				                       		   	if(date.after(campaign.getEndDate())){ %>
					                          		<img src="../../images/red.png" alt="inactive" title="inactive" class="icon"/>
					                          	<% } else { %>
					                          		<img src="../../images/green.png" alt="active" title="active" class="icon"/>
					                          	<% } %>
					                       	<% } else { %>
					                       		<img src="../../images/green.png" alt="active" title="active" class="icon"/>
					                       	<% } %>
					                        </div>
						                    <div class="bottom">
						                       <div class="row">
						                          <div class="col-xs-6">
						                      		<img src="../../images/key.png" alt="cancle" class="icon"/>
						                      		<span class="span-style">BOOKED</span>
						                      		<h4><% out.print(campaign.getBooking()); %></h4>
						                          </div>
						                          <div class="col-xs-6">
								                      <img src="../../images/click.png" alt="cancle" class="icon"/>
								                      <span class="span-style">LEADS</span>
						                      		 <h4><% out.print(campaign.getLeads()); %></h4>
						                          </div>
						                       </div>
						                    </div>
				                       </div>
			                       </div>
	                           </div>
	                       </div>
                       </div>
                 	<% } %>
                 	<% } %>
	                </div>
	              </div>
                <!-- row -->
           </div>
         </div>
      </div>
  	  <div id="sidebar1"> 
	     <%@include file="../../partial/footer.jsp"%>
	  </div> 
  </body>
</html>
<div class="modal fade" id="myCampainTermsModal" role="dialog" style="padding-right: 15px;padding-top: 15%;">
  	<div class="modal-dialog inbox">
     	<div class="modal-content">
     		<form id='updatecampaign' name='updatecampaign' class='form-horizontal' action='' method='post' enctype='multipart/form-data' >
       		<div class="modal-body">
          		<div class="row">
					<div class="col-md-10 col-sm-10 col-xs-10">
						<h3>Update Campaign</h3>
					</div>
					<div class="col-md-2 col-sm-2 col-xs-2" style="padding-top:10px">
						<a href=""><img src="../../images/error.png" alt="cancle" data-dismiss="modal" style="width:50%;"></a>
					</div>
				</div>
	    		<div class="row">
	  				<input type='hidden' id='camp_id' name='camp_id' value=""/>
						<div class='row'>
							<div class='col-sm-9'>
								<div class='form-group row'>
									<label class='col-sm-4'> T&C</label>
									<div class='col-sm-8'>
										<div>
											<pre><textarea rows="6" style="resize:none;" cols="60" id='terms' class='form-control' name='terms' value=""></textarea></pre>
										</div>
										<div class='messageContainer'></div>
									</div>
								</div>
							</div>
						</div>
						<div class='row'>
							<div class='col-sm-6'>
								<div class='form-group row'>
									<label class='col-sm-4'> start date </label>
									<div class='col-sm-8'>
										<div>
											<input type='text' id='startdate' class='form-control' name='startdate' value="">
										</div>
										<div class='messageContainer'></div>
									</div>
								</div>
							</div>
							<div class='col-sm-6'>
								<div class='form-group row'>
									<label class='col-sm-4'>end date</label>
									<div class='col-sm-8'>
										<div>
											<input type='text' id='enddate' class='form-control' name='enddate' value="">
										</div>
										<div class='messageContainer'></div>
									</div>
								</div>
							</div>
						</div>
	  				</div>
  				</div>
  				<div class='modal-footer'>
					<button type='submit' id='publish' class='btn btn-submit' style="margin-right: 43%;">UPDATE</button>
				</div>
  			</form>
	  	</div>
 	</div>
</div>
<script src="//oss.maxcdn.com/momentjs/2.8.2/moment.min.js"></script>
<!--  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script src="../../js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
$('#startdate').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	$('#updatecampaign').data('bootstrapValidator').revalidateField('startdate');
});
$('#enddate').datepicker({
	autoclose:true,
	format: "dd M yyyy"
}).on('change',function(e){
	 $('#updatecampaign').data('bootstrapValidator').revalidateField('enddate');
});
function openEditModal(id,tc){
	
	var startdate = $("#campstartdate"+id).val();
	var enddate = $("#campenddate"+id).val();
	$("#startdate").val(startdate);
	$("#enddate").val(enddate);
	$("#terms").val(tc);
	$("#camp_id").val(id);
	$("#myCampainTermsModal").modal('show');
	  $('#updatecampaign').bootstrapValidator({
	    	container: function($field, validator) {
	    		return $field.parent().next('.messageContainer');
	       	},
	        feedbackIcons: {
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        excluded: ':disabled',
	        fields: {
	        	
	          startdate  : {
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
	            enddate: {
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
	           terms:{
	            	validators:{
	            		notEmpty:{
	            			message: 'term is required and cannot be empty'
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
	  
}
function saveCampaign(){
	ajaxindicatorstart("Please wait, while loading...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/campaign/new/update',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatecampaign').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/marketinghead/campaign/mycampaigns.jsp?project_id=<%out.print(projectId);%>";
        ajaxindicatorstop();
  	}
}
// function openTermsModal(tc) {
// 	$("#myterms_popup").html(tc);
// 	$("#myCampainTermsModal").modal('show');
// }
$("#marketing_newcampaign").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/marketinghead/newcampaign/newcampaign.jsp?project_id=<%out.print(projectId);%>";
});

</script>

