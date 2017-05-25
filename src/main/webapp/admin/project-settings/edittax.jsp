<%@page import="org.bluepigeon.admin.dao.TaxDAO"%>
<%@page import="org.bluepigeon.admin.model.Tax" %>
<%@page import="java.util.List"%>
<%
	
	List<Tax> tax_list = null;
	TaxDAO taxDAO = new TaxDAO();
	
	int tax_id = Integer.parseInt(request.getParameter("tax_id"));
	Tax tax = null;
	if (tax_id > 0) {
		tax_list = taxDAO.getTaxById(tax_id);
		tax = tax_list.get(0);
	}
%>				<input type="hidden" name="tax_id" id="utax_id" value="<% out.print(tax.getId()); %>"/>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Pincode</label>
                       		<input type="text" name="pincode" id="upincode" value="<%out.print(tax.getPincode()); %>" class="form-control" placeholder="Enter Pincode"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">tax</label>
                       		<input type="text" name="tax" id="utax" value="<%out.print(tax.getTax()); %>" class="form-control" placeholder="Enter tax"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Stamp Duty</label>
                       		<input type="text" name="sduty" id="usduty" value="<%out.print(tax.getStampDuty()); %>" class="form-control" placeholder="Enter stamp Duty"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Vat</label>
                       		<input type="text" name="vat" id="uvat" value="<%out.print(tax.getVat()); %>" class="form-control" placeholder="Enter Vat"/>
                  		</div>
              		</div>
              	</div>
              	<div class="row">
              		<div class="col-xs-12">
             			<button type="submit" class="btn btn-primary" onclick="updateTax();">UPDATE</button>
             		</div>
              	</div>
<script type="text/javascript">
$("#upincode").attr('maxlength','6');
$('#upincode').keyup(function() {
    var $th = $(this);
    $th.val( $th.val().replace(/[^0-9]/g, function(str) { alert('\n\nPlease use only numbers.'); return ''; } ) );
});
$('#utax').keypress(function (event) {
    return isNumber(event, this)
});
$('#uvat').keypress(function (event) {
    return isNumber(event, this)
});
$('#usduty').keypress(function (event) {
    return isNumber(event, this)
});
function isNumber(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode

    if (
        (charCode != 45 || $(element).val().indexOf('-') != -1) &&      // “-” CHECK MINUS, AND ONLY ONE.
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;

    return true;
}    
</script>
