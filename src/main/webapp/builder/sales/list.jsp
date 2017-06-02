<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.model.ProjectImageGallery"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectList"%>
<%@page import="org.bluepigeon.admin.data.PossessionList"%>
<%@page import="org.bluepigeon.admin.dao.PossessionDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%
	List<ProjectList> project_list = null;
	session = request.getSession(false);
	Builder builder = new Builder();
	ProjectImageGallery imageGaleries = null;
	int builder_uid = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (Builder)session.getAttribute("ubname");
			builder_uid = builder.getId();
		}
		if(builder_uid > 0){
			project_list = new ProjectDAO().getBuilderActiveProjectsByBuilderId(builder_uid);
			int builder_size = project_list.size();
		}
   	}
	List<State> stateList = new StateImp().getActiveStateByCountryId(1);
	
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
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/custom.css">
     <link href="../plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/switchery/dist/switchery.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.css" rel="stylesheet" />
    <link href="../plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css" rel="stylesheet" />
    <link href="../plugins/bower_components/multiselect/css/multi-select.css" rel="stylesheet" type="text/css" />
 
   <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
       <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
   </div>
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Project List</h4> </div>
                    <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12"></div>
                    <!-- /.col-lg-12 -->
                </div>
                <!--.row -->
               
                   <div class="row re white-box">
<!--                     <div class="col-md-3 col-sm-6 col-xs-12"> -->
<!--                         <select class="selectpicker" data-style="form-control" id="country_id" name="country_id"> -->
<!--                                   <option value="0">Country</option> -->
<%--                                   <% for(Country country : countryList){%> --%>
<%--                                   <option value="<%out.print(country.getId());%>"><%out.print(country.getName()); %></option> --%>
<%--                                   <%} %> --%>
<!--                            </select> -->
                               
<!--                     </div> -->
                    <div class="col-md-3 col-sm-6 col-xs-12">
                      <select class="selectpicker" data-style="form-control" id="state_id" name="state_id" >
                      		<option value="0">State</option>
                      		 <% for(State state : stateList){%>
                             <option value="<%out.print(state.getId());%>"><%out.print(state.getName()); %></option>
                             <%} %>
                          </select>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                       <select class="selectpicker" data-style="form-control" id="city_id" name="city_id">
                                        <option value="0">City</option>
                         </select>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                       <select class="selectpicker" data-style="form-control" id="locality_id" name="locality_id">
                                        <option value="0">Locality</option>
                        </select>
                    </div>
                    <input type="hidden" id="builder_id" name="builder_id" value="<%out.print(builder_uid); %>"/>
                    <div class="container" id="project_list">
                       
                       	<%
                       		if(project_list !=null){
                       			
                       			for(ProjectList projectList : project_list ){
                       	%>
                       	<div class="col-md-6 col-sm-6 col-xs-12 projectsection" id="projectlist">
                       		 <a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id=<% out.print(projectList.getId());%>" >
	                       	<div class="image">
	                       		<%
	                       		try{
	                       		imageGaleries = new ProjectDAO().getProjectImagesByProjectId(projectList.getId()).get(0);
	                       	     if(imageGaleries.getImage() != null){
	                       	%>
		                     <img src="${baseUrl}/<% out.print(imageGaleries.getImage()); %>" height="330" alt="Project image"/>
		                       	<%}}catch(Exception e){ %>
		                       		 <img src="../plugins/images/Untitled-1.png" alt="Project image"/>
		                       	<%} %>
		                       	<div class="overlay">
			                       	<div class="row">
				                       	<div class="col-md-6 left">
					                       <h3><%out.print(projectList.getName()); %></h3>
					                       <h4><%out.print(projectList.getCityName()); %></h4>
<!-- 					                       <br> -->
<!-- 						                       <div class="bottom"> -->
<!-- 						                       <h4>50/500 SOLD</h4> -->
<!-- 						                       </div> -->
				                       	</div>
				                    	<div class="col-md-6 right">
					                      	<div class="chart" id="graph<%out.print(projectList.getId()); %>" data-percent="<%out.print(projectList.getId()); %>"> </div>
<!-- 						                  	<div class="bottom"> -->
<!-- 						                    	<h4>10 NEW LEADS</h4> -->
<!-- 						                 	</div> -->
				                       </div>
			                       </div>
	                           </div>
	                       </div></a>
                        </div>
                        <%  
                       		}
                       	}
                        %>
