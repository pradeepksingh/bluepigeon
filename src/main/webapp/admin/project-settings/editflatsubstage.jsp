
<%@page import="org.bluepigeon.admin.dao.FlatSubstagesDAO"%>
<%@page import="org.bluepigeon.admin.model.FlatSubstage"%>
<%@page import="org.bluepigeon.admin.dao.FlatStageDAO"%>
<%@page import="org.bluepigeon.admin.model.FlatStage"%>
<%@page import="java.util.List"%>
<%
int flat_stage_size=0;
int flat_substage_id = Integer.parseInt(request.getParameter("flat_substage_id"));
List<FlatStage> flat_stage_list = new FlatStageDAO().getFlatStageList();
List<FlatSubstage> flat_substage_detail = null;
FlatSubstage flatSubstage = null;
if (flat_substage_id > 0) {
	flat_substage_detail = new FlatSubstagesDAO().getFlatSubstageById(flat_substage_id);
	if(flat_substage_detail.size() > 0)
		flatSubstage = flat_substage_detail.get(0);
}
flat_stage_size = flat_stage_list.size();
%>				<input type="hidden" name="flat_substage_id" id="uflat_substage_id" value="<% out.print(flat_substage_id); %>"/>
				<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Flat Stage</label>
                       		<select name="stage_id" id="ustage_id" class="form-control">
								<option value=""> Select Flat Stage </option>
								<% for(int i=0; i < flat_stage_size ; i++){ %>
								<option value="<% out.print(flat_stage_list.get(i).getId());%>" <% if(flat_stage_list.get(i).getId() == flatSubstage.getFlatStage().getId()){ %>selected<%}  %>><% out.print(flat_stage_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Flat Substage Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(flatSubstage.getName()); %>" class="form-control" placeholder="Enter flat substage Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(flatSubstage.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(flatSubstage.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateFlatSubstages();">Update</button>
             		</div>
              	</div>
