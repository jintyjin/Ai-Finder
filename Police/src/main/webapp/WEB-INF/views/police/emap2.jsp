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
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/exif-js"></script> -->
<script type="text/javascript" src="./resources/func/exif.js"></script>
<style>
html{
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
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
	color:white;
	background-color:#b3b3b3;
}
table {
	background-color:#b3b3b3;
}
td {
	background-color:#252525;
}
.container-fluid {
	height:100%;
	width:100%;
	margin:0;
	padding:0;
	background-color:#252525;
}
img {
	margin:0;
	padding:0;
}
div {
	margin:0;
	padding:0;
}
.selectImage {
	border:2px solid yellow;
}
#labelBtn {
    width: 100%;
    height: 100%;
    border: none;
    border-radius: 3px;
    padding: 0;
    margin: 0;
    background-color: rgb(30, 144, 255);
}
/* The Modal (background) */
.modal2 {
	display:block;
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */ 
	padding-top:250px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
.modal_hide2 {
	display: none; /* Hidden by default */
}
/* Modal Content */
.modal-content2 {
  background-color: #252525;
  margin: auto;
  /* padding: 20px; */
  border: none;
  width: 800px;
  display:block;
  /* flex-direction:inherit; */
}
.btnDiv2 {
	width:100%;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.contentDiv2 {
	width:100%;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.checkBtn2 {
	width:60px;
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
	margin-right:15px;
}
.checkBtn2:hover {
	color:#1c97ea;
}
.checkBtn2:active {
	box-shadow: 0 #666;
}
.closeDiv6 {
	width:100%;
	padding-left:15px;
	/* padding-right:15px; */
	/* padding-top:20px; */
	/* padding-bottom:20px; */
	text-align-last:right;
}
.closeBtn6 {
	/* width:60px; */
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
	margin-right:2px;
	margin-top:3px;
}
.closeBtn6:hover {
	color:#1c97ea;
}
.closeBtn6:active {
	box-shadow: 0 #666;
}
.closeBtn5 {
	width:60px;
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
	margin-right:8px;
}
.closeBtn5:hover {
	color:#1c97ea;
}
.closeBtn5:active {
	box-shadow: 0 #666;
}
#caseTitle {
	color:black;
	width:100%;
}
.titleDiv3 {
	width:100%;
	padding-left:15px;
	color:#fff;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
function removeInfo(key) {
	sessionStorage.removeItem(key);
}
function setObj(obj) {		// 파일 경로
	sessionStorage.setItem('obj', obj);
}
function setCount(count) {		// 전체 이미지 갯수
	sessionStorage.setItem('count', count);
}
function setPage(page) {		// 현재 페이지
	sessionStorage.setItem('page', page);
}
function setUpdatePage(updatePage) {		// 현재 페이지
	sessionStorage.setItem('updatePage', updatePage);
}
function setTmpPage(tmpPage) {		// 현재 페이지
	sessionStorage.setItem('tmpPage', tmpPage);
}
function setShowPage(showPage) {	// 한 번에 보여줄 페이지의 갯수
	sessionStorage.setItem('showPage', showPage);
}
function setStartPage(startPage) {	// 총 시작 페이지
	sessionStorage.setItem('startPage', startPage);
}
function setEndPage(endPage) {	// 총 마지막 페이지
	sessionStorage.setItem('endPage', endPage);
}
function setEndCount(endCount) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('endCount', endCount);
}
function setPerTime(perTime) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('perTime', perTime);
}
function setWidth(width) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('width', width);
}
function setTimeRemaining(timeRemaining) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('timeRemaining', timeRemaining);
}
function setTimeTaken(timeTaken) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('timeTaken', timeTaken);
}
function setImgNum(imgNum) { 
	sessionStorage.setItem('imgNum', imgNum);
}
function setIsShow(isShow) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('isShow', isShow);
}
function setTimer3(timer) {		// 전체 이미지 갯수
	sessionStorage.setItem('timer3', timer);
}
function setTimer4(timer) {		// 전체 이미지 갯수
	sessionStorage.setItem('timer4', timer);
}
function setTestMap(testMap) {		// 테스트 지도
	sessionStorage.setItem('testMap', testMap);
}
function setIsTimer(isTimer) {		// 시간 정지 구분자
	sessionStorage.setItem('isTimer', isTimer);
}
function setIsAnalyze(isAnalyze) {	// 분석 완료 구분자
	sessionStorage.setItem('isAnalyze', isAnalyze);
}
function setNew(New) {
	sessionStorage.setItem('New', New);
}
function setCase(caseNum) {
	sessionStorage.setItem('case', caseNum);
}
function setCase_idx(case_idx) {
	sessionStorage.setItem('case_idx', case_idx);
}
function setPage_number(page_number) {
	sessionStorage.setItem('page_number', page_number);
}
var websocketUrl = '/police/websocket';
var isTimer = true;
var mapContainer;
var map;
var linePath;
var mapLine;
var circlePath = new Array();
var isAnalyzeArr;
var imageMarker;
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
var case_num = "";
var jsonDraw = new Object();
var jsonDrawAll = new Object();
var drawingMapContainer;
var drawingMap;
var circle_array = new Array();
var case_idx;
$(document).ready(function () {
	if ('${case_idx}' != null && '${case_idx}' != '') {
		case_num = '${case_idx}';
		$('#input_text').hide();
		$('#time_text').hide();
		$('#labelBtn').hide();
		$('#btn').hide();
		eval('function set' + '${case_idx}' + ' (caseNum) { sessionStorage.setItem("' + '${case_idx}' + '", caseNum); }');
		eval('set' + '${case_idx}' + '("' + '${case_idx}' + '")');
		//alert(eval('get("' + '${caseNum}' + '");'));
	}
	$('.closeBtn5').click(function () {
		$('.modal2').attr('class','modal_hide2');
	});
	$('.closeBtn6').click(function () {
		$('.modal2').attr('class','modal_hide2');
	});
	/* alert(JSON.stringify(JSON.parse(get('obj'))[24])); */
	/* for(var o = 0; o < JSON.parse(get('obj')).length; o++) {
		alert(JSON.stringify(JSON.parse(get('obj'))[o]));
	} */
	if ('${case_idx}' != null && '${case_idx}' != '') {		// get('obj') == null || 
		var jsonUrl = "/police/imageData";
		var jsonObject = new Object();
		jsonObject.case_idx = '${case_idx}';
		var page_number = get('page_number');
		if (page_number == null) {
			page_number = 1;
		}

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
		    		$('.page').remove();
		    		var data_number = 15 * (page_number - 1);

		    		case_idx = '${case_idx}';
					setCase_idx(case_idx);
		    		
					var total_count = data.length;
					var total_page = parseInt((total_count - 1) / 15) + 1;
					
					$('#title', top.document).text(data[data_number].case_content);
					$('#imgName').text(data[data_number].gps_imgname.substring(data[data_number].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[data_number].gps_width + ' x ' + data[data_number].gps_height);	
					
					var date = new Date(data[data_number].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					$('#fileCount').text(data[data_number].case_image_count + " / " + data[data_number].case_image_count);

					setPage(page_number);
					setPage_number(page_number);

					var first = parseInt((page_number - 1) / 10) * 10 + 1;
					var end = first + 10;
					
					if (end > total_page + 1) {
						end = total_page + 1;
					}

					$('#previous').removeClass('disabled');
					
					$('#next').removeClass('disabled');
					$('#next').attr("onclick", "goEndPage(" + case_idx + ", " + total_count + ", " + total_page + ")");

					$('#previous').attr("onclick", "goStartPage(" + case_idx + ", " + total_count + ", " + 1 + ")");
					
					for (var i = first; i < end; i++) {
						var opt = '';
						if (i == page_number) {
							opt = 'active'
						}
						$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
					}
					
					if (total_page > 1) {
						$('#next_one').attr("onclick", "goNextPage(" + case_idx + ", " + total_count + ", " + total_page + ")");
						$('#previous_one').attr("onclick", "goPreviousPage(" + case_idx + ", " + total_count + ", " + total_page + ")");
					}
					var polyline;
					var polyline_path;
					for (var k = 0; k < data.length; k++) {
						if (typeof kakao != "undefined" && data[k].gps_wtmx != null & data[k].gps_wtmy != null) {
							var position = new kakao.maps.LatLng(data[k].gps_wtmx, data[k].gps_wtmy);
							var color = data[k].gps_color;
							if (map == null) {
								mapContainer = document.getElementById('map'), // 지도를 표시할 div 
								    mapOption = { 
								        center: position, // 지도의 중심좌표
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
								    position: position
								});
			
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
							}
							var circle;
							if (map != null) {
								circle = drawCircle(position, color, data[k].gps_image, k, data.length);
								
					    	    if (polyline != null) {
					    	    	polyline_path.push(position);
					    	    	polyline.setPath(polyline_path);
					    	    } else {
					    	    	polyline_path = new Array();
					    	    	polyline_path.push(position);

					    			var polyline = new kakao.maps.Polyline({
					    			    path: polyline_path, // 선을 구성하는 좌표배열 입니다
					    			    strokeWeight: 2, // 선의 두께 입니다
					    			    strokeColor: 'yellow', // 선의 색깔입니다
					    			    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    			    strokeStyle: 'solid' // 선의 스타일입니다
					    			});

					    			// 지도에 선을 표시합니다 
					    			polyline.setMap(map);
					    	    }
							}
						} else {
							circle_array.push(null);
						}

						if (k >= data_number && k < data_number + 15) {
	   						var w = $('#imageTd' + (k % 15)).width();
	   						var h = $('#imageTd' + (k % 15)).height();
	   						var src = data[k].gps_image;
	   						
	   						var selectImage = '';
	   						if ((k % 15) == 0) {
	   							selectImage = 'selectImage';
	   						}
	   						
	   						var data_date = new Date(data[k].gps_imgtime);
	   						var data_month = data_date.getMonth() + 1;
	   						if (data_month < 10) {
	   							data_month = "0" + data_month;
	   						}
	   						var data_day = data_date.getDate();
	   						if (data_day < 10) {
	   							data_day = "0" + data_day;
	   						}
	   						
	   						var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
	   						
	   						var data_hour = data_date.getHours();
	   						if (data_hour < 10) {
	   							data_hour = "0" + data_hour;
	   						}
	   						var data_minutes = data_date.getMinutes();
	   						if (data_minutes < 10) {
	   							data_minutes = "0" + data_minutes;
	   						}
	   						var data_seconds = data_date.getSeconds();
	   						if (data_seconds < 10) {
	   							data_seconds = "0" + data_seconds;
	   						}
	   						
	   						var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
	   						
	   						var src_text = data[k].gps_imgname.substring(data[k].gps_imgname.lastIndexOf('/') + 1);
	   						var size_text = data[k].gps_width + ' x ' + data[k].gps_height;
	   						var date_text = data_firstDate + " " + data_secondDate;
	   						
	   						var option = "'image', '" + data[k].gps_imgname + "', null, '" + src_text + "', '" + size_text + "', '" + date_text + "'";
	   						if (circle != null) {
	   							option = "'circle', " + data[k].gps_wtmx + ", " + data[k].gps_wtmy + ", '" + src_text + "', '" + size_text + "', '" + date_text + "'";
	   						}
							$('<img class="' + selectImage + '" id="image' + (k % 15) + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + (k % 15) + ', ' + option + ');" />').insertBefore('#analyse' + (k % 15));
						}
					}

					if (data[data_number].gps_wtmx == null && data[data_number].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[data_number].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					}
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	} else if (get('case_idx') != null) {
		case_idx = get('case_idx');
		var page_number = get('page_number');

		var jsonUrl = "/police/imageData";
		
		var obj = new Object();
		obj.case_idx = case_idx;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	if (data.length > 0) {
		    		$('.page').remove();
		    		
		    		var data_number = 15 * (page_number - 1);
		    		
		    		console.log(page_number);
		    		
					$('#title', top.document).text(data[data_number].case_content);
					$('#imgName').text(data[data_number].gps_imgname.substring(data[data_number].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[data_number].gps_width + ' x ' + data[data_number].gps_height);	
					var total_count = data.length;
					var total_page = parseInt((total_count - 1) / 15) + 1;
					
					var date = new Date(data[data_number].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					$('#fileCount').text(data[data_number].case_image_count + " / " + data[data_number].case_image_count);

					var first = parseInt((page_number - 1) / 10) * 10 + 1;
					var end = first + 10;
					
					if (end > total_page + 1) {
						end = total_page + 1;
					}

					$('#previous').removeClass('disabled');
					
					$('#next').removeClass('disabled');
					$('#next').attr("onclick", "goEndPage(" + case_idx + ", " + total_count + ", " + total_page + ")");

					$('#previous').attr("onclick", "goStartPage(" + case_idx + ", " + total_count + ", " + 1 + ")");
					
					for (var i = first; i < end; i++) {
						var opt = '';
						if (i == page_number) {
							opt = 'active'
						}
						$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
					}
					
					if (total_page > 1) {
						$('#next_one').attr("onclick", "goNextPage(" + case_idx + ", " + total_count + ", " + total_page + ")");
						$('#previous_one').attr("onclick", "goPreviousPage(" + case_idx + ", " + total_count + ", " + total_page + ")");
					}
					
					var polyline;
					var polyline_path;
					
					for (var k = 0; k < data.length; k++) {
						if (typeof kakao != "undefined" && data[k].gps_wtmx != null & data[k].gps_wtmy != null) {
							var position = new kakao.maps.LatLng(data[k].gps_wtmx, data[k].gps_wtmy);
							var color = data[k].gps_color;
							if (map == null) {
								mapContainer = document.getElementById('map'), // 지도를 표시할 div 
								    mapOption = { 
								        center: position, // 지도의 중심좌표
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
								    position: position
								});
			
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
							}
							
							var circle;
							if (map != null) {
								circle = drawCircle(position, color, data[k].gps_image, k, data.length);
								
					    	    if (polyline != null) {
					    	    	polyline_path.push(position);
					    	    	polyline.setPath(polyline_path);
					    	    } else {
					    	    	polyline_path = new Array();
					    	    	polyline_path.push(position);

					    			var polyline = new kakao.maps.Polyline({
					    			    path: polyline_path, // 선을 구성하는 좌표배열 입니다
					    			    strokeWeight: 2, // 선의 두께 입니다
					    			    strokeColor: 'yellow', // 선의 색깔입니다
					    			    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    			    strokeStyle: 'solid' // 선의 스타일입니다
					    			});

					    			// 지도에 선을 표시합니다 
					    			polyline.setMap(map);
					    	    }
							}
						} else {
							circle_array.push(null);
						}

						if (k >= data_number && k < data_number + 15) {
	   						var w = $('#imageTd' + (k % 15)).width();
	   						var h = $('#imageTd' + (k % 15)).height();
	   						var src = data[k].gps_image;
	   						
	   						var selectImage = '';
	   						if ((k % 15) == 0) {
	   							selectImage = 'selectImage';
	   						}
	   						
	   						var data_date = new Date(data[k].gps_imgtime);
	   						var data_month = data_date.getMonth() + 1;
	   						if (data_month < 10) {
	   							data_month = "0" + data_month;
	   						}
	   						var data_day = data_date.getDate();
	   						if (data_day < 10) {
	   							data_day = "0" + data_day;
	   						}
	   						
	   						var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
	   						
	   						var data_hour = data_date.getHours();
	   						if (data_hour < 10) {
	   							data_hour = "0" + data_hour;
	   						}
	   						var data_minutes = data_date.getMinutes();
	   						if (data_minutes < 10) {
	   							data_minutes = "0" + data_minutes;
	   						}
	   						var data_seconds = data_date.getSeconds();
	   						if (data_seconds < 10) {
	   							data_seconds = "0" + data_seconds;
	   						}
	   						
	   						var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
	   						
	   						var src_text = data[k].gps_imgname.substring(data[k].gps_imgname.lastIndexOf('/') + 1);
	   						var size_text = data[k].gps_width + ' x ' + data[k].gps_height;
	   						var date_text = data_firstDate + " " + data_secondDate;
	   						
	   						var option = "'image', '" + data[k].gps_imgname + "', null, '" + src_text + "', '" + size_text + "', '" + date_text + "'";
	   						if (circle != null) {
	   							option = "'circle', " + data[k].gps_wtmx + ", " + data[k].gps_wtmy + ", '" + src_text + "', '" + size_text + "', '" + date_text + "'";
	   						}
							$('<img class="' + selectImage + '" id="image' + (k % 15) + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + (k % 15) + ', ' + option + ');" />').insertBefore('#analyse' + (k % 15));
						}
					}

					if (data[data_number].gps_wtmx == null && data[data_number].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[data_number].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					}
		    	}
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
	}
	
	function drawCircle(position, color, src, image_number, total_count) {
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
	    	circle.setOptions({fillColor: color});
	    }); 

	    // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
	    kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {
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

		    var page_number = parseInt(image_number / 15) + 1;
		    var now_page = parseInt(get('page'));
		    
		    if (now_page == page_number) {
				$('#image_list').find('.selectImage').removeClass('selectImage');
				$('#image' + parseInt(image_number % 15)).addClass("selectImage");
		    } else {
		    	if (parseInt((now_page - 1) / 10) + 1 == parseInt((page_number - 1) / 10) + 1) {
			    	$('#menu').find('.active').removeClass('active');
			    	$('#page' + page_number).addClass("active");
		    	} else {
		    		$('.page').remove();
		    		
		    		var first = parseInt((page_number - 1) / 10) * 10 + 1;
		    		var end = first + 10;
		    		var total_page = parseInt((total_count - 1) / 15) + 1;
		    		
		    		if (total_page < end) {
		    			end = total_page + 1;
		    		}

					for (var i = first; i < end; i++) {
						var opt = '';
						if (i == page_number) {
							opt = 'active'
						}
						$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
					}
		    	}	
		    }

			var jsonUrl = "/police/clickPage_num";
			
			var obj = new Object();
			obj.case_idx = case_idx;
			obj.page_number = page_number;
			
			var jsonData = JSON.stringify(obj);
			
			$.ajax({
				type : "POST",                        	 	     
				url : jsonUrl,                      		
				dataType : "json",                        	  
				contentType : "application/json; charset=UTF-8",         
				data : jsonData,          		   
			    success: function(data) {
			    	if (data.length > 0) {
				    	for (var i = 0; i < 15; i++) {
							$('#image' + i).remove();
				    	}
						$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
						$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
						
						var date = new Date(data[0].gps_imgtime);
						var month = date.getMonth() + 1;
						if (month < 10) {
							month = "0" + month;
						}
						var day = date.getDate();
						if (day < 10) {
							day = "0" + day;
						}
						
						var firstDate = date.getFullYear() + "-" + month + "-" + day;
						
						var hour = date.getHours();
						if (hour < 10) {
							hour = "0" + hour;
						}
						var minutes = date.getMinutes();
						if (minutes < 10) {
							minutes = "0" + minutes;
						}
						var seconds = date.getSeconds();
						if (seconds < 10) {
							seconds = "0" + seconds;
						}
						
						var secondDate = hour + ":" + minutes +  ":" + seconds;
						
						$('#imgTime').text(firstDate + " " + secondDate);		
						
						for (var j = 0; j < data.length; j++) {
							var w = $('#imageTd' + j).width();
							var h = $('#imageTd' + j).height();
							var src = data[j].gps_image;
							
							var selectImage = '';
							if (j == parseInt(image_number % 15)) {
								selectImage = 'selectImage';
							}
							
							var data_date = new Date(data[j].gps_imgtime);
							var data_month = data_date.getMonth() + 1;
							if (data_month < 10) {
								data_month = "0" + data_month;
							}
							var data_day = data_date.getDate();
							if (data_day < 10) {
								data_day = "0" + data_day;
							}
							
							var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
							
							var data_hour = data_date.getHours();
							if (data_hour < 10) {
								data_hour = "0" + data_hour;
							}
							var data_minutes = data_date.getMinutes();
							if (data_minutes < 10) {
								data_minutes = "0" + data_minutes;
							}
							var data_seconds = data_date.getSeconds();
							if (data_seconds < 10) {
								data_seconds = "0" + data_seconds;
							}
							
							var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
							
							var src_text = data[j].gps_imgname.substring(data[j].gps_imgname.lastIndexOf('/') + 1);
							var size_text = data[j].gps_width + ' x ' + data[j].gps_height;
							var date_text = data_firstDate + " " + data_secondDate;
							
							var option = "'image', '" + data[j].gps_imgname + "', null, '" + src_text + "', '" + size_text + "', '" + date_text + "'";
							if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
								option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy + ", '" + src_text + "', '" + size_text + "', '" + date_text + "'";
							}
							$('<img class="' + selectImage + '" id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
						}
				
			    	}
			    },
				error: function(errorThrown) {
					/* alert(errorThrown.statusText);
					alert(jsonUrl); */
				}
			});

			$('#original_img').hide();
	        
			$('#map').show();
			
		    map.panTo(position);
	    });
	    
		circle.setMap(map); 

		circle_array.push(circle);
		
		return circle;
	}
	
	if (typeof kakao != "undefined") {
		$('#chkRoute').attr('checked', true);
	}
	
	if (get('isTimer') != null) {
		isTimer = get('isTimer');
	}
	
	if (get('userdata') != null) {
		$('#login_id').val(JSON.parse(get('userdata')).login_id);
	}
	if (get('isShow') == null) {
		setIsShow(true);
	}
	
	if (get('map') != null) {
		$('#image_map').attr('src', get('map'));
	}
	if (get('imgName') != null) {
		//$('#imgName').text(get('imgName'));		
	}

	if (get('imgSize') != null) {
		$('#imgSize').text(get('imgSize'));		
	}
	
	if (get('imgTime') != null) {
		$('#imgTime').text(get('imgTime'));		
	}
	
	if (get('timeRemaining') == null) {
		setTimeRemaining('0시간 0분 0초');
	}
	
	if (get('timeTaken') == null) {
		setTimeTaken('0시간 0분 0초');
	}

	if (get('timeTaken') != null) {
		$('#timeTaken').text(get('timeTaken'));
	}
	
	if (get('perTime') == null) {
		setPerTime('0');
	}
	
	//$('<a href="/police/imageDownload?caseNum=' + JSON.parse(get('obj'))[0].image0.image.substring(JSON.parse(get('obj'))[0].image0.image.lastIndexOf('case'), JSON.parse(get('obj'))[0].image0.image.lastIndexOf('/')) + '"><input type="button" value="다운로드" style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF;"/></a>').insertAfter('#tmpDownload');
	
	if (get('perTime') != null && (get('perTime') == '100' || get('perTime') == '0')) {
		$('#btn').val('분석 시작');
		//$('#btn').attr('disabled', false);
		$('#btn').css('opacity', '1');
	}

	if (get('count') == null) {
		//$('#fileCount').text('0');
	}
	
	if (get('count') != null) {
		//$('#fileCount').text(get('count') + ' / ' + get('count'));
	}
	
	if (get('perTime') != null && get('perTime') != '100' && get('perTime') != '0') {
		if (!isTimer) {
			$('#btn').val('분석 취소');
			//$('#btn').attr('disabled', true);
			//$('#btn').css('opacity', '0.5');
			$('#downloadBtn').attr('disabled', true);
			//$('#downloadBtn').css('opacity', '0.5');
		} else {
			$('#btn').val('분석 시작');
			//$('#btn').attr('disabled', false);
			$('#btn').css('opacity', '1');
			$('#downloadBtn').attr('disabled', false);
			$('#downloadBtn').css('opacity', '1');
		}
	}
	if (get('obj') != null) {
		if (JSON.parse(get("obj")).length != parseInt($('#fileCount').text())) {
			$('#stitching').attr('disabled', true);
			$('#stitching').css('opacity', '0.5');
			$('#stitchingUploadBtn').attr('disabled', true);
			$('#stitchingUploadBtn').css('opacity', '0.5');
			//$('#download').attr('href', '/police/webserver/image/' + get('case') + '.zip');
		}
		var caseNum = JSON.parse(get('obj'))[0].image0.image.substring(JSON.parse(get('obj'))[0].image0.image.lastIndexOf('case'), JSON.parse(get('obj'))[0].image0.image.lastIndexOf('/'));
		if (get('New') != null && get('New') != '' && $('#title', top.document).text() == '') {
			$('#title', top.document).text(get('New'));
		}
	} else {
		var caseNum = 'NEW(제목없음)';
		//$('#title', top.document).text(caseNum);
	}
	
	if (get('width') == null) {
		setWidth('0');
	}

	if (get('width') != null) {
		$('#perTime').width(get('width') + '%');
	}

	if (get('perTime') != null) {
		$('#perTime').text(parseInt(get('perTime')) + '%');
		$('#perTime').width(parseInt(get('perTime')) + '%');
	}
	
	if (get('endCount') == null) {
		setEndCount(0);
	}
	
	if (get('page') == null || get('page') == '') {
		setPage('1');
		setTmpPage('1');
	}
	
	if (get('endPage') == null) {
		setEndPage('1');
	}
	
	setStartPage('1');

	var array;
	if (get('obj') != null) {
		array = JSON.parse(get('obj'));
	}
	var testMap;

	function drawMap() {
	}
	if (get('isAnalyze') != null) {
		isAnalyzeArr = JSON.parse(get('isAnalyze'));
	}
    function displayCircle(x, y, num) {
    }
	function drawMapLine() {
	}
	
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/showImage', function (message) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(message.body).login_id && '${case_idx}' == '') {
				// 썸네일 이미지 번호
				var tmpNum = JSON.parse(message.body).img_number;
				var wtmX = JSON.parse(message.body).wtmX;
				var wtmY = JSON.parse(message.body).wtmY;
				var original_src = JSON.parse(message.body).original_image;
				var thumb_src = JSON.parse(message.body).image;
				var imgTime = JSON.parse(message.body).imgTime;
				var width = JSON.parse(message.body).width;
				var height = JSON.parse(message.body).height;
				var total_count = JSON.parse(message.body).total_count;
				
				var location = new Object();
				location.wtmX = JSON.parse(message.body).wtmX;
				location.wtmY = JSON.parse(message.body).wtmY;
				location.imgTime = JSON.parse(message.body).imgTime;

				if (tmpNum == 0) {
					sessionStorage.removeItem('obj');
					testMap = new Array();
					circlePath = new Array();
					isAnalyzeArr = new Array();
					count = 0;
					case_idx = JSON.parse(message.body).case_idx;
					case_num = 'case' + case_idx;
					setCase_idx(case_idx);
					linePath = new Array();
					map = null
					$('.page').remove();
					$('<li class="page-item page active" id="page1"><a href="#">1</a></li>').insertBefore('#next_one');

					$('#page1 a').attr("onclick", "clickPage_num('" + case_idx + "', '1')");
					setPage_number(1);
				}

				$('#next_one').attr("onclick", "goNextPage(" + case_idx + ", " + (tmpNum + 1) + ", " + (parseInt(tmpNum / 15) + 1) + ")");
				$('#previous_one').attr("onclick", "goPreviousPage(" + case_idx + ", " + (tmpNum + 1) + ", " + (parseInt(tmpNum / 15) + 1) + ")");
				
				if (typeof kakao != "undefined" && map == null && wtmX != null && wtmY != null) {
					// 마커가 표시될 위치입니다 
					var markerPosition = new kakao.maps.LatLng(wtmX, wtmY); 

					mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    	mapOption = { 
					        center: markerPosition, // 지도의 중심좌표
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
					    position: markerPosition
					});

					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
			    }
				
				testMap.push(location);
				setTestMap(JSON.stringify(testMap));
				isAnalyzeArr.push('분석중')
				setIsAnalyze(JSON.stringify(isAnalyzeArr));
				
				var circle;
				if (typeof kakao != "undefined" && wtmX != null && wtmY != null) {
					$('#original_img').hide();
					var position = new kakao.maps.LatLng(wtmX, wtmY);
					//displayCircle(location.wtmX, location.wtmY, tmpNum);
					circle = drawCircle(position, 'green', original_src, tmpNum, total_count);
					linePath.push(position);
					if (tmpNum > 0) {
						mapLine.setPath(linePath);
					} else {
						mapLine = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 2, // 선의 두께 입니다
						    strokeColor: 'yellow', // 선의 색깔입니다
						    strokeOpacity: 0.5, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});
						mapLine.setMap(map);
					}

		    		//var chk = $("input:checkbox[id='chkRoute']").is(":checked");
		    		//if (chk) {
						// 지도에 선을 표시합니다 
					//	polyline.setMap(map);
		    		//}

					$('#map').show();
				} else if (wtmX == null || wtmY == null) {
					$('#map').hide();
				    var mapWidth = $('#map_size').width();
				    var mapHeight = $('#map_size').height();
				    
					var original_img = document.getElementById('original_img');
					original_img.src = original_src;
					original_img.style.display = '';
					original_img.style.width = mapWidth + 'px';
					original_img.style.height = mapHeight + 'px';
					
					$('#original_img').show();
				}				
				
				if (typeof kakao == "undefined" || typeof location.wtmX == "undefined" || typeof location.wtmY == "undefined" || location.wtmX == null || location.wtmY == null) {
					//clickId(tmpNum % 15);
				}
				
				var page_num = parseInt(get('page'));
				var update_page_num = parseInt(tmpNum / 15) + 1;
				
				if (tmpNum > 0 && tmpNum % 15 == 0 && page_num + 1 == update_page_num) {
			    	for (var i = 0; i < 15; i++) {
						$('#image' + i).remove();
			    	}
					if (parseInt((page_num - 1) / 10) != parseInt((update_page_num - 1) / 10)) {
						$('.page').remove();
					} else {
						$('#menu').find('.active').removeClass('active');
					}

					$('<li class="page-item page active" id="page' + update_page_num + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + update_page_num + "'" + ');">' + update_page_num + '</a></li>').insertBefore('#next_one');
					
					$('#image_list').find('.selectImage').removeClass('selectImage');
				} else if (tmpNum > 0 && tmpNum % 15 == 0 && page_num + 1 != update_page_num) {
					if (parseInt((page_num - 1) / 10) == parseInt((update_page_num - 1) / 10)) {
						$('<li class="page-item page" id="page' + update_page_num + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + update_page_num + "'" + ');">' + update_page_num + '</a></li>').insertBefore('#next_one');
					}
				}
				setPage(update_page_num);
				setPage_number(update_page_num);
				
				if (parseInt(get('page')) == update_page_num) {
					var img_num =  parseInt(tmpNum % 15);
					var w = $('#imageTd' + img_num).width();
					var h = $('#imageTd' + img_num).height();
					
					var selectImage = '';
					if (k == 0) {
						selectImage = 'selectImage';
					}

					var data_date = new Date(imgTime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = original_src.substring(original_src.lastIndexOf('/') + 1);
					var size_text = width + ' x ' + height;
					var date_text = data_firstDate + " " + data_secondDate;
						
					$('#imgName').text(src_text);
					$('#imgSize').text(size_text);	
					$('#imgTime').text(date_text);
					
					var option = "'image', '" + original_src + "', null, '" + src_text + "', '" + size_text + "', '" + date_text + "'";
					if (circle != null) {
						option = "'circle', " + wtmX + ", " + wtmY + ", '" + src_text + "', '" + size_text + "', '" + date_text + "'";
					}
					
					$('<img class="' + selectImage + '" id="image' + img_num + '"src="' + thumb_src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + img_num + ', ' + option + ');" />').insertBefore('#analyse' + img_num);
				}
				
				if (tmpNum + 1 == total_count) {
					$('#stitching').attr('disabled', false);
					$('#stitching').css('opacity', '1');
					$('#stitchingUploadBtn').attr('disabled', false);
					$('#stitchingUploadBtn').css('opacity', '1');
					if (typeof kakao != "undefined" && typeof map != "undefined" && map != null) {
						var bounds = new kakao.maps.LatLngBounds();    

						for (var i = 0; i < linePath.length; i++) {
						    // LatLngBounds 객체에 좌표를 추가합니다
						    bounds.extend(linePath[i]);
						}

				    	map.setBounds(bounds);
					}
				}
				
				var endPage = 0;
				var endCount = 0;
				var count1 = tmpNum + 1;
					
				if (parseInt(count1 % 15) > 0) {
					endPage = parseInt(count1 / 15) + 1;
					endCount = parseInt(count1 % 15);
				} else {
					endPage = parseInt(count1 / 15);
					endCount = parseInt(15);
				}

				setEndPage(endPage);
				setEndCount(endCount);

				$('#fileCount').text(count1 + ' / ' + total_count);
				if (tmpNum == 0) {
					$('#previous').removeClass('disabled');		// 이전 버튼 열기
					$('#next').removeClass('disabled');			// 다음 버튼 열기
				}
				$('#next').attr("onclick", "goEndPage(" + case_idx + ", " + count1 + ", " + update_page_num + ")");
				$('#previous').attr("onclick", "goStartPage(" + case_idx + ", " + count1 + ", " + 1 + ")");
				//console.log('page = ' + get('page') + ' / tmpPage = ' + get('tmpPage') + ' / endPage = ' + get('endPage') + ' / endCount = ' + get('endCount'));
			}
		}); 
		stompClient.subscribe('/endAnalyse', function (number) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(number.body).login_id && '${case_idx}' == '') {
				if (parseInt(get('count')) == (parseInt(JSON.parse(number.body).num) + 1)) {
					$('#btn').val('분석 시작');
					//$('#btn').attr('disabled', false);
					$('#btn').css('opacity', '1');
					$('#downloadBtn').attr('disabled', false);
					$('#downloadBtn').css('opacity', '1');
				}
				var perTime = parseFloat(100 /parseInt(get('count'))) * (parseInt(JSON.parse(number.body).num) + 1);
				setPerTime(perTime + '');
				setWidth(parseInt(perTime) + '');
				if (typeof kakao != "undefined") {
					var color;
					var status;
					if (JSON.parse(number.body).isTag == 'Y') {
						color = 'red';
						status = '태그발견';
					} else {
						color = 'blue';
						status = '분석완료';
					}
					if (circlePath[parseInt(JSON.parse(number.body).num)] != null) {
						circlePath[parseInt(JSON.parse(number.body).num)].setOptions({fillColor: color});
					}
				}
				isAnalyzeArr[parseInt(JSON.parse(number.body).num)] = status;
				setIsAnalyze(JSON.stringify(isAnalyzeArr));
				$('#perTime').text(get('width') + '%');
				$('#perTime').width(get('width') + '%');
			}
		});
		stompClient.subscribe('/imageDownload', function (number) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(number.body).login_id && JSON.parse(number.body).isNew == '${case_idx}') {
				$('#downloadBtn').text('다운로드중..\n ' + JSON.parse(number.body).per);
				$('#downloadBtn').html($('#downloadBtn').html().replace(/\n/g,'<br/>'));
			}
		});
		stompClient.subscribe('/stitchingUpload', function (number) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(number.body).stitching_id && JSON.parse(number.body).isNew == '${case_idx}') {
				$('#stitchingUploadBtn button').text('스티칭 업로드');
				$('#stitchingUploadBtn').attr('disabled', false);
				$('#stitchingUploadBtn').css('opacity', '1');
				if (/(MSIE|Trident)/.test(navigator.userAgent)) { 
					// ie 일때 input[type=file] init.
					$("#stitchingUpload_path").replaceWith($("#stitchingUpload_path").clone(true));
				} else {
					 // other browser 일때 input[type=file] init.
					$("#stitchingUpload_path").val("");
				}
				var target = $('#stitchingMenu', window.parent.document);
				target.click();
			}
		});
		stompClient.subscribe('/fileCount', function (total) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(total.body).login_id && '${case_idx}' == '') {
		    	for (var i = 0; i < 15; i++) {
		    		if ($('#image' + i) != null) {
						$('#image' + i).remove();
		    		} else {
		    			break;
		    		}
		    	}
				var data = JSON.parse(total.body);
				setCase('case' + data.case_idx);
				//setCase(JSON.parse(total.body).case_num);
				setNew(data.analyze_content);
				//$('#download').attr('href', '/police/webserver/image/' + JSON.parse(total.body).case_num + '.zip');

				$('#title', top.document).text(data.analyze_content);
				
				$('#progress_Loading').hide();
				$('#loading').attr('disabled', false);
				$('#loading').css('opacity', '1');
				
				var count = data.case_image_count;
				setCount(count);
				$('#fileCount').text(0 + ' / ' + count);

				isTimer = true;
				
				timer(parseInt(count) * 8);
				timer2(parseInt(count) * 8);
				setPerTime('0');
				setWidth('0');
				var endPage = 0;
				var endCount = 0;
				
				count = parseInt(count);
				
				if (parseInt(count % 15) > 0) {
					endPage = parseInt(count / 15) + 1;
					endCount = parseInt(count % 15);
				} else {
					endPage = parseInt(count / 15);
					endCount = parseInt(15);
				}
				//setEndPage(endPage);
				//setEndCount(endCount);
				
			}
		});

		stompClient.subscribe('/selectEndCase', function (count) {
			if (parseInt(get('count') - 1) == parseInt(JSON.parse(count.body).num) && '${case_idx}' == '') {
				clearInterval(get('timer3'));
				clearInterval(get('timer4'));
				setPerTime('100');
				setWidth('100');
				$('#perTime').text(parseInt(get('perTime')) + '%');
				$('#perTime').width(parseInt(get('perTime')) + '%');
				setTimeRemaining('0시간 0분 0초');
				$('#timeTaken').text(get('timeTaken'));
				$('#timeRemaining').text(get('timeRemaining'));
				$('#btn').val('분석 시작');	
				//$('#btn').attr('disabled', false);
				$('#btn').css('opacity', '1');
				
				var jsonUrl = "/police/galleryUpdate";
				var obj = new Object();
				obj.login_id = JSON.parse(get('userdata')).login_id;
				obj.timeTaken = get('timeTaken');
				obj.timeRemaining = get('timeRemaining');
				obj.perTime = get('perTime');
				obj.isFailed = "N";
				obj.case_num = 'case' + JSON.parse(count.body).case_idx;
				var jsonData = JSON.stringify(obj);
				
				$.ajax({
					type : "POST",                        	 	     
					url : jsonUrl,                      		
					dataType : "text",                        	  
					contentType : "application/json; charset=UTF-8",         
					data : jsonData,          		
					success: function (data) {
					}, error: function(errorThrown) {
						//alert(errorThrown.statusText);
					}
				});

				/* ajax로 다 저장
				1. count (gallery_json)
				2. obj (gallery_json) -> image
				3. imgNum
				4. timetaken
				5. timeremaining
				6. perTime
				7. setPage(1)
				8. setImgNum(0)
				9. login_id (gallery_json)
				*/
			}
		});

		stompClient.subscribe('/selectGalImage', function (select) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(select.body).login_id && '${case_idx}' == JSON.parse(select.body).caseNum) {
				var location = JSON.parse(get('obj')); 
				var imageNum = parseInt(JSON.parse(select.body).image) % 15;
				var num = parseInt(JSON.parse(select.body).image);
				var imagePage = parseInt(JSON.parse(select.body).image) / 15 + 1;
				$('#image_list').find('.selectImage').removeClass('selectImage');
				$('#image' + imageNum).addClass("selectImage");
				
				if (parseInt(get('page')) == parseInt(parseInt(num / 15) + 1)) {	// 예) num = 20
    				$('#image_list').find('.selectImage').removeClass('selectImage');
    				$('#image' + (num % 15)).addClass("selectImage");
    			} else {
    				if (parseInt((parseInt(get('page')) - 1) / 10) * 10 + 1 == parseInt(parseInt(num / 15) / 10) * 10 + 1) {	// 보는 페이지와 선택한 이미지가 있는 줄이 같은 줄이라면
    					$('#menu').find('.active').removeClass('active');
    					var pageNumber = parseInt(parseInt(num / 15) + 1);
    					$('#page' + pageNumber).addClass("active");

    					var last = 15;
    					if (parseInt(get('endPage')) == parseInt(get('page'))) {
    						last = parseInt(get('endCount'));
    						for (var k = 0; k < last; k++) {
    							$('#image' + k).remove();
    						}
    					} else {
    						for (var j = 0; j < last; j++) {		// 이미지 지우기
    							$('#image' + j).remove();
    						}
    					}

    					setPage(pageNumber);

    					if (parseInt(get('endPage')) == parseInt(get('page'))) {
    						last = parseInt(get('endCount'));
    						for (var k = 0; k < last; k++) {
    							$('#image' + k).remove();
    						}
    					} else {
    						for (var j = 0; j < last; j++) {		// 이미지 지우기
    							$('#image' + j).remove();
    						}
    					}

    					if (parseInt(get('endPage')) == parseInt(get('page'))) {
    						last = parseInt(get('endCount'));
    					} else {
    						last = 15;
    					}
    					
    					var imageCount = (pageNumber - 1) * 15;
    					
    					for (var i = 0; i < last; i++) {
    						var objArr = JSON.parse(get('obj'));F
    						var imgNum = imageCount + i;
    						var src = eval('objArr[' + imgNum + '].image' + imgNum + '.image');
    						
    						var w = $('#imageTd' + i).width();
    						var h = $('#imageTd' + i).height();

    						$('<img id="image' + i + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickId(' + i +  ')" />').insertBefore('#analyse' + i);	//onclick="moveCenter + l +  ')"
    					}
    					
    					$('#image_list').find('.selectImage').removeClass('selectImage');
    					$('#image' + parseInt(num % 15)).addClass("selectImage");
    				} else {	// 보는 페이지와 선택한 이미지가 있는 줄이 다른 줄이라면
    					//$('#previous').removeClass('disabled');		// 이전 버튼 열기
    					//$('#next').removeClass('disabled');			// 다음 버튼 열기
    					
    					if (parseInt(parseInt(num / 15) / 10) == 0) {		// 이전 버튼 닫기
    						//$('#previous').addClass('disabled');
    					}
    					
    					if (parseInt(parseInt(num / 15) / 10) == parseInt(parseInt(parseInt(get('endPage')) - 1) / 10)) {		// 다음 버튼 닫기
    						//$('#next').addClass('disabled')
    					}
    					var last = 15;
    					//alert("end = " + parseInt(get('endPage')) + ", " + "page = " + parseInt(get('page')));
    					if (parseInt(get('endPage')) == parseInt(get('page'))) {
    						last = parseInt(get('endCount'));
    						for (var k = 0; k < last; k++) {
    							$('#image' + k).remove();
    						}
    					} else {
    						for (var j = 0; j < last; j++) {		// 이미지 지우기
    							$('#image' + j).remove();
    						}
    					}
    					var preNum = parseInt(parseInt((parseInt(get('page')) - 1) / 10) * 10 + 1);	// 블럭 - 1;
    					
    					for (var i = preNum; i < preNum + 10; i++) {		// 페이지 지우기
    						$('#page' + i).remove();
    					}

    					setPage(parseInt(num / 15) + 1);
    					
    					preNum = parseInt(parseInt((parseInt(get('page')) - 1) / 10) * 10 + 1);
    					var endNum = 0;
    					
    					if (preNum != parseInt(parseInt((parseInt(get('endPage')) - 1) / 10) * 10 + 1)) {
    						endNum = preNum + 10;
    					} else {
    						endNum = parseInt(get('endPage')) + 1;
    					}
    					
    					for (var k = preNum; k < endNum; k++) {
    						var active = '';
    						if (k == parseInt(get('page'))) {
    							active = ' active';
    						}
    						//$('<li class="nav-item' + active + '" id="page' + k + '" onclick="showImage(' + k + ')"><a href="#">' + k + '</a></li>').insertBefore('#next');
    					}
    					if (get('page') != get('endPage')) {
    						last = 15;
    					} else {
    						last = parseInt(get('endCount'));
    					}
    					for (var l = 0; l < last; l++) {
    						var startImage = (parseInt(get('page')) - 1) * 15;
    						var imgNum = startImage + l;
    						var objArr = JSON.parse(get('obj'));
    						var src = eval('objArr[' + imgNum + '].image' + imgNum + '.image');
    						
    						var w = $('#imageTd' + l).width();
    						var h = $('#imageTd' + l).height();

    						$('<img id="image' + l + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickId(' + l +  ')" />').insertBefore('#analyse' + l);	//onclick="moveCenter + l +  ')"
    					}	
    					$('#image_list').find('.selectImage').removeClass('selectImage');
    					$('#image' + parseInt(num % 15)).addClass("selectImage");
    				}
    			}

				clickId2(imageNum);
				//console.log('page = ' + get('page') + ' / tmpPage = ' + get('tmpPage') + ' / endPage = ' + get('endPage'));
			}
		});
		
		
	});
	//$('#previous').removeClass('disabled');
	//$('#next').removeClass('disabled');
	
	if (parseInt((parseInt(get('page')) - 1) / 10) == 0) {
		//$('#previous').addClass('disabled');
	}

	if (parseInt((parseInt(get('page')) - 1) / 10) == parseInt((parseInt(get('endPage')) - 1) / 10)) {
		//$('#next').addClass('disabled');
	}
	
	if (get('page') == '1' && get('obj') == null) {
		//$('<li class="nav-item active" id="page1"><a href="#">1</a>').insertBefore('#next');
	} else {
		if (get('endPage') != null) {
			if (parseInt(get('endPage')) < 10) {
				for (var i = 1; i < parseInt(get('endPage')) + 1; i++) {
					if (i == parseInt(get('page'))) {
						//$('<li class="nav-item active" id="page' + i + '" onclick="showImage(' + i + ')"><a href="#">' + i + '</a></li>').insertBefore('#next');
					} else {
						//$('<li class="nav-item" id="page' + i + '" onclick="showImage(' + i + ')"><a href="#">' + i + '</a></li>').insertBefore('#next');
					}
				}
			} else {
				var startNum = parseInt(parseInt((parseInt(get('page')) - 1) / 10) * 10  + 1);	// 시작페이지
				setStartPage(startNum + '');
				if (parseInt((parseInt(get('page')) - 1) / 10) == parseInt((parseInt(get('endPage')) - 1) / 10)) {		// 현재 페이지와 마지막 페이지 같은 블록일 때
					for (var j = startNum; j < parseInt(get('endPage')) + 1; j++) {
						if (j == parseInt(get('page'))) {
							//$('<li class="nav-item active" id="page' + j + '" onclick="showImage(' + j + ')"><a href="#">' + j + '</a></li>').insertBefore('#next');
						} else {
							//$('<li class="nav-item" id="page' + j + '" onclick="showImage(' + j + ')"><a href="#">' + j + '</a></li>').insertBefore('#next');
						}
					}
				} else {	// 현재 페이지와 마지막 페이지 다른 블록일 때
					for (var k = startNum; k < startNum + 10; k++) {
						if (k == parseInt(get('page'))) {
							//$('<li class="nav-item active" id="page' + k + '" onclick="showImage(' + k + ')"><a href="#">' + k + '</a></li>').insertBefore('#next');
						} else {
							//$('<li class="nav-item" id="page' + k + '" onclick="showImage(' + k + ')"><a href="#">' + k + '</a></li>').insertBefore('#next');
						}	
					}
				}
			}
		}
	}
});
$('#timeTaken').ready(function() {
	$('#timeTaken').text(get('timeTaken'));
});
$(window).resize(function() {
	if (get('obj') != null) {
		var array = JSON.parse(get('obj'));
		var showImage = parseInt(parseInt(get('count')) % 15);
		if (get('page') < get('endPage') || showImage == 0) {
			showImage = 15;
		}

		if (typeof kakao == "undefined") {
			changeMap(get('imgNum'));
		}
		
		for (var j = 0; j < showImage; j++) {
			$('#image' + j).remove();
		}
		for (var i = 0; i < showImage; i++) {
			var array2 = array[(parseInt(get('page')) - 1) * 15 + i];
			var src = eval('array2.image' + ((parseInt(get('page')) - 1) * 15 + i)).image;
			
			var w = $('#analyse' + i).width();
			var h = $('#analyse' + i).height();
			
			$('<img id="image' + i + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickId(' + i +  ')" />').insertBefore('#analyse' + i);
		}

		if (typeof JSON.parse(get('obj'))[0].wtmX != "undefined" && typeof JSON.parse(get('obj'))[0].wtmY != "undefined" && JSON.parse(get('obj'))[0].wtmX != null && JSON.parse(get('obj'))[0].wtmY != null) {
			//var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    var imageSize = new kakao.maps.Size(24, 35); 
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    // 마커를 생성합니다
			var imageMarker = new kakao.maps.Marker({ 
		        map: map, // 마커를 표시할 지도
			    position:new kakao.maps.LatLng(JSON.parse(get('obj'))[0].wtmX, JSON.parse(get('obj'))[0].wtmY), 
		        image : markerImage
			});
		} else {
			/* $('#original_img').hide();

		    var mapWidth = parseInt($('#map_size').width());
		    var mapHeight = parseInt($('#map_size').height());
			
		    $('#original_img').width(mapWidth);
		    $('#original_img').height(mapHeight);
		    
			$('#original_img').show(); */
		}
	}
});
function clickId(imageNum) {
	var location = JSON.parse(get('obj')); 
	var mapNum = (parseInt(get('page')) - 1) * 15 + imageNum;
	var imgTime = eval('location[mapNum].image' + mapNum).imgTime;
	var imgName = eval('location[mapNum].image' + mapNum).image.substring(0, eval('location[mapNum].image' + mapNum).image.lastIndexOf('_') + '.jpg');
	var width = eval('location[mapNum].image' + mapNum).width;
	var height = eval('location[mapNum].image' + mapNum).height;
	
	//alert(eval('location[' + mapNum + '].image' + mapNum + '.wtmX') + " / " + eval('location[' + mapNum + '].image' + mapNum + '.wtmY'));
	
    if (typeof kakao != "undefined" && typeof eval('location[mapNum].image' + mapNum + '.wtmX') != "undefined" && typeof eval('location[mapNum].image' + mapNum + '.wtmY') != "undefined"  && eval('location[mapNum].image' + mapNum + '.wtmX') != null && eval('location[mapNum].image' + mapNum + '.wtmY') != null) {
    	var map_image = document.getElementById('map');
    	map_image.style.display = '';
    	var original_img = document.getElementById('original_img');
    	original_img.style.display = 'none';
    	var moveLatLon = new kakao.maps.LatLng(eval('location[mapNum].image' + mapNum + '.wtmX'), eval('location[mapNum].image' + mapNum + '.wtmY'));
        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);

        //var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
        
        //alert("imageMarker = " + imageMarker);
        
        if (imageMarker != null && imageMarker != "undefined") {
    		imageMarker.setPosition(moveLatLon);
        } else {
            var imageSize = new kakao.maps.Size(24, 35); 
            
            // 마커 이미지를 생성합니다    
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
        	imageMarker = new kakao.maps.Marker({
    			map: map, // 마커를 표시할 지도
    			position: moveLatLon, // 마커를 표시할 위치
    			image : markerImage // 마커 이미지 
    		});
        }
        
    	//$('#imgName').text(imgName.substring(imgName.lastIndexOf('/') + 1, imgName.lastIndexOf('_')) + '.jpg');
    	$('#imgTime').text(imgTime);
    	$('#imgSize').text(width + ' x ' + height);
    } else {
    	changeMap(imageNum);
    }
	$('#image_list').find('.selectImage').removeClass('selectImage');
	$('#image' + imageNum).addClass("selectImage");

	var jsonUrl = "/police/selectImage";
	var obj = new Object();
	obj.gallery_path = eval('location[mapNum].image' + mapNum + '.original_image');
	obj.login_id = JSON.parse(get('userdata')).login_id;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
		success: function (data) {
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	});
}

