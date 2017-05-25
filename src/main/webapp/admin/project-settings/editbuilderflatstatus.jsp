<%@page import="org.bluepigeon.admin.dao.BuilderFlatStatusDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderFlatStatus"%>
<%@page import="java.util.List"%>
<%

	List<BuilderFlatStatus> flat_status_list = null;
	BuilderFlatStatusDAO builderFlatStatusDAO = new BuilderFlatStatusDAO();
	
	int flat_status_id = Integer.parseInt(request.getParameter("flat_status_id"));
	BuilderFlatStatus builderFlatStatus = null;
	if (flat_status_id > 0) {
		flat_status_list = builderFlatStatusDAO.getCountryById(flat_status_id);
		builderFlatStatus = flat_status_list.get(0);
	}
%>				<input type="hidden" name="flat_status_id" id="uflat_status_id" value="<% out.print(builderFlatStatus.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Flat Status Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(builderFlatStatus.getName()); %>" class="form-control" placeholder="Enter flat status Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(builderFlatStatus.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(builderFlatStatus.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFlatStatus();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>