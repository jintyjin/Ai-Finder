<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	background-color:#404040;
}
#map {
	width:100%;
	height:100%;
}
</style>
<script>
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
var mapContainer;
var map;
var imageMarker;
$(document).ready(function () {
	if (typeof kakao != "undefined" && '${case_idx}' != null && '${case_idx}' != '') {
		var jsonUrl = "/police/droneData"; 
		
		var obj = new Object();
		obj.case_idx = '${case_idx}';
		
		var jsonData = JSON.stringify(obj);

		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
            async: false,
			success: function (data) {
				if (data.length > 0) {
					var position_array = new Array();
					var last_position = new kakao.maps.LatLng(data[data.length - 1].gps_wtmx, data[data.length - 1].gps_wtmy);
					drawMap(last_position);
					for (var i = 0; i < data.length; i++) {
						var position = new kakao.maps.LatLng(data[i].gps_wtmx, data[i].gps_wtmy);
						position_array.push(position);
						displayCircle(data[i]);
					}
					drawMapLine(position_array);
				} else {
					alert('맵 정보를 불러올 수 없습니다.');
					self.close();
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 

		function drawMap(last_position) {
			mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: last_position, // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			map = new kakao.maps.Map(mapContainer, mapOption),
			    customOverlay = new kakao.maps.CustomOverlay({}),
			    infowindow = new kakao.maps.InfoWindow({removable: true});
			
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: last_position
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);			
		}

		function displayCircle(data_info) {
			var position = new kakao.maps.LatLng(data_info.gps_wtmx, data_info.gps_wtmy);
			var color = data_info.gps_color;
			
    		var circle = new kakao.maps.Circle({
    		    center : position,  // 원의 중심좌표 입니다 
    		    radius: 2, // 미터 단위의 원의 반지름입니다 
    		    strokeWeight: 0, // 선의 두께입니다 
    		    strokeColor: color, // 선의 색깔입니다
    		    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    		    strokeStyle: 'solid', // 선의 스타일 입니다
    		    fillColor: color, // 채우기 색깔입니다
    		    fillOpacity: 1  // 채우기 불투명도 입니다      
    		});  

    	    kakao.maps.event.addListener(circle, 'mouseover', function(mouseEvent) {
    	    	circle.setOptions({fillColor: '#09f'});
    	    });
    	    
    	    kakao.maps.event.addListener(circle, 'mouseout', function() {
    	    	circle.setOptions({fillColor:color});
    	    }); 

    	    kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {
    		    // 지도 중심을 부드럽게 이동시킵니다
    		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다

    		    if (imageMarker != null && imageMarker != "undefined") {
    				imageMarker.setPosition(position);
    		    } else {
    		        var imageSize = new kakao.maps.Size(24, 35); 
    		        // 마커 이미지를 생성합니다    
    		        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    		    	imageMarker = new kakao.maps.Marker({
    					map: map, // 마커를 표시할 지도
    					position: position, // 마커를 표시할 위치
    					image : markerImage // 마커 이미지 
    				});
    		    }
    			
    	        var content = '<div class="info"><img src="' + data_info.gps_image + '" style="width:148px;"/></div>';	// style="width:100%; height:100%;"	
    	        
    			infowindow.setContent(content);
    			infowindow.setPosition(mouseEvent.latLng); 
    			infowindow.setMap(map);
    			
    		    map.panTo(position);
	    	});
    		circle.setMap(map);
		}
		
		function drawMapLine(position_array) {
			var polyline = new kakao.maps.Polyline({
			    path: position_array, // 선을 구성하는 좌표배열 입니다
			    strokeWeight: 5, // 선의 두께 입니다
			    strokeColor: 'yellow', // 선의 색깔입니다
			    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle: 'solid' // 선의 스타일입니다
			});

			// 지도에 선을 표시합니다 
			polyline.setMap(map);
		}
	    
	} else {
		alert('맵 정보를 불러올 수 없습니다.');
		self.close();
	}
}); 
</script>
</head>
<body>
	<div id="map"></div>
</body>
</html>