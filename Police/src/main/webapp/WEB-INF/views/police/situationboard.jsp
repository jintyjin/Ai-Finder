<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-datepicker.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.js"></script>
<script src="./resources/js/stomp.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script type="text/javascript" src="./resources/func/exif.js"></script>
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_A.css">
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_B.css">
<link rel="stylesheet" href="./resources/css/app_C.css">
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_D.css">
<script type="text/javascript" src="./resources/js/translate/translate.js"></script> 
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
}
label {
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
	font-weight:normal;
}
.map_wrap {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
#map {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
.MapControlView {
	position:absolute;
	top:80px;
	right:9px;
	z-index:490;
	width:38px;
	margin:0;
	padding:0;
}
.MapControlView .accessLocation {
    width:auto;
    padding:0px;
}
.MapControlView .accessLocation:hover {
	background-position: -150px -350px;
}
.room_info {
	position:absolute;
	top:60px;
	left:10px;
	z-index:1;
	background:#ffffff;
	padding:10px;
	border-radius:2px;
	border:1px solid #dbdbdb;
	box-shadow:0 1px 1px rgb(0 0 0 / 4%);
}
.btn_div {
	/* width:767px;
	height:112px; */
	position:absolute;
	top:10px;
	left:10px;
	z-index:1;
	/* background:#ffffff; */
	/* padding:10px; */
	border-radius:2px;
	border:none;
	/* border:1px solid #dbdbdb; */
	box-shadow:0 1px 1px rgb(0 0 0 / 4%);
}
#setup_div {
	background-color:#fff;
	float:left;
}
#btn_top {
	padding:5px 10px 5px 5px;
	background-color:#404040;
	color:white;
}
#btn_top_arrow {
	margin-top:2px;
	margin-left:5px;
	float:right;
}
#btn_top_arrow:hover {
	cursor:pointer;
	color:#1c97ea;
}
#btn_bottom {
	padding:10px;
	width:767px;
}
input {
	border:1px solid black;
	border-radius:3px;
}
.input-daterange input:first-child, .input-daterange input:last-child {
	border-radius:3px;
}
#date_div {
	margin-bottom:8px;
}
#data_btn {
	border-radius:3px;
	background-color:#c8c8c8;
	padding:2px 2px 2px 2px;
}
#data_btn:hover {
	color:#1c97ea;
}
#date_td {
	padding-right:10px;
}
#receive_td {
	padding-left:10px;
	padding-right:10px;
	border-left:1px solid black;
	vertical-align:top;
}
#category_title_td {
	border-left:1px solid black;
	padding-left:10px;
	padding-right:10px;
	vertical-align:top;
}
#category_title_td > div > label {
	margin-top:2px;
}
#category_content_td {
	padding-left:30px;
	padding-right:20px;
}
#drone_notice {
	float:right;
	margin-left:5px;
}
#drone_notice_top {
	padding:5px 10px 5px 5px;
	background-color:#404040;
	color:white;
}
#drone_notice_top_arrow {
	margin-top:2px;
	margin-left:5px;
	float:right;
}
#drone_notice_top_arrow:hover {
	cursor:pointer;
	color:#1c97ea;
}
#drone_notice_bottom {
	width:767px;
	height:81px;
	background-color:#fff;
	overflow-y:auto;
}
.window {
	padding:5px;
	width:148px;
	text-align:center;
	letter-spacing: normal;
}
#recentDrone {
	position:absolute;
	top:120px;
	right:9px;
	z-index:490;
	width:38px;
	height:32px;
	margin:0;
	padding:0;
}
#droneCenter {
	font-size:13px;
	line-height:16px;
	text-decoration:none;
	color:#666;
	text-align:center;
	white-space:nowrap;
	display:block;
	cursor:pointer;
}
#droneCenter_i {
	/* background-position:-350px -100px; */
	overflow:hidden;
	width:36px;
	height:36px;
	margin:0 auto;
	background-size:contain;
	background:url(//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/img_search.png) no-repeat -352px -102px;
	display:block;
}
#droneCenter_i:hover {
	background:url(//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/img_search.png) no-repeat -352px -202px;
}
#rightOveray {    
	box-shadow: 2px 2px 2px #222;
	border:0;
	border-radius:6px;
	width:120px;
	/* padding:3px 0 3px 0; */
	background-color:white;
	margin-left:104px;
	margin-top:85px;
}
.rightDiv {
	text-align:center;
	border-radius:6px;
	border:0;
	width:100%;
	height:31px;
	line-height:31px;
}
.rightDiv:hover {
	background-color:#f5f5f5;
}
.overlay {
	background-color:white; 
	position:absolute; 
	left:0; 
	bottom:42px; 
	padding:4px; 
	border-radius:5px; 
	margin-left:-80px; 
	border-radius:5px;
	border:1px solid black;
}
.droneOverlay {
	background-color:white; 
	position:absolute; 
	left:0; 
	bottom:42px; 
	padding:4px; 
	border-radius:5px; 
	margin-left:-65px; 
	border-radius:5px;
	border:1px solid black;
}
#personNotice {
	display:none;
	z-index:0;
	position:absolute;
	top:80px;
	right:50px;
	color:black;
	background-color:#fff;
	border-radius:6px;
	line-height:32px;
	padding:0 5px 0 5px;
}
#droneNotice {
	display:none;
	z-index:0;
	position:absolute;
	top:120px;
	right:50px;
	color:black;
	background-color:#fff;
	border-radius:6px;
	line-height:36px;
	padding:0 5px 0 5px;
}
</style>
<script>
var jsonDraw = new Object();
var jsonDrawAll = new Object();
var jsonDrawAllDb = new Object();

var jsonImage = new Object();
var jsonImageReal = new Object();

var caseData = new Object();

