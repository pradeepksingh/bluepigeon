<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<div class="main-content">
	<div class="main-content-inner">
		<div class="breadcrumbs ace-save-state" id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Home</a>
				</li>

				<li><a href="#">Forms</a></li>
				<li class="active">New Builder</li>
			</ul>
			<!-- /.breadcrumb -->

		</div>
		<input type="hidden" value="" name="builder_id" id="builder_id">
		<div class="page-content">
			<div class="page-header">
				<h1>New Builder</h1>
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
								<input type="text" id="bname" placeholder="Builder Name"
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
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1" for="form-field-11">Head Office</label>
							<div class="col-sm-4">
								<textarea id="hoffice"
									class="autosize-transition form-control"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Phone Number </label>
							<div class="col-sm-9">
								<input type="text" id="hphno"
									placeholder="Phone Numbers" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Email </label>
							<div class="col-sm-9">
								<input type="text" id="hemail" placeholder="Email ids"
									class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Password </label>
							<div class="col-sm-9">
								<input type="password" id="password" name="password" placeholder="password"
									class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1" for="form-field-11">About Builder</label>
							<div class="col-sm-4">
								<textarea id="abuilder"
									class="autosize-transition form-control"></textarea>
							</div>
						</div>
						<hr>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1">Company Name </label>
							<div class="col-sm-9">
								<input type="text" id="cname-1" name="cname[]"
									placeholder="Company Name" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1">Contact </label>
							<div class="col-sm-9">
								<input type="text" id="contact-1" name="contact[]"
									placeholder="Contact number" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1">Email </label>
							<div class="col-sm-9">
								<input type="text" id="cemail-1" name="email[]" placeholder="Email"
									class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div id="addCompanyName"></div>
						<div class="clearfix form-actions">
							<div class="col-md-offset-3 col-md-9">
								 <input type="button" id="addBuilder" value="Add Company" onclick="javascript:addBuilderCompanyName()"
									class="btn btn-info ">
								&nbsp; &nbsp; &nbsp;
								<button id="saveBuilder" class="btn btn-info" type="button">
									<i class="ace-icon fa fa-check bigger-110"></i> Submit
								</button>
								&nbsp; &nbsp; &nbsp;
								<button class="btn" type="reset">
									<i class="ace-icon fa fa-undo bigger-110"></i> Reset
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../../footer.jsp"%>
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
    	var batch='<hr><div class="form-group">';
    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Company Name </label>';
    	batch+='<div class="col-sm-9">';
    	batch+='<input type="text" id="cname-'+batch_count+'" name="cname[]" placeholder="Company Name" class="col-xs-10 col-sm-5" />';
    	batch+='</div>';
    	batch+='</div>';
    	batch+='<div class="form-group">';
    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Contact </label>';
    	batch+='<div class="col-sm-9">';
    	batch+='<input type="text" id="contact-'+batch_count+'" name="contact[]" placeholder="Contact number" class="col-xs-10 col-sm-5" />';
    	batch+='</div>';
    	batch+='</div>';
    	batch+='<div class="form-group">';
    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>';
    	batch+='<div class="col-sm-9">';
    	batch+='<input type="text" id="cemail-'+batch_count+'" name="cemail[]" placeholder="Email" class="col-xs-10 col-sm-5" />';
    	batch+='</div></div>';
    	
    	$("#addCompanyName").append(batch);
    	
    	}	
    $("#saveBuilder").click(function(){
    	saveNewBuilder();
    })
    function saveNewBuilder(){
    	if($("#password").val() == $("#cpassword").val()){
    	company_names=getCompanyNames();
        var builder_data=getBuilderData();
    	var final_data=[];
    	final_data={builderCompanyNames:company_names,builder:builder_data};
    	$.ajax({
		    url: '${baseUrl}/webapi/create/builder/new/save/',
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
					 clearAllFields();
					 window.location.href ="${baseUrl}/admin/project-settings/addbuilder.jsp";
				}
			},
			error : function(data)
			{
				alert("Fail to save data"+JSON.stringify(data,null,2));
			}
			
		});
      }
    	else{
    		alert("Password does not match with confirm password");
    	}
    }
    
    function getBuilderData(){
    	if($("#builder_id").val()>0){
    		var  builder_info = {id:$("#builder_id").val(),name:$("#bname").val(),status:$("#status").val(),headOffice:$("#hoffice").val(),email:$("#hemail").val(),password:$("#password").val(),loginStatus:0,mobile:$("#hphno").val(),aboutBuilder:$("#abuilder").val()}
    	}else{
    		var  builder_info = {name:$("#bname").val(),status:$("#status").val(),headOffice:$("#hoffice").val(),email:$("#hemail").val(),mobile:$("#hphno").val(),password:$("#password").val(),loginStatus:0,aboutBuilder:$("#abuilder").val()}
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
	  if($("#cname-"+i).val()!="" || typeof $("#cname-"+i).val()!="undefined"){
		  cname=$("#cname-"+i).val();
	  }
	   if($("#contact-"+i).val()!="" || typeof $("#contact-"+i).val()!="undefined"){
		  
		  ccontact=$("#contact-"+i).val();
		
	  }
	   if($("#cemail-"+i).val()!="" || typeof $("#cemail-"+i).val()!="undefined"){
		  cemail=$("#cemail-"+i).val();
	  }
	company ={name : cname, contact:ccontact,email:cemail}
	  contact_company.push(company);  
  }
  return contact_company;
}
    
    function clearAllFields(){
    	 for(var i=1;i<=batch_count;i++){
    		 $("#cname-"+i).val("");
    		 $("#contact-"+i).val("");
    		 $("#cemail-"+i).val("");
    	 }
    	 $("#bname").val("");
    	 $("#hoffice").val("");
    	 $("#hemail").val("");
    	 $("#hphno").val("");
    	 $("#abuilder").val("");
    	 $("#password").val("");
    	 $("cpassord").val("");
    }
    </script>
</body>
</html>