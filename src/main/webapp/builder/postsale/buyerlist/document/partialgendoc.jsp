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
	int buyer_id=0;
	List<BuyerUploadDocuments> buyerUploadDocuments = new ArrayList<BuyerUploadDocuments>();
	buyer_id = Integer.parseInt(request.getParameter("buyer_id"));
	buyerUploadDocuments = new BuyerDAO().getBuyerUploadDocumentsByBuyerId(buyer_id);
%>
<%
	if(buyerUploadDocuments != null){
	int a=buyerUploadDocuments.size();
		for(BuyerUploadDocuments buyerUploadDocuments2:buyerUploadDocuments){
			if(buyerUploadDocuments2.getDocType()==1){
%>
<ul >
	<li  class="col-lg-4 col-xs-12" style="list-style: none;">
		<a href="javascript:deleteGenDocument(<%out.print(buyerUploadDocuments2.getId());%>)"><img src="../../../images/error.png" alt="User" width="35px" style="margin-left:108px;"/></a>
		<br/>
		<img src="../../../images/docpdf.png" alt="User" width="150px"/>
		<br/><h5><% out.print(buyerUploadDocuments2.getName());%></h5>
	</li>
</ul>
<%
		}
	}
}
%>