<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.AdminUser"%>
<%
	session = request.getSession(false);
	AdminUser mainadmin = new AdminUser();
	int session_uid = 0;
	if(session!=null)
	{
		if(session.getAttribute("uname") != null)
		{
			mainadmin  = (AdminUser)session.getAttribute("uname");
			session_uid = mainadmin.getId();
		}
   	}
	if(session_uid <= 0) {
		String url = request.getRequestURL().toString();
		String site = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
	   	response.setStatus(response.SC_MOVED_TEMPORARILY);
	   	response.setHeader("Location", site);
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>Blue Pigeon Admin</title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="${baseUrl}/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${baseUrl}/font-awesome/4.5.0/css/font-awesome.min.css" />

		<!-- page specific plugin styles -->
		<link rel="stylesheet" href="${baseUrl}/css/jquery-ui.min.css" />
		<link rel="stylesheet" href="${baseUrl}/css/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="${baseUrl}/css/ui.jqgrid.min.css" />
		<link rel="stylesheet" href="${baseUrl}/css/dataTables.bootstrap.css" />
		<!-- text fonts -->
		<link rel="stylesheet" href="${baseUrl}/css/fonts.googleapis.com.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="${baseUrl}/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />

		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${baseUrl}/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->
		<link rel="stylesheet" href="${baseUrl}/css/ace-skins.min.css" />
		<link rel="stylesheet" href="${baseUrl}/css/ace-rtl.min.css" />

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${baseUrl}/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->
		<script src="${baseUrl}/js/ace-extra.min.js"></script>

		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

		<!--[if lte IE 8]>
		<script src="${baseUrl}/js/html5shiv.min.js"></script>
		<script src="${baseUrl}/js/respond.min.js"></script>
		<![endif]-->
	</head>