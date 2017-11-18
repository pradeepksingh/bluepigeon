<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlat"%>
<%@page import="org.bluepigeon.admin.dao.CancellationDAO"%>
<%@page import="org.bluepigeon.admin.model.Notification"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.EmployeeRole"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%
session = request.getSession(false);
	BuilderEmployee mainadmin = new BuilderEmployee();
	List<EmployeeRole> employeeRoles = new ArrayList<EmployeeRole>();
	List<Notification> notifications = new ArrayList<Notification>();
	int session_uid = 0;
	int access_uid =0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			mainadmin  = (BuilderEmployee)session.getAttribute("ubname");
			session_uid = mainadmin.getId();
			access_uid = mainadmin.getBuilderEmployeeAccessType().getId();
			employeeRoles = new BuilderDetailsDAO().getEmployeeRolesByEmployee(session_uid);
			notifications = new CancellationDAO().getAssignedToByEmployee(session_uid);
		}
   	}
	if(session_uid <= 0) {
		String url = request.getRequestURL().toString();
		System.out.println("URL :: "+url);
		String site = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/builder/";
	   	response.setStatus(response.SC_MOVED_TEMPORARILY);
	   	response.setHeader("Location", site);
	   	System.out.println("Site :: "+site);
	}
%>

<link href="${baseUrl}/builder/css/responsive.css" rel="stylesheet">
<nav class="navbar navbar-default navbar-static-top m-b-0">
            <div class="navbar-header">
                <a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i class="ti-menu"></i></a>
                <div class="top-left-part"><a class="logo" href="${baseUrl}/builder/dashboard.jsp"><b><img src="${baseUrl}/builder/plugins/images/bpadmin-logo.png" alt="home"/></b><span class="hidden-xs"></a></div>
                <ul class="nav navbar-top-links navbar-left hidden-xs">
<!--                     <li> -->
<!--                         <a href="javascript:void(0)" class="open-close hidden-xs waves-effect waves-light"><i class="icon-arrow-left-circle ti-menu"></i></a> -->
<!--                     </li> -->
                    <li>
                        <form role="search" class="app-search hidden-xs">
                            <input type="text" placeholder="Search..." class="form-control"> <a href="#"><i class="fa fa-search"></i></a>
                        </form>
                    </li>
                </ul>
                <ul class="nav navbar-top-links navbar-right pull-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle waves-effect waves-light" data-toggle="dropdown" href="#"><i class="icon-envelope"></i>
<!--                     <div class="notify"><span class="heartbit"></span><span class=""></span></div> -->
                </a>
                        <ul class="dropdown-menu mailbox animated bounceInDown">
<!--                             <li> -->
<!--                                 <div class="drop-title">You have 4 new messages</div> -->
<!--                             </li> -->
<!--                             <li> -->
<!--                                 <div class="message-center"> -->
<!--                                     <a href="#"> -->
<%--                                         <div class="user-img"> <img src="${baseUrl}/builder/plugins/images/users/pawandeep.jpg" alt="user" class="img-circle"> <span class="profile-status online pull-right"></span> </div> --%>
<!--                                         <div class="mail-contnet"> -->
<!--                                             <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:30 AM</span> </div> -->
<!--                                     </a> -->
<!--                                     <a href="#"> -->
<%--                                         <div class="user-img"> <img src="${baseUrl}/builder/plugins/images/users/sonu.jpg" alt="user" class="img-circle"> <span class="profile-status busy pull-right"></span> </div> --%>
<!--                                         <div class="mail-contnet"> -->
<!--                                             <h5>Sonu Nigam</h5> <span class="mail-desc">I've sung a song! See you at</span> <span class="time">9:10 AM</span> </div> -->
<!--                                     </a> -->
<!--                                     <a href="#"> -->
<%--                                         <div class="user-img"> <img src="${baseUrl}/builder/plugins/images/users/arijit.jpg" alt="user" class="img-circle"> <span class="profile-status away pull-right"></span> </div> --%>
<!--                                         <div class="mail-contnet"> -->
<!--                                             <h5>Arijit Sinh</h5> <span class="mail-desc">I am a singer!</span> <span class="time">9:08 AM</span> </div> -->
<!--                                     </a> -->
<!--                                     <a href="#"> -->
<%--                                         <div class="user-img"> <img src="${baseUrl}/builder/plugins/images/users/pawandeep.jpg" alt="user" class="img-circle"> <span class="profile-status offline pull-right"></span> </div> --%>
<!--                                         <div class="mail-contnet"> -->
<!--                                             <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span> <span class="time">9:02 AM</span> </div> -->
<!--                                     </a> -->
<!--                                 </div> -->
<!--                             </li> -->
<!--                             <li> -->
<!--                                 <a class="text-center" href="javascript:void(0);"> <strong>See all notifications</strong> <i class="fa fa-angle-right"></i> </a> -->
<!--                             </li> -->
                        </ul>
                        
                    </li>
                   
                 <%
                        %>
                    <li class="dropdown">
                        <a class="dropdown-toggle waves-effect waves-light" data-toggle="dropdown" href="#"><i class="fa fa-bell-o"></i>
                   <%if(notifications !=null){ 
                	   for(Notification newnotification : notifications){
                		   if(newnotification.isRead()){%> 
                   
                   			
                   <%		}else{%>
                	    	<div class="notify"><span class="heartbit"></span><span class="point"></span></div>
                   <%		}
                	   }
                   }
                   %>
                		</a>
                        <ul class="dropdown-menu dropdown-tasks animated slideInUp">
                        <%if(access_uid == 5){ 
                        		int count=1;
                        		if(notifications !=null){
                                    for(Notification notification : notifications){
                                    	if(notification.getFlatId() > 0 && !notification.isRead()){
                                    		BuilderFlat notificationBuilderFlat = new BuyerDAO().getFlatById(notification.getFlatId());
                        %>
                            <li>
                                <a href="javascript:isReadSaleshead('<%out.print(notification.getId());%>','<%out.print(notificationBuilderFlat.getBuilderFloor().getBuilderBuilding().getBuilderProject().getId());%>','<%out.print(notificationBuilderFlat.getBuilderFloor().getBuilderBuilding().getId());%>','<%out.print(notificationBuilderFlat.getBuilderFloor().getId());%>','<%out.print(notificationBuilderFlat.getId());%>');">
                                
                                    <div class="col-sm-6">
                                        <p> <span class="text-muted"><%out.print(notification.getDescription()); %></span> </p>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <%count++;}}}} %>
                            <%if(access_uid == 7){ 
                        		int count=1;
                        		if(notifications !=null){
                                    for(Notification notification : notifications){
                                    	if(notification.getType()==1){
                        %>
                            <li>
                                <a href="javascript:isReadSalesman(<%out.print(notification.getId());%>);">
                                   
                                        <div class="col-sm-12"> <strong>*</strong> <span class="text-muted"><%out.print(notification.getDescription()); %></span></div> 
                                    
                                </a>
                            </li>
                            
                            <%count++;}%>
                                 	
                                    <%}} }%>
                        </ul>
