<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/viewer.css" />
<link rel="stylesheet" href="./resources/css/viewer.min.css" />
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/viewer.js"></script>
<script src="./resources/js/viewer.min.js"></script>
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
	font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
	color:white;
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
.viewer-button {
	display:none;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
$('#images').ready(function() {
	var jsonUrl = "/police/selectRoi_image";
	
	var jsonObject = new Object();
	
	jsonObject.case_idx = parseInt('${case_idx}');
	jsonObject.gallery_roinum = parseInt('${roiNum}');
	
	var jsonData = JSON.stringify(jsonObject);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
        async: false,
		success: function (data) {
			var src = data.gallery_imgname;
			var x = data.gallery_x;
			var y = data.gallery_y;
			var width = data.gallery_width;
			var height = data.gallery_height;
			
			var viewer = new Viewer(document.getElementById('images'), {
				navbar : false,
				toolbar : false,
				url(image) {
					//return image.src.replace(image.src, JSON.parse(get('totalImage'))['${roiNum}'].img_name.substring(0, JSON.parse(get('totalImage'))['${roiNum}'].img_name.lastIndexOf('.')) + '_roi.jpg');
					return image.src.replace(image.src, src.substring(0, src.lastIndexOf('.')) + '_roi.jpg');
				},
				viewed(image) {
					/* viewer.move(-780, 0); 
					viewer.zoom(1);
					viewer.moveTo(0, 0);*/
					viewer.zoomTo(1);
					viewer.moveTo((window.innerWidth / 2) - x - (width / 2), (window.innerHeight / 2) - y - (height / 2));
					/* viewer.moveTo(window.innerWidth / 2, '-' + window.innerHeight / 2); */
				}
			});
//			$('img').attr('src', JSON.parse(get('totalImage'))['${roiNum}'].img_name.substring(0, JSON.parse(get('totalImage'))['${roiNum}'].img_name.lastIndexOf('.')) + '_roi.jpg');
//			$('img').attr('src', JSON.parse(get('totalImage'))['${roiNum}'].img_name.substring(0, JSON.parse(get('totalImage'))['${roiNum}'].img_name.lastIndexOf('.')) + '.jpg');
			$('img').width($('li').width());
			$('img').height($('li').height());
			$('img').attr('src', src.substring(0, src.lastIndexOf('.')) + '_roi.jpg');
			$('img').trigger('click');
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	}); 
	
});
$(window).resize(function() {	
	$('img').width($('li').width());
	$('img').height($('li').height());
});
</script>
<body>
<div style="width:100%; height:100%;">
	<ul id="images" style="margin:0; padding:0; width:100%; height:100%;">
	  <li style="width:100%; height:100%;"><img src="" alt="Alt 1" width="0px" height="0px" ></li>
	</ul>
</div>
</body>
</html>