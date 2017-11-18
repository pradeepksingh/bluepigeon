
<%@include file="../../head.jsp"%>
<%@page import="org.bluepigeon.admin.dao.CountryDAOImp"%>
<%@page import="org.bluepigeon.admin.model.Country"%>
<%@page import="org.bluepigeon.admin.dao.TaxDAO"%>
<%@page import="org.bluepigeon.admin.model.Tax" %>
<%@page import="java.util.List"%>
<%
	List<Country> country_list = new CountryDAOImp().getCountryList();
	int country_size=country_list.size();
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
              	<div class="row" style=padding:20px">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="password" class="control-label">Select Country</label>
                       		<select name="ucountry_id" id="ucountry_id" class="form-control">
								<option value=""> Select Country </option>
								<% for(int i=0; i < country_size ; i++){ %>
								<option value="<% out.print(country_list.get(i).getId());%>" <%if(country_list.get(i).getId() == tax.getCountry().getId()){ %>selected<%} %>><% out.print(country_list.get(i).getName());%></option>
								<% } %>
							</select>
                  		</div>
              		</div>
              	</div>
              	<%if(tax.getCountry().getTaxLabel1() != null && tax.getCountry().getTaxLabel1() != ""){ %>
              	<div class="row" id="uhtax1">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label  for="utax"  class="control-label"><%out.print(tax.getCountry().getTaxLabel1()); %></label>
                       		<input type="text" name="utax" id="utax" value="<%out.print(tax.getTax()); %>" class="form-control" placeholder="Enter <%out.print(tax.getCountry().getTaxLabel1()); %>"/>
                  		</div>
              		</div>
              	</div>
              	<%}else{ %>
              	<input type="hidden" id="utax" name="utax" value="0">
              	<%} %>
              	<%if(tax.getCountry().getTaxLabel2() != null && tax.getCountry().getTaxLabel2() != ""){ %>
              	<div class="row" id="uhtax2">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="usduty" class="control-label"><%out.print(tax.getCountry().getTaxLabel2()); %></label>
                       		<input type="text" name="usduty" id="usduty" value="<%out.print(tax.getStampDuty()); %>" class="form-control" placeholder="Enter <%out.print(tax.getCountry().getTaxLabel2()); %>"/>
                  		</div>
              		</div>
              	</div>
              	<%}else{ %>
              	<input type="hidden" id= "usduty" name="usduty" value="0" />
              	<%} %>
              	<%if(tax.getCountry().getTaxLabel3() != null && tax.getCountry().getTaxLabel3() != ""){ %>
              	<div class="row" id="uhtax3">
              		<div class="col-xs-12">
                  		<div class="form-group">
                       		<label for="uvat"  class="control-label"><%out.print(tax.getCountry().getTaxLabel3()); %></label>
                       		<input type="text" name="uvat" id="uvat" value="<%out.print(tax.getVat()); %>" class="form-control" placeholder="Enter <%out.print(tax.getCountry().getTaxLabel3()); %>"/>
                  		</div>
              		</div>
              	</div>
              	<%}else{ %>
              	<input type="hidden" id="uvat" name="uvat" value="0"/>
              	<%} %>
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
        (charCode != 45 || $(element).val().indexOf('-') != -1) &&      //  CHECK MINUS, AND ONLY ONE.
        (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // CHECK DOT, AND ONLY ONE.
        (charCode < 48 || charCode > 57))
        return false;
    return true;
}    

$("#ucountry_id").change(function(){
	//get the current placeholder
	var ptax1 = $("#utax").attr('placeholder');
	var ptax2 = $("#usduty").attr('placeholder');
	var ptax3 = $("#uvat").attr('placeholder');
	if($("#ucountry_id").val() > 0){
		ajaxindicatorstart("Please wait while.. we load ...");
		$.post("${baseUrl}/webapi/general/uchangeLabel",{country_id : $("#ucountry_id").val()}, function(data){
			if(data != "" && data != null){
				if(data.taxLabel1 != "" && data.taxLabel1 != "undefined"){
					$("#utax").show();
				//chnage the label according to selected country
				 $("label[for='utax']").text(data.taxLabel1);
				//change the old placeholder with new placeholder
				 document.getElementById("utax").placeholder = "Enter "+data.taxLabel1;
				 //$("#tax").placeholder("Enter "+data.taxLabel1);
				 $("#uhtax1").show();
				}else{
					$("#utax").hide();
					$("#utax").val('0');
					$("#uhtax1").hide();
				}
				if(data.taxLabel2 != "" && data.taxLabel2 != "undefined"){
					$("#usduty").show();
					 $("label[for='usduty']").text(data.taxLabel2);
					  document.getElementById("usduty").placeholder = "Enter "+data.taxLabel2;
					 $("#uhtax2").show();
				}else{
					$("#usduty").hide();
					$("#usduty").val('0');
					$("#uhtax2").hide();
				}
				if(data.taxLabel3 != "" && data.taxLabel3 != "undefined"){
					$("#uvat").show();
					 $("label[for='uvat']").text(data.taxLabel3);
					  document.getElementById("uvat").placeholder = "Enter "+data.taxLabel3;
					 $("#uhtax3").show();
				}else{
						
						$("#uvat").hide();
						$("#uvat").val('0');
						$("#uhtax3").hide();
					
				}}else{
				$("#uhtax1").hide();
				$("#uhtax2").hide();
				$("#uhtax3").hide();
			}
			ajaxindicatorstop();
		});
	}
});
</script>