<!--                         /.dropdown-tasks -->
                    </li>
                   
                    <!-- /.dropdown -->
                    <li class="dropdown">
                        <a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#"> <img src="<%if(mainadmin.getPhoto()!=null){ %>${baseUrl}/<%out.print(mainadmin.getPhoto());}else{%>${baseUrl}/builder/plugins/images/users/1.jpg" <% }%>" alt="user-img" width="36" class="img-circle"><b class="hidden-xs"><%out.print(mainadmin.getName()); %></b> </a>
                        <ul class="dropdown-menu dropdown-user animated flipInY">
<!--                             <li><a href="javascript:void(0)"><i class="ti-user"></i>  My Profile</a></li> -->
<!--                             <li><a href="javascript:void(0)"><i class="ti-email"></i>  Inbox</a></li> -->
<!--                             <li><a href="javascript:void(0)"><i class="ti-settings"></i>  Account Setting</a></li> -->
							<%if(employeeRoles!=null){ 
								if(employeeRoles.size()>1){
								for(EmployeeRole employeeRole : employeeRoles){
							%>
							 <li><a href="javascript:switchRole(<%out.print(employeeRole.getBuilderEmployeeAccessType().getId());%>);"><i class="ti-settings"></i><%out.print("switch As "+employeeRole.getBuilderEmployeeAccessType().getName()); %></a></li>
							<%}}} %>
                            <li><a href="${baseUrl }/webapi/validatebuilder/logoutbuilder"><i class="fa fa-power-off"></i>Logout</a></li>
                        </ul>
                        <!-- /.dropdown-user -->
                    </li>
<!--                     <li class="right-side-toggle"> <a class="waves-effect waves-light" href="javascript:void(0)"><i class="ti-settings"></i></a></li> -->
                    <!-- /.dropdown -->
                </ul>
            </div>
            <!--  <script src="${baseUrl}/js/bootstrap.min.js"></script>-->
            <script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
           <script>
           function switchRole(id){
        	   $.post('${baseUrl}/webapi/validatebuilder/builder/switch',{access_id: id}, function(data){
        			var success = data.status;
        			var status =parseInt(success);
        			if(status==1) {
        				$("#perror").empty();
        				$('#error').empty();
        				window.location.href="${baseUrl }/builder/dashboard.jsp";	
        			} 
        		},'json');
           }
           
           function isReadSaleshead(id,projectId,buildingId,floorId,flatId){
        	   
        	   
        	   $.post('${baseUrl}/webapi/cancellation/notification/isread',{id:id}, function(data){
        		   var success = data.status;
        		   var status = parseInt(success);
        		   if(status == 1){
        			   <%
        			 //  int flatId = Integer.parseInt(out.print(""));
        			   //BuilderFlat builderFlat = new CancellationDAO().getFlatDetailId(flatId);%>
        			   window.location.href = "${baseUrl}/builder/saleshead/cancellation/Salesman_booking_new2.jsp?project_id="+projectId+"&building_id="+buildingId+"&floor_id="+floorId+"&flat_id="+flatId;
        		   }
        	   },'json');
           }
           function isReadSalesman(id){
        	   $.post('${baseUrl}/webapi/cancellation/notification/isread',{id:id}, function(data){
        		   var success = data.status;
        		   var status = parseInt(success);
        		   if(status==1)
        		  	 window.location.reload();
        	   },'json');
           }
           </script>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>