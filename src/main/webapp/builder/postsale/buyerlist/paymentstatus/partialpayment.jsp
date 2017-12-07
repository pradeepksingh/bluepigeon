<%@page import="java.util.List"%>
<%@page import="org.bluepigeon.admin.dao.BuyerDAO"%>
<%@page import="org.bluepigeon.admin.model.BuyerPayment"%>
<%

int id = 0;
int buyerId = 0;
BuyerPayment buyerPayment = null;
List<BuyerPayment> buyerPayments = null;
String scheduleName = "";
double previous = 0;
double current = 0;
double total = 0;
try{
	if (request.getParameterMap().containsKey("id")) {
		if (request.getParameterMap().containsKey("buyer_id")) {
			id = Integer.parseInt(request.getParameter("id"));
			buyerId = Integer.parseInt(request.getParameter("buyer_id"));
			buyerPayment = new BuyerDAO().getBuyerPymentsById(id);
			if(buyerPayment != null){
				scheduleName = buyerPayment.getMilestone();
				buyerPayments  = new BuyerDAO().getBuyerPaymentsByBuyerId(buyerId);
				if(buyerPayments != null && buyerPayments.size() > 0){
					for(BuyerPayment buyerPayment2 : buyerPayments){
						if(!buyerPayment.isPaid()){
							if(buyerPayment.getId().equals(buyerPayment2.getId())){
								current = buyerPayment2.getAmount();
							}else{
								previous += buyerPayment2.getAmount();
							}
							
						}
					}
					total = current+previous;
				}
			}
		}
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
	<form id='updatepayment' name='updatepayment'>
		<input type='hidden' id='buyer_id' name='buyer_id' value='<%out.print(buyerId);%>'/>
		<div class='row'>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Demand name</label>
					<div class='col-sm-6'>
						<div>
							<input type='text' class='form-control' id='demand_name' name='demand_name' autocomplete='false' />
						</div>
						<div class='messageContainer'></div>
 					</div>
				</div>
		    </div>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Schedule name</label>
					<div class='col-sm-6'>
						<input type='text' class='form-control' id='schedule_name' name='schedule_name' value="<%out.print(scheduleName); %>" readonly/>
 					</div>
				</div>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Previous outstanding</label>
					<div class='col-sm-6'>
						<input type='text' class='form-control' id='previous' name='previous' value='<%out.print(Math.round(previous)); %>' readonly />
 					</div>
				</div>
			</div>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>New demand</label>
					<div class='col-sm-6'>
						<input type='text' class='form-control' id='new_demand' name='new_demand' value='<%out.print(Math.round(current)); %>' readonly/>
 					</div>
				</div>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Total demand value</label>
					<div class='col-sm-6'>
						<input type='text' class='form-control' id='previous' name='previous' value='<%out.print(Math.round(total)); %>' readonly />
 					</div>
				</div>
			</div>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Payment date</label>
					<div class='col-sm-6'>
						<div>
							<input type='text' class='form-control' id='payment_date' name='payment_date' autocomplete='false' />
						</div>
						<div class='messageContainer'></div>
 					</div>
				</div>
			</div>
		</div>
		<div class='row'>
			<div class='col-sm-6'>
				<div class='form-group row'>
					<label for='example-text-input' class='col-sm-4 col-form-label'>Reminder Day</label>
					<div class='col-sm-6'>
						<select id="remind_day" name="remind_day" class="col-sm-12" style="height:40px;">
							<option value="0">Select Remind days</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
						</select>
 					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class='col-sm-6 center'>
				<button type="submit" id="closebtn" onclick="closepayment(<%out.print(id); %>);" class="btn btn-submit waves-effect waves-light m-t-10">CLOSE</button>
            </div>
			<div class='col-sm-6 center'>
               	<button type="submit" id="pricebtn" class="btn btn-submit waves-effect waves-light m-t-10">UPDATE</button>
            </div>
        </div>
	</form>