var lastLocPosition = new kakao.maps.LatLng(36.676425709615486, 127.50080489999998);
var lastImagePosition = new kakao.maps.LatLng(36.676425709615486, 127.50080489999998);
var mapContainer;
var map;
var imageMarker;
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
var startDroneSrc = "https://t1.daumcdn.net/localimg/localimages/07/2018/pc/flagImg/blue_b.png";
var endDroneSrc = "https://t1.daumcdn.net/localimg/localimages/07/2018/pc/flagImg/red_b.png";
$(document).ready(function () {
	if (getCookie('finder_situation') == null) {
		var cookieJson = new Object();
		
		cookieJson.date_btn = 'Y';
		cookieJson.receive_btn = 'Y';
		cookieJson.drone_btn = 'Y';
		cookieJson.person_btn = 'Y';
		setCookie("finder_situation", JSON.stringify(cookieJson), 1);
	} else {
		var cookieJson = JSON.parse(getCookie('finder_situation'));
	
		Object.keys(cookieJson).forEach(function(k){
			if (cookieJson[k] != 'Y') {
				//console.log(k + " = " + cookieJson[k]);
				//eval('cookieJson[k].');
			}
		});
	}
	
	mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(36.676425709615486, 127.50080489999998), // 지도의 중심좌표
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
	
	$(window).click(function(event) {
		//alert($(event.target) + " / " + event.target.id);
		if (!($(event.target).is('.rightDiv'))) {
			customOverlay.setMap(null);
		}
	});
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	/* var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); */
	/* $.each(data, function (index, item) {
		console.log(index + " : " + item.receive_room_name);
	}); */
	if (typeof kakao != "undefined") {
		var jsonUrl = "/police/selectReceiveGpsInfoList";
		var jsonObject = new Object();
		var date = new Date();
		jsonObject.receive_gps_time = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
		var month = (date.getMonth() + 1);
		var day = date.getDate();
		
		if ((date.getMonth() + 1) < 10) {
			month = "0" + month;
		}
		if (date.getDate() < 10) {
			day = "0" + day;
		}
		
		$('#date_start').val(date.getFullYear() + "-" + month + "-" + day);
		$('#date_end').val(date.getFullYear() + "-" + month + "-" + day);
		
		var jsonData = JSON.stringify(jsonObject);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
            async: false,
			success: function (data) { 
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var linePath = [];
						var locPosition = new kakao.maps.LatLng(data[i].receive_gps_la, data[i].receive_gps_ma);
						var jsonKey = data[i].receive_room_name + '_' + data[i].receive_user_name + '_' + data[i].receive_room_idx;
						
						if (eval('jsonDrawAll.' + jsonKey) != null) { 
							linePath = eval('jsonDrawAll.' + jsonKey + '.linePath');
							linePath.push(new kakao.maps.LatLng(data[i].receive_gps_la, data[i].receive_gps_ma));
							eval('jsonDrawAll.' + jsonKey + '.linePath = linePath');
							eval('jsonDrawAll.' + jsonKey + '.locPosition = locPosition');
							eval('jsonDrawAll.' + jsonKey + '.arrive_time = data[i].receive_gps_time');
						} else {
							linePath.push(new kakao.maps.LatLng(data[i].receive_gps_la, data[i].receive_gps_ma));

							var positionObject = new Object();
							//positionObject.polyline = polyline;
							positionObject.linePath = linePath;
							positionObject.locPosition = locPosition;
							positionObject.receive_gps_time = data[i].receive_gps_time;
							positionObject.arrive_time = data[i].receive_gps_time;
							positionObject.receive_user_name = data[i].receive_user_name;

							eval('jsonDrawAll.' + jsonKey + '= positionObject');

						}
						
						lastLocPosition = locPosition;
					}
					Object.keys(jsonDrawAll).forEach(function(k){
						var linePath = jsonDrawAll[k].linePath;
						var CircleLocPosition = jsonDrawAll[k].locPosition;
				        var imageSize = new kakao.maps.Size(37, 42); 
				        // 마커 이미지를 생성합니다    
				        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
				        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 
				        
						var polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 4, // 선의 두께 입니다
						    strokeColor: 'red', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'line' // 선의 스타일입니다
						});
						var circle = new kakao.maps.Circle({
							center : CircleLocPosition,  // 원의 중심좌표 입니다 
							radius: 5, // 미터 단위의 원의 반지름입니다 
							strokeWeight: 2, // 선의 두께입니다 
							strokeColor: '#ffffff', // 선의 색깔입니다
							strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
							strokeStyle: 'line', // 선의 스타일 입니다
							fillColor: 'blue', // 채우기 색깔입니다
							fillOpacity: 0.7  // 채우기 불투명도 입니다   
						});
				    	var startMarker = new kakao.maps.Marker({
							position: linePath[0], // 마커를 표시할 위치
							image : startImage // 마커 이미지 
						});
				    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'white',
				    		    zIndex:490
				    		});
				    		this.setZIndex(490);
				    		if (jsonDrawAll[k].endMarker != null) {
					    		jsonDrawAll[k].endMarker.setZIndex(490);
				    		}
				    		jsonDrawAll[k].startOverlay.setZIndex(480);
				    		if (jsonDrawAll[k].endOverlay != null) {
					    		jsonDrawAll[k].endOverlay.setZIndex(480);
				    		}
				    		circle.setZIndex(490);
				    	});
				    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'red',
				    		    zIndex:0
				    		});
				    		this.setZIndex(0);
				    		if (jsonDrawAll[k].endMarker != null) {
					    		jsonDrawAll[k].endMarker.setZIndex(0);
				    		}
				    		jsonDrawAll[k].startOverlay.setZIndex(0);
				    		if (jsonDrawAll[k].endOverlay != null) {
					    		jsonDrawAll[k].endOverlay.setZIndex(0);
				    		}
				    		circle.setZIndex(0);
				    	});

					    var iwContent2 = '<div class="overlay">' + jsonDrawAll[k].receive_user_name + ' ' + jsonDrawAll[k].receive_gps_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
					
					    var startOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent2,
					        position: startMarker.getPosition()       
					    });
					    
						jsonDrawAll[k].startOverlay = startOverlay;
						jsonDrawAll[k].startMarker = startMarker;
						jsonDrawAll[k].polyline = polyline;
						jsonDrawAll[k].circle = circle;

						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							startMarker.setMap(map);
							startOverlay.setMap(map);
							//startWindow.open(map, startMarker); 
						}
						
						var length = linePath.length - 1;
						
						if (linePath.length > 1) {
					    	var endMarker = new kakao.maps.Marker({
								map: map, // 마커를 표시할 지도
								position: linePath[length], // 마커를 표시할 위치
								image : endImage // 마커 이미지 
							});

					    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'white',
					    		    zIndex:490
					    		});
					    		this.setZIndex(490);
					    		jsonDrawAll[k].startMarker.setZIndex(490);
					    		jsonDrawAll[k].startOverlay.setZIndex(480);
					    		jsonDrawAll[k].endOverlay.setZIndex(480);
					    		circle.setZIndex(490);
					    	});
					    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'red',
					    		    zIndex:0
					    		});
					    		this.setZIndex(0);
					    		jsonDrawAll[k].startMarker.setZIndex(0);
					    		jsonDrawAll[k].startOverlay.setZIndex(0);
					    		jsonDrawAll[k].endOverlay.setZIndex(0);
					    		circle.setZIndex(0);
					    	});
					    	var iwContent = '<div class="overlay">' + jsonDrawAll[k].receive_user_name + ' ' + jsonDrawAll[k].arrive_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

						    var endOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent,
						        position: endMarker.getPosition()       
						    });
						 
							jsonDrawAll[k].endMarker = endMarker;
							jsonDrawAll[k].endOverlay = endOverlay;

							if ($("input:checkbox[id='person_btn']").is(":checked")) {
								endMarker.setMap(map);
								endOverlay.setMap(map);
							}
						}
						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							polyline.setMap(map);
							circle.setMap(map);
						}
					});
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
		
		jsonUrl = "/police/selectSituationData";
		var jsonData = JSON.stringify(jsonObject);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
            async: false,
			success: function (data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var locPosition = new kakao.maps.LatLng(JSON.parse(data[i]).wtmX, JSON.parse(data[i]).wtmY);
						var thumb = JSON.parse(data[i]).image;
						var case_num = thumb.substring(thumb.indexOf('case'), thumb.lastIndexOf('/'));
						var linePath = [];
						var circlePath = [];
						var thumbList = [];
						var colorList = [];

						var color = "blue";
						
						if (JSON.parse(data[i]).tags != null && JSON.parse(JSON.parse(data[i]).tags).length > 0) {
							color = "red";	
						}
							
						//var circle = drawCircle(locPosition, color, thumb);

						var positionObject = new Object();
						if (eval('jsonImageReal.' + case_num) != null) {
							//linePath = eval('jsonImageReal.' + case_num + '.polyline.getPath()');
							linePath = eval('jsonImageReal.' + case_num + '.linePath');
							thumbList = eval('jsonImageReal.' + case_num + '.thumbList');
							colorList = eval('jsonImageReal.' + case_num + '.colorList');
							linePath.push(locPosition);
							thumbList.push(thumb);
							colorList.push(color);
							
							eval('jsonImageReal.' + case_num + '.linePath = linePath');
							eval('jsonImageReal.' + case_num + '.thumbList = thumbList');
							eval('jsonImageReal.' + case_num + '.colorList = colorList');
							
							eval('jsonImageReal.' + case_num + '.imgTime = JSON.parse(data[i]).imgTime');
						} else {
							linePath.push(locPosition);	
							thumbList.push(thumb);
							colorList.push(color);

							//positionObject.polyline = polyline;
							//circlePath.push(circle);
							//positionObject.circle = circlePath;
							positionObject.linePath = linePath;
							positionObject.thumbList = thumbList;
							positionObject.colorList = colorList;
							positionObject.startTime = JSON.parse(data[i]).imgTime;
							positionObject.imgTime = JSON.parse(data[i]).imgTime;

							eval('jsonImageReal.' + case_num + '= positionObject');
							
						}

						if ($("input:checkbox[id='drone_btn']").is(":checked")) {
			        		//circle.setMap(map);
						} 
		        		
						lastImagePosition = locPosition;
					}
					Object.keys(jsonImageReal).forEach(function(k){
						var linePath = jsonImageReal[k].linePath;
						var thumbList = jsonImageReal[k].thumbList;
						var colorList = jsonImageReal[k].colorList;
						var circlePath = [];
				        var imageSize = new kakao.maps.Size(37, 42); 
				       
				        // 마커 이미지를 생성합니다    
				        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
				        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 

				    	var startMarker = new kakao.maps.Marker({
							position: linePath[0], // 마커를 표시할 위치
							image : startImage // 마커 이미지 
						});
				    	
						for (var i = 0; i < linePath.length; i++) {
							var circle = drawCircle(linePath[i], colorList[i], thumbList[i]);
							circlePath.push(circle);
							
							if ($("input:checkbox[id='drone_btn']").is(":checked")) {
				        		circle.setMap(map);
							} 
						}
						
						var polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 4, // 선의 두께 입니다
						    strokeColor: 'yellow', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});

				    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'white',
				    		    zIndex:490
				    		});
				    		jsonImageReal[k].startMarker.setZIndex(490);
				    		jsonImageReal[k].startOverlay.setZIndex(480);
				    		if (jsonImageReal[k].endOverlay != null) {
					    		jsonImageReal[k].endOverlay.setZIndex(480);
				    		}
				    		if (jsonImageReal[k].endMarker != null) {
					    		jsonImageReal[k].endMarker.setZIndex(490);
				    		}
				    	});
				    	
				    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'yellow',
				    		    zIndex:0
				    		});
				    		jsonImageReal[k].startMarker.setZIndex(0);
				    		jsonImageReal[k].startOverlay.setZIndex(0);
				    		if (jsonImageReal[k].endOverlay != null) {
					    		jsonImageReal[k].endOverlay.setZIndex(0);
				    		}
				    		if (jsonImageReal[k].endMarker != null) {
					    		jsonImageReal[k].endMarker.setZIndex(0);
				    		}
				    	});

				    	kakao.maps.event.addListener(startMarker, 'rightclick', function(mouseEvent) {
				    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
				    		customOverlay.setContent(content);
				    		customOverlay.setPosition(linePath[0]); 
				    		customOverlay.setMap(map);
				    	});
				    	
					    var iwContent2 = '<div class="droneOverlay">' + jsonImageReal[k].startTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						
					    var startOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent2,
					        position: startMarker.getPosition()       
					    });
					    
					    jsonImageReal[k].startOverlay = startOverlay;
				    	jsonImageReal[k].startMarker = startMarker;
						jsonImageReal[k].circle = circlePath;
						jsonImageReal[k].polyline = polyline;
						
						if ($("input:checkbox[id='drone_btn']").is(":checked")) {
							polyline.setMap(map);
							startMarker.setMap(map);
							startOverlay.setMap(map);
						} 
						
						if (linePath.length > 1) {
					    	var endMarker = new kakao.maps.Marker({
								position: linePath[linePath.length - 1], // 마커를 표시할 위치
								image : endImage // 마커 이미지 
							});

					    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'white',
					    		    zIndex:490
					    		});
					    		jsonImageReal[k].startMarker.setZIndex(490);
					    		jsonImageReal[k].startOverlay.setZIndex(480);
					    		jsonImageReal[k].endOverlay.setZIndex(480);
					    	});
					    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'yellow',
					    		    zIndex:0
					    		});
					    		jsonImageReal[k].startMarker.setZIndex(0);
					    		jsonImageReal[k].startOverlay.setZIndex(0);
					    		jsonImageReal[k].endOverlay.setZIndex(0);
					    	});

					    	kakao.maps.event.addListener(endMarker, 'rightclick', function() {
					    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
					    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">드론 경로</div></div>'
					    		customOverlay.setContent(content);
					    		customOverlay.setPosition(linePath[linePath.length - 1]); 
					    		customOverlay.setMap(map);
					    	});
					    	
					    	jsonImageReal[k].endMarker = endMarker;
					    	
					    	var iwContent = '<div class="droneOverlay">' + jsonImageReal[k].imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

						    var endOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent,
						        position: endMarker.getPosition()       
						    });

							jsonImageReal[k].endOverlay = endOverlay;
							
							if ($("input:checkbox[id='drone_btn']").is(":checked")) {
								endMarker.setMap(map);
								endOverlay.setMap(map);
							}
						}
					});
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		});
	} else {
		alert("지도를 사용할 수 없습니다.");
	}
	
	var websocketUrl = '/police/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/receiveGps', function (message) {
			if ($("input:checkbox[id='person_btn']").is(":checked")) {
				var linePath = [];
				var locPosition = new kakao.maps.LatLng(JSON.parse(message.body).receive_gps_la, JSON.parse(message.body).receive_gps_ma);
				var jsonKey = JSON.parse(message.body).receive_room_name + '_' + JSON.parse(message.body).receive_user_name + '_' + JSON.parse(message.body).receive_room_idx;
				
				if (eval('jsonDrawAll.' + jsonKey) != null) { 
					linePath = eval('jsonDrawAll.' + jsonKey + '.linePath');
					linePath.push(new kakao.maps.LatLng(JSON.parse(message.body).receive_gps_la, JSON.parse(message.body).receive_gps_ma));
					eval('jsonDrawAll.' + jsonKey + '.linePath = linePath');
					eval('jsonDrawAll.' + jsonKey + '.locPosition = locPosition');
					eval('jsonDrawAll.' + jsonKey + '.arrive_time = JSON.parse(message.body).receive_gps_time');
					
					eval('jsonDrawAll.' + jsonKey + '.polyline.setPath(linePath)');
					eval('jsonDrawAll.' + jsonKey + '.circle.setPosition(locPosition)');

					var length = linePath.length - 1;
					
					if (eval('jsonDrawAll.' + jsonKey + '.endMarker') != null) {
						eval('jsonDrawAll.' + jsonKey + '.endMarker.setPosition(locPosition)');
					} else {
				    	var endMarker = new kakao.maps.Marker({
							position: locPosition, // 마커를 표시할 위치
							image : endImage // 마커 이미지 
						});

				    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
				    		eval("jsonDrawAll." + jsonKey + ".polyline.setOptions({strokeColor: 'white', zIndex:490})");
				    		this.setZIndex(490);
				    		eval('jsonDrawAll.' + jsonKey + '.startMarker.setZIndex(490)');
				    		eval('jsonDrawAll.' + jsonKey + '.startOverlay.setZIndex(480)');
				    		eval('jsonDrawAll.' + jsonKey + '.endOverlay.setZIndex(480)');
				    		eval('jsonDrawAll.' + jsonKey + '.circle.setZIndex(490)');
				    	});
				    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
				    		eval("jsonDrawAll." + jsonKey + ".polyline.setOptions({strokeColor: 'red', zIndex:0})");
				    		this.setZIndex(0);
				    		eval('jsonDrawAll.' + jsonKey + '.startMarker.setZIndex(0)');
				    		eval('jsonDrawAll.' + jsonKey + '.startOverlay.setZIndex(0)');
				    		eval('jsonDrawAll.' + jsonKey + '.endOverlay.setZIndex(0)');
				    		eval('jsonDrawAll.' + jsonKey + '.circle.setZIndex(0)');
				    	});
				    	eval('jsonDrawAll.' + jsonKey + '.endMarker = endMarker');
				    	
						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							endMarker.setMap(map);
						}
					}

					if (eval('jsonDrawAll.' + jsonKey + '.endOverlay') != null) {
				    	var iwContent = '<div class="overlay">' + JSON.parse(message.body).receive_user_name + ' ' + JSON.parse(message.body).receive_gps_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						eval('jsonDrawAll.' + jsonKey + '.endOverlay.setPosition(locPosition)');
				    	eval('jsonDrawAll.' + jsonKey + '.endOverlay.setContent(iwContent)');
					} else {
				    	var iwContent = '<div class="overlay">' + JSON.parse(message.body).receive_user_name + ' ' + JSON.parse(message.body).receive_gps_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

					    var endOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent,
					        position: locPosition   
					    });

				    	eval('jsonDrawAll.' + jsonKey + '.endOverlay = endOverlay');
				    	
						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							endOverlay.setMap(map);
						}
					}
				} else {
					linePath.push(locPosition);

					var positionObject = new Object();
					//positionObject.polyline = polyline;
					positionObject.linePath = linePath;
					positionObject.locPosition = locPosition;
					positionObject.receive_gps_time = JSON.parse(message.body).receive_gps_time;
					positionObject.arrive_time = JSON.parse(message.body).receive_gps_time;
					positionObject.receive_user_name = JSON.parse(message.body).receive_user_name;

					eval('jsonDrawAll.' + jsonKey + '= positionObject');

			        var imageSize = new kakao.maps.Size(37, 42); 
			        // 마커 이미지를 생성합니다    
			        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
			        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 
			        
					var polyline = new kakao.maps.Polyline({
					    path: linePath, // 선을 구성하는 좌표배열 입니다
					    strokeWeight: 4, // 선의 두께 입니다
					    strokeColor: 'red', // 선의 색깔입니다
					    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    strokeStyle: 'line' // 선의 스타일입니다
					});
					var circle = new kakao.maps.Circle({
						center : locPosition,  // 원의 중심좌표 입니다 
						radius: 5, // 미터 단위의 원의 반지름입니다 
						strokeWeight: 2, // 선의 두께입니다 
						strokeColor: '#ffffff', // 선의 색깔입니다
						strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						strokeStyle: 'line', // 선의 스타일 입니다
						fillColor: 'blue', // 채우기 색깔입니다
						fillOpacity: 0.7  // 채우기 불투명도 입니다   
					});
			    	var startMarker = new kakao.maps.Marker({
						position: linePath[0], // 마커를 표시할 위치
						image : startImage // 마커 이미지 
					});
			    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
			    		eval("jsonDrawAll." + jsonKey + ".polyline.setOptions({strokeColor: 'white', zIndex:490})");
			    		this.setZIndex(490);
			    		if (eval('jsonDrawAll.' + jsonKey + '.endMarker') != null) {
				    		eval("jsonDrawAll." + jsonKey + ".endMarker.setZIndex(490)");
			    		}
			    		eval("jsonDrawAll." + jsonKey + ".startOverlay.setZIndex(480)");
			    		if (eval("jsonDrawAll." + jsonKey + ".endOverlay") != null) {
				    		eval("jsonDrawAll." + jsonKey + ".endOverlay.setZIndex(480)");
			    		}
			    		circle.setZIndex(490);
			    	});
			    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
			    		eval("jsonDrawAll." + jsonKey + ".polyline.setOptions({strokeColor: 'red', zIndex:0})");
			    		this.setZIndex(0);
			    		if (eval('jsonDrawAll.' + jsonKey + '.endMarker') != null) {
				    		eval("jsonDrawAll." + jsonKey + ".endMarker.setZIndex(0)");
			    		}
			    		eval("jsonDrawAll." + jsonKey + ".startOverlay.setZIndex(0)");
			    		if (eval("jsonDrawAll." + jsonKey + ".endOverlay") != null) {
				    		eval("jsonDrawAll." + jsonKey + ".endOverlay.setZIndex(0)");
			    		}
			    		circle.setZIndex(0);
			    	});

				    var iwContent2 = '<div class="overlay">' + JSON.parse(message.body).receive_user_name + ' ' + JSON.parse(message.body).receive_gps_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				
				    var startOverlay = new kakao.maps.CustomOverlay({
				        content: iwContent2,
				        position: startMarker.getPosition()       
				    });
				    
				    eval('jsonDrawAll.' + jsonKey + '.startOverlay = startOverlay');
				    eval('jsonDrawAll.' + jsonKey + '.startMarker = startMarker');
				    eval('jsonDrawAll.' + jsonKey + '.polyline = polyline');
				    eval('jsonDrawAll.' + jsonKey + '.circle = circle');

					if ($("input:checkbox[id='person_btn']").is(":checked")) {
						polyline.setMap(map);
						circle.setMap(map);
						startMarker.setMap(map);
						startOverlay.setMap(map);
					}
				}
				
				lastLocPosition = locPosition;
			}
		});
		stompClient.subscribe('/receiveDrone', function (message) {
			if ($("input:checkbox[id='drone_btn']").is(":checked")) {
				var json = JSON.parse(message.body);
		        var object_list = json.object_list;

				console.log('json.wtmX = ' + json.wtmX);
				console.log('json.object_list = ' + object_list);
				console.log('length = ' + object_list.length);
				
				if (json.wtmX != null && json.wtmY != null) {
					var locPosition = new kakao.maps.LatLng(json.wtmX, json.wtmY);
					var thumb = json.image;
					var case_num = thumb.substring(thumb.indexOf('case'), thumb.lastIndexOf('/'));
					var linePath = [];
					var circlePath = [];
					var thumbList = [];
					var colorList = [];
					var circlePath = [];

					var color = "blue";
					
					if (object_list != null && object_list.length > 0) {
						color = "red";	
					}
						
			        var imageSize = new kakao.maps.Size(37, 42); 
			        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
			        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 
			       
					var positionObject = new Object();
					if (eval('jsonImageReal.' + case_num) != null) {
						linePath = eval('jsonImageReal.' + case_num + '.linePath');
						thumbList = eval('jsonImageReal.' + case_num + '.thumbList');
						colorList = eval('jsonImageReal.' + case_num + '.colorList');
						linePath.push(locPosition);
						thumbList.push(thumb);
						colorList.push(color);
						
						eval('jsonImageReal.' + case_num + '.linePath = linePath');
						eval('jsonImageReal.' + case_num + '.thumbList = thumbList');
						eval('jsonImageReal.' + case_num + '.colorList = colorList');
						eval('jsonImageReal.' + case_num + '.imgTime = json.imgTime');
						
						circlePath = eval('jsonImageReal.' + case_num + '.circle');
						
						eval('jsonImageReal.' + case_num + '.polyline.setPath(linePath)');	
						
						if (linePath.length < 3) {
					    	var endMarker = new kakao.maps.Marker({
								position: locPosition, // 마커를 표시할 위치
								image : endImage // 마커 이미지 
							});
					    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
					    		eval("jsonImageReal." + case_num + ".polyline.setOptions({strokeColor: 'white', zIndex:490})");
					    		this.setZIndex(490);
					    		eval('jsonImageReal.' + case_num + '.startMarker.setZIndex(490)');
					    		eval('jsonImageReal.' + case_num + '.startOverlay.setZIndex(480)');
					    		eval('jsonImageReal.' + case_num + '.endOverlay.setZIndex(480)');
					    	});
					    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
					    		eval("jsonImageReal." + case_num + ".polyline.setOptions({strokeColor: 'yellow', zIndex:0})");
					    		this.setZIndex(0);
					    		eval('jsonImageReal.' + case_num + '.startMarker.setZIndex(0)');
					    		eval('jsonImageReal.' + case_num + '.startOverlay.setZIndex(0)');
					    		eval('jsonImageReal.' + case_num + '.endOverlay.setZIndex(0)');
					    	});

					    	kakao.maps.event.addListener(endMarker, 'rightclick', function() {
					    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
					    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + case_num + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + case_num + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + case_num + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + case_num + "'" + ');">드론 경로</div></div>'
					    		customOverlay.setContent(content);
					    		customOverlay.setPosition(locPosition); 
					    		customOverlay.setMap(map);
					    	});

				    		eval('jsonImageReal.' + case_num + '.endMarker = endMarker');
					    	
					    	var iwContent = '<div style="background-color:white; position:absolute; left:0; bottom:42px; padding:4px; border-radius:5px; margin-left:-65px; border-radius:5px;">' + json.imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

						    var endOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent,
						        position: endMarker.getPosition()       
						    });

				    		eval('jsonImageReal.' + case_num + '.endOverlay = endOverlay');
							
							if ($("input:checkbox[id='drone_btn']").is(":checked")) {
								endMarker.setMap(map);
								endOverlay.setMap(map);
							}
						} else {
							var endMarker = eval('jsonImageReal.' + case_num + '.endMarker');
					    	kakao.maps.event.addListener(endMarker, 'rightclick', function() {
					    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
					    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + case_num + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + case_num + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + case_num + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + case_num + "'" + ');">드론 경로</div></div>'
					    		customOverlay.setContent(content);
					    		customOverlay.setPosition(locPosition); 
					    		customOverlay.setMap(map);
					    	});
					    	endMarker.setPosition(locPosition);

					    	var iwContent = '<div class="droneOverlay">' + json.imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

					    	eval('jsonImageReal.' + case_num + '.endOverlay.setPosition(locPosition)');
					    	eval('jsonImageReal.' + case_num + '.endOverlay.setContent(iwContent)');
					    	
							eval('jsonImageReal.' + case_num + '.endMarker = endMarker');	
						}
					} else {
						linePath.push(locPosition);	
						thumbList.push(thumb);
						colorList.push(color);

						positionObject.linePath = linePath;
						positionObject.thumbList = thumbList;
						positionObject.colorList = colorList;
						positionObject.startTime = json.imgTime;
						positionObject.imgTime = json.imgTime;

						eval('jsonImageReal.' + case_num + '= positionObject');

				    	var startMarker = new kakao.maps.Marker({
							position: linePath[0], // 마커를 표시할 위치
							image : startImage // 마커 이미지 
						});
						var polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 4, // 선의 두께 입니다
						    strokeColor: 'yellow', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});

				    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'white',
				    		    zIndex:490
				    		});
				    		eval('jsonImageReal.' + case_num + '.startMarker.setZIndex(490)');
				    		eval('jsonImageReal.' + case_num + '.startOverlay.setZIndex(480)');

				    		if (eval('jsonImageReal.' + case_num + '.endMarker') != null) {
					    		eval('jsonImageReal.' + case_num + '.endMarker.setZIndex(490)');
				    		}
				    		if (eval('jsonImageReal.' + case_num + '.endOverlay') != null) {
					    		eval('jsonImageReal.' + case_num + '.endOverlay.setZIndex(480)');
				    		}
				    	});
				    	
				    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'yellow',
				    		    zIndex:0
				    		});
				    		eval('jsonImageReal.' + case_num + '.startMarker.setZIndex(0)');
				    		eval('jsonImageReal.' + case_num + '.startOverlay.setZIndex(0)');
				    		
				    		if (eval('jsonImageReal.' + case_num + '.endMarker') != null) {
					    		eval('jsonImageReal.' + case_num + '.endMarker.setZIndex(0)');
				    		}
				    		if (eval('jsonImageReal.' + case_num + '.endOverlay') != null) {
					    		eval('jsonImageReal.' + case_num + '.endOverlay.setZIndex(0)');
				    		}
				    	});

				    	kakao.maps.event.addListener(startMarker, 'rightclick', function() {
				    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
				    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + case_num + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + case_num + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + case_num + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + case_num + "'" + ');">드론 경로</div></div>'
				    		customOverlay.setContent(content);
				    		customOverlay.setPosition(locPosition); 
				    		customOverlay.setMap(map);
				    	});
				    	
					    var iwContent2 = '<div class="droneOverlay">' + json.imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						
					    var startOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent2,
					        position: locPosition
					    });

			    		eval('jsonImageReal.' + case_num + '.startOverlay = startOverlay');
			    		eval('jsonImageReal.' + case_num + '.startMarker = startMarker');
			    		eval('jsonImageReal.' + case_num + '.polyline = polyline');
				    	
						if ($("input:checkbox[id='drone_btn']").is(":checked")) {
							polyline.setMap(map);
							startMarker.setMap(map);
							startOverlay.setMap(map);
						} 
					}
					lastImagePosition = locPosition;
					
			        // 마커 이미지를 생성합니다    
					var circle = drawCircle(locPosition, color, thumb);
					
					circlePath.push(circle);
					
					if ($("input:checkbox[id='drone_btn']").is(":checked")) {
		        		circle.setMap(map);
					} 

		    		eval('jsonImageReal.' + case_num + '.circle = circlePath');
				}
			}
		});
		stompClient.subscribe('/start_analyze', function (message) {
			var json = JSON.parse(message.body);
			var text_box = document.getElementById('drone_notice_bottom');
			text_box.innerHTML += (json.case_num + ' 이미지 분석을 시작함');
		});
		stompClient.subscribe('/end_analyze', function (message) {
			var json = JSON.parse(message.body);
			var text_box = document.getElementById('drone_notice_bottom');
			text_box.innerHTML += (json.case_num + ' 이미지 분석을 시작함');
		});
		stompClient.subscribe('/_analyze', function (message) {
			var json = JSON.parse(message.body);
			var text_box = document.getElementById('drone_notice_bottom');
			text_box.innerHTML += (json.case_num + ' 이미지 분석을 시작함');
		});
	});
	$('.input-daterange').datepicker({
	    format: "yyyy-mm-dd",
	    language: "ko",
	    keyboardNavigation: false,
	    forceParse: false
	});
      $("#btn_top_arrow").on("click",function(event){
        $("#btn_bottom").toggle(200);
      })
      $("#drone_notice_top_arrow").on("click",function(event){
          $("#drone_notice_bottom").toggle(200);
        })
	$('#date_btn').click(function () {
		$(".input-daterange").toggle();
	});
	$('#drone_btn').click(function () {
		if ($(this).is(":checked")) {
			Object.keys(jsonImage).forEach(function(k){
				jsonImage[k].polyline.setMap(map);
				var circlePath = jsonImage[k].circle;
				var startMarker = jsonImage[k].startMarker;
				var endMarker;
				var endOverlay;
				for (var i = 0; i < circlePath.length; i++) {
					circlePath[i].setMap(map);
				}
				startMarker.setMap(map);
				if (jsonImage[k].endMarker != null) {
					endMarker = jsonImage[k].endMarker;
					endMarker.setMap(map);
				}
				jsonImage[k].startOverlay.setMap(map);
				if (jsonImage[k].endOverlay != null) {
					endOverlay = jsonImage[k].endOverlay;
					endOverlay.setMap(map);
				}
			});
			Object.keys(jsonImageReal).forEach(function(k){
				jsonImageReal[k].polyline.setMap(map);
				var circlePath = jsonImageReal[k].circle;
				var startMarker = jsonImageReal[k].startMarker;
				var endMarker;
				var endOverlay;
				for (var i = 0; i < circlePath.length; i++) {
					circlePath[i].setMap(map);
				}
				startMarker.setMap(map);
				if (jsonImageReal[k].endMarker != null) {
					endMarker = jsonImageReal[k].endMarker;
					endMarker.setMap(map);
				}
				jsonImageReal[k].startOverlay.setMap(map);
				if (jsonImageReal[k].endOverlay != null) {
					endOverlay = jsonImageReal[k].endOverlay;
					endOverlay.setMap(map);
				}
			});
		} else {
			Object.keys(jsonImage).forEach(function(k){
				jsonImage[k].polyline.setMap(null);
				var circlePath = jsonImage[k].circle;
				var startMarker = jsonImage[k].startMarker;
				var endMarker;
				var endOverlay;
				for (var i = 0; i < circlePath.length; i++) {
					circlePath[i].setMap(null);
				}
				startMarker.setMap(null);
				if (jsonImage[k].endMarker != null) {
					endMarker = jsonImage[k].endMarker;
					endMarker.setMap(null);
				}
				jsonImage[k].startOverlay.setMap(null);
				jsonImage[k].endOverlay.setMap(null);
				if (jsonImage[k].endOverlay != null) {
					endOverlay = jsonImage[k].endOverlay;
					endOverlay.setMap(null);
				}
			});
			Object.keys(jsonImageReal).forEach(function(k){
				jsonImageReal[k].polyline.setMap(null);
				var circlePath = jsonImageReal[k].circle;
				var startMarker = jsonImageReal[k].startMarker;
				var endMarker;
				var endOverlay;
				for (var i = 0; i < circlePath.length; i++) {
					circlePath[i].setMap(null);
				}
				startMarker.setMap(null);
				if (jsonImageReal[k].endMarker != null) {
					endMarker = jsonImageReal[k].endMarker;
					endMarker.setMap(null);
				}
				jsonImageReal[k].startOverlay.setMap(null);
				if (jsonImageReal[k].endOverlay != null) {
					endOverlay = jsonImageReal[k].endOverlay;
					endOverlay.setMap(null);
				}
			});
		}
	});
	$('#person_btn').click(function () {
		if ($(this).is(":checked")) {
			Object.keys(jsonDrawAll).forEach(function(k){
				var endOverlay;
				jsonDrawAll[k].polyline.setMap(map);
				jsonDrawAll[k].circle.setMap(map);
				jsonDrawAll[k].startMarker.setMap(map);
				jsonDrawAll[k].startOverlay.setMap(map);
				if (jsonDrawAll[k].endMarker != null) {
					endMarker = jsonDrawAll[k].endOverlay;
					endMarker.setMap(map);
				}
				if (jsonDrawAll[k].endOverlay != null) {
					endOverlay = jsonDrawAll[k].endOverlay;
					endOverlay.setMap(map);
				}
			});
			Object.keys(jsonDraw).forEach(function(k){
				var circlePath = jsonDraw[k].circle;
				circlePath.setMap(map);
			});
			Object.keys(jsonDrawAllDb).forEach(function(k){
				var endOverlay;
				jsonDrawAllDb[k].polyline.setMap(map);
				jsonDrawAllDb[k].circle.setMap(map);
				jsonDrawAllDb[k].startOverlay.setMap(map);
				if (jsonDrawAllDb[k].endOverlay != null) {
					endOverlay = jsonDrawAllDb[k].endOverlay;
					endOverlay.setMap(map);
				}
				jsonDrawAllDb[k].startMarker.setMap(map);
				if (jsonDrawAllDb[k].endMarker != null) {
					endOverlay = jsonDrawAllDb[k].endMarker;
					endOverlay.setMap(map);
				}
			});
		} else {
			Object.keys(jsonDrawAll).forEach(function(k){
				var endOverlay;
				jsonDrawAll[k].polyline.setMap(null);
				jsonDrawAll[k].circle.setMap(null);
				jsonDrawAll[k].startOverlay.setMap(null);
				if (jsonDrawAll[k].endOverlay != null) {
					endOverlay = jsonDrawAll[k].endOverlay;
					endOverlay.setMap(null);
				}
				jsonDrawAll[k].startMarker.setMap(null);
				if (jsonDrawAll[k].endMarker != null) {
					endOverlay = jsonDrawAll[k].endMarker;
					endOverlay.setMap(null);
				}
			});
			Object.keys(jsonDraw).forEach(function(k){
				var circlePath = jsonDraw[k].circle;
				circlePath.setMap(null);
			});
			Object.keys(jsonDrawAllDb).forEach(function(k){
				var endOverlay;
				jsonDrawAllDb[k].polyline.setMap(null);
				jsonDrawAllDb[k].circle.setMap(null);
				jsonDrawAllDb[k].startOverlay.setMap(null);
				if (jsonDrawAllDb[k].endOverlay != null) {
					endOverlay = jsonDrawAllDb[k].endOverlay;
					endOverlay.setMap(null);
				}
				jsonDrawAllDb[k].startMarker.setMap(null);
				if (jsonDrawAllDb[k].endMarker != null) {
					endOverlay = jsonDrawAllDb[k].endMarker;
					endOverlay.setMap(null);
				}
			});
			
		}
	});
	function drawCircle(locPosition, color, thumb) {
		var circle = new kakao.maps.Circle({
		    center : locPosition,  // 원의 중심좌표 입니다 
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
	    	circle.setOptions({fillColor: color});
	    }); 

	    kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {
		    map.panTo(locPosition);

		    if (imageMarker != null && imageMarker != "undefined") {
				imageMarker.setPosition(locPosition);
		    } else {
		        var imageSize = new kakao.maps.Size(24, 35); 
		        
		        // 마커 이미지를 생성합니다    
		        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    	imageMarker = new kakao.maps.Marker({
					map: map, // 마커를 표시할 지도
					position: locPosition, // 마커를 표시할 위치
					image : markerImage // 마커 이미지 
				});
		    }

	        var content = '<div class="info"><img src="' + thumb + '" style="width:148px;"/></div>';	// style="width:100%; height:100%;"	
	        
			infowindow.setContent(content);
			infowindow.setPosition(mouseEvent.latLng); 
			infowindow.setMap(map);
	    });
	    
	    return circle;
	}
});
function changeCenter() {
	map.panTo(lastLocPosition);
}
function changeDroneCenter() {
	map.panTo(lastImagePosition);
} 
function drawCircle2(locPosition, color, thumb) {
	var circle = new kakao.maps.Circle({
	    center : locPosition,  // 원의 중심좌표 입니다 
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
    	circle.setOptions({fillColor: color});
    }); 

    kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {
	    map.panTo(locPosition);

	    if (imageMarker != null && imageMarker != "undefined") {
			imageMarker.setPosition(locPosition);
	    } else {
	        var imageSize = new kakao.maps.Size(24, 35); 
	        
	        // 마커 이미지를 생성합니다    
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    	imageMarker = new kakao.maps.Marker({
				map: map, // 마커를 표시할 지도
				position: locPosition, // 마커를 표시할 위치
				image : markerImage // 마커 이미지 
			});
	    }

        var content = '<div class="info"><img src="' + thumb + '" style="width:148px;"/></div>';	// style="width:100%; height:100%;"	
        
		infowindow.setContent(content);
		infowindow.setPosition(mouseEvent.latLng); 
		infowindow.setMap(map);
    });
    return circle;
}
function selectDroneData() {
	var date_start = $('#date_start').val();
	var date_end = $('#date_end').val();

	if (typeof kakao != "undefined") {
		var jsonUrl = "/police/selectReceiveGpsInfoList2";
		var jsonObject = new Object();
		jsonObject.receive_gps_la = date_start;
		jsonObject.receive_gps_ma = date_end;
		
		var jsonData = JSON.stringify(jsonObject);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
            async: false,
			success: function (data) {
				var droneData = data[0];
				
				Object.keys(jsonImage).forEach(function(k){
					jsonImage[k].polyline.setMap(null);
					var circlePath = jsonImage[k].circle;
					for (var i = 0; i < circlePath.length; i++) {
						circlePath[i].setMap(null);
					}
					jsonImage[k].startMarker.setMap(null);
					jsonImage[k].startOverlay.setMap(null);
					if (jsonImage[k].endMarker != null) {
						jsonImage[k].endMarker.setMap(null);
					}
					if (jsonImage[k].endOverlay != null) {
						jsonImage[k].endOverlay.setMap(null);
					}
				});
				
				if (imageMarker != null) {
					imageMarker.setMap(null);
				}
				
				jsonImage = new Object();
				if (droneData.length > 0) {
					for (var i = 0; i < droneData.length; i++) {
						var locPosition = new kakao.maps.LatLng(JSON.parse(droneData[i]).wtmX, JSON.parse(droneData[i]).wtmY);
						var thumb = JSON.parse(droneData[i]).image;
						var case_num = thumb.substring(thumb.indexOf('case'), thumb.lastIndexOf('/'));
						var linePath = [];
						var circlePath = [];
						var thumbList = [];
						var colorList = [];

						var color = "blue";
						
						if (JSON.parse(droneData[i]).tags != null && JSON.parse(JSON.parse(droneData[i]).tags).length > 0) {
							color = "red";	
						}
							
						//var circle = drawCircle(locPosition, color, thumb);

						var positionObject = new Object();
						if (eval('jsonImage.' + case_num) != null) {
							//linePath = eval('jsonImage.' + case_num + '.polyline.getPath()');
							linePath = eval('jsonImage.' + case_num + '.linePath');
							thumbList = eval('jsonImage.' + case_num + '.thumbList');
							colorList = eval('jsonImage.' + case_num + '.colorList');
							linePath.push(locPosition);
							thumbList.push(thumb);
							colorList.push(color);
							//circlePath = eval('jsonImage.' + case_num + '.circle');
							
							//circlePath.push(circle);
							//eval('jsonImage.' + case_num + '.circle = circlePath');
							eval('jsonImage.' + case_num + '.imgTime = JSON.parse(droneData[i]).imgTime');
						} else {
							linePath.push(locPosition);	
							thumbList.push(thumb);
							colorList.push(color);

							//positionObject.polyline = polyline;
							//circlePath.push(circle);
							//positionObject.circle = circlePath;
							positionObject.linePath = linePath;
							positionObject.thumbList = thumbList;
							positionObject.colorList = colorList;
							positionObject.startTime = JSON.parse(droneData[i]).imgTime;
							positionObject.imgTime = JSON.parse(droneData[i]).imgTime;

							eval('jsonImage.' + case_num + '= positionObject');
							
						}

						lastImagePosition = locPosition;
					}
					Object.keys(jsonImage).forEach(function(k){
						var linePath = jsonImage[k].linePath;
						var thumbList = jsonImage[k].thumbList;
						var colorList = jsonImage[k].colorList;
						var circlePath = [];
				        var imageSize = new kakao.maps.Size(37, 42); 
				       
				        // 마커 이미지를 생성합니다    
				        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
				        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 

				    	var startMarker = new kakao.maps.Marker({
							position: linePath[0], // 마커를 표시할 위치
							image : startImage // 마커 이미지 
						});
				    	
						for (var i = 0; i < linePath.length; i++) {
							var circle = drawCircle2(linePath[i], colorList[i], thumbList[i]);
							circlePath.push(circle);
							
							if ($("input:checkbox[id='drone_btn']").is(":checked")) {
				        		circle.setMap(map);
							} 
						}
						
						var polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 4, // 선의 두께 입니다
						    strokeColor: 'yellow', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});

				    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'white',
				    		    zIndex:490
				    		});
				    		this.setZIndex(490);
				    		jsonImage[k].startOverlay.setZIndex(480);
				    		if (jsonImage[k].endMarker != null) {
					    		jsonImage[k].endMarker.setZIndex(490);
				    			
				    		}
				    		if (jsonImage[k].endOverlay != null) {
					    		jsonImage[k].endOverlay.setZIndex(480);
				    		}
				    	});
				    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'yellow',
				    		    zIndex:0
				    		});
				    		this.setZIndex(0);
				    		jsonImage[k].startOverlay.setZIndex(0);
				    		if (jsonImage[k].endMarker != null) {
					    		jsonImage[k].endMarker.setZIndex(0);
				    			
				    		}
				    		if (jsonImage[k].endOverlay != null) {
					    		jsonImage[k].endOverlay.setZIndex(0);
				    		}
				    	});

				    	kakao.maps.event.addListener(startMarker, 'rightclick', function() {
				    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
				    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">드론 경로</div></div>'
				    		//'<div data-id="ViewContext" class="Context" style="cursor: default;"><div class="contextWrap"><a data-id="here" href="#" class="context_here"><span class="text">여기 주소 보기</span></a><a data-id="newplace" href="#" class="context_new"><span class="text">신규 장소 등록</span></a><a data-id="strange" href="#" class="strange"><span class="text">여기 정보 수정</span></a><a data-id="favorite" class="fav" href="#"><span class="text">즐겨찾기 추가</span></a><a data-id="w3w" class="fav" href="#"><span class="text">W3W</span></a><span class="separator"></span><a data-id="origin" href="#"><span class="origin"></span><span class="text">출발지 지정</span></a><a data-id="via" href="#"><span class="via"></span><span class="text">경유지 지정</span></a><a data-id="destination" href="#"><span class="destination"></span><span class="text">도착지 지정</span></a></div></div>'
				    		customOverlay.setContent(content);
				    		customOverlay.setPosition(linePath[0]); 
				    		customOverlay.setMap(map);
				    	});
				    	
					    var iwContent2 = '<div class="droneOverlay">' + jsonImage[k].startTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						
					    var startOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent2,
					        position: startMarker.getPosition()       
					    });
					    
					    jsonImage[k].startOverlay = startOverlay;
				    	jsonImage[k].startMarker = startMarker;
						jsonImage[k].circle = circlePath;
						jsonImage[k].polyline = polyline;
						
						if ($("input:checkbox[id='drone_btn']").is(":checked")) {
							startMarker.setMap(map);
							startOverlay.setMap(map);
							polyline.setMap(map);
						} 
						
						if (linePath.length > 1) {
					    	var endMarker = new kakao.maps.Marker({
								position: linePath[linePath.length - 1], // 마커를 표시할 위치
								image : endImage // 마커 이미지 
							});

					    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'white',
					    		    zIndex:490
					    		});
					    		this.setZIndex(490);
					    		jsonImage[k].startMarker.setZIndex(490);
					    		jsonImage[k].startOverlay.setZIndex(480);
					    		jsonImage[k].endOverlay.setZIndex(480);
					    	});
					    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'yellow',
					    		    zIndex:0
					    		});
					    		this.setZIndex(0);
					    		jsonImage[k].startMarker.setZIndex(0);
					    		jsonImage[k].startOverlay.setZIndex(0);
					    		jsonImage[k].endOverlay.setZIndex(0);
					    	});

					    	kakao.maps.event.addListener(endMarker, 'rightclick', function() {
					    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
					    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">드론 경로</div></div>'
					    		customOverlay.setContent(content);
					    		customOverlay.setPosition(linePath[linePath.length - 1]); 
					    		customOverlay.setMap(map);
					    	});
					    	
					    	jsonImage[k].endMarker = endMarker;
					    	
					    	var iwContent = '<div class="droneOverlay">' + jsonImage[k].imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

						    var endOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent,
						        position: endMarker.getPosition()       
						    });

							jsonImage[k].endOverlay = endOverlay;
							
							if ($("input:checkbox[id='drone_btn']").is(":checked")) {
								endMarker.setMap(map);
								endOverlay.setMap(map);
							}
						}
					});
					lastImagePosition = locPosition;
				}

				var personData = data[1];

				Object.keys(jsonDrawAllDb).forEach(function(k){
					var endOverlay;
					jsonDrawAllDb[k].polyline.setMap(null);
					jsonDrawAllDb[k].circle.setMap(null);
					jsonDrawAllDb[k].startOverlay.setMap(null);
					if (jsonDrawAllDb[k].endOverlay != null) {
						endOverlay = jsonDrawAllDb[k].endOverlay;
						endOverlay.setMap(null);
					}
					jsonDrawAllDb[k].startMarker.setMap(null);
					if (jsonDrawAllDb[k].endMarker != null) {
						endOverlay = jsonDrawAllDb[k].endMarker;
						endOverlay.setMap(null);
					}
				});
				
				jsonDrawAllDb = new Object();
				
				if (personData.length > 0) {
					for (var i = 0; i < personData.length; i++) {
						var linePath = [];
						var locPosition = new kakao.maps.LatLng(personData[i].receive_gps_la, personData[i].receive_gps_ma);
						var jsonKey = personData[i].receive_room_name + '_' + personData[i].receive_user_name + '_' + personData[i].receive_room_idx;
						
						if (eval('jsonDrawAllDb.' + jsonKey) != null) { 
							linePath = eval('jsonDrawAllDb.' + jsonKey + '.linePath');
							linePath.push(new kakao.maps.LatLng(personData[i].receive_gps_la, personData[i].receive_gps_ma));
							eval('jsonDrawAllDb.' + jsonKey + '.linePath = linePath');
							eval('jsonDrawAllDb.' + jsonKey + '.locPosition = locPosition');
							eval('jsonDrawAllDb.' + jsonKey + '.arrive_time = personData[i].receive_gps_time');
						} else {
							linePath.push(new kakao.maps.LatLng(personData[i].receive_gps_la, personData[i].receive_gps_ma));

							var positionObject = new Object();
							//positionObject.polyline = polyline;
							positionObject.linePath = linePath;
							positionObject.locPosition = locPosition;
							positionObject.receive_gps_time = personData[i].receive_gps_time;
							positionObject.arrive_time = personData[i].receive_gps_time;
							positionObject.receive_user_name = personData[i].receive_user_name;

							eval('jsonDrawAllDb.' + jsonKey + '= positionObject');
						}
						
						lastLocPosition = locPosition;
					}
					Object.keys(jsonDrawAllDb).forEach(function(k){
						var linePath = jsonDrawAllDb[k].linePath;
						var CircleLocPosition = jsonDrawAllDb[k].locPosition;
				        var imageSize = new kakao.maps.Size(37, 42); 
				        // 마커 이미지를 생성합니다    
				        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
				        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 
				        
						var polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 4, // 선의 두께 입니다
						    strokeColor: 'red', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'line' // 선의 스타일입니다
						});
						var circle = new kakao.maps.Circle({
							center : CircleLocPosition,  // 원의 중심좌표 입니다 
							radius: 5, // 미터 단위의 원의 반지름입니다 
							strokeWeight: 2, // 선의 두께입니다 
							strokeColor: '#ffffff', // 선의 색깔입니다
							strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
							strokeStyle: 'line', // 선의 스타일 입니다
							fillColor: 'blue', // 채우기 색깔입니다
							fillOpacity: 0.7  // 채우기 불투명도 입니다   
						});
				    	var startMarker = new kakao.maps.Marker({
							position: linePath[0], // 마커를 표시할 위치
							image : startImage // 마커 이미지 
						});
				    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'white',
				    		    zIndex:490
				    		});
				    		this.setZIndex(490);
				    		if (jsonDrawAllDb[k].endMarker != null) {
					    		jsonDrawAllDb[k].endMarker.setZIndex(490);
				    		}
				    		jsonDrawAllDb[k].startOverlay.setZIndex(480);
				    		if (jsonDrawAllDb[k].endOverlay != null) {
					    		jsonDrawAllDb[k].endOverlay.setZIndex(480);
				    		}
				    		circle.setZIndex(490);
				    	});
				    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
				    		polyline.setOptions({
				    		    strokeColor: 'red',
				    		    zIndex:0
				    		});
				    		this.setZIndex(0);
				    		if (jsonDrawAllDb[k].endMarker != null) {
					    		jsonDrawAllDb[k].endMarker.setZIndex(0);
				    		}
				    		jsonDrawAllDb[k].startOverlay.setZIndex(0);
				    		if (jsonDrawAllDb[k].endOverlay != null) {
					    		jsonDrawAllDb[k].endOverlay.setZIndex(0);
				    		}
				    		circle.setZIndex(0);
				    	});

					    var iwContent2 = '<div class="overlay">' + jsonDrawAllDb[k].receive_user_name + ' ' + jsonDrawAllDb[k].receive_gps_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
					
					    var startOverlay = new kakao.maps.CustomOverlay({
					        content: iwContent2,
					        position: startMarker.getPosition()       
					    });
					    
						jsonDrawAllDb[k].startOverlay = startOverlay;
						jsonDrawAllDb[k].startMarker = startMarker;
						jsonDrawAllDb[k].polyline = polyline;
						jsonDrawAllDb[k].circle = circle;

						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							startMarker.setMap(map);
							startOverlay.setMap(map);
							//startWindow.open(map, startMarker); 
						}
						
						var length = linePath.length - 1;
						
						if (linePath.length > 1) {
					    	var endMarker = new kakao.maps.Marker({
								position: linePath[length], // 마커를 표시할 위치
								image : endImage // 마커 이미지 
							});

					    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'white',
					    		    zIndex:490
					    		});
					    		this.setZIndex(490);
					    		jsonDrawAllDb[k].startMarker.setZIndex(490);
					    		jsonDrawAllDb[k].startOverlay.setZIndex(480);
					    		jsonDrawAllDb[k].endOverlay.setZIndex(480);
					    		circle.setZIndex(490);
					    	});
					    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'red',
					    		    zIndex:0
					    		});
					    		this.setZIndex(0);
					    		jsonDrawAllDb[k].startMarker.setZIndex(0);
					    		jsonDrawAllDb[k].startOverlay.setZIndex(0);
					    		jsonDrawAllDb[k].endOverlay.setZIndex(0);
					    		circle.setZIndex(0);
					    	});
					    	var iwContent = '<div class="overlay">' + jsonDrawAllDb[k].receive_user_name + ' ' + jsonDrawAllDb[k].arrive_time + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

						    var endOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent,
						        position: endMarker.getPosition()       
						    });
						 
							jsonDrawAllDb[k].endMarker = endMarker;
							jsonDrawAllDb[k].endOverlay = endOverlay;

							if ($("input:checkbox[id='person_btn']").is(":checked")) {
								endMarker.setMap(map);
								endOverlay.setMap(map);
							}
						}
						if ($("input:checkbox[id='person_btn']").is(":checked")) {
							polyline.setMap(map);
							circle.setMap(map);
						}
					});
					lastLocPosition = locPosition;
				}
