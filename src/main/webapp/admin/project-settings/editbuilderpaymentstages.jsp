<%@page import="org.bluepigeon.admin.dao.BuilderPaymentStagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPaymentStages" %>
<%@page import="java.util.List"%>
<%
	
	List<BuilderPaymentStages> payment_list = null;
	BuilderPaymentStagesDAO builderPaymentStagesDAO = new BuilderPaymentStagesDAO();
	
	int payment_id = Integer.parseInt(request.getParameter("payment_id"));
	BuilderPaymentStages builderPaymentStages = null;
	if (payment_id > 0) {
		payment_list = builderPaymentStagesDAO.getBuilderPaymentStagesById(payment_id);
		builderPaymentStages = payment_list.get(0);
	}
%>				<input type="hidden" name="payment_id" id="upayment_id" value="<% out.print(builderPaymentStages.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Payment Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderPaymentStages.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderPaymentStages.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderPaymentStages.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updatePaymentStages();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>