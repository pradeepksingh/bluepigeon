<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.ProjectDetailsDAO"%>
<%@page import="org.bluepigeon.admin.model.BuilderProject"%>
<%@page import="org.bluepigeon.admin.model.BuilderEmployee"%>
<%@page import="org.bluepigeon.admin.dao.BuilderDetailsDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
	session = request.getSession(false);
	BuilderEmployee builder = new BuilderEmployee();
	List<BuilderProject> project_list = null; 
	int builder_id = 0;
	if(session!=null)
	{
		if(session.getAttribute("ubname") != null)
		{
			builder  = (BuilderEmployee)session.getAttribute("ubname");
			builder_id = builder.getBuilder().getId();
		}
   }
	int builder_id1 = 1;
	if(builder_id> 0 ){
		project_list = new ProjectDetailsDAO().getBuilderActiveProjectList(builder_id);
	}
	List<BuilderEmployee> builderEmployees = new BuilderDetailsDAO().getBuilderEmployees(builder_id1);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Piegon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- animation CSS -->
    <link href="../css/animate.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/custom.css" rel="stylesheet">
    <link href="../css/custom1.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <script src="../js/bootstrapValidator.min.js"></script>
     
<script type="text/javascript">
    $('input[type=checkbox]').click(function(){
    if($(this).is(':checked')){
          var tb = $('<input type=text />');    
          $(this).after(tb)  ;
    }
    else if($(this).siblings('input[type=text]').length>0){
        $(this).siblings('input[type=text]').remove();
    }
})
</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
         <div id="wrapper">
         <div id="header">
	       <%@include file="../partial/header.jsp"%>
      </div>
      <div id="sidebar1"> 
       	<%@include file="../partial/sidebar.jsp"%>
      </div>
    
    
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">New Buyer</h4>
                    </div>
                  
                    <!-- /.col-lg-12 -->
                </div>
             
                <div class="row">
                    <div class="col-lg-12">
                        <div class="white-box">
                             <h4 class="page-title">New Buyer</h4>
                             <br>
                                <ul class="nav tabs-horizontal">
                                    <li class="tab nav-item" aria-expanded="false">
                                        <a data-toggle="tab" class="nav-link active" href="#vimessages" aria-expanded="false"><span>Add New Buyer</span></a>
                                    </li>
                                     <li class="tab nav-item">
                                        <a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages1"><span>Project Details</span></a>
                                    </li>
                                    <li class="tab nav-item">
                                        <a aria-expanded="false" class="nav-link space1" data-toggle="tab" href="#vimessages2"><span>Buying Details</span></a>
                                    </li>
                                     <li class="tab nav-item">
                                        <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages3"><span>Payment Schedule</span></a>
                                    </li>
                                    <li class="tab nav-item">
                                        <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages4"><span>Documents</span></a>
                                    </li>
                                    <!--   <li class="tab nav-item">
                                        <a aria-expanded="true" class="nav-link space1" data-toggle="tab" href="#vimessages5"><span>Pricing Rate</span></a>
                                    </li>-->
                                </ul>
                                
                                 <form id="addbuyer" name="addbuyer" action="" method="post" enctype="multipart/form-data"> 
                              <div class="tab-content"> 
                              	<input type="hidden" name="builder_id" id="builder_id" value="<% out.print(builder_id1); %>" />
                               <div class="tab-pane active" id="vimessages" aria-expanded="false">
                                <div class="col-12" id="vimessages111" >
                            
                                <input type="hidden" name="buyer_count" id="buyer_count" value="1"/>
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Buyer Name*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="buyer_name" name="buyer_name[]" value="">
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Contact*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="contact" name="contact[]" value="">
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Email*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="email" name="email[]" value="">
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Pan*</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" id="pan" name="pan[]" value="">
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Permanent Address*</label>
                                    <div class="col-3">
                                         <textarea class="form-control" rows="" cols="" id="address" name="address[]"></textarea>
                                    </div>
                                    <label for="example-tel-input" class="col-3 col-form-label">Owner*</label>
                                    <div class="col-3">
                                      <select name="is_primary[]" id="is_primary" class="form-control">
			                       		<option value="">Select Owner</option>
			                     		<option value="0">Co-Owner</option>
			                      		<option value="1" selected>Owner</option>
							          </select>
                                    </div>
                                </div>
								<div class="form-group row" id="error-project_type">
									<label class="col-12 col-form-label">Documents <span class='text-danger'>*</span></label>
										<div class="col-3">
											<input type="checkbox" name="document_pan[]" value="1" /> PAN Card
										</div>
										<div class="col-3">
											<input type="checkbox" name="document_aadhar[]" value="2" /> Aadhar Card
										</div>
										<div class="col-3">
											<input type="checkbox" name="document_passport[]" value="3" /> Passport 
										</div>
										<div class="col-3">
											<input type="checkbox" name="document_rra[]" value="4" /> Registered Rent Agreement 
										</div>
										<div class="col-3">
											<input type="checkbox" name="document_voterid[]" value="5" /> Vote ID 
										</div>
										<div class="messageContainer col-sm-offset-2"></div>
								</div>
                               </div>
                                <div class="offset-sm-10 col-sm-7">
                                <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="show();" id="next">Next</button>
                                       <a href="javascript:addMoreBuyers();"> <button type="button" class="btn btn-info waves-effect waves-light m-t-10">+ Add New Buyer</button></a>
                                 </div>
                                
                              </div>
                              
                             <div id="vimessages1" class="tab-pane" aria-expanded="false">
                           
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Project Name</label>
                                    <div class="col-6">
                                       <select name="project_id" id="project_id" class="form-control">
						                    <option value="">Select Project</option>
						                    <% for(BuilderProject builderProject : project_list){ %>
											<option value="<% out.print(builderProject.getId());%>" ><% out.print(builderProject.getName());%></option>
											<% } %>
							            </select>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                  <label for="example-text-input" class="col-3 col-form-label">Building</label>
                                    <div class="col-6">
                                       <select name="building_id" id="building_id" class="form-control">
						                    <option value="">Select Building</option>
							          	</select>
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Flat</label>
                                    <div class="col-6">
                                       <select name="flat_id" id="flat_id" class="form-control">
						                    <option value="">Select Flat</option>
							           </select>
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Assign Manager</label>
                                    <div class="col-6">
                                      <select name="admin_id" id="admin_id" class="form-control">
											<% for(BuilderEmployee builderEmployee :builderEmployees) { %>
						                  	<option value="<% out.print(builderEmployee.getId());%>"><% out.print(builderEmployee.getName());%></option>
						                  	<% } %>
							          </select>
                                    </div>
                                </div>

                                <div class="offset-sm-5 col-sm-7">
                                <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="previous1();">Previous</button>
                                        <button type="button" class="btn btn-info waves-effect waves-light m-t-10" id="next1" onclick="show1();">Next</button>
                                 </div>
                             
                               </div>

                                <div id="vimessages2" class="tab-pane" aria-expanded="false">
                                 <div class="col-12">
                           
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-3 col-form-label">Booking Date</label>
                                    <div class="col-3">
                                       <input type="text" class="form-control" id="booking_date" name="booking_date" value=""/>
                                    </div>
                                    <label for="example-text-input" class="col-3 col-form-label">Base Rate</label>
                                    <div class="col-3">
                                        <input type="text" class="form-control" id="base_rate" name="base_rate" />
                                    </div>
                                </div> 
                                
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">Floor Rising Rate</label>
                                    <div class="col-3">
                                       <input type="text" class="form-control" id="rise_rate" name="rise_rate"/>
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Aminities Facing Rise Rates</label>
                                    <div class="col-3">
                                        <input type="text" class="form-control" id="amenity_rate" name="amenity_rate" />
                                    </div>
                                </div>
                                
                                 <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Parking Rates</label>
                                    <div class="col-3">
                                       	<input type="text" class="form-control" id="parking" name="parking" />
                                    </div>
                                    <label for="example-tel-input" class="col-3 col-form-label">Maintance</label>
                                    <div class="col-3">
                                        <input type="text" class="form-control" id="maintenance" name="maintenance" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-tel-input" class="col-3 col-form-label">Stamp Duty</label>
                                    <div class="col-3">
                                       <input type="text" class="form-control" id="stamp_duty" name="stamp_duty" />
                                    </div>
                                    <label for="example-tel-input" class="col-3 col-form-label">Taxes</label>
                                    <div class="col-3">
                                         <input type="text" class="form-control" id="tax" name="tax" />
                                    </div>
                                </div>
                                                              
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">VAT</label>
                                    <div class="col-3">
                                       <input type="text" class="form-control" id="vat" name="vat" />
                                    </div>
                                    <label for="example-search-input" class="col-3 col-form-label">Tenure</label>
                                    <div class="col-3">
                                      <input type="text" class="form-control" id="tenure" name="tenure" />
									  <span class="input-group-addon">Months</span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="example-search-input" class="col-3 col-form-label">No. of Post</label>
                                    <div class="col-3">
                                        <input class="form-control" type="text" value="" id="post" name="post">
                                    </div>
                               </div>
                               <div class="form-group row">
                                    <button type="button" class="col-2" onclick="showOffers()">+ADD offers</button>
                                </div>
                                 <div id="displayoffers" style="display:none">
                                  <div class="offset-sm-11 col-sm-7">
                                    <i class="fa fa-times"></i> 
                                  </div>
                                   <div class="form-group row">
	                                    <label for="example-search-input" class="col-2 col-form-label">Offer Title*</label>
	                                    <div class="col-2">
	                                        <input type="text" class="form-control" id="offer_title" name="offer_title[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Discount(%)*</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="discount" name="discount[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Discount Amount</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="discount_amount" name="discount_amount[]" value=""/>
	                                    </div>
	                                </div>
	                                <div class="form-group row">
	                                    <label for="example-search-input" class="col-2 col-form-label">Description</label>
	                                    <div class="col-2">
	                                        <textarea class="form-control" id="description" class="description"></textarea>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Offer Type</label>
	                                    <div class="col-2">
	                                     <select class="form-control" id="offer" name="offer">
										  <option value="">Percentage</option>
										  <option value="">Discount</option>
										</select>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">Status</label>
	                                    <div class="col-2">
	                                     <select class="form-control" id="status" name="status">
										  <option value="">Active</option>
										  <option value="">Inactive</option>
										</select>
										</div>
	                                </div>
	                             </div>
                                <div class="offset-sm-5 col-sm-7">
                                     <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="previous2();">Previous</button>
                                        <button type="button" class="btn btn-info waves-effect waves-light m-t-10" id="next2" onclick="show2();">Next</button>
                                 </div>
                                </div>
                               </div>

                                <div id="vimessages3" class="tab-pane" aria-expanded="true">        
                                <input type="hidden" name="schedule_count" id="schedule_count" value="1"/>
	                                <div class="form-group row">
	                                    <label for="example-search-input" class="col-2 col-form-label">Milestone*</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">% of net payable</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="payable" name="payable[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-1 col-form-label">Amount</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="amount" name="amount[]" value=""/>
	                                    </div>
	                                     <i class="fa fa-times"></i>
	                                </div>
	                                <div class="form-group row">
	                                    <label for="example-search-input" class="col-2 col-form-label">Milestone*</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-2 col-form-label">% of net payable</label>
	                                    <div class="col-2">
	                                       <input type="text" class="form-control" id="payable" name="payable[]" value=""/>
	                                    </div>
	                                    <label for="example-search-input" class="col-1 col-form-label">Amount</label>
	                                    <div class="col-2">
	                                        <input type="text" class="form-control" id="amount" name="amount[]" value=""/>
	                                    </div>
	                                     <i class="fa fa-times"></i>
	                                </div>
	                                
	                                 
	                                <div class="offset-sm-9 col-sm-7">
                                       <a href="javascript:addMoreSchedule();"> <button type="button" class="">+ Add More Schedules</button></a>
                                    </div>
	                                <div class="offset-sm-5 col-sm-7">
                                        <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="previous3();">Previous</button>
                                        <button type="button" class="btn btn-info waves-effect waves-light m-t-10" id="next3" onclick="show3();">Next</button>
                                    </div>
                                </div>
                               <div id="vimessages4" class="tab-pane" aria-expanded="true">
	                              <div class="form-group row">
	                              <input type="hidden" name="doc_name[]" value="Agreement" />
                                    <label for="example-text-input" class="col-6 col-form-label">Agreement*</label>
                                  
                                      <div class="col-2">  <input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true"></i>--></div>
<!--                                       <div class="col-2"><i class="fa fa-download" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-eye" aria-hidden="true"></i></div> -->
                                  </div>
                                  <div class="form-group row">
                                  <input type="hidden" name="doc_name[]" value="Index 2" />
                                    <label for="example-text-input" class="col-6 col-form-label">Index 2*</label>
                                   
                                      <div class="col-2"> <input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true"></i>--></div>
<!--                                       <div class="col-2"><i class="fa fa-download" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-eye" aria-hidden="true"></i></div> -->
                                  </div>
                                  <div class="form-group row">
                                  <input type="hidden" name="doc_name[]" value="Receipts with Date and time and Name" />
                                    <label for="example-text-input" class="col-6 col-form-label">Receipts with Date & Time & Name</label>
                                      <div class="col-2"> <input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true"></i>--></div>
<!--                                       <div class="col-2"><i class="fa fa-download" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-eye" aria-hidden="true"></i></div> -->
                                  </div>
                                  <div class="form-group row">
                                  <input type="hidden" name="doc_name[]" value="Electrical and Plumbing lines map" />
                                    <label for="example-text-input" class="col-6 col-form-label">Electricals & Plumbing lines map</label>
                                    
                                      <div class="col-2"><input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true"></i>--></div>
<!--                                       <div class="col-2"><i class="fa fa-download" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-eye" aria-hidden="true"></i></div> -->
                                  </div>
                                  <div class="form-group row">
                                  <input type="hidden" name="doc_name[]" value="Possession grant letter" />
                                    <label for="example-text-input" class="col-6 col-form-label">Possession grant letter</label>
                                  
                                  <div class="col-2"><input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true"></i>--></div>
<!--                                       <div class="col-2"><i class="fa fa-upload" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-download" aria-hidden="true"></i></div> -->
<!--                                       <div class="col-2"><i class="fa fa-eye" aria-hidden="true"></i></div> -->
                                  </div>
                                  <div class="form-group row">
                                    <label for="example-text-input" class="col-6 col-form-label">Other Documents</label>
                                       
                                      <div class="col-2"><input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/></div>
                                      <div class="col-2"><input type="file" class="form-control" name="doc_url[]" /><!-- <i class="fa fa-upload" aria-hidden="true">--></div>
                                     
                                  </div>
	                             
	                             <div class="offset-sm-5 col-sm-7">
	                             <button type="button" class="btn btn-info waves-effect waves-light m-t-10" onclick="previous4();">Previous</button>
                                        <button type="submit" class="btn btn-info waves-effect waves-light m-t-10">SAVE</button>
                                 </div>
                                </div>
                                </div>
                                </form>
                        </div>

                        </div>
                    </div>
                </div>
               
            </div>
            <!-- /.container-fluid -->
             <div id="sidebar1"> 
	      		<%@include file="../partial/footer.jsp"%>
			</div> 
        
        </div>
        <!-- /#page-wrapper -->
    
    <!-- /#wrapper -->
    </div>
</body>
</html>
<script type="text/javascript">

function showOffers()
{
	$("#displayoffers").show(); 
}


$('#booking_date').datepicker({
	format: "dd MM yyyy"
});

$("#project_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/buildings/names/"+$("#project_id").val(),{ }, function(data){
		var html = '<option value="0">Select Building</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#building_id").html(html);
	},'json');
});
$("#building_id").change(function(){
	$.get("${baseUrl}/webapi/buyer/building/available/flat/names/"+$("#building_id").val(),{ }, function(data){
		var html = '<option value="0">Select Flat</option>';
		$(data).each(function(index){
			
			html = html + '<option value="'+data[index].id+'">'+data[index].name+'</option>';
		});
		$("#flat_id").html(html);
	},'json');
});
$('#addbuyer').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	project_id: {
            validators: {
                notEmpty: {
                    message: 'Please select project'
                }
            }
        },
        building_id: {
            validators: {
                notEmpty: {
                    message: 'Please select building'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Please select flat'
                }
            }
        },
        'buyer_name[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer Name is required and cannot be empty'
                }
            }
        },
        'contact[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer mobile is required and cannot be empty'
                }
            }
        },
        'pan[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer pancard is required and cannot be empty'
                }
            }
        },
        'address[]': {
            validators: {
                notEmpty: {
                    message: 'Permanent address is required and cannot be empty'
                }
            }
        },
        'photo[]': {
            validators: {
                notEmpty: {
                    message: 'Buyer photo is required and cannot be empty'
                }
            }
        },
        flat_id: {
            validators: {
                notEmpty: {
                    message: 'Please select flat'
                }
            }
        },
        booking_date: {
            validators: {
                notEmpty: {
                    message: 'Please select booking date'
                }
            }
        },
        base_rate: {
            validators: {
                notEmpty: {
                    message: 'Base rate required and can not be empty'
                }
            }
        },
        rise_rate: {
            validators: {
                notEmpty: {
                    message: 'Floor rise rate required and can not be empty'
                }
            }
        },
        amenity_rate: {
            validators: {
                notEmpty: {
                    message: 'Amenity facing rate required and can not be empty'
                }
            }
        },
        maintenance: {
            validators: {
                notEmpty: {
                    message: 'Maintenance charge required and can not be empty'
                }
            }
        },
        tenure: {
            validators: {
                notEmpty: {
                    message: 'Tennure required and can not be empty'
                }
            }
        },
        registration: {
            validators: {
                notEmpty: {
                    message: 'Registration fee required and can not be empty'
                }
            }
        },
        parking: {
            validators: {
                notEmpty: {
                    message: 'Parking rate required and can not be empty'
                }
            }
        },
        stamp_duty: {
            validators: {
                notEmpty: {
                    message: 'Stamp duty charges required and can not be empty'
                }
            }
        },
        tax: {
            validators: {
                notEmpty: {
                    message: 'Tax required and can not be empty'
                }
            }
        },
        vat: {
            validators: {
                notEmpty: {
                    message: 'Vat required and can not be empty'
                }
            }
        },
        
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addBuyer1();
});

