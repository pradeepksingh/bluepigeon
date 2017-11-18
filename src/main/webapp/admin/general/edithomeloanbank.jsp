<%@page import="org.bluepigeon.admin.model.BankLogo"%>
<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks" %>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<%
	
	List<HomeLoanBanks> home_loan_bank_list = null;
	HomeLoanBanksDAO homeLoanBanksDAO = new HomeLoanBanksDAO();
	BankLogo bankLogo = null;
	int bank_id = Integer.parseInt(request.getParameter("bank_id"));
	HomeLoanBanks homeLoanBanks = null;
	if (bank_id > 0) {
		home_loan_bank_list = homeLoanBanksDAO.getHomeLoanBanksById(bank_id);
		homeLoanBanks = home_loan_bank_list.get(0);
		bankLogo = homeLoanBanksDAO.getBankLogoByBankId(bank_id);
	}
%>
<form class="form-horizontal" role="form" method="post" action="" id="updatehomeloanbanks" name="updatehomeloanbanks" enctype="multipart/form-data">	
			<input type="hidden" name="ubank_id" id="ubank_id" value="<% out.print(homeLoanBanks.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Bank Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(homeLoanBanks.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	 <div class="row">
        			 <div class="col-xs-12">
              			<div class="form-group">
		              		<label for="password" class="control-label">Bank Logo</label>
		                    <input type="file" class="form-control" id="bank_logo" name="bank_logo[]" />
		                    <% if(bankLogo != null) {%>
							<input type="hidden" value="<%out.print(bankLogo.getId()); %>" name="bank_logo_id[]" id="bank_logo_id"/>
							<div class="col-sm-4">
								<img alt="Bank logo" src="${baseUrl}/<% out.print(bankLogo.getLogoUrl()); %>" width="50px;">
							</div>
							<div class="messageContainer"></div>
							<% } %>
              			 </div>
          			</div>
   			 	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Location</label>
                       		<input type="text" name="ulocation" id="ulocation"  value="<% out.print(homeLoanBanks.getLocation()); %>" class="form-control" placeholder="Enter bank location"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Contact Person Name</label>
                       		<input type="text" name="ucontact_name" id="ucontact_name"  value="<% out.print(homeLoanBanks.getContactPerson()); %>" class="form-control" placeholder="Enter contact person name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Email</label>
                       		<input type="text" name="uemail" id="uemail"  value="<% out.print(homeLoanBanks.getEmail()); %>" class="form-control" placeholder="Enter contact person email id"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Phone</label>
                       		<input type="text" name="uphone" id="uphone"  value="<% out.print(homeLoanBanks.getPhone()); %>" class="form-control" placeholder="Enter contact person phone number"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(homeLoanBanks.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(homeLoanBanks.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" name="updateHomeLoanLogo">UPDATE</button>
             		</div>
              	</div>
            </form>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
$('#ucontact_name').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
$('#ulocation').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
$('#updatehomeloanbanks').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	uname: {
            validators: {
                notEmpty: {
                    message: 'Bank Name is required and cannot be empty'
                }
            }
        },
        ulocation: {
            validators: {
                notEmpty: {
                    message: 'Location Name is required and cannot be empty'
                }
            }
        },
        uemail: {
            validators: {
                notEmpty: {
                    message: 'Email id is required and cannot be empty'
                }
            }
        },
        ucontact_name: {
            validators: {
                notEmpty: {
                    message: 'Contact name is required and cannot be empty'
                }
            }
        },
        uphone:  {
            validators: {
                notEmpty: {
                    message: 'phone number is required and cannot be empty'
                }
            }
        },
        ustatus: {
            validators: {
                notEmpty: {
                    message: 'Status  is required and cannot be empty'
                }
            }
        }
   
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	updateHomeLoanBank();
});


function updateHomeLoanBank() {
	ajaxindicatorstart("Please wait while.. we load ...");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showUpdateRequest,
	 		success :  showUpdateResponse,
	 		url : '${baseUrl}/webapi/general/bank/update/',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#updatehomeloanbanks').ajaxSubmit(options);
}

function showUpdateRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showUpdateResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
		ajaxindicatorstop();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/admin/general/home-loan-bank.jsp";
  	}
}
</script>