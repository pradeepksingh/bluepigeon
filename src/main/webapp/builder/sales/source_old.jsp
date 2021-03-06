<%@page import="org.bluepigeon.admin.model.Builder"%>
<%@page import="org.bluepigeon.admin.dao.LocalityNamesImp"%>
<%@page import="org.bluepigeon.admin.model.Locality"%>
<%@page import="java.util.List"%>
<%
int p_user_id = 0;
List<Locality> localities = new LocalityNamesImp().getLocalityActiveList();
session = request.getSession(false);
BuilderEmployee builder = new BuilderEmployee();
if(session!=null)
{
	if(session.getAttribute("ubname") != null)
	{
		builder  = (BuilderEmployee)session.getAttribute("ubname");
		p_user_id = builder.getBuilder().getId();
	}
}
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
  	<script src="../js/jquery.form.js"></script>
	<script type="text/javascript">
	    $('input[type=checkbox]').click(function(){
		    if($(this).is(':checked')){
		          var tb = $('<input type=text />');    
		          $(this).after(tb)  ;
		    }
		    else if($(this).siblings('input[type=text]').length>0){
		        $(this).siblings('input[type=text]').remove();
		    }
		});
	</script>
</head>

<body class="fix-sidebar">
    <!-- Preloader -->
    <div class="preloader" style="display: none;">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <div id="header">
        	<%@include file="../partial/header.jsp"%>
        </div>
    	<div id="sidebar1"> 
       		<%@include file="../partial/sidebar.jsp"%>
       	</div>
        <div id="page-wrapper" style="min-height: 2038px;">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">Add New Source</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
       					<div class="white-box">
							
                                <div id="vimessages" class="tab-pane active" aria-expanded="false">
	                                <div class="col-lg-12">
	                                	<form id="addsource" name="addsource" method="post"  action="" enctype="multipart/form-data">
			                                <input type="hidden" value="<%out.print(p_user_id); %>" name="builder_id" id="builder_id" />
			                                <div class="form-group row">
			                                    <label for="example-text-input" class="col-lg-3 col-form-label">Source Name <span class='text-danger'>*</span></label>
			                                    <div class="col-lg-5">
			                                        <input class="form-control" type="text" id="name" name="name">
			                                    </div>
			                                    <div class="messageContainer col-lg-4"></div>
			                                </div>
			                                <div class="offset-sm-5 col-sm-7">
			                                	<button type="submit" name="addsource" class="btn btn-info waves-effect waves-light m-t-10">Submit</button>
			                                 </div>
	                               		</form>
	                            	</div>
                         		</div>
                     	</div>
                  	</div>
               	</div>
          	</div>
      	</div>
      	<div id="sidebar1"> 
	       <%@include file="../partial/footer.jsp"%>
		</div> 
  	</div>
</body>
</html>
<script type="text/javascript">
$('#addsource').bootstrapValidator({
	container: function($field, validator) {
		return $field.parent().next('.messageContainer');
   	},
    feedbackIcons: {
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: ':disabled',
    fields: {
    	
        name: {
            validators: {
                notEmpty: {
                    message: 'Source Name is required and cannot be empty'
                }
            }
        },
      
        locality_id: {
            validators: {
                notEmpty: {
                    message: 'Locality Name is required and cannot be empty'
                }
            }
        }
    }
}).on('success.form.bv', function(event,data) {
	// Prevent form submission
	event.preventDefault();
	addSource();
});

function addSource() {
	var options = {
	 		target : '#response', 
	 		beforeSubmit : showAddRequest,
	 		success :  showAddResponse,
	 		url : '${baseUrl}/webapi/project/source/add',
	 		semantic : true,
	 		dataType : 'json'
	 	};
   	$('#addsource').ajaxSubmit(options);
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
        window.location.href = "${baseUrl}/builder/sales/source-list.jsp";
  	}
}

</script>