function addBuyer1() {
	//alert("inside add");
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/buyer/updatebuyer',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addbuyer').ajaxSubmit(options);
}

function showAddRequest(formData, jqForm, options){
	$("#response").hide();
   	var queryString = $.param(formData);
	return true;
}
   	
function showAddResponse(resp, statusText, xhr, $form){
	if(resp.status == '0') {
		$("#response").removeClass('alert-success');
       	$("#response").addClass('alert-danger');
		$("#response").html(resp.message);
		$("#response").show();
  	} else {
  		$("#response").removeClass('alert-danger');
        $("#response").addClass('alert-success');
        $("#response").html(resp.message);
        $("#response").show();
        alert(resp.message);
        window.location.href = "${baseUrl}/builder/buyer/new.jsp";
  	}
}

function addMoreBuyers() {
	var buyers = parseInt($("#buyer_count").val());
	buyers++;
	
	var html = '<div class="tab-content" id="buyer-'+buyers+'"><hr>'
		+'<span class="pull-right">	<a href="javascript:removeBuyer('+buyers+');" class="btn btn-danger btn-xs">x</a></span><br>'
		+'<div class="col-12">'
		+'<div class="form-group row">'
			+'<label for="example-text-input" class="col-3 col-form-label">Buyer Name</label>'
				+'<div class="col-3">'
					+' <input class="form-control" type="text" id="buyer_name" name="buyer_name[]" value="">'
				+'</div>'
				
		
				+'<label for="example-text-input" class="col-3 col-form-label">Contact</label>'
				+'<div class="col-3">'
					+'<input class="form-control" type="text" id="contact" name="contact[]" value="">'
				+'</div>'
				+'</div>'
				
				+'<div class="form-group row">'
				
				+'<label for="example-text-input" class="col-3 col-form-label">Email</label>'
					+'<div class="col-3">'
						+' <input class="form-control" type="text" id="email" name="email[]" value="">'
					+'</div>'
					
			
					+'<label for="example-text-input" class="col-3 col-form-label">PAN</label>'
					+'<div class="col-3">'
						+'<input class="form-control" type="text" id="pan" name="pan[]" value="">'
					+'</div>'
					+'</div>'
					
					+'<div class="form-group row">'
					
					+'<label for="example-text-input" class="col-3 col-form-label"> Perm. Address</label>'
						+'<div class="col-3">'
							+' <input class="form-control" type="text" id="address" name="address[]" value="">'
						+'</div>'
						
				
						+'<label for="example-text-input" class="col-3 col-form-label">Owner *</label>'
						+'<div class="col-3">'
							+'<select name="is_primary[]" id="is_primary" class="form-control">'
                       		+'<option value="">Select Owner</option>'
                     		+'<option value="0" selected>Co-Owner</option>'
                      		+'<option value="1">Owner</option>'
				          +'</select>'
						+'</div>'
						+'</div>'
						
					
			 			+'<div class="form-group row" id="error-project_type">'
			 				+'<label class="col-12 col-form-label">Documents <span class="text-danger">*</span></label>'
			 					+'<div class="col-3">'
			 						+'<input type="checkbox" name="document_pan[]" value="1" /> PAN Card'
			 					+'</div>'
			 					+'<div class="col-3">'
			 						+'<input type="checkbox" name="document_aadhar[]" value="2" /> Aadhar Card' 
			 					+'</div>'
			 					+'<div class="col-3">'
			 						+'<input type="checkbox" name="document_passport[]" value="3" /> Passport' 
			 					+'</div>'
			 					+'<div class="col-3">'
			 						+'<input type="checkbox" name="document_rra[]" value="4" /> Registered Rent Agreement' 
			 					+'</div>'
			 					+'<div class="col-3">'
			 						+'<input type="checkbox" name="document_voterid[]" value="5" /> Vote ID' 
			 					+'</div>'
			 			
			 				+'<div class="messageContainer"></div>'
			 			+'</div>'
				
	+'</div>'
	+'</div>';

	
	$("#vimessages").append(html);
	$("#buyer_count").val(buyers);
}
function removeBuyer(id) {
	$("#buyer-"+id).remove();
}