/* 
				var caseGpsData = data[2];

				console.log(caseGpsData);
				
				Object.keys(caseData).forEach(function(k){
					var endOverlay;
					caseData[k].polyline.setMap(null);
					caseData[k].circle.setMap(null);
					caseData[k].startOverlay.setMap(null);
					if (caseData[k].endOverlay != null) {
						endOverlay = caseData[k].endOverlay;
						endOverlay.setMap(null);
					}
					caseData[k].startMarker.setMap(null);
					if (caseData[k].endMarker != null) {
						endOverlay = caseData[k].endMarker;
						endOverlay.setMap(null);
					}
				});
				
				caseData = new Object();
				
				if (caseGpsData.length > 0) {
			        var imageSize = new kakao.maps.Size(37, 42); 
				       
			        // 마커 이미지를 생성합니다    
			        var startImage = new kakao.maps.MarkerImage(startDroneSrc, imageSize); 
			        var endImage = new kakao.maps.MarkerImage(endDroneSrc, imageSize); 
			        
					var tmpObj = new Object();
					tmpObj.case_idx = "case";
					caseGpsData.push(tmpObj);
					
					var rowNum = 0;

					var linePath = [];
					var circlePath = [];
					var thumbList = [];
					var colorList = [];
					
					var startOverlay;
					var startMarker; 
					var endOverlay;
					var endMarker; 
					
					for (var i = 0; i < caseGpsData.length - 1; i++) {
						var locPosition = new kakao.maps.LatLng(JSON.parse(caseGpsData[i]).gps_wtmx, JSON.parse(caseGpsData[i]).gps_wtmy);
						linePath.push(locPosition);	
						var thumb = JSON.parse(caseGpsData[i]).gps_image;
						thumbList.push(thumb);
						var case_idx = JSON.parse(caseGpsData[i]).case_idx;
						var color = JSON.parse(caseGpsData[i]).gps_color;
						colorList.push(color);
						
						// 동그라미 그리기
						rowNum++;
						
						if (rowNum == 1) {
							// start 마커 그리기
					    	startMarker = new kakao.maps.Marker({
								position: linePath[0], // 마커를 표시할 위치
								image : startImage // 마커 이미지 
							});
							// start 마커 이벤트1 : 마우스 오른쪽 버튼 클릭 시 이벤트 선택 창 나와야됨
							// start 마커 이벤트2 : 마우스 올리면 이어져 있는 선이 흰 색으로 바귐
					    	kakao.maps.event.addListener(startMarker, 'mouseover', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'white',
					    		    zIndex:490
					    		});
					    		this.setZIndex(490);
					    		if (caseData.case_idx.endMarker != null) {
					    			caseData.case_idx.endMarker.setZIndex(490);
					    		}
					    		caseData.case_idx.startOverlay.setZIndex(480);
					    		if (caseData.case_idx.endOverlay != null) {
					    			caseData.case_idx.endOverlay.setZIndex(480);
					    		}
					    		circle.setZIndex(490);
					    	});
					    	kakao.maps.event.addListener(startMarker, 'mouseout', function() {
					    		polyline.setOptions({
					    		    strokeColor: 'red',
					    		    zIndex:0
					    		});
					    		this.setZIndex(0);
					    		if (caseData.case_idx.endMarker != null) {
					    			caseData.case_idx.endMarker.setZIndex(0);
					    		}
					    		caseData.case_idx.startOverlay.setZIndex(0);
					    		if (caseData.case_idx.endOverlay != null) {
					    			caseData.case_idx.endOverlay.setZIndex(0);
					    		}
					    		circle.setZIndex(0);
					    	});

						    var iwContent2 = '<div class="overlay">' + 'case' + case_idx + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						
						    startOverlay = new kakao.maps.CustomOverlay({
						        content: iwContent2,
						        position: startMarker.getPosition()       
						    });
						}
						
						if (caseGpsData[i].case_idx != caseGpsData[i + 1].case_idx) {
							colorList.push(color);

							//positionObject.polyline = polyline;
							//circlePath.push(circle);
							//positionObject.circle = circlePath;
							var positionObject = new Object();
							positionObject.linePath = linePath;
							positionObject.thumbList = thumbList;
							positionObject.colorList = colorList;
							positionObject.startTime = JSON.parse(caseGpsData[i]).imgTime;
							positionObject.imgTime = JSON.parse(caseGpsData[i]).imgTime;

							caseData.case_idx = positionObject;
							//eval('caseData.' + case_idx + '= positionObject');
							
							if (rowNum > 1) {
								// end 마커 그리기
								// end 마커 이벤트1 : 마우스 올리면 이어져 있는 선이 흰 색으로 바귐
								// 원을 잇는 라인 그리기
						    	var endMarker = new kakao.maps.Marker({
									position: locPosition, // 마커를 표시할 위치
									image : endImage // 마커 이미지 
								});
	
						    	kakao.maps.event.addListener(endMarker, 'mouseover', function() {
						    		polyline.setOptions({
						    		    strokeColor: 'white',
						    		    zIndex:490
						    		});
						    		this.setZIndex(490);
						    		caseData.case_idx.startMarker.setZIndex(490);
						    		caseData.case_idx.startOverlay.setZIndex(480);
						    		caseData.case_idx.endOverlay.setZIndex(480);
						    	});
						    	kakao.maps.event.addListener(endMarker, 'mouseout', function() {
						    		polyline.setOptions({
						    		    strokeColor: 'yellow',
						    		    zIndex:0
						    		});
						    		this.setZIndex(0);
						    		caseData.case_idx.startMarker.setZIndex(0);
						    		caseData.case_idx.startOverlay.setZIndex(0);
						    		caseData.case_idx.endOverlay.setZIndex(0);
						    	});
	
						    	kakao.maps.event.addListener(endMarker, 'rightclick', function() {
						    		var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">' + getTranslate('open') + '</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">' + getTranslate('gallery') + '</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">' + getTranslate('stitchingView') + '</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">' + getTranslate('droneRoute') + '</div></div>'
						    		//var content = '<div id="rightOveray"><div class="rightDiv" onclick="openPage(' + "'" + k + "'" + ');">열기</div><div class="rightDiv" onclick="openGallery(' + "'" + k + "'" + ');">갤러리</div><div class="rightDiv" onclick="openStitching(' + "'" + k + "'" + ');">스티칭 뷰</div><div class="rightDiv" onclick="openDroneRoute(' + "'" + k + "'" + ');">드론 경로</div></div>'
						    		customOverlay.setContent(content);
						    		customOverlay.setPosition(linePath[linePath.length - 1]); 
						    		customOverlay.setMap(map);
						    	});
						    	
						    	jsonImage[k].endMarker = endMarker;
						    	
						    	var iwContent = '<div class="droneOverlay">' + jsonImage[k].imgTime + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	
							    var endOverlay = new kakao.maps.CustomOverlay({
							        content: iwContent,
							        position: endMarker.getPosition()       
							    });
	
								jsonImage[k].endOverlay = endOverlay;
								
								if ($("input:checkbox[id='drone_btn']").is(":checked")) {
									endMarker.setMap(map);
									endOverlay.setMap(map);
								}
							}
							rowNum = 0;
						}
					}
				} */
				
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	} else {
		alert(getTranslate('canNotUseMap'));
	}
}
function setCookie(name, value, exp) {
    var date = new Date();
    // ms단위기에 1초로 변환->60초->60분->24시간->최종적으로 day
    date.setTime(date.getTime() + (1000 * 24 * 60 * 60 * exp));
    
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}
function getCookie(name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
}
function openPage(case_num) {
	var jsonUrl = "/police/selectAnalyzeContent";
	var jsonObject = new Object();
	jsonObject.case_num = case_num;
	
	var jsonData = JSON.stringify(jsonObject);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
        async: false,
		success: function (data) {
			var open_url = '/police/main.htm?caseNum=' + case_num + '&analyze_content=' + data.analyze_content;

			window.open(open_url, 'situation_open', 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no');
			
		}, error: function(errorThrown) {
		}
	}); 
}
function openGallery(case_num) {
	var url = '/police/gallery.htm';
	if (case_num != null && case_num != '') {
		url += '?caseNum=' + case_num;
	}

	window.open(url, 'situation_gallery', 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
}
function openStitching(src) {
	var jsonUrl = "/police/isStitchingImage";
	var obj = new Object();
	
	obj.img_name = src;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			if (data == 'N') {
				alert(getTranslate('needToUploadStitchingImage'));
			} else {
				window.open(data, 'situation_stitching', 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 0, left = 0, location = no');		
			}
		},
		error: function(errorThrown) {
			//alert(errorThrown.statusText);
			//alert(JSON.stringify(data));
		}
	}); 
}
function openDroneRoute(caseNum) {
	var open_url = '/police/drone?caseNum=' + caseNum;
	
	window.open(open_url, 'situation_droneRoute', 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
}
function showNotice(option) {
	if (option == 'person') {
		$('#personNotice').css('z-index', 490);
		$('#personNotice').show();
	} else {
		$('#droneNotice').css('z-index', 490);
		$('#droneNotice').show();
	}
}
function hideNotice(option) {
	if (option == 'person') {
		$('#personNotice').css('z-index', 0);
		$('#personNotice').hide();
	} else {
		$('#droneNotice').css('z-index', 0);
		$('#droneNotice').hide();
	}
}
</script>
</head>
<body>
<div class="map_wrap">
	<div id="map"></div>
	<div class="MapControlView">
		<a class="accessLocation" href="#none" onclick="changeCenter(); return false;" onmouseover="showNotice('person');" onmouseout="hideNotice('person');">
			<!-- <span class="screen_out">현위치</span> -->
			<!-- <span class="coach_accessLocation"></span> -->
		</a>
	</div>
	<div id="personNotice">
		<span><spring:message code="situationBoard.latestRealTimeLocation" /></span>
	</div>
	<div id="recentDrone">
		<a id="droneCenter" onclick="changeDroneCenter(); return false;" onmouseover="showNotice('drone');" onmouseout="hideNotice('drone');">
			<i id="droneCenter_i"></i>
		</a>
	</div>
	<div id="droneNotice">
		<span><spring:message code="situationBoard.RecentlyAnalyzedImageLocation" /></span>
	</div>
	<div class="btn_div">
		<div id="setup_div">
			<div id="btn_top">
				<spring:message code="situationBoard.setup" />
				<span class="glyphicon glyphicon-cog" aria-hidden="true" id="btn_top_arrow"></span>
			</div>
			<div id="btn_bottom">
				<table>
					<tr>
						<td id="date_td">
							<div id="date_div">
								<label>
									<input name="date_btn" type="checkbox" id="date_btn" checked> <spring:message code="situationBoard.viewSearchDate" />
								</label>
								<div class="input-daterange" id="datepicker">
								    <input type="text" class="input-small" name="start" id="date_start" />
								    <span> ~ </span>
								    <input type="text" class="input-small" name="end" id="date_end" />
								    <button id="data_btn" onclick="selectDroneData();"><spring:message code="situationBoard.apply" /></button>
							    </div>
							</div>
						</td>
						<td id="receive_td">
							<div id="receive_div">
								<label>
									<input name="receive_btn" type="checkbox" id="receive_btn" checked> <spring:message code="situationBoard.realTimeUpdate" />
								</label>
							</div>
						</td>
						<td id="category_title_td">
							<div>
								<label>
									<spring:message code="situationBoard.category" />
								</label>
							</div>
						</td>
						<td id="category_content_td">
							<div >
								<label>
									<input name="" type="checkbox" id="drone_btn" checked> <spring:message code="situationBoard.drone" />
								</label>
							</div>
							<div>
								<label>
									<input name="" type="checkbox" id="person_btn" checked> <spring:message code="situationBoard.searchPath" />
								</label>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="drone_notice">
			<div id="drone_notice_top">
				<spring:message code="situationBoard.analysisHistory" />
				<span class="glyphicon glyphicon-list-alt" aria-hidden="true" id="drone_notice_top_arrow"></span>
			</div>
			<div id="drone_notice_bottom">
				
			</div>
		</div>
	</div>
</div>
</body>
</html>