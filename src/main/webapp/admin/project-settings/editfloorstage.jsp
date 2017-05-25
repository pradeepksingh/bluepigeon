<%@page import="org.bluepigeon.admin.model.FloorStage"%>
<%@page import="org.bluepigeon.admin.dao.FloorStageDAO"%>
<%@page import="java.util.List"%>
<%
	int amenity_size = 0;
	int state_size = 0;
	FloorStageDAO floorStageDAO = new FloorStageDAO();
	
	int id = Integer.parseInt(request.getParameter("stage_id"));
	FloorStage floorStage = null;
	if (id > 0) {
		floorStage = floorStageDAO.getFloorStageById(id);
	}
%>				<input type="hidden" name="stage_id" id="ustage_id" value="<% out.print(floorStage.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Floor Stage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(floorStage.getName()); %>" class="form-control" placeholder="Enter floor stage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(floorStage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(floorStage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFloorStage();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
</script>