function addMoreSchedule() {
	var schedule_count = parseInt($("#schedule_count").val());
	schedule_count++;
	alert(schedule_count);
	var html = '<div class="tab-content" id="schedule-'+schedule_count+'">'
				+'<hr/>'
				+'<span class="pull-right">	<a href="javascript:removeSchedule('+schedule_count+');" class="btn btn-danger btn-xs">x</a></span><br>'
				+'<div class="col-12">'
				+'<div class="form-group row">'
				+'<label for="example-search-input" class="col-2 col-form-label">Milestone</label>'
				+'<div class="col-2">'
				+'<input type="text" class="form-control" id="schedule" name="schedule[]" value=""/>'
				+'</div>'
				+'<label for="example-search-input" class="col-2 col-form-label">% of Net Payable</label>'
				+'<div class="col-2">'
				+'<input type="text" class="form-control"  id="payable" name="payable[]" value=""/>'
				+'</div>'
				+'<label for="example-search-input" class="col-2 col-form-label">Amount</label>'
				+'<div class="col-2">'
				+'<input type="text" class="form-control" id="amount" name="amount[]" value=""/>'
				+'</div>'
				+'</div>'
			+'</div>'
				
			+'</div>';
	$("#vimessages3").append(html);
	$("#schedule_count").val(schedule_count);
}
function removeSchedule(id) {
	$("#schedule-"+id).remove();
}

