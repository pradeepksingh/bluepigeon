<%@page import="org.bluepigeon.admin.dao.HomeLoanBanksDAO"%>
<%@page import="org.bluepigeon.admin.model.HomeLoanBanks" %>
<%@page import="java.util.List"%>
<%
	
	List<HomeLoanBanks> home_loan_bank_list = null;
	HomeLoanBanksDAO homeLoanBanksDAO = new HomeLoanBanksDAO();
	
	int bank_id = Integer.parseInt(request.getParameter("bank_id"));
	HomeLoanBanks homeLoanBanks = null;
	if (bank_id > 0) {
		home_loan_bank_list = homeLoanBanksDAO.getHomeLoanBanksById(bank_id);
		homeLoanBanks = home_loan_bank_list.get(0);
	}
%>				<input type="hidden" name="bank_id" id="ubank_id" value="<% out.print(homeLoanBanks.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Bank Name</label>
                       		<input type="text" name="name" id="uname" value="<% out.print(homeLoanBanks.getName()); %>" class="form-control" placeholder="Enter building amenity Name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Location</label>
                       		<input type="text" name="location" id="ulocation"  value="<% out.print(homeLoanBanks.getLocation()); %>" class="form-control" placeholder="Enter bank location"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Contact Person Name</label>
                       		<input type="text" name="contact name" id="ucontact_name"  value="<% out.print(homeLoanBanks.getContactPerson()); %>" class="form-control" placeholder="Enter contact person name"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Email</label>
                       		<input type="text" name="email" id="uemail"  value="<% out.print(homeLoanBanks.getEmail()); %>" class="form-control" placeholder="Enter contact person email id"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Phone</label>
                       		<input type="text" name="phone" id="uphone"  value="<% out.print(homeLoanBanks.getPhone()); %>" class="form-control" placeholder="Enter contact person phone number"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Status</label>
                       		<select name="status" id="ustatus" class="form-control">
								<option value="1" <% if(homeLoanBanks.getStatus() == 1) { %>selected<% } %>> Active </option>
								<option value="0" <% if(homeLoanBanks.getStatus() == 0) { %>selected<% } %>> Inactive </option>
							</select>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateHomeLoanBank();">UPDATE</button>
             		</div>
              	</div>