function clickId2(imageNum) {
	var location = JSON.parse(get('obj')); 
	var mapNum = (parseInt(get('page')) - 1) * 15 + imageNum;
	var imgTime = eval('location[mapNum].image' + mapNum).imgTime;
	var imgName = eval('location[mapNum].image' + mapNum).image.substring(0, eval('location[mapNum].image' + mapNum).image.lastIndexOf('_') + '.jpg');
	var width = eval('location[mapNum].image' + mapNum).width;
	var height = eval('location[mapNum].image' + mapNum).height;
	
	//alert(eval('location[' + mapNum + '].image' + mapNum + '.wtmX') + " / " + eval('location[' + mapNum + '].image' + mapNum + '.wtmY'));
	
    if (typeof kakao != "undefined" && typeof eval('location[mapNum].image' + mapNum + '.wtmX') != "undefined" && typeof eval('location[mapNum].image' + mapNum + '.wtmY') != "undefined"  && eval('location[mapNum].image' + mapNum + '.wtmX') != null && eval('location[mapNum].image' + mapNum + '.wtmY') != null) {
    	var map_image = document.getElementById('map');
    	map_image.style.display = '';
    	var original_img = document.getElementById('original_img');
    	original_img.style.display = 'none';
    	var moveLatLon = new kakao.maps.LatLng(eval('location[mapNum].image' + mapNum + '.wtmX'), eval('location[mapNum].image' + mapNum + '.wtmY'));
        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);

        //var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
        
        //alert("imageMarker = " + imageMarker);
        
        if (imageMarker != null && imageMarker != "undefined") {
    		imageMarker.setPosition(moveLatLon);
        } else {
            var imageSize = new kakao.maps.Size(24, 35); 
            
            // 마커 이미지를 생성합니다    
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
        	imageMarker = new kakao.maps.Marker({
    			map: map, // 마커를 표시할 지도
    			position: moveLatLon, // 마커를 표시할 위치
    			image : markerImage // 마커 이미지 
    		});
        }
        
    	//$('#imgName').text(imgName.substring(imgName.lastIndexOf('/') + 1, imgName.lastIndexOf('_')) + '.jpg');
    	$('#imgTime').text(imgTime);
    	$('#imgSize').text(width + ' x ' + height);
    } else {
    	changeMap(imageNum);
    }
	$('#image_list').find('.selectImage').removeClass('selectImage');
	$('#image' + imageNum).addClass("selectImage");

	var jsonUrl = "/police/selectImage2";
	var obj = new Object();
	obj.gallery_path = eval('location[mapNum].image' + mapNum + '.original_image');
	obj.login_id = JSON.parse(get('userdata')).login_id;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
		success: function (data) {
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	});
}
$('#timeRemaining').ready(function() {
	$('#timeRemaining').text(get('timeRemaining'));
});
$('#perTime').ready(function() {
	$(this).text(get('perTime'));
	$(this).width(get('perTime') + '%');
});
$('#map_size').ready(function() {
	if (get('imgNum') != null) {
		if (typeof kakao == "undefined") {
			changeMap(get("imgNum"));
		}
	}
});

