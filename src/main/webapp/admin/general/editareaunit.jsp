<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit" %>
<%@page import="java.util.List"%>
<%
	
	List<AreaUnit> amenity_list = null;
	AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
	
	Short areaunit_id = Short.parseShort(request.getParameter("areaunit_id"));
	AreaUnit areaUnit = null;
	if (areaunit_id > 0) {
		amenity_list = areaUnitDAOImpl.getAreaUnitById(areaunit_id);
		areaUnit = amenity_list.get(0);
	}
%>				<input type="hidden" name="areaunit_id" id="uareaunit_id" value="<% out.print(areaUnit.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Area Unit</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(areaUnit.getName()); %>" class="form-control" placeholder="Enter unit Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Value In Square feet.</label>
                       		<input type="text" name="sqft_value" id="usqft_value" value="<% out.print(areaUnit.getSqft_value()); %>" class="form-control" placeholder="Enter suare feet value"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(areaUnit.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(areaUnit.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateAreaUnit();">UPDATE</button>
             		</div>
              	</div>
<script>
$('#uname').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^a-zA-Z ]/g, function(str) { alert('\n\nPlease use only letters.'); return ''; } ) );
});
$('#usqft_value').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9.]/g, function(str) { alert('\n\nPlease enter only decimal numbers.'); return ''; } ) );
});

</script>