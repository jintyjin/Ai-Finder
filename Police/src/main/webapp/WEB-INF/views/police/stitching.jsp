<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="./resources/css/viewer.css" />
<link rel="stylesheet" href="./resources/css/viewer.min.css" />
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script src="./resources/js/viewer.js"></script>
<script src="./resources/js/viewer.min.js"></script>
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
ul {
	margin:0;
	padding:0;
}
li {
	margin:0;
	padding:0;
}
img {
	margin:0;
	padding:0;
}
.viewer-prev {
	display:none;
}
.viewer-next {
	display:none;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
$('#images').ready(function() {
	var viewer = new Viewer(document.getElementById('images'), {
		navbar : false,
		url(image) {
			return image.src.replace(image.src, '/police/webserver/image/case' + '${case_idx}' + '/stitching.jpg');
		}
	});
	$('img').width($('li').width());
	$('img').height($('li').height());
	$('img').attr('src', '/police/webserver/image/case' + '${case_idx}' + '/stitching.jpg');
	$('img').trigger('click');
	$('.viewer-button').click(function() {
		window.close(); // 일반적인 현재 창 닫기	
		window.open('about:blank','_self').self.close();  // IE에서 묻지 않고 창 닫기
	});
	$(window).click(function(event) {
		//alert($(event.target));
		if ($(event.target).is('.viewer-canvas')) {
			window.close(); // 일반적인 현재 창 닫기	
			window.open('about:blank','_self').self.close();  // IE에서 묻지 않고 창 닫기
		}
	});
});
</script>
<body>
<div style="width:100%; height:100%; background-color:#252525;" id="images">
	<!-- <ul id="images" style="margin:0; padding:0; width:100%; height:100%;">
	  <li style="width:100%; height:100%;"><img src="" alt="Alt 1" ></li>
	</ul> -->
	<img src="" alt="Alt 1" width="0px" height="0px" >
</div>
</body>
</html>