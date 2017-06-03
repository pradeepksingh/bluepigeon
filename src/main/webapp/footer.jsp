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
<%-- <script src="${baseUrl}/js/ace-elements.min.js"></script> --%>
<%-- <script src="${baseUrl}/js/ace.min.js"></script> --%>
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
</script>