<%@page import="org.bluepigeon.admin.dao.BuilderProjectPaymentInfoDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPaymentInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int project_id = 0;
List<BuilderProjectPaymentInfo> projectPaymentInfos = null;
if (request.getParameterMap().containsKey("project_id")) {
	
project_id = Integer.parseInt(request.getParameter("project_id"));
projectPaymentInfos = new BuilderProjectPaymentInfoDAO().getBuilderProjectPaymentInfo(project_id);
}
%>
    
    	<% 	int i = 1;
											int sum = 0;
											if(projectPaymentInfos != null){
  												for(BuilderProjectPaymentInfo projectPaymentInfo :projectPaymentInfos) {  
 											%> 
 											<input type="hidden" id="schedule_id" name="schedule_id[]" value="<%out.print(projectPaymentInfo.getId());%>"/>
 											<% if(projectPaymentInfo.getPayable() != null){sum += projectPaymentInfo.getPayable();}  %>
											<div class="row" id="schedule-<% out.print(i); %>">
												<% if(i > 1) { %>
												<hr/>
												<% } %>
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="schedule" name="schedule[]" value="<% if(projectPaymentInfo.getSchedule() != null) { out.print(projectPaymentInfo.getSchedule());}%>"/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable <span class='text-danger'>*</span></label>
														<div class="col-sm-4">
															<input type="text" class="form-control" onblur="javascript:vaildPayablePer(<%out.print(i); %>)" onkeypress=" return isNumber(event, this);" id="payable<%out.print(i); %>" name="payable[]" value="<% if(projectPaymentInfo.getPayable() != null) { out.print(projectPaymentInfo.getPayable());}%>"/>
														</div>
														<div class="epayable<%out.print(i);%>"></div>
													</div>
												</div>
												<!-- div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-amount">
														<label class="control-label col-sm-6">Amount <span class='text-danger'>*</span></label>
														<div class="col-sm-6">
															<input type="text" class="form-control" onkeypress=" return isNumber(event, this);" id="amount" name="amount[]" value="<% if(projectPaymentInfo.getAmount() != null) { out.print(projectPaymentInfo.getAmount());}%>"/>
														</div>
														<div class="messageContainer"></div>
													</div>
												</div-->
												<div class="col-lg-1">
													<span><a href="javascript:deleteSchudle(<% out.print(projectPaymentInfo.getId()); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% i++; } %>
											<input type="hidden" value="<%out.print(sum);%>" id="hsum" name="hsum" />
 											<% if(i <= 1) { %>
											<input type="hidden" id="schedule_id" name="schedule_id[]" value="0"/>
											<div class="row" id="schedule-0">
												<div class="col-lg-5 margin-bottom-5">
													<div class="form-group" id="error-schedule">
														<label class="control-label col-sm-4">Milestone <span class='text-danger'>*</span></label>
														<div class="col-sm-8">
															<div>
																<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
															</div>
															<div class="messageContainer"></div>
														</div>
													</div>
												</div>
												<div class="col-lg-3 margin-bottom-5">
													<div class="form-group" id="error-payable">
														<label class="control-label col-sm-8">% of Net Payable <span class='text-danger'>*</span></label>
														<div class="col-sm-4">
															<input type="text" class="form-control"  onkeypress=" return isNumber(event, this);" id="payable<% out.print(i);%>" name="payable[]" value=""/>
														</div>
														<div id="epayable<%out.print(i);%>"></div>
													</div>
												</div>
												<div class="col-lg-1">
													<span><a href="javascript:removeSchedule(<% out.print(i); %>);" class="btn btn-danger btn-xs">x</a></span>
												</div>
											</div>
											<% }} %>