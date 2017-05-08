<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.model.BuilderCompanyNames"%>
<%@include file="../../head.jsp"%>
<%@include file="../../leftnav.jsp"%>
<%
int id = Integer.parseInt(request.getParameter("id"));	
Builder builder=null;
//List<BuilderCompanyNames> builderCompanyNames = null;
if(id>0){
List<Builder> builder_list=new BuilderDetailsDAO().getBuilderById(id);
if(builder_list.size()>0){
	builder=builder_list.get(0);	
	//builderCompanyNames = new BuilderDetailsDAO().getAllBuilderCompanyNameByBuilderId(id);
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
		
		<div class="page-content">
			<div class="page-header">
				<h1>Update Builder</h1>
			</div>
			<!-- /.page-header -->
			<div class="row">
				<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
					<form class="form-horizontal" role="form" method="post" action="" id="updateBuilder" name="updateBuilder" enctype="multipart/form-data">
						<input type="hidden" value="<% out.print(builder.getId()); %>" name="ubuilder_id" id="ubuilder_id">
						<input type="hidden" value="<%out.print(builder.getLoginStatus()); %> name="uloginstatus" id="uloginstatus"/>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Builder Name </label>
							<div class="col-sm-9">
								<input type="text" name="ubname" id="ubname" placeholder="Builder Name" value="<%out.print(builder.getName()); %>" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Status </label>
							<div class="col-sm-4">
								<select name="ustatus" id="ustatus" class="form-control">
									<option value="1" <% if(builder.getStatus() == 1) { %>selected<% } %>> Active </option>
									<option value="0" <% if(builder.getStatus() == 0) { %>selected<% } %>> Inactive </option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1" for="form-field-11">Head Office</label>
							<div class="col-sm-4">
								<textarea id="uhoffice" name="uhoffice" class="autosize-transition form-control"><%out.print(builder.getHeadOffice()); %></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Phone Number </label>
							<div class="col-sm-9">
								<input type="text" id="uhphno" name="uhphno" value="<%out.print(builder.getMobile()); %>" placeholder="Phone Numbers" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"	for="form-field-1"> Email </label>
							<div class="col-sm-9">
								<input type="text" id="uhemail" name="uhemail" placeholder="Email ids" value="<% out.print(builder.getEmail()); %>" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Password </label>
							<div class="col-sm-9">
								<input type="password" id="password" name="password" value="<%out.print(builder.getPassword()); %>" placeholder="password"
									class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"	for="form-field-1" for="form-field-11">About Builder</label>
							<div class="col-sm-4">
								<textarea id="uabuilder" name="uabuilder" class="autosize-transition form-control"><%out.print(builder.getAboutBuilder());%></textarea>
							</div>
						</div>
						<% if(builder.getBuilderCompanyNameses().size()>0) {
							int i=1;
							Set<BuilderCompanyNames> builderCompanyNames = builder.getBuilderCompanyNameses();
							  Iterator<BuilderCompanyNames> bIterator = builderCompanyNames.iterator();
							  while(bIterator.hasNext()){
								BuilderCompanyNames builderCompanyNames1=bIterator.next();
						%>
						<hr>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Company Name </label>
							<div class="col-sm-9">
								<input type="text" id="uname-<%out.print(i); %>" name="uname[]" value="<%out.print(builderCompanyNames1.getName()); %>"	placeholder="Company Name" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Contact </label>
							<div class="col-sm-9">
								<input type="text" id="ucontact-<%out.print(i); %>" name="ucontact[]" value="<%out.print(builderCompanyNames1.getContact());%>" placeholder="Contact number" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"	for="form-field-1">Email </label>
							<div class="col-sm-9">
								<input type="text" id="uemail-<%out.print(i); %>" name="uemail[]" placeholder="Email" value="<%out.print(builderCompanyNames1.getEmail()); %>"class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<% i++;}} %>
						<div id="addCompanyName"></div>
						<div class="clearfix form-actions">
							<div class="col-md-offset-3 col-md-9">
								 <input type="button" id="addBuilder" value="Add Company" onclick="javascript:addBuilderCompanyName()" class="btn btn-info ">
									&nbsp; &nbsp; &nbsp;
								<button type="submit" name="updatebtn" class="btn btn-info">
									<i class="ace-icon fa fa-check bigger-110"></i> Update
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
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>
<script src="${baseUrl}/js/jquery.form.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
var batch_count =1;
function addBuilderCompanyName(){
  	batch_count++;
  	var batch='<div class="form-group">';
  	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Company Name </label>';
  	batch+='<div class="col-sm-9">';
  	batch+='<input type="text" id="uname-'+batch_count+'" name="uname[]" placeholder="Company Name" class="col-xs-10 col-sm-5" />';
  	batch+='</div>';
  	batch+='</div>';
  	batch+='<div class="form-group">';
  	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Contact </label>';
  	batch+='<div class="col-sm-9">';
  	batch+='<input type="text" id="ucontact-'+batch_count+'" name="ucontact[]" placeholder="Contact number" class="col-xs-10 col-sm-5" />';
  	batch+='</div>';
  	batch+='</div>';
  	batch+='<div class="form-group">';
  	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>';
  	batch+='<div class="col-sm-9">';
  	batch+='<input type="text" id="uemail-'+batch_count+'" name="uemail[]" placeholder="Email" class="col-xs-10 col-sm-5" />';
  	batch+='</div></div>';
  	$("#addCompanyName").append(batch);
}	
// $("#updateBuilder").click(function(){
// 	updateNewBuilder();
// })
// function updateNewBuilder(){
// 	company_names=getCompanyNames();
// 	var builder_data=getBuilderData();
// 	var final_data=[];
// 	final_data={builderCompanyNames:company_names,builder:builder_data};
// 	$.ajax({
//    		url: '${baseUrl}/webapi/create/builder/new/update/',
//     	type: 'POST',
//     	data: JSON.stringify(final_data),
//     	contentType: 'application/json; charset=utf-8',
//     	dataType: 'json',
//    		async: false,
//     	success: function(data) {
// 			if (data.status == 0) {
// 				alert(data.message);
// 			} else {
// 				alert(data.message);
// 			 	window.location.href ="${baseUrl}/createbuilder/addbuilder.jsp";
// 			}
// 		},
// 		error : function(data){
// 			alert("Fail to save data"+JSON.stringify(data,null,2));
// 		}
// 	});
// }
// function getBuilderData(){
// 	if($("#ubuilder_id").val()>0){
// 		var  builder_info = {id:$("#ubuilder_id").val(),name:$("#ubname").val(),status:$("#ustatus").val(),headOffice:$("#uhoffice").val(),email:$("#uhemail").val(),mobile:$("#uhphno").val(),aboutBuilder:$("#uabuilder").val()}
// 	}else{
// 		var  builder_info = {name:$("#ubname").val(),status:$("#ustatus").val(),headOffice:$("#uhoffice").val(),email:$("#uhemail").val(),mobile:$("#uhphno").val(),aboutBuilder:$("#uabuilder").val()}
// 	}
//    	return builder_info;
// }
// function getCompanyNames(){
//    	var contact_company=[];
//    	var company;
// 	for(var i=1;i<=batch_count;i++){
//   		var cname="#uname-"+i;
//   		var ccontact="#ucontact-"+i;
//   		var cemail ="#uemail-"+i;
//   		if($("#uname-"+i).val()!="" || (typeof $("#uname-"+i).val()!="undefined")){
// 	  		cname=$("#uname-"+i).val();
// 	  		alert(cname);
//   		}
//    		if($("#ucontact-"+i).val()!="" || (typeof $("#ucontact-"+i).val()!="undefined")){
// 		  ccontact=$("#ucontact-"+i).val();
// 		  alert($("#ucontact-"+i).val());
// 	    }
//    		if($("#uemail-"+i).val()!="" || (typeof $("#uemail-"+i).val()!="undefined")){
// 	  		cemail=$("#uemail-"+i).val();
// 	  		alert($("#uemail-"+i).val());
//   		}
// 		company ={name : cname, contact:ccontact,email:cemail}
//   		contact_company.push(company);  
//  	}
// 	return contact_company;
// }

$('#updateBuilder').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	ubname: {
            validators: {
                notEmpty: {
                    message: 'Builder Name is required and cannot be empty'
                }
            }
        },
        ustatus: {
            validators: {
                notEmpty: {
                    message: 'Status  is required and cannot be empty'
                }
            }
        },
        uhoffice: {
            validators: {
                notEmpty: {
                    message: 'Head Office is required and cannot be empty'
                }
            }
        },
        uhphno: {
            validators: {
                notEmpty: {
                    message: 'Phone Number is required and cannot be empty'
                }
            }
        },
        uhemail: {
            validators: {
                notEmpty: {
                    message: 'Email is required and cannot be empty'
                }
            }
        },
        password: {
            validators: {
                notEmpty: {
                    message: 'password is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateBuilder();
});

function updateBuilder() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/create/builder/new/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updateBuilder').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/project-settings/addbuilder.jsp";
  	}
}

</script>
</body>
</html>
