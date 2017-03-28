<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.dao.ProjectLeadDAO"%>
<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectApprovalTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectApprovalType"%>
<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectAmenitySubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectAmenitySubstages"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectPropertyConfigurationDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectPropertyConfiguration"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPropertyTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPropertyType"%>
<%@page import="org.bluepigeon.admin.dao.CityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.StateImp"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.model.State"%>
<%@page import="org.bluepigeon.admin.model.City"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.dao.BuilderProjectTypeDAO"%>
<%@page import="org.bluepigeon.admin.controller.GeneralController"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="org.bluepigeon.admin.model.BuilderProjectType"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
  int builder_id=0;
int company_id = 0;
int company_size=0;
int admin_size =0;
int project_size=0;
 List<BuilderCompanyNames> builderCompanyNames = null;
  List<Builder> builders = new BuilderDetailsDAO().getBuilderList();
  if(builders.size()>0){
	  builder_id = builders.get(0).getId();
	  builderCompanyNames = new BuilderDetailsDAO().getBuilderCompanyNameList(builder_id);
	  company_size= builderCompanyNames.size();
	  company_id = builderCompanyNames.get(0).getId();
  }
  
  List<Locality> locality_list = null;
  
 List<AdminUser> adminUsers = new ProjectLeadDAO().getAmdinUser();
 if(adminUsers.size()>0)
 admin_size= adminUsers.size();
 
 List<BuilderProject> builderProjects=new ProjectLeadDAO().getProjectList();
    if(builderProjects.size()>0)
    	project_size = builderProjects.size();
 int city_size=0;
  List<City> city_list = null;

    city_list = new CityNamesImp().getCityNames();
    if(city_list.size()>0)
    city_size=city_list.size();
    
  
     session = request.getSession(false);
	 AdminUser adminuser6 = new AdminUser();
 	int user_id6=0;
 	if(session!=null)
 	{
 		if(session.getAttribute("uname") != null)
 		{
 			adminuser6  = (AdminUser)session.getAttribute("uname");
   				System.out.println();
   				System.out.println("user id : "+adminuser6.getId());
   				user_id6 =adminuser6.getId();
   				System.out.println();
 		}
    }
 // }
%>
			<div class="main-content">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
						</li>

						<li><a href="#">Project Lead</a></li>
						<li class="active">Add New Lead</li>
					</ul>
					<!-- /.breadcrumb -->

				</div>
					<input type="hidden" value="" name="lead_id" id="lead_id">
				<div class="page-content">
					<div class="page-header">
						<h1>Add New Lead</h1>
					</div>
					<!-- /.page-header -->

					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<form class="form-horizontal" role="form">
							<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Lead Name </label>

									<div class="col-sm-9">
										<input type="text" id="name" placeholder="enter lead name"
											class="col-xs-10 col-sm-5" />
									</div>
									
							</div>
								
							<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Phone </label>

									<div class="col-sm-9">
										<input type="text" id="mobile" placeholder="enter lead phone number"
											class="col-xs-10 col-sm-5" />
									</div>
									
							</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Email </label>

									<div class="col-sm-9">
										<input type="text" id="email" placeholder="enter lead email"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Area </label>

									<div class="col-sm-9">
										<input type="text" id="area" placeholder="enter lead area"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">City </label>
										<div class="col-sm-4">
											 <select name="searchcityId" id="searchcityId" class="form-control">
								                    <option value="0">Select City</option>
								                    <% for(int i=0; i < city_size ; i++){ %>
													<option value="<% out.print(city_list.get(i).getId());%>" ><% out.print(city_list.get(i).getName());%></option>
													<% } %>
								              </select>
										</div>
								</div>
						
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Select Source </label>

									<div class="col-sm-4">
								 <select name="sourceId" id="sourceId" class="form-control">
							                    <option value="0">Select Source</option>
							                    <% for(int i=0; i < admin_size ; i++){ %>
												<option value="<% out.print(adminUsers.get(i).getId());%>"><% out.print(adminUsers.get(i).getName());%></option>
												<% } %>
							                </select>
									</div>
								</div>
						
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Select Project </label>

									<div class="col-sm-4">
										<select name="searchprojectId" id="searchprojectId" class="form-control">
							                 	   <option value="0">Select Project</option>
							                  	   <% for(int i=0; i < project_size ; i++){ %>
														<option value="<% out.print(builderProjects.get(i).getId());%>"><% out.print(builderProjects.get(i).getName());%></option>
												  <%
												  	}
							                  	  %>
							       	  </select>
									</div>
							  </div>
							  <div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Select Building </label>

									<div class="col-sm-4">
										<select name="searchbuildingId" id="searchbuildingId" class="form-control">
							                 	   <option value="0">Select Building</option>
							                 	   <% for(int i=0; i < project_size ; i++){ %>
														<option value="<% out.print(builderProjects.get(i).getId());%>"><% out.print(builderProjects.get(i).getName());%></option>
												  <%
												  	}
							                  	  %>
							       	  </select>
									</div>
							  </div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Latitude </label>

									<div class="col-sm-9">
										<input type="text" id="latitude" placeholder="enter latitude"
											class="col-xs-10 col-sm-5" />
									</div>
									
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Longitude </label>

									<div class="col-sm-9">
										<input type="text" id="longitude" placeholder="enter longitude "
											class="col-xs-10 col-sm-5" />
									</div>
									
								</div>
								
								
								
							
									<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Status </label>

									<div class="col-sm-4">
										
                       		<select name="status" id="status" class="form-control">
								<option value="1"> Active </option>
								<option value="0"> Inactive </option>
							</select>
									</div>
								</div>
								<div class="clearfix form-actions">

									<div class="col-md-offset-3 col-md-9">
										
										<button id="saveProject" class="btn btn-info" type="button">
											<i class="ace-icon fa fa-check bigger-110"></i> Submit
										</button>

										&nbsp; &nbsp; &nbsp;
										<button class="btn" type="reset">
											<i class="ace-icon fa fa-undo bigger-110"></i> Reset
										</button>
									</div>
								</div>

							</form>
							

						<%@include file="../footer.jsp"%>
						<!-- inline scripts related to this page -->
						

						<script type="text/javascript">
			
						$("#searchprojectId").change(function(){
							$.get("${baseUrl}/webapi/create/building/list/",{ project_id: $("#searchprojectId").val() }, function(data){
								var html = '<option value="">Select Building</option>';
								$(data).each(function(index){
									
									html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
								});
								$("#searchbuildingid").html(html);
							},'json');
						});
						
				
			function ValidateEmail(email) {
		        var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		        return expr.test(email);
		    };
		    $("#searchcountryId").change(function(){
		        $.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#searchcountryId").val() }, function(data){
		            var html = '<option value="">Select State</option>';
		            $(data).each(function(index){
		                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		            });
		            $("#searchstateId").html(html);
		        },'json');
		    });

		    $("#searchstateId").change(function(){
		        $.get("${baseUrl}/webapi/general/city/list",{ state_id: $("#searchstateId").val() }, function(data){
		            var html = '<option value="">Select City</option>';
		            $(data).each(function(index){
		                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		            });
		            $("#searchcityId").html(html);
		        },'json');
		    	
		    });

		    $("#searchcityId").change(function(){
		    	
		    	 $.get("${baseUrl}/webapi/general/locality/list",{ city_id: $("#searchcityId").val() }, function(data){
		    	
			            var html = '<option value="">Select Locality</option>';
			            $(data).each(function(index){
			            	
			                html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
			            });
			            $("#searchlocalityId").html(html);
			        },'json');
		    });
		    
		   
		    </script>


