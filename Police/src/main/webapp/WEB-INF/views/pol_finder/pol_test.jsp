<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3&libraries=services,clusterer,drawing"></script>
<style>
html, body {
	width:100%;
	height:100%;
}
</style>
<script type="text/javascript">
var trackerId = 0;
var geocoder;
var theUser = {};
var map = {};
var drawingMapContainer;
var drawingMap;
var circle1;
var marker1;
function initialize() {
	if (navigator.geolocation){
		var gps = navigator.geolocation;
		gps.getCurrentPosition(function(pos) {
			var latLng = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);
			drawingMapContainer = document.getElementById('map_canvas');
		    drawingMap = { 
		        center: latLng, // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			drawingMap = new kakao.maps.Map(drawingMapContainer, drawingMap);

			var circle1 = new kakao.maps.Circle({
				center : latLng,  // 원의 중심좌표 입니다 
				radius: 3, // 미터 단위의 원의 반지름입니다 
				strokeWeight: 2, // 선의 두께입니다 
				strokeColor: 'white', // 선의 색깔입니다
				strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle: 'line', // 선의 스타일 입니다
				fillColor: 'red', // 채우기 색깔입니다
				fillOpacity: 0.5  // 채우기 불투명도 입니다   
			});

			marker1 = new kakao.maps.Marker({
			    position: latLng
			});

			if (pos.coords.accuracy < 10) {
				circle1.setMap(drawingMap);
				marker1.setMap(drawingMap);
			}
			$('#text').text('시작좌표 : ' + latLng + ' / ' + '오차범위 : ' + Math.round(pos.coords.accuracy) + ' m');
		});
	}
}

function checkGPS() {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    
	if (navigator.geolocation){
		var gps = navigator.geolocation;
		gps.watchPosition(function(pos) {
			var latLng = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

			if (pos.coords.accuracy < 10) {
				marker1.setPosition(latLng);
			}
			$('#text1').text('간략 좌표 : ' + latLng + ' / ' + '오차범위 : ' + Math.round(pos.coords.accuracy) + ' m');
		}, function error(err) {
			  console.warn('ERROR(' + err.code + '): ' + err.message);
		}, {
			enableHighAccuracy: true
		});
		gps.watchPosition(function(pos) {
			var latLng = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

			var circle2 = new kakao.maps.Circle({
				center : latLng,  // 원의 중심좌표 입니다 
				radius: 3, // 미터 단위의 원의 반지름입니다 
				strokeWeight: 2, // 선의 두께입니다 
				strokeColor: 'white', // 선의 색깔입니다
				strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle: 'line', // 선의 스타일 입니다
				fillColor: 'red', // 채우기 색깔입니다
				fillOpacity: 0.5  // 채우기 불투명도 입니다   
			});
			
			if (pos.coords.accuracy < 10) {
				circle2.setMap(drawingMap);
			}
			$('#text2').text('상세 좌표 : ' + latLng + ' / ' + '오차범위 : ' + Math.round(pos.coords.accuracy) + ' m');
		});
	}
}


</script> 
</head> 

<body style="margin:0px; padding:0px;" onload="initialize();"> 
<div id="superbar"> 
	<span class="msg">Current location: 
		<span id="location"></span>
	</span>
	<input type="button" value="check your gps!" onclick="checkGPS()"/>
	<div id="text"></div>
	<div id="text1"></div>
	<div id="text2"></div>
</div>
<div id="map_canvas" style="width:100%; height:90%; float:left; border: 1px solid black;">
</div> 
</body> 
</html>