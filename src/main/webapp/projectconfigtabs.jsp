
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="head.jsp" %>
<%@include file="leftnav.jsp" %>    
            <!-- Right main content -->
             <%
             
        int project_id = Integer.parseInt(request.getParameter("project_id"));
             List<BuilderProject> builderProject = new ProjectDetailsDAO().getBuilderProjectById(project_id);
    %>
     <div class="col-sm-8 col-md-10  main">
                <ol class="breadcrumb">
                    <li>
                        <a href="#">Project Configuration</a>
                        
                    </li>
                </ol>
<!--                 <form method="" action="" class="form-horizontal"> -->

                    <ul id="myTab" class="nav nav-tabs">
                    <li class="active">
                            <a href="#contact" data-toggle="tab" >Project</a>
                        </li>
                        
	                     <li >
	                            <a href="#school" data-toggle="tab">Building</a>
	                        </li>
	                     <li>
                            <a href="#campus" data-toggle="tab" >Floor</a>
                        </li>
                         <li>
                            <a href="#school-acheivement" data-toggle="tab">Flat</a>
                        </li>
                         <li>
                            <a href="#school-pano-image-tab" data-toggle="tab">360<sup>0</sup></a>
                        </li>
                         <li>
                            <a href="#school-image-gallery-tab" data-toggle="tab">Gallery</a>
                        </li>
                        
                        
                    </ul>
                     
                    <div id="myTabContent" class="tab-content">
                      <!-- first tab content -->
                       <div class="tab-pane fade active in" id="contact" aria-labelledby="contact-tab">
                           <h2>Project</h2>
                        </div>
                        <!--end first tab content -->
                        <!-- sec tab content -->
                          <div class="tab-pane fade " id="school" aria-labelledby="country-tab">
                            <h2>Building</h2>
                        </div>                    
                        <!-- end sec tab content -->
                        
                        <!-- third tab content -->     
                       <div class="tab-pane fade " id="campus" aria-labelledby="defaults-tab">
                             <h2>Floor</h2>
                        </div>
                         
                        <!-- third tab content -->
                        
                         <!-- fourth tab content -->                         
                       <div class="tab-pane fade" id="school-acheivement" aria-labelledby="school-acheivement-tab">
                           	<h2>Flat</h2>
                       	</div>
                        <!-- fourth tab content -->
                        
                         <!-- sixth tab content --> 
                         <div class="tab-pane fade" id="school-highlight-tab" aria-labelledby="school-highlight-tab">
                            <h2>School Highlights</h2>
                        </div>                                        
                              <!-- sixth tab content -->
                              <div class="tab-pane fade" id="school-pano-image-tab" aria-labelledby="country-tab">
                            <h2>360<sup>0</sup> Pano</h2>
                             
                        </div>                     
                        <!-- 12th tab content -->
                        <!-- 13th tab content -->
                        <div class="tab-pane fade" id="school-image-gallery-tab" aria-labelledby="country-tab">
                            <h2>Image Gallery</h2>
                           
                        </div>
                 </div>
<!--                 </form> -->

        </div>
    <!-- /Right main content -->
   
    <%@include file="footer.jsp" %>
