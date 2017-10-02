<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseUrl" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<footer class="footer text-center"> 2017 &copy; Blue Pigeon</footer>
<%-- <script src="${baseUrl}/builder/bootstrap/dist/js/tether.min.js"></script> --%>
<%-- <script src="${baseUrl}/builder/bootstrap/dist/js/bootstrap.min.js"></script> --%>
<script src="${baseUrl}/builder/plugins/bower_components/bootstrap-extension/js/bootstrap-extension.min.js"></script>
<!-- Menu Plugin JavaScript -->
<script src="${baseUrl}/builder/plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js"></script>
<!--slimscroll JavaScript -->
<script src="${baseUrl}/builder/js/jquery.slimscroll.js"></script>
<!--Wave Effects -->
<%-- <script src="${baseUrl}/builder/js/waves.js"></script> --%>
<!-- Custom Theme JavaScript -->
<%-- <script src="${baseUrl}/builder/js/custom.min.js"></script> --%>
<!--Morris JavaScript -->
<%-- <script src="${baseUrl}/builder/plugins/bower_components/datatables/jquery.dataTables.min.js"></script> --%>
 <!-- Footable -->
<%-- <script src="${baseUrl}/builder/plugins/bower_components/footable/js/footable.all.min.js"></script> --%>
<script src="${baseUrl}/builder/plugins/bower_components/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
<!--FooTable init-->
<%-- <script src="${baseUrl}/builder/js/footable-init.js"></script> --%>
<!--Style Switcher -->
<%-- <script src="${baseUrl}/builder/plugins/bower_components/styleswitcher/jQuery.style.switcher.js"></script> --%>
<%-- <script src="${baseUrl}/builder/plugins/bower_components/raphael/raphael-min.js"></script> --%>
<script>
function ajaxindicatorstart(text)
{
	if(jQuery('body').find('#resultLoading').attr('id') != 'resultLoading'){
	jQuery('body').append('<div id="resultLoading" style="display:none"><div><i class="fa fa-spinner spin fa-5x"></i><div>'+text+'</div></div><div class="bg"></div></div>');
	}

	jQuery('#resultLoading').css({
		'width':'100%',
		'height':'100%',
		'position':'fixed',
		'z-index':'10000000',
		'top':'0',
		'left':'0',
		'right':'0',
		'bottom':'0',
		'margin':'auto'
	});

	jQuery('#resultLoading .bg').css({
		'background':'#000000',
		'opacity':'0.7',
		'width':'100%',
		'height':'100%',
		'position':'absolute',
		'top':'0'
	});

	jQuery('#resultLoading>div:first').css({
		'width': '250px',
		'height':'75px',
		'text-align': 'center',
		'position': 'fixed',
		'top':'0',
		'left':'0',
		'right':'0',
		'bottom':'0',
		'margin':'auto',
		'font-size':'16px',
		'z-index':'10',
		'color':'#ffffff'

	});

    jQuery('#resultLoading .bg').height('100%');
       jQuery('#resultLoading').fadeIn(300);
    jQuery('body').css('cursor', 'wait');
}
function ajaxindicatorstop()
{
    jQuery('#resultLoading .bg').height('100%');
       jQuery('#resultLoading').fadeOut(300);
    jQuery('body').css('cursor', 'default');
}


</script>