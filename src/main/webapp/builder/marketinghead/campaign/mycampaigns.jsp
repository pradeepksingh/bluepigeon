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
		if(session_id > 0){
			if (request.getParameterMap().containsKey("project_id")) {
				projectId = Integer.parseInt(request.getParameter("project_id"));
				if(projectId != 0) {
					campaignLists = new CampaignDAO().getMyCampaignsByProjectId(projectId);
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
    <link rel="stylesheet" type="text/css" href="../../css/projectheadcampaign.css">
    <link href="../../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <!-- jQuery -->
    <script src="../../plugins/bower_components/jquery/dist/jquery.min.js"></script>
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
                       <div class="col-md-6 col-sm-6 col-xs-12 projectsection">
	                       <div class="image">
		                       <img src="${baseUrl}/<% out.print(campaign.getImage());%>" alt="Project image">
		                       <div class="overlay">
			                       <div class="row">
				                       <div class="col-md-7 col-sm-7 col-xs-7 left">
					                       <h3><% out.print(campaign.getName()); %></h3>
					                        <br>
						                    <div class="bottom">
						                      <h4><span><a href="javascript:openTermsModal(`<% out.print(campaign.getTerms()); %>`);" class="tcanchor">T&C</a></span></h4>
						                      <h6>Duration</h6>
						                      <h4><% if(campaign.getStartDate() != null){ out.print(dt1.format(campaign.getStartDate()));} %> to <%if(campaign.getEndDate() != null){out.print(dt1.format(campaign.getEndDate())); }else{out.print("till date");}%></h4>
						                    </div>
				                        </div>
				                        <h3 class="center-tag">
				                           <% if(campaign.getContent() != null && campaign.getContent() != "")out.print(campaign.getContent()); %> <BR>
				                           <span>on your next booking</span>
										</h3>
				                        <div class="col-md-5 col-sm-5 col-xs-5 right">
					                       <div class="right">
					                       <% if(campaign.getEndDate() != null){
				                       		   	if(date.after(campaign.getEndDate())){ %>
					                          		<img src="../../images/red.png" alt="inactive" class="icon"/>
					                          	<% } else { %>
					                          		<img src="../../images/green.png" alt="active" class="icon"/>
					                          	<% } %>
					                       	<% } else { %>
					                       		<img src="../../images/green.png" alt="active" class="icon"/>
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
<div class="modal fade" id="myCampainTermsModal" role="dialog">
  	<div class="modal-dialog inbox">
     	<div class="modal-content">
       		<div class="modal-body">
          		<div class="row">
		  			<div class="col-md-12 col-sm-12 col-xs-12">
		    			<h3>Terms & Conditions</h3>
	      			</div>
	    		</div>
	  			<div class="row" id="myterms_popup"></div>
  			</div>
	  	</div>
 	</div>
</div>
<script type="text/javascript">
function openTermsModal(tc) {
	$("#myterms_popup").html(tc);
	$("#myCampainTermsModal").modal('show');
}
$("#marketing_newcampaign").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/marketinghead/newcampaign/newcampaign.jsp?project_id=<% out.print(projectId);%>";
});

</script>

