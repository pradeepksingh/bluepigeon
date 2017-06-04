<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%
session = request.getSession(false);
	BuilderEmployee mainadmin = new BuilderEmployee();
	int session_uid = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			mainadmin  = (BuilderEmployee)session.getAttribute("ubname");
			session_uid = mainadmin.getId();
		}
   	}
	if(session_uid <= 0) {
		String url = request.getRequestURL().toString();
		String site = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
	   	response.setStatus(response.SC_MOVED_TEMPORARILY);
	   	response.setHeader("Location1", site);
	}
%>
<link rel="stylesheet" href="css/custom1.css" />
 <script src="bootstrap/dist/js/tether.min.js"></script>
    <script src="bootstrap/dist/js/bootstrap.min.js"></script>
       <script src="plugins/bower_components/bootstrap-extension/js/bootstrap-extension.min.js"></script>
    <!-- Menu Plugin JavaScript -->
    <script src="plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js"></script>
    <!--slimscroll JavaScript -->
    <script src="js/jquery.slimscroll.js"></script>
    <!--Wave Effects -->
    <script src="js/waves.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="js/custom.min.js"></script>
    <!--Morris JavaScript -->
   <script src="plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
    <!-- Footable -->
    <script src="plugins/bower_components/footable/js/footable.all.min.js"></script>
    <script src="plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
    <!--FooTable init-->
    <script src="js/footable-init.js"></script>
    <!--Style Switcher -->
    <script src="plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script>



<nav class="navbar navbar-default navbar-static-top m-b-0">
            <div class="navbar-header">
                
                <div class="top-left-part"><a class="logo" href="index.jsp"><b><img src="${baseUrl}/builder/plugins/images/bpadmin-logo.png" alt="logo" /></b><span class="hidden-xs"></span></a></div>
                <ul class="nav navbar-top-links navbar-right pull-right">
                   <li><a href="${baseUrl }/webapi/validatebuilder/logoutbuilder"><b class="hidden-xs">logout</b></a></li>
                   <li></li>
                </ul>
                
            </div>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>