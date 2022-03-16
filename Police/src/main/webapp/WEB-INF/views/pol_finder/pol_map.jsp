<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>���� ����</title>
<script src="./resources/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="./resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_A.css">
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_B.css">
<!-- <link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_C.css"> -->
<link rel="stylesheet" href="./resources/css/app_C.css">
<link rel="stylesheet" href="//t1.daumcdn.net/kakaomapweb/map/202103251400738/app_D.css">
<style>
html, body {
	width:100%;
	height:100%;
}
.map_wrap {width: 100%; height:100%; position: relative;}
.exitBtn {position: absolute;top: 10px;left: 10px;z-index: 1;}
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
/* #room_user_name {
	margin-bottom:5px;
}
#room_name {
	margin-bottom:5px;
}
#room_limited {
} */
.btn_div {
	position:absolute;
	top:165px;
	left:10px;
	z-index:1;
	background:#ffffff;
	padding:10px;
	border-radius:2px;
	border:1px solid #dbdbdb;
	box-shadow:0 1px 1px rgb(0 0 0 / 4%);
}
#drawingMap{width: 100%;height: 100%;}
.info {position:relative;top:5px;left:5px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;font-size:12px;padding:5px;background:#fff;list-style:none;margin:0;} 
.info:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}  
/* .info {
	display:none;
}  */
.label2 {display:inline-block;width:50px;}
.number {font-weight:bold;color:#00a0e9;}
.exitBtn button:hover {
	background-color:#fcfcfc;
	/* border:1px solid #c1c1c1; */
}
.exitBtn button {
	padding:7px 12px;
	margin:0 6px 4px 0;
	background-color:#fff;
	border-radius:3px;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	outline:0;
	border:2px solid #fcfcfc;
	box-shadow:2px 2px 4px;
}
.exitBtn button:active {
	box-shadow: 0px 0px 0px;
}
button:focus {
	outline: 0;
}
.MapControlView {
	position:absolute;
	top:149px;
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
</style>
</head>
<body>
<div class="map_wrap">
    <div id="drawingMap"></div>
    <div class="exitBtn">
		<button onclick="deleteCookie('pol_room');">�� ������</button>
	</div>
	<div class="MapControlView">
		<a class="accessLocation" href="#none" onclick="changeCenter(); return false;">
			<span class="screen_out">����ġ</span>
			<span class="coach_accessLocation"></span>
		</a>
	</div>
	<div class="room_info">
		<div><label id="room_user_name">��ȭ�� : </label></div>
		<div><label id="room_name">�� �̸� : </label></div>
		<div><label id="room_limited">���ð� : </label></div>
	</div>
	<div class="btn_div">
		<div id="history_div">
			<label>
				<input name="history_btn" type="checkbox" onclick="showHistory();"> �����丮 ����
			</label>
		</div>
		<div id="disappear_div">
			<label>
				<input name="gps_btn" type="checkbox" onclick="hideGps();"> ��ǥ ������ �ʱ�
			</label>
		</div>
	</div>
    <!-- <p class="getdata">
        <button onclick="selectOverlay('MARKER')">����</button>
        <button onclick="selectOverlay2('MARKER')">������</button>
        <button onclick="selectOverlay3('MARKER')">�⺻</button>
    	<button onclick="selectOverlay('CIRCLE')">��</button>
	    <button onclick="selectOverlay('RECTANGLE')">�簢��</button>
		<button onclick="selectOverlay('POLYLINE')">��</button>
		<button onclick="deleteCookie('pol_room');">�� ������</button>
		<p id="result"></p>
		<button onclick="setCookie('pol_room', getCookie('pol_room'), -1) location.replace('pol_main');">��Ű ������</button>
    </p> -->
</div>
<script>
var center;
var isdrawned = true;
var length_array = new Array();
var center_array = new Array();
var radius_array = new Array();
var figure = 0;
var rect_array = new Array();
var jsonDraw = new Object();
var jsonOverlay = new Object();
var room_count = 1;
var update_array = new Array();
var jsonDrawAll = new Object();
var time = 1;
// Drawing Manager�� ������ �׸� ���� div
$(document).ready(function () {
	if (getCookie('pol_app') == null) {
		location.replace('pol_login');
	} else if (getCookie('pol_room') == null) {
		location.replace('pol_main');
	}
	//alert(getCookie('pol_room'));
	var jsonUrl = "/police/pol_getRoomUserAll";
	var jsonObject = new Object();
	//alert(JSON.stringify(JSON.parse(getCookie('pol_room')).room_name) + " / " + parseInt(JSON.parse(getCookie('pol_room')).hidden_room_idx));
	jsonObject.room_name = (JSON.parse(getCookie('pol_room')).room_name);
	jsonObject.room_idx = parseInt(JSON.parse(getCookie('pol_room')).hidden_room_idx);
	jsonObject.room_isclose = 'N';
	jsonObject.room_isexit = 'N';		// ��ȭ �濡�� ������ ���� ���� �ִ� ��
	jsonObject.room_create_date = JSON.parse(getCookie('pol_room')).room_create_date;
	
	var jsonData = JSON.stringify(jsonObject);
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
        async: true,
		success: function (data) {
			$('#room_user_name').text('��ȭ�� : ' + JSON.parse(getCookie('pol_room')).room_user_name);
			$('#room_limited').text('���ð� : ' + JSON.parse(getCookie('pol_room')).room_close_date.split(':')[0] + '�� ' + JSON.parse(getCookie('pol_room')).room_close_date.split(':')[1] + '��');
			if (data.length > 0) {
				for (var k = 0; k < data.length; k++) {
					var locPosition = new kakao.maps.LatLng(data[k].room_gps_la, data[k].room_gps_ma);
					
					var linePath = [];
					
					var color = 'blue';
					var lineColor = 'blue';
					
					if (eval('jsonDraw.' +  data[k].room_user_name) != null) {
						linePath = eval('jsonDraw.' +  data[k].room_user_name + '.linePath');
						linePath.push(locPosition);
						eval('jsonDraw.' +  data[k].room_user_name + '.linePath = linePath');
						eval('jsonDraw.' +  data[k].room_user_name + '.locPosition = locPosition');
					} else {
						linePath.push(locPosition);

						if (JSON.parse(getCookie('pol_room')).room_user_name == data[k].room_user_name) {
							color = 'red';
							lineColor = '#ffffff';
							var cookie = JSON.parse(getCookie('pol_room'));
							cookie.room_recent_gps = data[k].room_gps_ma + "," + data[k].room_gps_la;
							setCookie("pol_room", JSON.stringify(cookie), 1);
						} else if (data[k].room_isadmin == 'Y') {
							color = 'purple';
							lineColor = 'purple';
						} else if (data[k].room_isexit == 'Y') {
							color = 'gray';
							lineColor = 'gray';
						}

						var positionObject = new Object();
						positionObject.color = color;
						positionObject.lineColor = lineColor;
						positionObject.locPosition = locPosition;
						positionObject.room_isexit = data[k].room_isexit;
						positionObject.linePath = linePath;
						
						eval('jsonDraw.' + data[k].room_user_name + '= positionObject');
					}

					if (JSON.parse(getCookie('pol_room')).room_user_name == data[k].room_user_name) {
						drawingMap.panTo(locPosition);
					}
				}
				Object.keys(jsonDraw).forEach(function(k){
				    if (jsonDraw[k].room_isexit != 'Y' && jsonDraw[k].room_user_name != JSON.parse(getCookie('pol_room')).room_user_name) {
				    	room_count++;
				    }

					var locPosition = jsonDraw[k].locPosition;
					var linePath = jsonDraw[k].linePath;
					var color = jsonDraw[k].color;
					var lineColor = jsonDraw[k].lineColor;
					
					var circle = new kakao.maps.Circle({
						center : locPosition,  // ���� �߽���ǥ �Դϴ� 
						radius: 5, // ���� ������ ���� �������Դϴ� 
						strokeWeight: 2, // ���� �β��Դϴ� 
						strokeColor: lineColor, // ���� �����Դϴ�
						strokeOpacity: 1, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
						strokeStyle: 'line', // ���� ��Ÿ�� �Դϴ�
						fillColor: color, // ä��� �����Դϴ�
						fillOpacity: 0.7  // ä��� ������ �Դϴ�   
					});
					
					var polyline = new kakao.maps.Polyline({
					    path: linePath, // ���� �����ϴ� ��ǥ�迭 �Դϴ�
					    strokeWeight: 2, // ���� �β� �Դϴ�
					    strokeColor: color, // ���� �����Դϴ�
					    strokeOpacity: 0.7, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
					    strokeStyle: 'line' // ���� ��Ÿ���Դϴ�
					});
					
					jsonDraw[k].circle = circle;
					jsonDraw[k].polyline = polyline;
					
				    circle.setMap(drawingMap);
				});
				
				/* if (room_count == 0) {
					alert('���� ���Դϴ�.');
					setCookie('pol_room', getCookie('pol_room'), -1)
					location.replace('pol_main');
				} */
				
				//room_count = Object.keys(jsonDraw).length;
			}/*  else {
				alert('���� ���Դϴ�.');
				setCookie('pol_room', getCookie('pol_room'), -1)
				location.replace('pol_main');
			} */
			$('#room_name').text('�� �̸� : ' + JSON.parse(getCookie('pol_room')).room_name + ' (' + (room_count) + '��)');
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	}); 
	
	var websocketUrl = '/police/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/exitRoom', function (message) {
			if (JSON.parse(getCookie('pol_room')).hidden_room_idx == JSON.parse(message.body).room_idx) {	//  && JSON.parse(getCookie('pol_room')).room_isadmin != 'Y'
				alert('���� ���Ǿ����ϴ�.');
				setCookie('pol_room', getCookie('pol_room'), -1)
				location.replace('pol_main');
			}
		});
		stompClient.subscribe('/exitRoomUser', function (message) {
			if (JSON.parse(getCookie('pol_room')).hidden_room_idx == JSON.parse(message.body).room_idx) {
				if (eval('jsonDraw.' + JSON.parse(message.body).room_user_name) != null) {
					eval('jsonDraw.' + JSON.parse(message.body).room_user_name + ".circle.setOptions({fillColor : 'gray'})");
				}
				if (document.getElementsByName('history_btn')[0].checked) {
					if (eval('jsonDraw.' + JSON.parse(message.body).room_user_name) != null) {
						eval('jsonDraw.' + JSON.parse(message.body).room_user_name + ".polyline.setOptions({strokeColor : 'gray'});");
					}
				}
			}
			room_count--;
			$('#room_name').text('�� �̸� : ' + JSON.parse(getCookie('pol_room')).room_name + ' (' + room_count + '��)');
		});
		stompClient.subscribe('/insertRoomUser', function (message) {
			if (JSON.parse(getCookie('pol_room')).hidden_room_idx == JSON.parse(message.body).room_idx) {
				var json = JSON.parse(message.body);
				
				var locPosition = new kakao.maps.LatLng(json.room_gps_la, json.room_gps_ma);
				
				var color = 'blue';
				var lineColor = 'blue';
				
				var linePath = [];
				
				if (JSON.parse(getCookie('pol_room')).room_user_name != JSON.parse(message.body).room_user_name) {
					room_count++;
					$('#room_name').text('�� �̸� : ' + JSON.parse(getCookie('pol_room')).room_name + ' (' + room_count + '��)');
				}

				if (JSON.parse(getCookie('pol_room')).room_user_name == json.room_user_name) {
					color = 'red';
					lineColor = '#ffffff';
					var cookie = JSON.parse(getCookie('pol_room'));
					cookie.room_recent_gps = json.room_gps_ma + "," + json.room_gps_la;
					setCookie("pol_room", JSON.stringify(cookie), 1);
				} else if (json.room_isadmin == 'Y') {
					color = 'purple';
					lineColor = 'purple';
				}

				if (eval('jsonDraw.' + json.room_user_name) != null) {
					linePath = eval('jsonDraw.' +  json.room_user_name + '.linePath');
					linePath.push(locPosition);
					eval('jsonDraw.' +  json.room_user_name + '.linePath = linePath');
					eval('jsonDraw.' +  json.room_user_name + '.locPosition = locPosition');
					eval('jsonDraw.' +  json.room_user_name + '.color = color');
					eval('jsonDraw.' +  json.room_user_name + '.lineColor = lineColor');
				} else {
					linePath.push(locPosition);
					
					var positionObject = new Object();
					positionObject.color = color;
					positionObject.lineColor = lineColor;
					positionObject.locPosition = locPosition;
					positionObject.room_isexit = json.room_isexit;
					positionObject.linePath = linePath;

					var circle = new kakao.maps.Circle({
						center : locPosition,  // ���� �߽���ǥ �Դϴ� 
						radius: 5, // ���� ������ ���� �������Դϴ� 
						strokeWeight: 2, // ���� �β��Դϴ� 
						strokeColor: lineColor, // ���� �����Դϴ�
						strokeOpacity: 1, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
						strokeStyle: 'line', // ���� ��Ÿ�� �Դϴ�
						fillColor: color, // ä��� �����Դϴ�
						fillOpacity: 0.7  // ä��� ������ �Դϴ�   
					});
					
					var polyline = new kakao.maps.Polyline({
					    path: linePath, // ���� �����ϴ� ��ǥ�迭 �Դϴ�
					    strokeWeight: 2, // ���� �β� �Դϴ�
					    strokeColor: color, // ���� �����Դϴ�
					    strokeOpacity: 0.7, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
					    strokeStyle: 'line' // ���� ��Ÿ���Դϴ�
					});
					
					positionObject.circle = circle;
					positionObject.polyline = polyline;
					
					eval('jsonDraw.' + json.room_user_name + '= positionObject');

					if (document.getElementsByName('gps_btn')[0].checked) {
					} else {
					    circle.setMap(drawingMap);
					    if (document.getElementsByName('history_btn')[0].checked) {
							polyline.setMap(drawingMap);
					    }
					}
				}
			}
		});
		stompClient.subscribe('/pol_test', function (message) {
			getDataFromDrawingMap(JSON.parse(message.body));
			drawRectangle(JSON.parse(message.body));
		    //drawRectangle(JSON.parse(message.body)[kakao.maps.drawing.OverlayType.RECTANGLE]);
			/* if (JSON.parse(getCookie('pol_room')).hidden_room_idx == JSON.parse(message.body).room_idx && JSON.parse(getCookie('pol_room')).room_isadmin != 'Y') {
				
			} */
		});
		stompClient.subscribe('/pol_update', function (message) {
			if (JSON.parse(getCookie('pol_room')).hidden_room_idx == JSON.parse(message.body).room_idx) {
				update_array.push(JSON.parse(message.body));
			}
		});
	});
});
var drawingMapContainer = document.getElementById('drawingMap'),
    drawingMap = { 
        center: new kakao.maps.LatLng(JSON.parse(getCookie('pol_app')).app_first_gps.split(', ')[0], JSON.parse(getCookie('pol_app')).app_first_gps.split(', ')[1]), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ����
    };