function changeMap(imgNum) {
	var mapNum = ((parseInt(get('page')) - 1) * 15) + parseInt(imgNum);
	var array = JSON.parse(get('obj'));
	var array2 = array[mapNum];
	var wtmX = eval('array2.image' + mapNum).wtmX;
	var wtmY = eval('array2.image' + mapNum).wtmY;
	var imgTime = eval('array2.image' + mapNum).imgTime;
	var imgName = eval('array2.image' + mapNum).image;
	var width = eval('array2.image' + mapNum).width;
	var height = eval('array2.image' + mapNum).height;
	
	//$('#imgName').text(imgName.substring(imgName.lastIndexOf('/') + 1, imgName.lastIndexOf('_')) + '.jpg');
	$('#imgTime').text(imgTime);
	$('#imgSize').text(width + ' x ' + height);

	setImgNum(imgNum);

	$('#image_map').remove();
	
    var mapWidth = parseInt($('#map_size').width());
    var mapHeight = parseInt($('#map_size').height());
    
    //alert('mapWidth = ' + mapWidth + ', mapHeight = ' + mapHeight + ', imgNum = ' + imgNum);
    
    //$('<img id="image_map" src="' + imgName + '" width="' + mapWidth + '" height="' + mapHeight + '" />').insertAfter('#map');
    //$('#original_img').append('<img id="image_map" src="' + imgName + '" width="' + mapWidth + '" height="' + mapHeight + '" />');
	var map_image = document.getElementById('map');
	map_image.style.display = 'none';
	
	var original_img = document.getElementById('original_img');
	original_img.src = imgName.substring(0, imgName.lastIndexOf('_')) + '.jpg';
	original_img.style.display = '';
	original_img.style.width = mapWidth + 'px';
	original_img.style.height = mapHeight + 'px';
	/* if (wtmX != null) {
		imgName = "'" + imgName.substring(0, imgName.lastIndexOf('_')) + '.jpg' + "'"
		$('<img onError ="this.src=' + imgName + ';" width="' + mapWidth + '" height="' + mapHeight + '" id="naver_map" src="' + 'https://naveropenapi.apigw.ntruss.com/map-static/v2/raster-cors?w=' + mapWidth + '&h=' + mapHeight + '&center=' + wtmY + ',' + wtmX + '&level=16&X-NCP-APIGW-API-KEY-ID=4zn2h8xem2&&maptype=satellite&markers=type:d|size:small|pos:' + wtmY + '%20' + wtmX + '" />').insertAfter('#tmp');
		
		//$('<img onError ="this.src=' + imgName + ';" width="' + mapWidth + '" height="' + mapHeight + '" id="naver_map" src="abcd" />').insertAfter('#tmp');
	} else {
		$('<img id="naver_map" src="' + imgName + '" width="' + mapWidth + '" height="' + mapHeight + '" />').insertAfter('#tmp');
	} */
}
function checkAnalyze() {
	if ($('#btn').val() != '분석 취소') {
		$('#caseTitle').val('');
		$('.modal_hide2').attr('class','modal2');
	} else {
		$('#submitBtn').click();
	}
}
function startAnalyze() {
	var caseTitle = $('#caseTitle').val();
	$('.modal2').attr('class','modal_hide2');
	$('#submitBtn').click();
}
function removeAll () {
	if ($('#btn').val() != '분석 취소') {
		// 텍스트 비움
		if(confirm('분석을 시작하시겠습니까?')) {
			var frm = document.analyzeForm;
			var path = document.getElementById('output_path');
			var login_id = document.getElementById('login_id');
			var analyze_content = document.getElementById('analyze_content');
			if (path.files.length > 0) {
				var isJPG = true;
				for (var i = 0; i < path.files.length; i++) {
					var file_name = path.files.item(i).name;
					var file_type = file_name.substring(file_name.lastIndexOf('.') + 1);
					if (file_type != 'jpg' && file_type != 'JPG') {
						isJPG = false;
					}
				}
				if (!isJPG) {
					alert('JPG 이미지 파일이 아닌 파일이 존재합니다.');
					return false;
				} else {
					frm.action = '/police/upload';
					$('#btn').val('분석 취소');
					$('#stitching').attr('disabled', true);
					$('#stitching').css('opacity', '0.5');
					$('#downloadBtn').attr('disabled', true);
					$('#stitchingUploadBtn').attr('disabled', true);
					$('#stitchingUploadBtn').css('opacity', '0.5');
					login_id.value = JSON.parse(get('userdata')).login_id;
					analyze_content.value = $('#caseTitle').val();

					$('#fileCount').text('0');
					$('#timeRemaining').text('0시간 0분 0초');
					$('#timeTaken').text('0시간 0분 0초');
					$('#perTime').text('0%');
					$('#perTime').width('0%');
					$('#imgName').text('');
					$('#imgTime').text('');
					$('#imgSize').text('');
					
					$('#progress_Loading').show();
					$('#loading').attr('disabled', true);
					$('#loading').css('opacity', '0.5');
					
					$('#map').remove();
		            $("#map_size").append('<div id="map" style="width:100%; height:100%;"></div>');
					
					map = null;
					linePath = new Array();
					
					var map_image = document.getElementById('map');
			    	map_image.style.display = '';
			    	var original_img = document.getElementById('original_img');
			    	original_img.style.display = 'none';

			    	$('.page').remove();
			    	
					$('<li class="page-item page active" id="page1"><a href="#">' + 1 + '</a></li>').insertBefore('#next_one');
			    	
					/* setCount('0');
					setPage('1');
					setTmpPage('1');
					setShowPage(null);
					setStartPage('1');
					setEndPage('1');
					setEndCount(0);

					setPerTime('0');
					setWidth('0');
					setTimeRemaining('0시간 0분 0초');
					setTimeTaken('0시간 0분 0초'); */
					
					return true;
				}
			} else {
				alert('업로드 할 폴더를 선택해주세요');
				return false;
			}
		} else {
			return false;
		}	
	} else {
		if (confirm('분석이 진행중입니다. 취소하시겠습니까?')) {
			isTimer = false;
			var frm = document.analyzeForm;
			var login_id = document.getElementById('login_id');
			login_id.value = JSON.parse(get('userdata')).login_id + "/" + JSON.parse(get('obj'))[0].image0.image.substring(JSON.parse(get('obj'))[0].image0.image.lastIndexOf('case'), JSON.parse(get('obj'))[0].image0.image.lastIndexOf('/'));
			//analyzeForm.action = '/police/deleteAsync';
			frm.action = '/police/deleteAsync';

			$('#btn').val('분석 시작');
			$('#btn').css('opacity', '1');
			//$('#downloadBtn').text('다운로드');
			//$('#downloadBtn').attr('disabled', false);
			//$('#downloadBtn').css('opacity', '1');

			clearInterval(get('timer3'));
			clearInterval(get('timer4'));
			if (/(MSIE|Trident)/.test(navigator.userAgent)) { 
				// ie 일때 input[type=file] init.
				$("#output_path").replaceWith($("#output_path").clone(true));
			} else {
				 // other browser 일때 input[type=file] init.
				$("#output_path").val("");
			}
			
			return true;
			
		} else {
			return false;
		}
	}
}

