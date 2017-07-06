<%@page import="org.bluepigeon.admin.dao.BuilderSellerTypeDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderSellerType"%>

<%@page import="java.util.List"%>
<%
	List<BuilderSellerType> seller_type_list = null;
	BuilderSellerTypeDAO builderSellerTypeDAO = new BuilderSellerTypeDAO();
	
	int seller_type_id = Integer.parseInt(request.getParameter("seller_id"));
	BuilderSellerType builderSellerType = null;
	if (seller_type_id > 0) {
		seller_type_list = builderSellerTypeDAO.getBuilderSellerTypeById(seller_type_id);
		builderSellerType = seller_type_list.get(0);
	}
%>				<input type="hidden" name="useller_id" id="useller_id" value="<% out.print(builderSellerType.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Project Level Name</label>
                       		<input type="text" name="uname" id="uname" value="<% out.print(builderSellerType.getName()); %>" class="form-control" placeholder="Enter project seller type"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="ustatus" id="ustatus" class="form-control">
								<option value="1" <% if(builderSellerType.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderSellerType.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateProjectSellerType();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z0-9 -]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>