// ������ ǥ���� div��  ���� �ɼ�����  ������ �����մϴ�
var drawingMap = new kakao.maps.Map(drawingMapContainer, drawingMap),
overlays = [];
var mapTypeControl = new kakao.maps.MapTypeControl();
// ���� ������ ���� ���� Ÿ�� ��Ʈ���� ǥ�õǵ��� ������ ��Ʈ���� �߰��Ѵ�.
drawingMap.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
var circle_latlng;

var options = { // Drawing Manager�� ������ �� ����� �ɼ��Դϴ�
    map: drawingMap, // Drawing Manager�� �׸��� ��Ҹ� �׸� map ��ü�Դϴ�
    drawingMode: [ // Drawing Manager�� ������ �׸��� ��� ����Դϴ�
        kakao.maps.drawing.OverlayType.MARKER,
        kakao.maps.drawing.OverlayType.CIRCLE,
        kakao.maps.drawing.OverlayType.RECTANGLE,
        kakao.maps.drawing.OverlayType.POLYLINE
    ],
    // ����ڿ��� ������ �׸��� ���̵� �����Դϴ�
    // ����ڿ��� ������ �׸���, �巡���Ҷ�, �����Ҷ� ���̵� ������ ǥ���ϵ��� �����մϴ�
    //guideTooltip: ['draw', 'drag', 'edit'], 
    guideTooltip: ['draw', 'edit'],
    markerOptions: { // ��Ŀ �ɼ��Դϴ� 
        draggable: true, // ��Ŀ�� �׸��� ���� �巡�� �����ϰ� �մϴ� 
        removable: true, // ��Ŀ�� ���� �� �� �ֵ��� x ��ư�� ǥ�õ˴ϴ�  
        markerImages: [
            {
                src: '/resources/image/test/KakaoTalk_20210217_173203443.jpg',
                width: 50,
                height: 55,
                shape: 'rect',
                coords: '0,0,31,35'
            }
        ]
    },
    circleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f',
        fillColor: '#39f',
        fillOpacity: 0.5
    },
    rectangleOptions: {
        draggable: true,
        removable: true,
        editable: true,
        strokeColor: '#39f', // �ܰ��� ��
        fillColor: '#39f', // ä��� ��
        fillOpacity: 1 // ä���� ����, default : 0.5
    },
    polylineOptions: {
        draggable: true, // �׸� �� �巡�װ� �����ϸ� guideTooltip�ɼǿ� 'drag'�� ���Ե� ��� ������ ǥ�õȴ�
        removable: true, // �׸� �� ���� �� �� �ֵ��� x ��ư�� ǥ�õȴ�
        editable: true, // �׸� �� ������ �� �ֵ��� ���� �簢���� ǥ�õǸ� guideTooltip�ɼǿ� 'edit'�� ���Ե� ��� ������ ǥ�õȴ�
        strokeColor: '#39f', // �� ��
        hintStrokeStyle: 'dash', // �׸��� ���콺�� ����ٴϴ� �������� �� ��Ÿ��
        hintStrokeOpacity: 0.5  // �׸��� ���콺�� ����ٴϴ� �������� ����
    }
};

