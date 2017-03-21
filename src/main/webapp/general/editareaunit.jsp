<%@page import="org.bluepigeon.admin.dao.AreaUnitDAO"%>
<%@page import="org.bluepigeon.admin.model.AreaUnit" %>
<%@page import="java.util.List"%>
<%
	
	List<AreaUnit> amenity_list = null;
	AreaUnitDAO areaUnitDAOImpl = new AreaUnitDAO();
	
	int areaunit_id = Integer.parseInt(request.getParameter("areaunit_id"));
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
                       		<input type="text" name="name" id="uname" value="<% out.print(areaUnit.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
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
