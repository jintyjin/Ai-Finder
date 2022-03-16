<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>폴-파인더</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script type="text/javascript" src="./resources/func/exif.js"></script>
<style>
button:focus {
	outline:none;
}
input:focus {
	outline:none;
}
button:hover {
	color:steelblue;
}
@media (min-width:992px) {
	html, body {
		width:100%;
		height:100%;
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		color:white;
		background-color:lightgray;
		padding-top:80px;
	}
	.container {
		padding:0;
	}
	#title {
		margin:0;
		background-color:mediumblue;
		font-size:25px;
		padding-top:5px;
		padding-bottom:5px;
	}
	#content {
		margin:0;
	}
}
</style>
</head>
<body>
	<div class="container">
		<div class="container-fluid" id="title">
			<div class="col-xs-1 col-md-1">asdfas
			
			</div>
			<div class="col-xs-11 col-md-11">방만들기
			
			</div>
		</div>
		<div class="container-fluid" id="content">
		asdfasdf
		</div>
	</div>

</body>
</html>