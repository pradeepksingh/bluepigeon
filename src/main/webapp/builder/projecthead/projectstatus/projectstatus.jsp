<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.text.DateFormat"%> 
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
int session_id = 0;
int access_id = 0;
int projectId = 0;
int building_id = 0;
List<ProjectImageGallery> projectImages = null; 
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		session_id = builder.getBuilder().getId();
		access_id = builder.getBuilderEmployeeAccessType().getId();
		if(session_id > 0 && access_id == 4){
			if (request.getParameterMap().containsKey("project_id")) {
				projectId = Integer.parseInt(request.getParameter("project_id"));
				if(projectId != 0) {
					projectImages = new ProjectDAO().getProjectStatusImages(projectId);
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
    <link href="../../plugins/bower_components/morrisjs/morris.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../../css/projectheadstatus.css">
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
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
               <!-- /.row -->
	                <div class="row bspace">
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-submit waves-effect waves-light m-t-10" id="project_status_btn">Project Status</button>
		                </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="inventory_btn">Inventory</button>
		                 </div>
		                 <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="revenue_btn">Revenue</button>
		                </div>
		                <div class="col-md-3 col-sm-3 col-lg-3">
		                    <button type="button" class="btn11 btn-info waves-effect waves-light m-t-10" id="campaign_btn">Campaign</button>
		                </div>
	                </div>
               <!-- row -->
               <!-- row -->
               <div class="white-box">
                   <div class="row">
                   <% for(ProjectImageGallery projectImage :projectImages) { %>
                       <div class="col-md-6 col-sm-6 col-xs-12 projectsection">
	                       <div class="image">
		                       <img src="${baseUrl}/<% out.print(projectImage.getImage()); %>" alt="Project image" class="img2">
		                       <div class="overlay">
		                      		<a href="javascript:openImageModal(<%out.print(projectImage.getId());%>);">
				                       	<div class="row margin-bottom1">
					                      	<div class="col-md-9 col-sm-8 col-xs-8 left" style="padding-top:5px;">
						                       <h3><% out.print(projectImage.getTitle()); %></h3>
					                        </div>
					                        <div class="col-md-3 col-sm-4 col-xs-4 right">
						                       <div class="right">
						                          <div class="chart" id="graph<%out.print(projectImage.getId());%>" data-percent="<%out.print(projectImage.getCompletion());%>">
						                            <canvas height="100" width="100"></canvas>
						                          </div>
						                        </div>
					                       </div>
				                       </div>
				                   </a>
			                       <div class="row bottom-layer">
			                         	<div class="col-sm-8 col-xs-8">
			                           		<h3>Date : <% out.print(dt1.format(projectImage.getCreatedDate())); %></h3>
			                         	</div>
			                         	<div class="col-sm-4 col-xs-4">
			                            	<div class="row">
			                              		<div class="col-sm-6 col-xs-6">
			                  						<a href="${baseUrl}/<% out.print(projectImage.getImage()); %>" download>
			                  				   			<img src="../../images/download.png" alt="Project image" class="img26">
			                  						</a>
			                              		</div>
			                              		<div class="col-sm-6 col-xs-6">
			                   				 		<a href="mailto:xyz@gmail.com;">
			                   				 			<img src="../../images/share.png" alt="Project image" class="img26">
			                   				 		</a>
			                        		 	</div>
			                            	</div>
			                         	</div>
			                       	</div>
                           		</div>
                       		</div>
                      	</div>
                  	<% } %>
	               	</div>
	         	</div>
                <!-- row -->
           	</div>
       	</div>
  </div>
      <!-- Modal -->
<div id="myModal" class="modal fade" role="dialog" style="top:10%;">
	<div class="modal-dialog modal-dialog1">
	<!-- Modal content-->
		<div class="modal-content modal-lg">
			<div class="modal-body modal-body1">
		      	<div id="myCarousel" class="carousel slide" data-ride="carousel" style="position: absolute;">
  					<!-- Wrapper for slides -->
					<div class="carousel-inner">
					    <% for(ProjectImageGallery projectImage :projectImages) { %>
					   	<div class="item" id="modal-img-<% out.print(projectImage.getId()); %>">
					      	<div class="image" style="margin-bottom:0px;">
		                     	<img src="${baseUrl}/<% out.print(projectImage.getImage()); %>" alt="Project image" class="img1" style="height:auto;">
		                        <div class="overlay">
				                  	<div class="row margin-bottom1">  
				                       	<div class="col-md-9 col-sm-8 col-xs-8 left">
					                       	<h3><% out.print(projectImage.getTitle()); %></h3>
				                        </div>
					                  	<div class="col-md-3 col-sm-4 col-xs-4  right">
						                 	<div class="right">
						                      	<div class="chart" id="modalchart<% out.print(projectImage.getId()); %>" data-percent="<% out.print(projectImage.getCompletion()); %>">
						                           	<canvas height="100" width="100"></canvas>
						                      	</div>
						                  	</div>
					                  	</div>
				                 	</div>
				                  	<div class="row bottom-layer">
				                       	<div class="col-sm-8 col-xs-8">
				                        	<h3>Date : <% out.print(dt1.format(projectImage.getCreatedDate())); %></h3>
				                      	</div>
				                     	<div class="col-sm-3 col-xs-4">
				                          	<div class="row">
				                              	<div class="col-sm-6 col-xs-6">
				                  					<a href="${baseUrl}/<% out.print(projectImage.getImage()); %>" download>
				                  				   		<img src="../../images/download.png" alt="Project image" class="img26">
				                  					</a>
				                              	</div>
				                              	<div class="col-sm-6 col-xs-6">
				                   				 	<a href="mailto:xyz@gmail.com;"><img src="../../images/share.png" alt="Project image" class="img26"></a>
				                        		</div>
				                          	</div>
				                      	</div>
				                  	</div>
		                       	</div>
                         	</div> 
					  	</div>
						<% } %>
					</div>
					<!-- Left and right controls -->
					<a class="left carousel-control left-arrow" href="#myCarousel" data-slide="prev">
					  	<img src="../../images/left-arrow.png" alt="Project image">
					   	<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control right-arrow" href="#myCarousel" data-slide="next">
					  	<img src="../../images/right-arrow.png" alt="Project image">
					   	<span class="sr-only">Next</span>
					</a>
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
<script src="${baseUrl}/builder/plugins/bower_components/morrisjs/morris.js"></script>
<script src="${baseUrl}/builder/js/real-estate.js"></script>
<script src="${baseUrl}/builder/plugins/bower_components/raphael/raphael-min.js"></script>
<script>
function openImageModal(id) {
	$(".item").removeClass("active");
	$("#modal-img-"+id).addClass("active");
	$("#myModal").modal("show");
}
<%
if(projectImages !=null){
	int i=1;
	for(ProjectImageGallery projectImage:projectImages){
%>
createGraph("graph<%out.print(projectImage.getId());%>");
createGraph("modalchart<%out.print(projectImage.getId());%>");
<%}}%>

function createGraph(graphId){
	var el = document.getElementById(graphId); 
	var per= el.getAttribute('data-percent');
    var options = {
        percent:  el.getAttribute('data-percent') || 2,
        size: el.getAttribute('data-size') || 100,
        lineWidth: el.getAttribute('data-line') || 5,
        rotate: el.getAttribute('data-rotate') || 0
    }
    var canvas = document.createElement('canvas');
    var span = document.createElement('span');
    span.textContent = options.percent + '%';
        
    if (typeof(G_vmlCanvasManager) !== 'undefined') {
        G_vmlCanvasManager.initElement(canvas);
    }
    var ctx = canvas.getContext('2d');
    canvas.width = canvas.height = options.size;
    el.appendChild(span);
    el.appendChild(canvas);
    ctx.translate(options.size / 2, options.size / 2); // change center
    ctx.rotate((-1 / 2 + options.rotate / 180) * Math.PI); // rotate -90 deg
    //imd = ctx.getImageData(0, 0, 240, 240);
    var radius = (options.size - options.lineWidth) / 2;
    var drawCircle = function(color, lineWidth, percent) {
    		percent = Math.min(Math.max(0, percent || 1), 1);
    		ctx.beginPath();
    		ctx.arc(0, 0, radius, 0, Math.PI * 2 * percent, false);
    		ctx.strokeStyle = color;
            ctx.lineCap = 'round'; // butt, round or square
    		ctx.lineWidth = lineWidth
    		ctx.stroke();
    };
    drawCircle('#efefef', options.lineWidth, 100 / 100);
    drawCircle('#03a9f3', options.lineWidth, options.percent / 100);
}
$("#revenue_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/projecthead/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
});
$("#campaign_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/projecthead/campaign/mycampaigns.jsp?project_id=<% out.print(projectId);%>";
});
$("#inventory_btn").click(function(){
	ajaxindicatorstart("Please wait while.. we load ...");
	window.location.href="${baseUrl}/builder/projecthead/inventory/inventory.jsp?project_id=<% out.print(projectId);%>";
});
</script>