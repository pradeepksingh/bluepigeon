<div class="footer">
	<div class="footer-inner">
		<div class="footer-content">
			<span class="bigger-120"> <span class="blue bolder">Blue</span>
				Pigeon &copy; 2017-2018
			</span> 
		</div>
	</div>
</div>

<a href="#" id="btn-scroll-up"
	class="btn-scroll-up btn btn-sm btn-inverse"> <i
	class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>


<!--[if !IE]> -->
<script src="${baseUrl}/js/jquery-2.1.4.min.js"></script>
<!-- <![endif]-->
<!--[if IE]>
<script src="${baseUrl}/js/jquery-1.11.3.min.js"></script>
<![endif]-->
<script type="text/javascript">
	if ('ontouchstart' in document.documentElement)
		document.write("<script src='${blueUrl}/js/jquery.mobile.custom.min.js'>" + "<"+"/script>");
</script>
<script src="${baseUrl}/js/bootstrap.min.js"></script>
<script src="${baseUrl}/js/dataTables.select.min.js"></script>
<script src="${baseUrl}/js/bootstrap-datepicker.min.js"></script>
<script src="${baseUrl}/js/grid.locale-en.js"></script>
<script src="${baseUrl}/js/ace-elements.min.js"></script>
<script src="${baseUrl}/js/ace.min.js"></script>
<script>
$(function() {
	var main_url = window.location.href;
	main_urls = main_url.split("?");
	var url_parts = main_urls[0].split("/");
	var target_page = url_parts[url_parts.length - 1];
	if(target_page == "edit.jsp" || target_page == "new.jsp") {
		url_parts[url_parts.length - 1] = 'list.jsp';
	}
    var pgurl = url_parts.join("/");
    
    $("ul.submenu li a").each(function(){
   	  var target_li = $(this).closest("li");
         if($(this).attr("href") == pgurl || $(this).attr("href") == '' ) {
         	setTimeout(function(){
        		slideToTop(target_li);
        	}, 1000);
       	  	target_li.addClass("active");
       	  	var tagetul = target_li.closest("ul");
   	  	  	if(tagetul.closest("li")) {
   	  			tagetul.closest("li").addClass("open");
   	  	  	}
         }
    });
});

function slideToTop(input) {
	$("#sidebar").animate({
 	    scrollTop: $(input).offset().top
 	},1500);
}
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