function addMoreDoc() {
	var doc_count = parseInt($("#doc_count").val());
	doc_count++;
	var html = '<div class="col-lg-12 margin-bottom-5" style="margin-bottom:5px;" id="doc-'+doc_count+'">'
			  +'<div class="form-group" id="error-offer_title">'
			  +'<label class="control-label col-sm-5">Other Documents </label>'
			  +'<div class="col-sm-3">'
			  +'<input type="text" name="doc_name[]" class="form-control" value="" placeholder="Enter Document Name"/>'
			  +'</div>'
			  +'<div class="col-sm-3">'
			  +'<input type="file" class="form-control" name="doc_url[]" />'
			  +'</div>'
			  +'<div class="col-sm-1"><a href="javascript:removeDoc('+doc_count+');" class="btn btn-danger btn-sm">X</a></div>'
			  +'<div class="messageContainer col-sm-offset-5"></div>'
			  +'</div>'
			  +'</div>';
	$("#doc_area").append(html);
	$("#doc_count").val(doc_count);
}

function removeDoc(id) {
	$("#doc-"+id).remove();
}

function show()
{
	$("#vimessages1").show();
	$("#111").hide();
	
}

function show1()
{
	$("#vimessages2").show();
	$("#vimessages1").hide();
	
}

function previous1()
{
	$("#vimessages1").hide();
	$("#111").show();
}


function show2()
{
	$("#vimessages3").show();
	$("#vimessages2").hide();
	
}
function previous2()
{
	$("#vimessages2").hide();
	$("#vimessages1").show();
	
}

function show3()
{
	$("#vimessages4").show();
	$("#vimessages3").hide();
	
}
function previous3()
{
	$("#vimessages3").hide();
	$("#vimessages2").show();
	
}
function previous4()
{
	$("#vimessages4").hide();
	$("#vimessages3").show();
	
}
</script>