var options2 = { // Drawing Manager�� ������ �� ����� �ɼ��Դϴ�
    map: drawingMap, // Drawing Manager�� �׸��� ��Ҹ� �׸� map ��ü�Դϴ�
    drawingMode: [ // Drawing Manager�� ������ �׸��� ��� ����Դϴ�
        kakao.maps.drawing.OverlayType.MARKER
    ],
    // ����ڿ��� ������ �׸��� ���̵� �����Դϴ�
    // ����ڿ��� ������ �׸���, �巡���Ҷ�, �����Ҷ� ���̵� ������ ǥ���ϵ��� �����մϴ�
    guideTooltip: ['draw', 'drag', 'edit'], 
    markerOptions: { // ��Ŀ �ɼ��Դϴ� 
        draggable: true, // ��Ŀ�� �׸��� ���� �巡�� �����ϰ� �մϴ� 
        removable: true, // ��Ŀ�� ���� �� �� �ֵ��� x ��ư�� ǥ�õ˴ϴ�  
        markerImages: [
            {
                src: '/resources/image/test/KakaoTalk_20200629_004005067.jpg',
                width: 50,
                height: 55,
                shape: 'rect',
                coords: '0,0,31,35'
            }
        ]
    }
};

var options3 = { // Drawing Manager�� ������ �� ����� �ɼ��Դϴ�
    map: drawingMap, // Drawing Manager�� �׸��� ��Ҹ� �׸� map ��ü�Դϴ�
    drawingMode: [ // Drawing Manager�� ������ �׸��� ��� ����Դϴ�
        kakao.maps.drawing.OverlayType.MARKER
    ],
    // ����ڿ��� ������ �׸��� ���̵� �����Դϴ�
    // ����ڿ��� ������ �׸���, �巡���Ҷ�, �����Ҷ� ���̵� ������ ǥ���ϵ��� �����մϴ�
    guideTooltip: ['draw', 'drag', 'edit'], 
    markerOptions: { // ��Ŀ �ɼ��Դϴ� 
        draggable: true, // ��Ŀ�� �׸��� ���� �巡�� �����ϰ� �մϴ� 
        removable: true // ��Ŀ�� ���� �� �� �ֵ��� x ��ư�� ǥ�õ˴ϴ�  
    }
};

