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
				<li><i class="ace-icon fa fa-home home-icon"></i>Home
				</li>

				<li>Project Settings</li>
				<li class="active">New Builder</li>
			</ul>
			<!-- /.breadcrumb -->

		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>New Builder</h1>
			</div>
			<!-- /.page-header -->
			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->
					<form class="form-horizontal" role="form" method="post" action="" id="addBuilder" name="addBuilder" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1">Builder Name </label>
							<div class="col-sm-9">
								<input type="text" id="bname" name="bname" placeholder="Builder Name"
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
								<textarea id="hoffice" name="hoffice"
									class="autosize-transition form-control"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Phone Number </label>
							<div class="col-sm-9">
								<input type="text" id="hphno" name="hphno"
									placeholder="Phone Numbers" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1"> Email </label>
							<div class="col-sm-9">
								<input type="text"  id="hemail" name="hemail" placeholder="Email ids"
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
								<textarea id="abuilder" name="abuilder"
									class="autosize-transition form-control"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1" for="form-field-11">Builder Logo</label>
							<div class="col-sm-4">
								<input type="file" class="form-control" id="builder_logo" name="builder_logo[]" />
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
								<input type="text" id="ccontact-1" name="ccontact[]"
									placeholder="Contact number" class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="form-field-1">Email </label>
							<div class="col-sm-9">
								<input type="text" id="cemail-1" name="cemail[]" placeholder="Email"
									class="col-xs-10 col-sm-5" />
							</div>
						</div>
						<div id="addCompanyName"></div>
						<div class="clearfix form-actions">
							<div class="col-md-offset-3 col-md-9">
								 <input type="button" id="addMoreCompany" value="Add Company" onclick="javascript:addBuilderCompanyName()"
									class="btn btn-info ">
								&nbsp; &nbsp; &nbsp;
								<button name="saveBuilder" class="btn btn-info" type="submit">
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
<script src="${baseUrl}/js/jquery.form.js"></script>
<script src="${baseUrl}/js/bootstrapValidator.min.js"></script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
var batch_count =1;
$('#bname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) {  return ''; } ) );
});
$('#cname-'+batch_count).keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) {  return ''; } ) );
});
$("#hemail").keyup(function() {
	ValidateEmail($("#hemail").val());
});
$('#cemail-'+batch_count).keyup(function() {
	ValidateEmail($("#cemail-"+batch_count).val());
});
$('#hphno').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { return ''; } ) );
});
$('#ccontact-'+batch_count).keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { return ''; } ) );
});
	function ValidateEmail(email) {
        var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return expr.test(email);
    };
	
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
    	batch+='<input type="text" id="ccontact-'+batch_count+'" name="ccontact[]" placeholder="Contact number" class="col-xs-10 col-sm-5" />';
    	batch+='</div>';
    	batch+='</div>';
    	batch+='<div class="form-group">';
    	batch+='<label class="col-sm-3 control-label no-padding-right" for="form-field-1">Email </label>';
    	batch+='<div class="col-sm-9">';
    	batch+='<input type="text" id="cemail-'+batch_count+'" name="cemail[]" placeholder="Email" class="col-xs-10 col-sm-5" />';
    	batch+='</div></div>';
    	
    	$("#addCompanyName").append(batch);
    	
    	}	

    
    function clearAllFields(){
    	 for(var i=1;i<=batch_count;i++){
    		 $("#cname-"+i).val("");
    		 $("#ccontact-"+i).val("");
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
    
    $('#addBuilder').bootstrapValidator({
    	container: function($field, validator) {
    		return $field.parent().next('.messageContainer');
       	},
        feedbackIcons: {
            validating: 'glyphicon glyphicon-refresh'
        },
        excluded: ':disabled',
        fields: {
        	bname: {
                validators: {
                    notEmpty: {
                        message: 'Builder Name is required and cannot be empty'
                    }
                }
            },
            status: {
                validators: {
                    notEmpty: {
                        message: 'Status  is required and cannot be empty'
                    }
                }
            },
            hoffice: {
                validators: {
                    notEmpty: {
                        message: 'Head Office is required and cannot be empty'
                    }
                }
            },
            hphno: {
            	 validators: {
                     notEmpty: {
                         message: 'The Mobile is required.'
                     },
                     regexp: {
                         regexp: '^[7-9][0-9]{9}$',
                         message: 'Invalid Mobile Number'
                     }
                 }
            },
            hemail: {
            	validators: {
                    notEmpty: {
                        message: 'Email is required and cannot be empty'
                    },
                    regexp: {
                        regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                        message: 'The value is not a valid email address'
                    }
            		
                }
            },
            'cname[]': {
                validators: {
                    notEmpty: {
                        message: 'name is required and cannot be empty'
                    }
                }
            },
            'ccontact[]' :{
            	 validators: {
                     notEmpty: {
                         message: 'The Mobile is required.'
                     },
                     regexp: {
                         regexp: '^[7-9][0-9]{9}$',
                         message: 'Invalid Mobile Number'
                     }
                 }
            },
            'cemail[]' :{
            	validators: {
                    notEmpty: {
                        message: 'Email is required and cannot be empty'
                    },
                    regexp: {
                        regexp: '^[^@\\s]+@([^@\\s]+\\.)+[^@\\s]+$',
                        message: 'The value is not a valid email address'
                    }
            		
                }
            }
        }
    }).on('success.form.bv', function(event,data) {
    	// Prevent form submission
    	event.preventDefault();
    	addBuilder();
    });

    function addBuilder() {
    	var options = {
    	 		target : '#response', 
    	 		beforeSubmit : showAddRequest,
    	 		success :  showAddResponse,
    	 		url : '${baseUrl}/webapi/create/builder/new/add/',
    	 		semantic : true,
    	 		dataType : 'json'
    	 	};
       	$('#addBuilder').ajaxSubmit(options);
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