function timer(time) {
		var hour;
		var min;
		var sec;
		
		var x = setInterval(function() {
			hour = (parseInt(time/3600));
			min = parseInt(time%3600/60);
			sec = parseInt(time%3600%60);
			
			/* document.getElementById('timeRemaining').innerHTML = hour + '시간 ' + min + '분 ' + sec + '초'; */
			$('#timeRemaining').text(hour + '시간 ' + min + '분 ' + sec + '초');
			setTimeRemaining(hour + '시간 ' + min + '분 ' + sec + '초');
			
			if (!isTimer) {
				clearInterval(x);
			}
			setTimer3(x);
			
			time--;
			
			if (time < 0) {
				clearInterval(x);
			}
		}, 1000);
}
function timer2(endTime) {
		var hour;
		var min;
		var sec;
		var time = 0;
		
		var x = setInterval(function() {
			hour = (parseInt(time/3600));
			min = parseInt(time%3600/60);
			sec = parseInt(time%3600%60);
			
			/* document.getElementById('timeRemaining').innerHTML = hour + '시간 ' + min + '분 ' + sec + '초'; */
			$('#timeTaken').text(hour + '시간 ' + min + '분 ' + sec + '초');
			setTimeTaken(hour + '시간 ' + min + '분 ' + sec + '초');

			if (!isTimer) {
				clearInterval(x);
			}
			
			setTimer4(x);
			
			time++;
			
			/* if (time == endTime) {
				clearInterval(x);
			} */
		}, 1000);
}
$(window).on("beforeunload", function() {
	if (get('isShow')) {
	} else {
		return "현재 이미지 분석중입니다. 이동 시 처음부터 다시 해야합니다. 그래도 이동하시겠습니까?";
	}
});
function imageDownload() {
	if (('${case_idx}' != null && '${case_idx}' != '') || $('#perTime').text() == '100%') {
		$('#downloadBtn').text('다운로드중..\n 0%');
		$('#downloadBtn').html($('#downloadBtn').html().replace(/\n/g,'<br/>'));
		$('#downloadBtn').attr('disabled', true);
		$('#downloadBtn').css('opacity', '0.5');
		

		var jsonUrl = "/police/imageDownload";
		
		var obj = new Object();
		obj.case_idx = 'case' + case_idx;
		obj.login_id = JSON.parse(get('userdata')).login_id;
		obj.isCase = 'case' + case_idx;
		obj.isNew = case_idx;

		var jsonData = JSON.stringify(obj);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
				$('#downloadBtn').text('다운로드');
				$('#downloadBtn').attr('disabled', false);
				$('#downloadBtn').css('opacity', '1');
				location.href = data.address;
				//$('#download').attr('href', data.address);
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
	} else {
		alert('분석이 완료되지 않았습니다. 분석 완료 후 다운로드가 가능합니다.');
	} 
}
function stitching() {
	$('#stitching').attr('href', 'icemng://C:\\web_server\\image\\case' + case_idx);
}
function clickUploadBtn() {
	var btn = document.getElementById('stitchingUpload_path');
	btn.click();
}
function stitchingUpload() {
	if ('${case_idx}' != null && '${case_idx}' != '') {
		var frm = document.getElementById('stitchingUpload');
		var caseNum = document.getElementById('caseNum');
		var file = document.getElementById('stitchingUpload_path');
		var isCase = document.getElementById('isCase');
		var isNew = document.getElementById('isNew');
		var stitching_id = document.getElementById('stitching_id');

		if (JSON.stringify(file.files.length) > 0) {
			$('#stitchingUploadBtn button').text('스티칭중..');
			$('#stitchingUploadBtn').attr('disabled', true);
			$('#stitchingUploadBtn').css('opacity', '0.5');
			caseNum.value = 'case' + '${case_idx}'
			stitching_id.value = JSON.parse(get('userdata')).login_id;
			isCase.value = 'case' + '${case_idx}';
			isNew.value = '${case_idx}'; 
			frm.submit();
		} else {
			alert('스티칭 이미지를 선택해야 합니다.');
		}
	} else {
		alert('이미지 분석을 완료하여야 합니다.');
	}
}
function isImageLoad(url) {
    var image = new Image();
    
    image.src = url;
}
function imageFound() {
	return true;
}
function imageNotFound() {
	return false;
}
function chkRoute() {
	var chk = $("input:checkbox[id='chkRoute']").is(":checked");
	var chkArray = JSON.parse(get('obj'));
	if (chk) {
		//alert("지도 ON");
		for (var c = 0; c < chkArray.length; c++) {
			if (circlePath[c] != null) {
				circlePath[c].setMap(map);
			}
		}
		mapLine.setMap(map);
	} else {
		for (var c = 0; c < chkArray.length; c++) {
			if (circlePath[c] != null) {
				circlePath[c].setMap(null);
			}
		}
		mapLine.setMap(null);
		//alert("지도 OUT");
	}
}
function labelClick() {
	$("#form_label").click();
}

