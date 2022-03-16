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
		        center: latLng, // ������ �߽���ǥ
		        level: 3 // ������ Ȯ�� ����
		    };

			// ������ ǥ���� div��  ���� �ɼ�����  ������ �����մϴ�
			drawingMap = new kakao.maps.Map(drawingMapContainer, drawingMap);

			var circle1 = new kakao.maps.Circle({
				center : latLng,  // ���� �߽���ǥ �Դϴ� 
				radius: 3, // ���� ������ ���� �������Դϴ� 
				strokeWeight: 2, // ���� �β��Դϴ� 
				strokeColor: 'white', // ���� �����Դϴ�
				strokeOpacity: 1, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
				strokeStyle: 'line', // ���� ��Ÿ�� �Դϴ�
				fillColor: 'red', // ä��� �����Դϴ�
				fillOpacity: 0.5  // ä��� ������ �Դϴ�   
			});

			marker1 = new kakao.maps.Marker({
			    position: latLng
			});

			if (pos.coords.accuracy < 10) {
				circle1.setMap(drawingMap);
				marker1.setMap(drawingMap);
			}
			$('#text').text('������ǥ : ' + latLng + ' / ' + '�������� : ' + Math.round(pos.coords.accuracy) + ' m');
		});
	}
}

function checkGPS() {
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // ��Ŀ�̹����� �ּ��Դϴ�    
    imageSize = new kakao.maps.Size(64, 69), // ��Ŀ�̹����� ũ���Դϴ�
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // ��Ŀ�̹����� �ɼ��Դϴ�. ��Ŀ�� ��ǥ�� ��ġ��ų �̹��� �ȿ����� ��ǥ�� �����մϴ�.
    
	if (navigator.geolocation){
		var gps = navigator.geolocation;
		gps.watchPosition(function(pos) {
			var latLng = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

			if (pos.coords.accuracy < 10) {
				marker1.setPosition(latLng);
			}
			$('#text1').text('���� ��ǥ : ' + latLng + ' / ' + '�������� : ' + Math.round(pos.coords.accuracy) + ' m');
		}, function error(err) {
			  console.warn('ERROR(' + err.code + '): ' + err.message);
		}, {
			enableHighAccuracy: true
		});
		gps.watchPosition(function(pos) {
			var latLng = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

			var circle2 = new kakao.maps.Circle({
				center : latLng,  // ���� �߽���ǥ �Դϴ� 
				radius: 3, // ���� ������ ���� �������Դϴ� 
				strokeWeight: 2, // ���� �β��Դϴ� 
				strokeColor: 'white', // ���� �����Դϴ�
				strokeOpacity: 1, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
				strokeStyle: 'line', // ���� ��Ÿ�� �Դϴ�
				fillColor: 'red', // ä��� �����Դϴ�
				fillOpacity: 0.5  // ä��� ������ �Դϴ�   
			});
			
			if (pos.coords.accuracy < 10) {
				circle2.setMap(drawingMap);
			}
			$('#text2').text('�� ��ǥ : ' + latLng + ' / ' + '�������� : ' + Math.round(pos.coords.accuracy) + ' m');
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