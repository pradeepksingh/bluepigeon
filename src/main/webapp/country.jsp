<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Country details</title>
<script language="javascript" type="text/javascript">
function toggle_visablity(object, button)
{
	object=document.getElementById(object);
	button=document.getElementById(button);
	
	if(button.innerHTML == '+')
		{button.innerHTML = '-';}
	else
		{button.innerHTML = '+';}
	
	var table =	'<form name="f1"><table  bordercolor="blue" cellspacing="0" width="300">'+
					'<tr>'+
						'<td>Enter new street name</td>'+'<td><input type="text" id="country" name="new_create"/></td>'+
					'</tr>'+'<tr><td><input type="button"name="bt" value="CREATE" onclick="showinput()" /></td></tr>'
				'</table></form>';
		
		if(object.innerHTML == '')
			{object.innerHTML = table;}
		else
			{object.innerHTML = '';}
 
}
function showinput(){
	var country=document.f1.new_create.value;
	//var country = $(country).attr('id');
	alert(country);
	$.post("webapi/country/create",{country : country},function(data)
	{
		getCountryList(data);
	}		
	);
	
	function getCountryList(data)
	{
		
					var countrylist = "";
					$("#viewcountry").empty();
					var length = data.length;
					for(var i=0;i< length; i++)
						{
						 countrylist =+ '<tr>'+
							'<td>'+ data[i].coutry_name+'</td>'+'</tr>';
						  
						}
					//countrylist =+ "</table>";
					$('#viewcountry').html(countrylist);
	}
	
}
</script>

</head>
<body>






<form action="" method="post" id="viewcountry">
<table  id="viewcountry" ></table>
</form>
<table >
<tr><td></td></table>
 <span onMouseOver="this.style.cursor='pointer'" id="toggle1" onClick="toggle_visablity('table1', 'toggle1');">+</span>Create new Street
<div id="table1"></div>
<script language="javascript" type="text/javascript">
$("document").ready(function (){
	
	$.post("webapi/country/view",{},function(data)
	{
		var countrylist = "<table>";
		$("#viewcountry").empty();
		var length = data.length;
		for(var i=0;i< length; i++)
			{
			 countrylist =+ '<tr>'+
				'<td>'+ data[i].coutry_name+'</td>'+'</tr>';
			  
			}
		countrylist =+ "</table>";
		$('#viewcountry').html(countrylist);
	});
	
});
</script>

</body>
</html>