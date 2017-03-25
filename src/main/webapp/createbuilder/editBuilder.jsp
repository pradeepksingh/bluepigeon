<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@include file="../head.jsp"%>
<%@include file="../leftnav.jsp"%>
<%
int id = Integer.parseInt(request.getParameter("id"));	
Builder builder=null;
List<BuilderCompanyNames> builderCompanyNames = null;
if(id>0){
List<Builder> builder_list=new BuilderDetailsDAO().getBuilderById(id);
if(builder_list.size()>0){
	builder=builder_list.get(0);	
	builderCompanyNames = new BuilderDetailsDAO().getBuilderCompanyNameList(id);
}
}
%>
		<div class="main-content">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
						</li>

						<li><a href="#">Forms</a></li>
						<li class="active">Update Builder</li>
					</ul>
					<!-- /.breadcrumb -->

				</div>
<input type="hidden" value="<% out.print(builder.getId()); %>" name="builder_id" id="ubuilder_id">
				<div class="page-content">
					<div class="page-header">
						<h1>Update Builder</h1>
					</div>
					<!-- /.page-header -->

					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Builder Name </label>

									<div class="col-sm-9">
										<input type="text" id="ubname" placeholder="Builder Name" value="<%out.print(builder.getName()); %>"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Status </label>

									<div class="col-sm-4">
										
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builder.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builder.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
									</div>
								</div>
								    	
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">Head Office</label>
									<div class="col-sm-4">
										<textarea id="uhoffice"
											class="autosize-transition form-control"><%out.print(builder.getHeadOffice()); %></textarea>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Phone Number </label>

									<div class="col-sm-9">
										<input type="text" id="uhphno" value="<%out.print(builder.getMobile()); %>"
											placeholder="Phone Numbers" class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1"> Email </label>

									<div class="col-sm-9">
										<input type="text" id="uhemail" placeholder="Email ids" value="<% out.print(builder.getEmail()); %>"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1" for="form-field-11">About Builder</label>
									<div class="col-sm-4">
										<textarea id="uabuilder" 
											class="autosize-transition form-control"><%out.print(builder.getAboutBuilder());%></textarea>
									</div>
								</div>
								<% if(builderCompanyNames.size()>0) {
										for(int i=0;i<builderCompanyNames.size();i++){
											BuilderCompanyNames builderCompanyNames1=builderCompanyNames.get(i);
								%>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Company Name </label>

									<div class="col-sm-9">
										<input type="text" id="ucname-<%out.print(i); %>" name="cname[]"
										value="<%out.print(builderCompanyNames1.getName()); %>"	placeholder="Company Name" class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Contact </label>

									<div class="col-sm-9">
										<input type="text" id="ucontact-<%out.print(i); %>" name="contact[]"
											value="<%out.print(builderCompanyNames1.getContact());
												  System.err.print(builderCompanyNames1.getContact());
												%>" placeholder="Contact number" class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right"
										for="form-field-1">Email </label>

									<div class="col-sm-9">
										<input type="text" id="ucemail-<%out.print(i); %>" name="email[]" placeholder="Email"
											value="<%out.print(builderCompanyNames1.getEmail()); %>"class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<% i++;}} %>
								<div id="addCompanyName"></div>

								<div class="clearfix form-actions">

									<div class="col-md-offset-3 col-md-9">
										 <input type="button" id="addBuilder" value="Add Company" onclick="javascript:addBuilderCompanyName()"
											class="btn btn-info ">
											
										&nbsp; &nbsp; &nbsp;
										<button id="updateBuilder" class="btn btn-info" type="button">
											<i class="ace-icon fa fa-check bigger-110"></i> Update
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
			
				
			function ValidateEmail(email) {
		        var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		        return expr.test(email);
		    };
			$("#addBuilder").click(function(){
				//alert("Hi");
			})
		    var batch_count =1;
		    function addBuilderCompanyName()
			{
		    //	alert("Hello...");
		    	batch_count++;
		    //	alert("Count :"+batch_count);
		    	var batch='<div class="form-group">';
		    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Company Name </label>';
		    	batch+='<div class="col-sm-9">';
		    	batch+='<input type="text" id="ucname-'+batch_count+'" name="cname[]" placeholder="Company Name" class="col-xs-10 col-sm-5" />';
		    	batch+='</div>';
		    	batch+='</div>';
		    	batch+='<div class="form-group">';
		    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Contact </label>';
		    	batch+='<div class="col-sm-9">';
		    	batch+='<input type="text" id="ucontact-'+batch_count+'" name="contact[]" placeholder="Contact number" class="col-xs-10 col-sm-5" />';
		    	batch+='</div>';
		    	batch+='</div>';
		    	batch+='<div class="form-group">';
		    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>';
		    	batch+='<div class="col-sm-9">';
		    	batch+='<input type="text" id="ucemail-'+batch_count+'" name="cemail[]" placeholder="Email" class="col-xs-10 col-sm-5" />';
		    	batch+='</div></div>';
		    	
		    	$("#addCompanyName").append(batch);
		    	
		    	}	
		    
		   
		    $("#updateBuilder").click(function(){
		    	updateNewBuilder();
		    })
		    function updateNewBuilder(){
		    	
		    	company_names=getCompanyNames();
		    	
		        var builder_data=getBuilderData();
		    	
		    	var final_data=[];
		    	final_data={builderCompanyNames:company_names,builder:builder_data};
		    
		    	$.ajax({
				    url: '${baseUrl}/webapi/create/builder/new/update/',
				    type: 'POST',
				    data: JSON.stringify(final_data),
				    contentType: 'application/json; charset=utf-8',
				    dataType: 'json',
				    async: false,
				    success: function(data) {
						if (data.status == 0) {
							alert(data.message);
							
						} else {
							alert(data.message);
							
							 window.location.href ="${baseUrl}/createbuilder/addbuilder.jsp";
						}
					},
					error : function(data)
					{
						alert("Fail to save data"+JSON.stringify(data,null,2));
					}
					
				});
		    
		    
		    }
		    
		    function getBuilderData(){
		    
		    	if($("#ubuilder_id").val()>0){
		    		var  builder_info = {id:$("#ubuilder_id").val(),name:$("#ubname").val(),status:$("#ustatus").val(),headOffice:$("#uhoffice").val(),email:$("#uhemail").val(),mobile:$("#uhphno").val(),aboutBuilder:$("#uabuilder").val()}
		    	}else{
		    		var  builder_info = {name:$("#ubname").val(),status:$("#ustatus").val(),headOffice:$("#uhoffice").val(),email:$("#uhemail").val(),mobile:$("#uhphno").val(),aboutBuilder:$("#uabuilder").val()}
		    	}
		    	return builder_info;
		    	
		    }
		    
		    function getCompanyNames(){
		    	var contact_company=[];
		    	var company;
		  for(var i=1;i<=batch_count;i++){
			  var cname="#cname-"+i;
			  var ccontact="#contact-"+i;
			  var cemail ="#email-"+i;
			  if($("#ucname-"+i).val()!="" || typeof $("#ucname-"+i).val()!="undefined"){
				  cname=$("#ucname-"+i).val();
			  }
			   if($("#ucontact-"+i).val()!="" || typeof $("#ucontact-"+i).val()!="undefined"){
				  
				  ccontact=$("#ucontact-"+i).val();
				
			  }
			   if($("#ucemail-"+i).val()!="" || typeof $("#ucemail-"+i).val()!="undefined"){
				  cemail=$("#ucemail-"+i).val();
			  }
			company ={name : cname, contact:ccontact,email:cemail}
			  contact_company.push(company);  
		  }
		
		  return contact_company;
		    	
		    }
		    
		    </script>
</body>
</html>