<!-- 	                    <div class="offset-sm-5 col-sm-7"> -->
<!-- 	                        <button type="submit" class="btn btn11 btn-info waves-effect waves-light m-t-10">More...</button> -->
<!-- 	                     </div> -->
                    </div>
                    
                </div>
                
                </div>
                </div>
        <!-- /.container-fluid -->
       		<div id="sidebar1"> 
	      		<%@include file="../partial/footer.jsp"%>
			</div> 
       
    <script src="../plugins/bower_components/switchery/dist/switchery.min.js"></script>
    <script src="../plugins/bower_components/custom-select/custom-select.min.js" type="text/javascript"></script>
    <script src="../plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
    <script src="../plugins/bower_components/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
    <script src="../plugins/bower_components/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../plugins/bower_components/multiselect/js/jquery.multi-select.js"></script>
    <script>
    jQuery(document).ready(function() {
        // Switchery
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
        $('.js-switch').each(function() {
            new Switchery($(this)[0], $(this).data());

        });
        // For select 2

        $(".select2").select2();
        $('.selectpicker').selectpicker();
		
        //Bootstrap-TouchSpin
        $(".vertical-spin").TouchSpin({
            verticalbuttons: true,
            verticalupclass: 'ti-plus',
            verticaldownclass: 'ti-minus'
        });
        var vspinTrue = $(".vertical-spin").TouchSpin({
            verticalbuttons: true
        });
        if (vspinTrue) {
            $('.vertical-spin').prev('.bootstrap-touchspin-prefix').remove();
        }

        $("input[name='tch1']").TouchSpin({
            min: 0,
            max: 100,
            step: 0.1,
            decimals: 2,
            boostat: 5,
            maxboostedstep: 10,
            postfix: '%'
        });
        $("input[name='tch2']").TouchSpin({
            min: -1000000000,
            max: 1000000000,
            stepinterval: 50,
            maxboostedstep: 10000000,
            prefix: '$'
        });
        $("input[name='tch3']").TouchSpin();

        $("input[name='tch3_22']").TouchSpin({
            initval: 40
        });

        $("input[name='tch5']").TouchSpin({
            prefix: "pre",
            postfix: "post"
        });

        // For multiselect

        $('#pre-selected-options').multiSelect();
        $('#optgroup').multiSelect({
            selectableOptgroup: true
        });

        $('#public-methods').multiSelect();
        $('#select-all').click(function() {
            $('#public-methods').multiSelect('select_all');
            return false;
        });
        $('#deselect-all').click(function() {
            $('#public-methods').multiSelect('deselect_all');
            return false;
        });
        $('#refresh').on('click', function() {
            $('#public-methods').multiSelect('refresh');
            return false;
        });
        $('#add-option').on('click', function() {
            $('#public-methods').multiSelect('addOption', {
                value: 42,
                text: 'test 42',
                index: 0
            });
            return false;
        });

    });
    
//     $("#country_id").change(function(){
//     //	alert("Country Id : "+$("#country_id").val());
//     	//$("#projectlist").remove();
//     	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
//     		var html = '<option value="">Select State</option>';
//     		$(data).each(function(index){
//     			alert(data[index].name);
//     			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
//     		});
//     		$("#state_id").html(html);
//     		$('.selectpicker').selectpicker('refresh');
//     	},'json');
//     	//getProjectList();
//     });
    $("#state_id").change(function(){
    	$.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#state_id").val() }, function(data){
    		var html = '<option value="">Select City</option>';
    		$(data).each(function(index){
    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
    		});
    		$("#city_id").html(html);
    		$('.selectpicker').selectpicker('refresh');
    	},'json');
    	getProjectList();
    });
    $("#city_id").change(function(){
    	$.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#city_id").val() }, function(data){
    		var html = '<option value="">Select Locality</option>';
    		$(data).each(function(index){
    			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
    		});
    		$("#locality_id").html(html);
    		$('.selectpicker').selectpicker('refresh');
    	},'json');
    	getProjectList();
    });
    $("#locality_id").change(function(){
    	getProjectList();
    });
    
   function getProjectList(){
    	
    	var html = "";
		var image = "";
		var projectName = "";
		var cityName = "";
		var projectId = "";
		$("#project_list").empty();
	   $.post("${baseUrl}/webapi/project/data/list",{builder_id: $("#builder_id").val(), country_id: 1,state_id: $("#state_id").val(), city_id: $("#city_id").val(),locality_id : $("#locality_id").val() },function(data){
		   if(data == ""){
			   $("#project_list").empty();
			   $("#project_list").append("<h2><center>No Records Found</center></h2>");
		   }
			$(data).each(function(index){
				if(data[index].image != "")
					image = "${baseUrl}/"+data[index].image;
				else
					image = "../plugins/images/Untitled-1.png";
				if(data[index].name != ""){
					projectName = data[index].name;
				}
				if(data[index].city != ""){
					cityName = data[index].city;
				}
				if(data[index].id != ""){
					projectId = data[index].id;
				}
 			    	html='<div class="col-md-6 col-sm-6 col-xs-12 projectsection" id="projectlist">'
                  		 +'<a href="${baseUrl}/builder/sales/projectdetails.jsp?project_id='+projectId+'" >'
                   	     +'<div class="image">'
                         +'<img src="'+image+'" height="330"  width="438" alt="Project image"/>'
                       	 +'<div class="overlay">'
	                     +'<div class="row">'
		                 +'<div class="col-md-6 left">'
			             +'<h3>'+projectName+'</h3>'
			             +'<h4>'+cityName+'</h4>'
		                 +'</div>'
		                 +'<div class="col-md-6 right">'
			             +'<div class="chart" id="graph'+projectId+'" data-percent="'+projectId+'"> </div>'
		                 +'</div>'
	                     +'</div>'
                       	 +'</div>'
                         +'</div></a>'
                         +'</div>';
 	            		$("#project_list").append(html);
 	            		createGraph("graph"+projectId);
			 
			});
			
		    },'json');
	   }
    </script>
    <script>
    
    <%
	if(project_list !=null){
		int i=1;
		for(ProjectList projectList : project_list ){
	%>
		createGraph("graph<% out.print(projectList.getId());%>");
	<%}}%>
    
    function createGraph(graphId){
    	//alert(graphId);
    	 var el = document.getElementById(graphId); 
    	//var el = $('div #'+graphId).attr('data-percent');
    	// alert("Graph Id "+el);
    	var per= el.getAttribute('data-percent');
    	//alert("per : "+per);
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
   
    </script>
    
   <!-- <script>
    var el = document.getElementById('graph1'); // get canvas

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
    </script>
        <script>
    var el = document.getElementById('graph2'); // get canvas

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
    </script>
        <script>
    var el = document.getElementById('graph3'); // get canvas

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
    </script>-->

</body>

</html>