// 개편 후
function clickPage_num(case_idx, page_number) {
	setPage(page_number);
	setPage_number(page_number);
		
	var jsonUrl = "/police/clickPage_num";
	
	var obj = new Object();
	obj.case_idx = case_idx;
	obj.page_number = page_number;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		   
	    success: function(data) {
	    	if (data.length > 0) {
		    	for (var i = 0; i < 15; i++) {
					$('#image' + i).remove();
		    	}
		    	
		    	$('#menu').find('.active').removeClass('active');
		    	$('#page' + page_number).addClass("active");

				//$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
				
				$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
				$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
				
				var date = new Date(data[0].gps_imgtime);
				var month = date.getMonth() + 1;
				if (month < 10) {
					month = "0" + month;
				}
				var day = date.getDate();
				if (day < 10) {
					day = "0" + day;
				}
				
				var firstDate = date.getFullYear() + "-" + month + "-" + day;
				
				var hour = date.getHours();
				if (hour < 10) {
					hour = "0" + hour;
				}
				var minutes = date.getMinutes();
				if (minutes < 10) {
					minutes = "0" + minutes;
				}
				var seconds = date.getSeconds();
				if (seconds < 10) {
					seconds = "0" + seconds;
				}
				
				var secondDate = hour + ":" + minutes +  ":" + seconds;
				
				$('#imgTime').text(firstDate + " " + secondDate);		
				
				for (var j = 0; j < data.length; j++) {
					var w = $('#imageTd' + j).width();
					var h = $('#imageTd' + j).height();
					var src = data[j].gps_image;
					
					var selectImage = '';
					if (j == 0) {
						selectImage = 'selectImage';
					}
					
					var data_date = new Date(data[j].gps_imgtime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = data[j].gps_imgname.substring(data[j].gps_imgname.lastIndexOf('/') + 1);
					var size_text = data[j].gps_width + ' x ' + data[j].gps_height;
					var date_text = data_firstDate + " " + data_secondDate;
					
					var option = "'image', '" + data[j].gps_imgname + "', null, '" + src_text + "', '" + size_text + "', '" + date_text + "'";
					if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
						option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy + ", '" + src_text + "', '" + size_text + "', '" + date_text + "'";
					}
					$('<img id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
				}

				$('#image_list').find('.selectImage').removeClass('selectImage');
				$('#image0').addClass("selectImage");
	    	}
	    },
		error: function(errorThrown) {
			/* alert(errorThrown.statusText);
			alert(jsonUrl); */
		}
	});
}

