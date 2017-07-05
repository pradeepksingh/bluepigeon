<%@page import="org.bluepigeon.admin.dao.BuilderPaymentSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.dao.BuilderPaymentStagesDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderPaymentStages"%>
<%@page import="org.bluepigeon.admin.model.BuilderPaymentSubstages"%>

<%@page import="java.util.List"%>
<%
int amenity_size=0;
int payment_stage_id = Integer.parseInt(request.getParameter("payment_stage_id"));
List<BuilderPaymentStages> payment_list = null;
List<BuilderPaymentSubstages> payment_stage_detail = null;
BuilderPaymentSubstages builderPaymentSubstages = null;
if (payment_stage_id > 0) {
	payment_stage_detail = new BuilderPaymentSubstagesDAO().getBuilderPaymentSubstagesById(payment_stage_id);
	if(payment_stage_detail.size() > 0)
		builderPaymentSubstages = payment_stage_detail.get(0);
}
payment_list = new BuilderPaymentStagesDAO().getBuilderPaymentStagesList();
amenity_size = payment_list.size();
%>				<input type="hidden" name="amenity_stage_id" id="ustage_id" value="<% out.print(builderPaymentSubstages.getId()); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Payment Stages</label>
                       		<select name="payment_id" id="upayment_id" class="form-control">
								<option value=""> Select Payment Stages </option>
								<% for(int i=0; i < amenity_size ; i++){ %>
								<option value="<% out.print(payment_list.get(i).getId());%>" <% if(payment_list.get(i).getId() == builderPaymentSubstages.getBuilderPaymentStages().getId()){ %>selected<%}  %>><% out.print(payment_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Amenity Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderPaymentSubstages.getName()); %>" class="form-control" placeholder="Enter Project Amenity Stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderPaymentSubstages.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderPaymentSubstages.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updatePaymentSubstages();">Update</button>
             		</div>
              	</div>
<script type="text/javascript">
// $("#country_id").change(function(){
// 	$.get("${baseUrl}/webapi/general/state/list",{ country_id: $("#country_id").val() }, function(data){
// 		var html = '<option value="">Select State</optio>';
// 		$(data).each(function(index){
// 			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
// 		});
// 		$("#ustate_id").html(html);
// 	},'json');
// });
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 ]/g, function(str) { alert('\n\nPlease use only alphanumeric.'); return ''; } ) );
});
</script>