// ���� �ۼ��� �ɼ����� Drawing Manager�� �����մϴ�
var manager = new kakao.maps.drawing.DrawingManager(options);
var manager2 = new kakao.maps.drawing.DrawingManager(options2);
var manager3 = new kakao.maps.drawing.DrawingManager(options3);

function setCookie(name, value, exp) {
    var date = new Date();
    // ms�����⿡ 1�ʷ� ��ȯ->60��->60��->24�ð�->���������� day
    date.setTime(date.getTime() + (1000 * 24 * 60 * 60 * exp));
    
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}
function getCookie (name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
}
function deleteCookie (name) {
	if (JSON.parse(getCookie('pol_room')).room_isadmin == 'Y') {
		if (confirm('������ ������ ��� ���� ���˴ϴ�. ���� �����ðڽ��ϱ�?')) {
			var jsonUrl = "/police/pol_exitRoom";
			var jsonObject2 = new Object();
			
			jsonObject2.room_user_name = (JSON.parse(getCookie('pol_room')).room_user_name);
			jsonObject2.room_name = (JSON.parse(getCookie('pol_room')).room_name);
			jsonObject2.room_idx = parseInt(JSON.parse(getCookie('pol_room')).hidden_room_idx);
			jsonObject2.room_isadmin = (JSON.parse(getCookie('pol_room')).room_isadmin);
			jsonObject2.room_isexit = 'N';		// ��ȭ �濡�� ������ ���� ���� �ִ� ��
			
			var jsonData = JSON.stringify(jsonObject2);
			
			$.ajax({
				type : "POST",                        	 	     
				url : jsonUrl,                      		
				dataType : "json",                        	  
				contentType : "application/json; charset=UTF-8",         
				data : jsonData,          		
		        async: false,
				success: function (data) {
				}, error: function(errorThrown) {
					//alert(errorThrown.statusText);
				}
			}); 
			setCookie(name, getCookie(name), -1)
			/* var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = name + '= ; expires=' + expireDate.toGMTString(); */

			location.replace('pol_main');
		}
	} else {
		var jsonUrl = "/police/pol_exitRoom";
		var jsonObject2 = new Object();
		
		jsonObject2.room_user_name = (JSON.parse(getCookie('pol_room')).room_user_name);
		jsonObject2.room_name = (JSON.parse(getCookie('pol_room')).room_name);
		jsonObject2.room_idx = parseInt(JSON.parse(getCookie('pol_room')).hidden_room_idx);
		jsonObject2.room_isadmin = (JSON.parse(getCookie('pol_room')).room_isadmin);
		jsonObject2.room_isexit = 'N';		// ��ȭ �濡�� ������ ���� ���� �ִ� ��
		
		var jsonData = JSON.stringify(jsonObject2);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
	        async: false,
			success: function (data) {
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
		setCookie(name, getCookie(name), -1)
		/* var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = name + '= ; expires=' + expireDate.toGMTString(); */

		location.replace('pol_main');
		
	}
}
function showHistory() {
	var chk = document.getElementsByName('history_btn')[0].checked;
	var chk2 = document.getElementsByName('gps_btn')[0].checked;

	if (chk) {
		if (chk2) {
			$("input:checkbox[name='gps_btn']").prop('checked', false);
			Object.keys(jsonDraw).forEach(function(k){
				jsonDraw[k].circle.setMap(drawingMap);
			});
		}

		Object.keys(jsonDraw).forEach(function(k){
			jsonDraw[k].polyline.setMap(drawingMap);
		});
	} else {
		Object.keys(jsonDraw).forEach(function(k){
			jsonDraw[k].polyline.setMap(null);
		});
	}
}
function showHistory1() {
	var chk = document.getElementsByName('history_btn')[0].checked;
	var chk2 = document.getElementsByName('gps_btn')[0].checked;

	if (chk) {
		$("input:checkbox[name='gps_btn']").prop('checked', false);

		var jsonUrl = "/police/pol_getRoomUserAll";
		var jsonObject = new Object();
		jsonObject.room_name = (JSON.parse(getCookie('pol_room')).room_name);
		jsonObject.room_idx = parseInt(JSON.parse(getCookie('pol_room')).hidden_room_idx);
		jsonObject.room_isclose = 'N';

		var jsonData = JSON.stringify(jsonObject);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
	        async: true,
			success: function (data) {
				if (data.length > 0) {
					for (var k = 0; k < data.length; k++) {
						var linePath = [];
						
						var color = 'blue';
						var lineColor = 'blue';
						
						if (JSON.parse(getCookie('pol_room')).room_user_name == data[k].room_user_name) {
							color = 'red';
							lineColor = '#ffffff';
						} else if (data[k].room_isadmin == 'Y') {
							color = 'purple';
							lineColor = 'purple';
						} else if (data[k].room_isexit == 'Y') {
							color = 'gray';
							lineColor = 'gray';
						}
						
						locPosition = new kakao.maps.LatLng(data[k].room_gps_la, data[k].room_gps_ma);
						
						if (eval('jsonDraw.' + data[k].room_user_name) != null) {
							linePath = eval('jsonDraw.' + data[k].room_user_name + '.polyline.getPath()');
							linePath.push(new kakao.maps.LatLng(data[k].room_gps_la, data[k].room_gps_ma));
							eval('jsonDraw.' + data[k].room_user_name + '.polyline.setPath(linePath)');
							eval('jsonDraw.' + data[k].room_user_name + ".room_isexit = '" + data[k].room_isexit + "'");
						} else {
							linePath.push(new kakao.maps.LatLng(data[k].room_gps_la, data[k].room_gps_ma));
							
							var polyline = new kakao.maps.Polyline({
							    path: linePath, // ���� �����ϴ� ��ǥ�迭 �Դϴ�
							    strokeWeight: 2, // ���� �β� �Դϴ�
							    strokeColor: color, // ���� �����Դϴ�
							    strokeOpacity: 0.7, // ���� ������ �Դϴ� 1���� 0 ������ ���̸� 0�� �������� �����մϴ�
							    strokeStyle: 'line' // ���� ��Ÿ���Դϴ�
							});

							var positionObject = new Object();
							positionObject.polyline = polyline;
							positionObject.room_isexit = data[k].room_isexit;
							//positionObject.areaOverlay = areaOverlay;
							
							eval('jsonDraw.' + data[k].room_user_name + '= positionObject');

							polyline.setMap(drawingMap);
						}
					}
				} else {
					/* alert('���� ���Դϴ�.');
					setCookie('pol_room', getCookie('pol_room'), -1)
					location.replace('pol_main'); */
				}
				if (chk2) {
					Object.keys(jsonDraw).forEach(function(k){
					    jsonDraw[k].circle.setMap(drawingMap);
					});
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	} else {
		Object.keys(jsonDrawAll).forEach(function(k){
			jsonDrawAll[k].polyline.setMap(null);
		});
		jsonDrawAll = new Object();
	}
}
function hideGps() {
	var chk = document.getElementsByName('gps_btn')[0].checked;
	var chk2 = document.getElementsByName('history_btn')[0].checked;
	
	if (chk) {
		$("input:checkbox[name='history_btn']").prop('checked', false);
		Object.keys(jsonDraw).forEach(function(k){
			jsonDraw[k].polyline.setMap(null);
		    jsonDraw[k].circle.setMap(null);
		});
		
	} else {
		Object.keys(jsonDraw).forEach(function(k){
		    jsonDraw[k].circle.setMap(drawingMap);
		});
	}
}
function changeCenter() {
	var locPosition = new kakao.maps.LatLng(JSON.parse(getCookie('pol_app')).app_first_gps.split(', ')[0], JSON.parse(getCookie('pol_app')).app_first_gps.split(', ')[1]);
	if (JSON.parse(getCookie('pol_room')).room_recent_gps != null && JSON.parse(getCookie('pol_room')).room_recent_gps != '') {
		locPosition = new kakao.maps.LatLng(JSON.parse(getCookie('pol_room')).room_recent_gps.split(',')[1], JSON.parse(getCookie('pol_room')).room_recent_gps.split(',')[0]);
	}
	drawingMap.panTo(locPosition);
}
function updateGpsDuration(time) {
	if (update_array.length > 0) {
		for (var i = 0; i < update_array.length; i++) {
			var json = update_array.shift();
			
			var locPosition = new kakao.maps.LatLng(json.room_recent_gps.split(',')[0], json.room_recent_gps.split(',')[1]);
			var linePath = [];
			
			if (eval('jsonDraw.' + json.room_user_name) != null) {
				linePath = eval('jsonDraw.' +  json.room_user_name + '.linePath');
				linePath.push(locPosition);
				eval('jsonDraw.' +  json.room_user_name + '.linePath = linePath');
				eval('jsonDraw.' +  json.room_user_name + '.locPosition = locPosition');
				eval('jsonDraw.' + json.room_user_name + '.circle.setPosition(locPosition)');
				eval('jsonDraw.' + json.room_user_name + '.polyline.setPath(linePath)');
			}
		}
	}
	setTimeout("updateGpsDuration(" + time + ")", (time * 1000)); 
}
updateGpsDuration(time);
</script>
</body>
</html>