function clickImage(image_number, option, data, wtmy, src_text, size_text, date_text) {
	$('#image_list').find('.selectImage').removeClass('selectImage');
	$('#image' + image_number).addClass("selectImage");
	
	if (option == 'circle') {
		$('#original_img').hide();

		var moveLatLon = new kakao.maps.LatLng(data, wtmy);
		
        map.panTo(moveLatLon);

        if (imageMarker != null && imageMarker != "undefined") {
    		imageMarker.setPosition(moveLatLon);
        } else {
            var imageSize = new kakao.maps.Size(24, 35); 
            
            // 마커 이미지를 생성합니다    
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
        	imageMarker = new kakao.maps.Marker({
    			map: map, // 마커를 표시할 지도
    			position: moveLatLon, // 마커를 표시할 위치
    			image : markerImage // 마커 이미지 
    		});
        }
		
		$('#map').show();
	} else {
		$('#map').hide();
	    var mapWidth = $('#map_size').width();
	    var mapHeight = $('#map_size').height();
	    
		var original_img = document.getElementById('original_img');
		original_img.src = data;
		original_img.style.display = '';
		original_img.style.width = mapWidth + 'px';
		original_img.style.height = mapHeight + 'px';
		
		$('#original_img').show();
	}

	$('#imgName').text(src_text);
	$('#imgSize').text(size_text);	
	$('#imgTime').text(date_text);		
	
}
function goEndPage(case_idx, total_count, page_number) {
	if ($(this).attr('class') != 'disabled' && get('page') != page_number) {
		var jsonUrl = "/police/clickPage_num";
		
		var obj = new Object();
		obj.case_idx = case_idx;
		obj.page_number = page_number;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	if (data.length > 0) {
			    	for (var i = 0; i < 15; i++) {
						$('#image' + i).remove();
			    	}
			    	
			    	$('#menu').find('.active').removeClass('active');
			    	$('#page' + page_number).addClass("active");

					//$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
					
					var date = new Date(data[0].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					for (var j = 0; j < data.length; j++) {
						var w = $('#imageTd' + j).width();
						var h = $('#imageTd' + j).height();
						var src = data[j].gps_image;
						var selectImage = '';
						if (j == 0) {
							selectImage = 'selectImage';
						}
						var option = "'image', '" + data[j].gps_imgname + "'";
						if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
							option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy;
						}
						$('<img id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
					}

					$('#image_list').find('.selectImage').removeClass('selectImage');
					$('#image0').addClass("selectImage");

					if (data[0].gps_wtmx == null && data[0].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[0].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					} else {
						$('#original_img').hide();
				        
						$('#map').show();
					}

					var end_opt = parseInt((page_number - 1) / 10);
					var now_opt = parseInt((get('page') - 1) / 10);
					
					if (now_opt != end_opt) {
						$('.page').remove();
						
						var first = end_opt * 10 + 1;
						var end = page_number + 1;
						
						for (var i = first; i < end; i++) {
							var opt = '';
							if (i == page_number) {
								opt = 'active'
							}
							$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
						}
					} else {
						$('#menu').find('.active').removeClass('active');
						$('#page' + page_number).addClass("active");
					}
					
					setPage(page_number);
					setPage_number(page_number);
					
					var data_date = new Date(data[0].gps_imgtime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1);
					var size_text = data[0].gps_width + ' x ' + data[0].gps_height;
					var date_text = data_firstDate + " " + data_secondDate;
						
					$('#imgName').text(src_text);
					$('#imgSize').text(size_text);	
					$('#imgTime').text(date_text);		
		    	}
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});

	}
}
function goStartPage(case_idx, total_count, page_number) {
	if ($(this).attr('class') != 'disabled' && get('page') != 1) {
		var jsonUrl = "/police/clickPage_num";
		
		var obj = new Object();
		obj.case_idx = case_idx;
		obj.page_number = page_number;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	if (data.length > 0) {
			    	for (var i = 0; i < 15; i++) {
						$('#image' + i).remove();
			    	}
			    	
					//$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
					
					var date = new Date(data[0].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					for (var j = 0; j < data.length; j++) {
						var w = $('#imageTd' + j).width();
						var h = $('#imageTd' + j).height();
						var src = data[j].gps_image;
						var selectImage = '';
						if (j == 0) {
							selectImage = 'selectImage';
						}
						var option = "'image', '" + data[j].gps_imgname + "'";
						if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
							option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy;
						}
						$('<img id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
					}

					$('#image_list').find('.selectImage').removeClass('selectImage');
					$('#image0').addClass("selectImage");

					if (data[0].gps_wtmx == null && data[0].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[0].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					} else {
						$('#original_img').hide();

						$('#map').show();
					}

					var end_opt = 0;
					var now_opt = parseInt((get('page') - 1) / 10);

					if (now_opt != end_opt) {
						$('.page').remove();

						var first = 1;
						var end = page_number + 10;
						
						var total_page = parseInt((total_count - 1) / 15) + 1;
						
						if (total_page < end) {
							end = total_page
						}
						
						for (var i = first; i < end; i++) {
							var opt = '';
							if (i == 1) {
								opt = 'active'
							}
							$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
						}
					} else {
						$('#menu').find('.active').removeClass('active');
						$('#page1').addClass("active");
					}
					
					setPage(1);
					setPage_number(1);

					var data_date = new Date(data[0].gps_imgtime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1);
					var size_text = data[0].gps_width + ' x ' + data[0].gps_height;
					var date_text = data_firstDate + " " + data_secondDate;
						
					$('#imgName').text(src_text);
					$('#imgSize').text(size_text);	
					$('#imgTime').text(date_text);		
		    	}
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
	}
}
function goNextPage(case_idx, total_count, total_page) {
	if ($(this).attr('class') != 'disabled' && get('page') != total_page) {
		var now_opt = parseInt((get('page') - 1) / 10);
		var total_opt = parseInt((total_page - 1) / 10);

		//var page_num = parseInt(get('page')) + 10;
		var page_num = (now_opt + 1) * 10 + 1;
		
		if (page_num > total_page) {
			page_num = total_page;
		}

		var end_opt = parseInt((page_num - 1) / 10);
		
		var jsonUrl = "/police/clickPage_num";
		
		var obj = new Object();
		obj.case_idx = case_idx;
		obj.page_number = page_num;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	if (data.length > 0) {
			    	for (var i = 0; i < 15; i++) {
						$('#image' + i).remove();
			    	}
			    	
					//$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
					
					var date = new Date(data[0].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					for (var j = 0; j < data.length; j++) {
						var w = $('#imageTd' + j).width();
						var h = $('#imageTd' + j).height();
						var src = data[j].gps_image;
						var selectImage = '';
						if (j == 0) {
							selectImage = 'selectImage';
						}
						var option = "'image', '" + data[j].gps_imgname + "'";
						if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
							option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy;
						}
						$('<img id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
					}

					$('#image_list').find('.selectImage').removeClass('selectImage');
					$('#image0').addClass("selectImage");

					if (data[0].gps_wtmx == null && data[0].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[0].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					} else {
						$('#original_img').hide();

						/* var moveLatLon = new kakao.maps.LatLng(data[0].gps_wtmx, data[0].gps_wtmy);
						
				        map.panTo(moveLatLon);

				        if (imageMarker != null && imageMarker != "undefined") {
				    		imageMarker.setPosition(moveLatLon);
				        } else {
				            var imageSize = new kakao.maps.Size(24, 35); 
				            
				            // 마커 이미지를 생성합니다    
				            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				        	imageMarker = new kakao.maps.Marker({
				    			map: map, // 마커를 표시할 지도
				    			position: moveLatLon, // 마커를 표시할 위치
				    			image : markerImage // 마커 이미지 
				    		});
				        } */
				        
						$('#map').show();
					}

					if (end_opt != now_opt) {
						$('.page').remove();
						
						var first = (now_opt + 1) * 10 + 1;
						
						var end = first + 10;

						if (end > total_page + 1) {
							end = total_page + 1;
						}
						
						for (var i = first; i < end; i++) {
							var opt = '';
							if (i == page_num) {
								opt = 'active'
							}
							$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
						}
						
						setPage(page_num);
						setPage_number(page_num);
					} else {
				    	$('#menu').find('.active').removeClass('active');
				    	$('#page' + page_num).addClass("active");
				    	
						setPage(page_num);
						setPage_number(page_num);
					}
					
					var data_date = new Date(data[0].gps_imgtime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1);
					var size_text = data[0].gps_width + ' x ' + data[0].gps_height;
					var date_text = data_firstDate + " " + data_secondDate;
						
					$('#imgName').text(src_text);
					$('#imgSize').text(size_text);	
					$('#imgTime').text(date_text);		
		    	}
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
		
	}
}
function goPreviousPage(case_idx, total_count, total_page) {
	if ($(this).attr('class') != 'disabled' && get('page') != 1) {
		var first_opt = 0;
		var now_opt = parseInt((get('page') - 1) / 10);
		
		//var page_num = parseInt(get('page')) - 10;
		var page_num = (now_opt - 1) * 10 + 10;
		
		if (page_num < 1) {
			page_num = 1;
		}
		
		var jsonUrl = "/police/clickPage_num";
		
		var obj = new Object();
		obj.case_idx = case_idx;
		obj.page_number = page_num;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	if (data.length > 0) {
			    	for (var i = 0; i < 15; i++) {
						$('#image' + i).remove();
			    	}
			    	
					//$('#imgName').text(data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1));
					$('#imgSize').text(data[0].gps_width + ' x ' + data[0].gps_height);	
					
					var date = new Date(data[0].gps_imgtime);
					var month = date.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = date.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					
					var firstDate = date.getFullYear() + "-" + month + "-" + day;
					
					var hour = date.getHours();
					if (hour < 10) {
						hour = "0" + hour;
					}
					var minutes = date.getMinutes();
					if (minutes < 10) {
						minutes = "0" + minutes;
					}
					var seconds = date.getSeconds();
					if (seconds < 10) {
						seconds = "0" + seconds;
					}
					
					var secondDate = hour + ":" + minutes +  ":" + seconds;
					
					$('#imgTime').text(firstDate + " " + secondDate);		
					
					for (var j = 0; j < data.length; j++) {
						var w = $('#imageTd' + j).width();
						var h = $('#imageTd' + j).height();
						var src = data[j].gps_image;
						var selectImage = '';
						if (j == 0) {
							selectImage = 'selectImage';
						}
						var option = "'image', '" + data[j].gps_imgname + "'";
						if (data[j].gps_wtmx != null && data[j].gps_wtmy != null) {
							option = "'circle', " + data[j].gps_wtmx + ", " + data[j].gps_wtmy;
						}
						$('<img id="image' + j + '"src="' + src + ' "width="' + w + 'px" height="' + h + 'px" style="position:absolute;" onclick="clickImage(' + j + ', ' + option + ');" />').insertBefore('#analyse' + j);
					}

					$('#image_list').find('.selectImage').removeClass('selectImage');
					$('#image0').addClass("selectImage");

					if (data[0].gps_wtmx == null && data[0].gps_wtmy == null) {
						$('#map').hide();
					    var mapWidth = $('#map_size').width();
					    var mapHeight = $('#map_size').height();
					    
						var original_img = document.getElementById('original_img');
						original_img.src = data[0].gps_imgname;
						original_img.style.display = '';
						original_img.style.width = mapWidth + 'px';
						original_img.style.height = mapHeight + 'px';
						
						$('#original_img').show();
					} else {
						$('#original_img').hide();
				        
						$('#map').show();
					}

					if (now_opt != first_opt) {
						var first = (now_opt - 1) * 10 + 1;
						
						if (first < 1) {
							first = 1;
						}
						
						var end = first + 10;
						
						$('.page').remove();

						for (var i = first; i < end; i++) {
							var opt = '';
							if (i == page_num) {
								opt = 'active'
							}
							$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + "'" + case_idx + "', '" + i + "'" + ');">' + i + '</a></li>').insertBefore('#next_one');
						}
						
						setPage(page_num);
						setPage_number(page_num);
					} else {
						$('#menu').find('.active').removeClass('active');
						$('#page' + page_num).addClass("active");
						
						setPage(page_num);
						setPage_number(page_num);
					} 
					
					var data_date = new Date(data[0].gps_imgtime);
					var data_month = data_date.getMonth() + 1;
					if (data_month < 10) {
						data_month = "0" + data_month;
					}
					var data_day = data_date.getDate();
					if (data_day < 10) {
						data_day = "0" + data_day;
					}
					
					var data_firstDate = data_date.getFullYear() + "-" + data_month + "-" + data_day;
					
					var data_hour = data_date.getHours();
					if (data_hour < 10) {
						data_hour = "0" + data_hour;
					}
					var data_minutes = data_date.getMinutes();
					if (data_minutes < 10) {
						data_minutes = "0" + data_minutes;
					}
					var data_seconds = data_date.getSeconds();
					if (data_seconds < 10) {
						data_seconds = "0" + data_seconds;
					}
					
					var data_secondDate = data_hour + ":" + data_minutes +  ":" + data_seconds;
					
					var src_text = data[0].gps_imgname.substring(data[0].gps_imgname.lastIndexOf('/') + 1);
					var size_text = data[0].gps_width + ' x ' + data[0].gps_height;
					var date_text = data_firstDate + " " + data_secondDate;
						
					$('#imgName').text(src_text);
					$('#imgSize').text(size_text);	
					$('#imgTime').text(date_text);		
		    	}
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
		
	}
}
</script>
<body>
<div id="progress_Loading" align="center" style="display:none; position:absolute; top:30%; left:45%; z-index:100;">
	<img src="./resources/image/loading.gif"/>
</div>
<table style="width:100%; height:100%; padding:0; margin:0; border-collapse: separate; border-spacing:8px; border:none;" id="loading">
<tr height="7%"><td width="100%">
<table style="width:100%; height:100%; border:none; padding:0; margin:0; border-collapse: separate; border-spacing:4px;">
<tr height="100%"><td width="30%">
	<p class="navbar-text" style="margin:15px;">분석 리스트
	<p class="navbar-text navbar-right" style="margin:15px;" id="fileCount">
</td>
<td width="*">
	<p class="navbar-text" style="margin:15px;">지도 뷰
	<!-- <p class="navbar-text navbar-right" style="margin:15px;">발견 경고음 활성화
	<p class="navbar-text navbar-right" style="margin:15px 0px 15px 15px;"><input type="checkbox" id="inlineCheckbox1" value="option1" /> -->
	<!-- <p class="navbar-text navbar-right" style="margin:15px;">드론 이동 경로 활성화
	<p class="navbar-text navbar-right" style="margin:15px 0px 15px 15px;"><input type="checkbox" id="chkRoute" value="option1" onclick="chkRoute();" /> -->
</td></tr>
</table>
</td></tr>
<tr height="93%"><td width="100%">
<table style="width:100%; height:100%; padding:0; margin:0; border-collapse: separate; border-spacing:4px;">
<tr height="100%"><td width="30%">
	<table id="image_list" style="width:100%; height:92%; padding:0; margin:0; border-collapse: separate; border-spacing:8px; background-color:#252525;">
		<% for (int i = 0; i < 15; i++) { 
			if (i % 3 == 0) {
		%>
			<tr height="15%">
		<%	} %>
			<td width="25%" id='imageTd<%=i %>' style="background-color:#404040; border:none; position:relative; padding:0; margin:0;">
				<div id='analyse<%=i %>' style="width:100%; height:100%; postion:absolute"></div>
			</td>
		<% if (i % 3 == 2) { %>
			</tr>
			<%
			}
		} %>
	</table>
	<table style="width:100%; height:6%; padding-bottom:8px; margin:0; background-color:#252525;"><tr><td>
		<div class="container-fluid" id="page" style="height:100%; text-align:center;">
				<ul id="menu" class="pagination" style="margin:0;">
					<li id="previous" class="disabled"> <!-- class="disabled" -->
						<a href="#" aria-label="Previous">
				   			<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
					<li class="page-item" id="previous_one"><a class="page-link" href="#">이전</a></li>
					<li class="page-item page active" id="page1"><a href="#">1</a></li>
					<li class="page-item" id="next_one"><a class="page-link" href="#">다음</a></li>
					<li id="next" class="disabled">
						<a href="#" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</ul>
			</div>
	</td></tr></table>
</td>
<td>
	<table style="width:100%; height:100%; background-color:#252525; margin:0; padding:8px; border-collapse:separate; border-spacing:8px;">
		<tr><td width="100%">
			<table style="width:100%; height:100%; border:none; padding:0; margin:0;">
			<tr height="94%">
			<td id="map_size" colspan="3" style="background-color:#404040;" align="center">
				<div id="map" style="width:100%; height:100%;"></div>
				<img id="original_img" src="" width="1293px" height="574px" style="display:none;" />
			</td>
			</tr>
			<tr>
			<td width="45%" id="imgName" style="background-color:#333333; padding:8px;"></td>
			<td width="35%" id="imgSize" style="background-color:#333333; padding:8px;"></td>
			<td width="20%" id="imgTime" align="right" style="background-color:#333333; padding:8px;"></td>
			</tr>
			</table>
		</td></tr>
		<tr height="10%"><td style="background-color:#404040;">
			<table style="width:100%; height:100%; border:none; padding:0; margin:0;">
			<tr>
			<td id="input_text" width="*" style="background-color:#404040; padding:8px;">입력 이미지 폴더</td>
			<td style="background-color:#404040; padding:8px;">
				<div class="container" id="upload_text" style="padding:0; margin:0; width:100%; height:100%; ">		<!-- display:none; -->
				<button id="labelBtn" onclick="labelClick();">업로드 폴더를 선택해주세요.</button>
				<input disabled="disabled" style="position:absolute; clip:rect(0,0,0,0); border:0; width:0px; height:0px; padding:0; margin:-1px; overflow: hidden; ">
				<label id="form_label" for="output_path" style="margin:0; display:none;">업로드 폴더를 선택해주세요.</label>
				<form action="/police/upload" name="analyzeForm" method="post" enctype="multipart/form-data" id="formUploadDir" onsubmit="return removeAll();" target="iframe1">
				<input type=hidden id="login_id" name="login_id" value="" />
				<input type=hidden id="analyze_content" name="analyze_content" value="" />
				<input type="file" accept=".jpg" id="output_path" name="file" webkitdirectory mozdirectory msdirectory odirectory directory multiple style="position:absolute; clip:rect(0,0,0,0); border: 0;width:1px; height:1px; padding:0; margin:-1px; overflow: hidden; "/>
				</div>
			</td>
			<td width="10%" style="background-color:#404040; padding:8px;">
				<input id="btn" type="button" style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF;" value="분석 시작" onclick="checkAnalyze();" />	 <!-- display:none; -->
				<input id="submitBtn" type="submit" style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF; display:none;" />		 <!-- display:none; -->
				</form>
			</td>
			<td width="10%" style="background-color:#404040; padding:8px;">
				<a id="download"><button id="downloadBtn" style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF;" onclick="imageDownload();">다운로드</button></a>
			</td>
			<td width="10%" style="background-color:#404040; padding:8px;">
				<a id="stitching" onclick="stitching();"><button id="stitchingBtn" style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF;">스티칭</button></a>
			</td>
			<td width="10%" style="background-color:#404040; padding:8px;">
				<input disabled="disabled" style="position:absolute; clip:rect(0,0,0,0); border: 0;width:1px; height:1px; padding:0; margin:-1px; overflow: hidden; ">
				<a id="stitchingUploadBtn"><button style="width:100%; height:100%; border:none; border-radius:3px; cursor:pointer; padding:0; margin:0; color:white; background-color:#1E90FF;" onclick="clickUploadBtn();">스티칭 업로드</button></a>
				<form action="/police/stitchingUpload" method="post" enctype="multipart/form-data" id="stitchingUpload" target="iframe1">
					<input type=hidden id="caseNum" name="caseNum" value="" />
					<input type=hidden id="stitching_id" name="stitching_id" value="" />
					<input type=hidden id="isCase" name="isCase" value="" />
					<input type=hidden id="isNew" name="isNew" value="" />
					<input type="file" id="stitchingUpload_path" accept=".jpg" name="file" style="position:absolute; clip:rect(0,0,0,0); border: 0;width:1px; height:1px; padding:0; margin:-1px; overflow: hidden;" onchange="stitchingUpload();"/>
				</form>
			</td>
			</tr>
			<!-- <tr>
			<td style="background-color:#404040; padding:8px;">출력 이미지 폴더</td>
			<td style="background-color:#404040; padding:8px;">
				<input type="text" value="C:/web_server/image" style="margin:0; padding:0; color:white; background-color:#404040; width:80%; border:none;" disabled/>
			</td>
			</tr> -->
			</table>
		</td></tr>
		<tr height="10%"><td style="background-color:#404040;">
			<table id="time_text" style="width:100%; height:100%; border:none; margin:0; padding:0;">
				<tr>
				<td style="background-color:#404040; padding:0px 8px;">
					<p class="navbar-text" style="margin:0px 8px 0px 0px;">가동시간 :
					<p class="navbar-text" style="margin:0;" id="timeTaken">
					<p class="navbar-text navbar-right" style="margin:0;" id="timeRemaining">
					<p class="navbar-text navbar-right" style="margin:0px 8px 0px 0px;">남은시간 :
				</td></tr>
				<tr>
				<td style="background-color:#404040; padding:8px;">
					<div class="progress" style="margin:0px 8px 0px 8px;">
						<div id="perTime" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" >
						</div>
					</div>
				</td>
				</tr>
			</table>
		</td></tr>
	</table>
</td></tr>
</table>
</td></tr>
</table>
<iframe name="iframe1" style="display:none; width:0px; height:0px;"></iframe>
<!-- The Modal -->
<div class="modal_hide2">
	<!-- Modal content -->
	<div class="modal-content2">
		<div class="closeDiv6">
			<button class="button_close closeBtn6">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			</button> 
		</div>
		<div class="titleDiv3">
			수색 내용
		</div>
		<div class="contentDiv2">
			<input type="text" id="caseTitle" />
		</div>
		<div class="btnDiv2">
			<button class="button_check2 checkBtn2" onclick="startAnalyze();">
				확인
			</button>
			<button class="button_delete2 closeBtn5">
				취소
			</button>
		</div>
	</div>
</div>
</body>
</html>