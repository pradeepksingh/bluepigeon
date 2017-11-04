<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.bluepigeon.admin.data.InboxBuyerData"%>
<%@page import="java.util.Date"%>
<%@page import="org.bluepigeon.admin.data.InboxMessageData"%>
<%@page import="org.bluepigeon.admin.model.BuyerUploadDocuments"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.bluepigeon.admin.model.Buyer"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDAO"%>
<%@page import="org.bluepigeon.admin.data.ProjectData"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	int buyerId=0;
	List<InboxMessageData> inboxMessageList = null;
	buyerId = Integer.parseInt(request.getParameter("buyer_id"));
	inboxMessageList = new ProjectDAO().getBookedBuyer(buyerId);
	SimpleDateFormat dt1 = new SimpleDateFormat("dd MMM yyyy");
	SimpleDateFormat dt2 = new SimpleDateFormat("h:m a");
	if(inboxMessageList != null){
		for(InboxMessageData inboxMessageList1:inboxMessageList){
%>
<ul class="col-lg-12" style="box-shadow: 0 2px 5px rgba(0, 0, 0, 0.16), 0 2px 10px rgba(0, 0, 0, 0.12);">
 	<a href="javascript:getInboxMsg(<%out.print(inboxMessageList1.getId());%>);">
		<li class="col-lg-2 col-xs-12" style="list-style: none;">
		<%if(inboxMessageList1.getImage()!=null && inboxMessageList1.getImage() !="") {%>
		<img src="${baseUrl}/<%out.print(inboxMessageList1.getImage());%>" alt="User" style="border-radius: 50%;margin-top: 20px;" width="68px" height="48px">
		<%}else{ %>
		<img src="../../../images/user.png" alt="User" style="border-radius: 50%;margin-top: 20px;" width="58px" height="38px">
		<%} %>
		</li>
		<li class="col-lg-8 col-xs-12" style="list-style: none;text-align: left;">
			<p><b><%out.print(inboxMessageList1.getName()); %></b></p>
			<p style="font-size: 13px;"><% if(inboxMessageList1.getDate() != null) { out.print(dt1.format(inboxMessageList1.getDate()));} %><span style="margin-left:10px"><% if(inboxMessageList1.getDate() != null) { out.print(dt2.format(inboxMessageList1.getDate()));} %></span></p>
			<p><%out.print(inboxMessageList1.getSubject()); %></p>
		</li>
		<li class="col-lg-2 col-xs-12" style="list-style: none;">
			<img src="../../../images/status-green.png" alt="User" style="margin-top: 20px;" width="58px" height="38px">
		</li>
	</a>
</ul>
<%}} %>