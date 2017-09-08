
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="../plugins/images/favicon.png">
    <title>Blue Pigeon</title>
    <!-- Bootstrap Core CSS -->
    <link href="../bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../plugins/bower_components/bootstrap-extension/css/bootstrap-extension.css" rel="stylesheet">
   <!-- Menu CSS -->
    <link href="../plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- color CSS -->
    <link rel="stylesheet" type="text/css" href="../css/custom10.css">
   
      <link rel="stylesheet" type="text/css" href="../css/jquery.multiselect.css" />
    <link href="../plugins/bower_components/custom-select/custom-select.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/bower_components/bootstrap-select/bootstrap-select.min.css" rel="stylesheet" />
    <!-- jQuery -->
    <script src="../plugins/bower_components/jquery/dist/jquery.min.js"></script>
       <script type="text/javascript" src="../js/jquery.multiselect.js"></script>
  
        
		<script type="text/javascript">
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-2').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-3').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-4').multiselect();
// 		    });
// 		    $(document).ready(function() {
// 		        $('#multiple-checkboxes-5').multiselect();
// 		    });
// 		    $select_project = $("#multiple-checkboxes-3").selectize({
// 		    	persist: false,
// 		    	 onChange: function(value) {
// 		    		alert(value);
// 		    	 },
// 		    	 onDropdownOpen: function(value){
// 		        	 var obj = $(this);
// 		    		var textClear =	 $("#multiple-checkboxes-3 :selected").text();
// 		        	 if(textClear.trim() == "Enter Project Name"){
// 		        		 obj[0].setValue("");
// 		        	 }
// 		         }
// 		    });

		    //select_project = $select_project[0].selectize;
		    
		   
		</script>
		<script type="text/javascript">
// 		$("#select").click(function(){
// 		    $("li").addClass("active");
// 		});
		</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Top Navigation -->
        <div id="header">
         <%@include file="../partial/header.jsp"%>
        </div>
        <!-- End Top Navigation -->
        <!-- Left navbar-header -->
        <div id="sidebar1"> 
        	<%@include file="../partial/sidebar.jsp"%>
        </div>
        <!-- Left navbar-header end -->
        <!-- Page Content -->
        <div id="page-wrapper" style="min-height: 2038px;">
           <div class="container-fluid addlead">
               <!-- /.row -->
	            <h1>Add Lead</h1>
               <!-- row -->
               <div class="white-box">
                 <div class="row bg11">
                   <form class="addlead1">
                  
                     <div class="col-md-6 col-sm-6 col-xs-12">
                         <div class="form-group row">
							<label for="example-text-input" class="col-5 col-form-label"> Name</label>
							  <div class="col-7">
								 <input class="form-control" type="text" value="" id=""  placeholder="">
							  </div>
						  </div>
						  <div class="form-group row">
							 <label for="example-search-input" class="col-5 col-form-label">Email ID</label>
								<div class="col-7">
								   <input class="form-control" type="text" value="" id="" placeholder="">
								 </div>
						    </div>
							<div class="form-group row">
							   <label for="example-search-input" class="col-5 col-form-label">Configuration</label>
								  <div class="col-7">
								      <select id="multiple-checkboxes-3" name="multiple-checkboxes-3" multiple>
								        <option value="php">PHP</option>
								        <option value="javascript">JavaScript</option>
								        <option value="java">Java</option>
								        <option value="sql" >SQL</option>
								        <option value="jquery" >Jquery</option>
								        <option value=".net">.Net</option>
								     </select>
								  </div>
							 </div>
                            <div class="form-group row">
					           <label for="example-tel-input" class="col-5 col-form-label">Source</label>
						         <div class="col-7">
							        <select class="selectpicker" data-style="form-control">
			                          <option>All Floor</option>
			                          <option>Floor No-1</option>
			                          <option>Floor No-2</option>
			                          <option>Floor No-3</option>
			                          <option>Floor No-4</option>
			                        </select>
							     </div>
						    </div>
				       </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                       <div class="form-group row">
							<label for="example-text-input" class="col-5 col-form-label"> Phone No.</label>
							  <div class="col-7">
								 <input class="form-control" type="text" value="" id=""  placeholder="">
							  </div>
						  </div>
						  <div class="form-group row">
							 <label for="example-search-input" class="col-5 col-form-label">Interested Project</label>
								<div class="col-7">
								   <select id="multiple-checkboxes-2"  name="multipule-checkboxes-2" multiple>
								        <option value="php">PHP</option>
								        <option value="javascript">JavaScript</option>
								        <option value="java">Java</option>
								        <option value="sql">SQL</option>
								        <option value="jquery">Jquery</option>
								        <option value=".net">.Net</option>
								     </select>
								 </div>
						    </div>
							<div class="form-group row">
							   <label for="example-search-input" class="col-5 col-form-label">Budget</label>
								  <div class="col-7">
								    <select class="selectpicker" data-style="form-control">
			                          <option>All Floor</option>
			                          <option>Floor No-1</option>
			                          <option>Floor No-2</option>
			                          <option>Floor No-3</option>
			                          <option>Floor No-4</option>
			                        </select>
								   </div>
							 </div>
						</div>
						<div class="center bcenter">
					  	   <button type="button" id="save" class="button1">Save</button>
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
  </body>
</html>
<script>
//$("#multiple-checkboxes-3").selectize();
// $select_project = $("#multiple-checkboxes-3").selectize({
// 	persist: false,
// 	 onChange: function(value) {
// 		alert(value);
// 	 },
// 	 onDropdownOpen: function(value){
//     	 var obj = $(this);
// 		var textClear =	 $("#multiple-checkboxes-3 :selected").text();
//     	 if(textClear.trim() == "Enter Configuration Name"){
//     		 obj[0].setValue("");
//     	 }
//      }
// });

$('#multiple-checkboxes-3').multiselect({
    columns: 1,
    placeholder: 'Select Configuration',
    search: true,
    selectAll: true
});
//$('#multiple-checkboxes-3').style.margin-left="5px";
//$('#multiple-checkboxes-3').css({"padding-left":"10px !important"});

$('#multiple-checkboxes-2').multiselect({
    columns: 1,
    placeholder: 'Select Project',
    search: true,
    selectAll: true
});
$("#save").click(function(){
// 	var projects = [];
// 	var  projectList = document.getElementById("#multiple-checkboxes-2");
	
// 	for(var i=0;i<projectList.options.length;i++){
// 		if(projectList[i].options[i].selected){
// 			alert("Value :: "+projectList[i].options[i].value);
// 			projects.push(projectList[i].options[i].value);
// 		}
// 	}
  alert($("#multiple-checkboxes-2").val());
  $("#multiple-checkboxes-2  option:selected").each(function(){
	  alert($(this).val());
  })
})

</script>


