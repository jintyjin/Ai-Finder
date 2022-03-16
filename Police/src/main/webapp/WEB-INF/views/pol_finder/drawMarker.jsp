<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
// 버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay(type) {
    // 그리기 중이면 그리기를 취소합니다
	/* isCircleMode = false;
	drawingFlag = true; */
    manager.cancel();
    manager2.cancel();
    manager3.cancel();

    // 클릭한 그리기 요소 타입을 선택합니다
    manager.select(kakao.maps.drawing.OverlayType[type]);
}

//버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay2(type) {
 // 그리기 중이면 그리기를 취소합니다
    manager.cancel();
    manager2.cancel();
    manager3.cancel();
 // 클릭한 그리기 요소 타입을 선택합니다
 manager2.select(kakao.maps.drawing.OverlayType[type]);
}

//버튼 클릭 시 호출되는 핸들러 입니다
function selectOverlay3(type) {
// 그리기 중이면 그리기를 취소합니다
    manager.cancel();
    manager2.cancel();
    manager3.cancel();

// 클릭한 그리기 요소 타입을 선택합니다
manager3.select(kakao.maps.drawing.OverlayType[type]);
}
function getDataFromDrawingMap(data1) {
    // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
    //var data = manager.getData();

    // 지도에 가져온 데이터로 도형들을 그립니다
    //drawMarker(data[kakao.maps.drawing.OverlayType.MARKER]);
    //drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]);
    drawRectangle1(data1.rectangle);
    //drawCircle(data[kakao.maps.drawing.OverlayType.CIRCLE]);
    //drawPolygon(data[kakao.maps.drawing.OverlayType.POLYGON]);
}
// 가져오기 버튼을 클릭하면 호출되는 핸들러 함수입니다
// Drawing Manager로 그려진 객체 데이터를 가져와 아래 지도에 표시합니다
// 아래 지도에 그려진 도형이 있다면 모두 지웁니다

/* manager.addListener('drawstart', function(data) {
    //console.log('drawstart', data);
    var coords = new kakao.maps.Coords(data.coords.La, data.coords.Ma);
    
	center = coords.toLatLng();

    if (data.overlayType == 'circle') {
        drawingOverlay = new kakao.maps.CustomOverlay({
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 1
        });              

        var json = new Object();
        json.drawingOverlay = drawingOverlay;
        json.center = center;
        json.type = 'circle';
        json.id = figure;
        
        length_array.push(json)
        //console.log(JSON.stringify(length_array));
        
    	//length_array.push(drawingOverlay);
    	//center_array.push(center);
    } else if (data.overlayType == 'rectangle') {
        drawingOverlay = new kakao.maps.CustomOverlay({
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 1
        });          
    }
    
    isdrawned = false;
});

manager.addListener('drawend', function(mouseEvent) {
    //console.log(mouseEvent.target.xb.id);
    //console.log(mouseEvent.overlayType);
    if (mouseEvent.overlayType == 'polyline') {
    	figure = (parseInt(mouseEvent.target.Hc[0].id.substring(mouseEvent.target.Hc[0].id.lastIndexOf('-') + 1)));
    	// 선 저장 로직만 아직 안만듬(보류)
    }
    
	if (mouseEvent.overlayType == 'rectangle') {
		var jsonUrl = "/police/pol_test";

		var jsonObject = new Object();
		jsonObject.style = 'rectangle';
		jsonObject.sPointY = manager.getData()[kakao.maps.drawing.OverlayType.RECTANGLE][0].sPoint.y;
		jsonObject.sPointX = manager.getData()[kakao.maps.drawing.OverlayType.RECTANGLE][0].sPoint.x;  
		jsonObject.ePointY = manager.getData()[kakao.maps.drawing.OverlayType.RECTANGLE][0].ePoint.y;
		jsonObject.ePointX = manager.getData()[kakao.maps.drawing.OverlayType.RECTANGLE][0].ePoint.x;
		
		var jsonData = JSON.stringify(manager.getData());
		
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
		
		figure = mouseEvent.target.xb.id.substring(mouseEvent.target.xb.id.lastIndexOf('-') + 1);
		drawingOverlay.setPosition(center);
		var path = document.getElementById('daum-maps-shape-' + figure);
	    var tmpPath = new Array();
	    var width = 0;
	    var height = 0;
	    var width_small = 0;
	    var height_small = 0;
	    for (var i = 1; i < path.getAttribute('d').split(' ').length; i++) {
	    	var val = path.getAttribute('d').split(' ')[i];
	    	if (i == 1) {
				width_small = parseInt(val.substring(1));
	    	}
	    	if (i == 2) {
	    		height = parseInt(val);
	    		height_small = parseInt(val);
	    	}
	    	
	    	if (i > 0 && i < path.getAttribute('d').split(' ').length - 1) {
	    		if (i % 2 == 1) {		// x좌표
	    			if (i == 1 || i == 3) {
	    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
	    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
	    			} else {
	    				parseInt(val) > width ? width = parseInt(val) : width = width;
	    			}
	    		} else {		// y좌표
    				parseInt(val) > height ? height = parseInt(val) : height = height;
    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
	    		}
	    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
	    	}
	    }
		var content = '<div id="rectangle-text-' + figure + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트</div>';
		drawingOverlay.setContent(content);
		drawingOverlay.setMap(drawingMap);
		
		$('#rectangle-text-' + figure).css('pointer-events', 'none');
		$('#rectangle-text-' + figure).css('white-space', 'break-spaces');
		$('#rectangle-text-' + figure).parent().css('pointerEvents', 'none');
		$('#rectangle-text-' + figure).parent().css('overflow', 'hidden');
		
	    //$('#rectangle-text-' + figure).draggable();
	    
		var json = new Object();
		json.id = figure;
        json.drawingOverlay = drawingOverlay;
        json.center = center;
        json.width = (width - width_small);
        json.height = (height - height_small);
        json.type = 'rectangle';
        json.id = figure;
        json.content = $('#rectangle-text-' + figure).text();
        
        rect_array.push(json);
	}
	
    //var json = mouseEvent.target.n;
    //alert(JSON.stringify(json));
	//var coords = new kakao.maps.Coords(json.La, json.Ma);
    //alert(coords.toLatLng().toString());
    
    //alert(data.tagret);
    /* $('#' + mouseEvent.target.xb.id).contextmenu(function() {
    	alert(1);
    });
    var data = manager.getData();
    
    // 지도에 가져온 데이터로 도형들을 그립니다
    drawMarker(data[kakao.maps.drawing.OverlayType.MARKER]);
    if (mouseEvent.overlayType != 'marker') {
        figure++;
    }
    isdrawned = true;
}); */
    
/* manager.addListener('state_changed', function(e) {
    var data = manager.getData();
    
    drawCircle(data[kakao.maps.drawing.OverlayType.CIRCLE]);
    drawRectangle(data[kakao.maps.drawing.OverlayType.RECTANGLE]);
	
}); */
/* manager.addListener('draw', function(data) {
    //console.log('draw', data);
    
    if (data.overlayType == 'circle') {
        var coords = new kakao.maps.Coords(data.coords.La, data.coords.Ma);
        
    	var mousePosition = coords.toLatLng(); 
    	
        // 그려지고 있는 선을 표시할 좌표 배열입니다. 클릭한 중심좌표와 마우스커서의 위치로 설정합니다
        var linePath = [center, mousePosition];    
        
        drawingLine = new kakao.maps.Polyline({
            strokeWeight: 1, // 선의 두께입니다
            strokeColor: '#00a0e9', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });    
        
        drawingLine.setPath(linePath);
        
        // 원의 반지름을 선 객체를 이용해서 얻어옵니다 
        var length = drawingLine.getLength();
        
        if(length > 0) {
            // 반경 정보를 표시할 커스텀오버레이의 내용입니다
			var circle_json = length_array.length - 1;
			
            var id = length_array[circle_json].id;
            
            //console.log('id = ' + id);
            
            var radius = Math.round(length),   
            content = '<div class="info" id="length' + id + '">반경 <span class="number">' + radius + '</span>m</div>';
            
            radius_array[id] = radius;
            length_array[circle_json].radius = radius;
			//console.log(JSON.stringify(radius_array));
            
            // 반경 정보를 표시할 커스텀 오버레이의 좌표를 마우스커서 위치로 설정합니다
            //drawingOverlay.setPosition(mousePosition);
            drawingOverlay.setPosition(center);
            
            // 반경 정보를 표시할 커스텀 오버레이의 표시할 내용을 설정합니다
            drawingOverlay.setContent(content);

        	if (drawingOverlay != null) {
                //drawingOverlay.setMap(null);
        	}
            // 그려지고 있는 원의 반경정보 커스텀 오버레이를 지도에 표시합니다
            
            //length_array[id] = drawingOverlay;
            length_array[length_array.length - 1].drawingOverlay = drawingOverlay;
            
            drawingOverlay.setMap(drawingMap);
            
            $('#daum-maps-shape-' + id).mouseover(function () {
            	if (isdrawned) {
            		//console.log('id = ' + id);
            		//console.log('array = ' + JSON.stringify(radius_array[id]));
            		for (var i = 0; i < length_array.length; i++) {
            			if (length_array[i] != null && length_array[i].id == id) {
            				//console.log(i + " / " + id);
                           	drawingOverlay = length_array[i].drawingOverlay;
            				drawingOverlay.setPosition(length_array[i].center);
            				//console.log(length_array[length_array.length - 1].center);
            				var content = '<div class="info" id="length' + id + '">반경 <span class="number">' + length_array[i].radius + '</span>m</div>';
            				drawingOverlay.setContent(content);
            				length_array[i].drawingOverlay = drawingOverlay;
            				//drawingOverlay.setContent(content);
            				drawingOverlay.setMap(drawingMap);
            				break;
            			}
            		}
            	}
            });
            
            $('#daum-maps-shape-' + id).mouseout(function () {
            	if (isdrawned) {
            		for (var i = 0; i < length_array.length; i++) {
            			if (length_array[i] != null && length_array[i].id == id) {
                    		length_array[i].drawingOverlay.setMap(null);
            				break;
            			}
            		}
            	}
            });

            $('#daum-maps-shape-' + id).unbind('contextmenu');
            

            $('#daum-maps-shape-' + id).contextmenu(function () {
            	alert('contextmenu');
            });
            
            length_array[circle_json] = length_array[circle_json];
            
        } else {
        	if (drawingOverlay != null) {
                //drawingOverlay.setMap(null);
        	}
        }
    }
    if (data.overlayType == 'rectangle') {
        var coords = new kakao.maps.Coords(data.coords.La, data.coords.Ma);
        
    	var mousePosition = coords.toLatLng();

        var id = (length_array.length - 1);

        /* $('#daum-maps-shape-' + id).dblclick(function () {
        	if (isdrawned) {
				var element = document.createElement("div");
				element.appendChild(document.createTextNode('텍스트'));
				document.getElementById('daum-maps-shape-' + id).appendChild(element);
            	//$('#daum-maps-shape-' + id).text('텍스트');
        	}
        });
    }
}); */

// Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
function drawMarker(markers) {
    var len = markers.length, i = 0;
    
    for (; i < len; i++) {
    	/* var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(markers[i].y, markers[i].x)
   		 });
    	
		clusterer.addMarker(marker, true); */
       //alert('위도 = ' + markers[i].y + ', 경도 = ' + markers[i].x);
    }
}

// Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
function drawPolyline(lines) {
    var len = lines.length, i = 0;

    for (; i < len; i++) {
        var path = pointsToPath(lines[i].points);
        var style = lines[i].options;
        var polyline = new kakao.maps.Polyline({
            map: map,
            path: path,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight
        });

        overlays.push(polyline);
    }
}

// Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
function drawRectangle(rects) {
	//console.log(rects[0].ePoint.y + ' / ' + rects[0].sPoint.y);
	//console.log(new kakao.maps.LatLngBounds(new kakao.maps.LatLng(rects[0].sPoint.y, rects[0].sPoint.x), new kakao.maps.LatLng(rects[0].ePoint.y, rects[0].ePoint.x)));
	
	//console.log(rects.length);
	
    var len = rects.length, k = 0;
	var start_num = 0;
	
    for (; k < len; k++) {
    	for (var j = start_num; j < rect_array.length; j++) {
    		if (rect_array[j] != null && document.getElementById('daum-maps-shape-' + rect_array[j].id) != null) {
    			// width, height
    			// latlng
    			
				rect_array[j].drawingOverlay.setPosition(new kakao.maps.LatLng(rects[k].ePoint.y, rects[k].sPoint.x));
				var path = document.getElementById('daum-maps-shape-' + rect_array[j].id);
			    var tmpPath = new Array();
			    var width = 0;
			    var height = 0;
			    var width_small = 0;
			    var height_small = 0;
			    for (var i = 1; i < path.getAttribute('d').split(' ').length; i++) {
			    	var val = path.getAttribute('d').split(' ')[i];
			    	if (i == 1) {
						width_small = parseInt(val.substring(1));
			    	}
			    	if (i == 2) {
			    		height = parseInt(val);
			    		height_small = parseInt(val);
			    	}
			    	
			    	if (i > 0 && i < path.getAttribute('d').split(' ').length - 1) {
			    		if (i % 2 == 1) {		// x좌표
			    			if (i == 1 || i == 3) {
			    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
			    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
			    			} else {
			    				parseInt(val) > width ? width = parseInt(val) : width = width;
			    			}
			    		} else {		// y좌표
		    				parseInt(val) > height ? height = parseInt(val) : height = height;
		    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
			    		}
			    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
			    	}
			    }
				var content = '<div id="rectangle-text-' + rect_array[j].id + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트</div>';
				rect_array[j].drawingOverlay.setContent(content);
				rect_array[j].drawingOverlay.setMap(drawingMap);
				
				$('#rectangle-text-' + rect_array[j].id).css('pointer-events', 'none');
				$('#rectangle-text-' + rect_array[j].id).css('white-space', 'break-spaces');
				$('#rectangle-text-' + rect_array[j].id).parent().css('pointerEvents', 'none');
				$('#rectangle-text-' + rect_array[j].id).parent().css('overflow', 'hidden');
				
                start_num = j + 1;
                break;
    		} else {
    			//$('#rectangle-text-' + rect_array[j].id).remove();
				rect_array[j].drawingOverlay.setMap(null);
    			rect_array[j] = null;
    		}
    	}
       
        //overlays.push(rect);
    }
}

function drawRectangle1(rects) {
    var len = rects.length, i = 0;

    for (; i < len; i++) {
        var style = rects[i].options;
        var rect = new kakao.maps.Rectangle({
            map: drawingMap, 
            bounds: new kakao.maps.LatLngBounds(
                new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
            ), 
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity
        });

        overlays.push(rect);
    }
}

// Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
function drawCircle(circles) {
	//console.log('circles = ' + JSON.stringify(circles));
	
    var len = circles.length, i = 0;
    
	center_array = new Array();
	radius_array = new Array();
	
	var start_num = 0;
	
    for (; i < len; i++) {
    	for (var j = start_num; j < length_array.length; j++) {
        	if (length_array[j] != null && document.getElementById('daum-maps-shape-' + length_array[j].id) != null) {
        		//console.log('num = ' + j + ' / id = ' + length_array[j].id);
                var latlng = new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x);
                
                length_array[j].center = latlng;
                length_array[j].radius = Math.round(circles[i].radius);
                start_num = j + 1;
                break;
        	} else {
        		length_array[j] = null;
                //start_num += 1;
        		//break;
        	}
    	}
    }
}

var isCircleMode = false;

var drawingFlag = true;
var centerPosition; // 원의 중심좌표 입니다
var drawingLine;
var drawingCircle;
var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이 입니다
var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이 입니다
var circles = [];
//지도에 클릭 이벤트를 등록합니다
kakao.maps.event.addListener(drawingMap, 'click', function(mouseEvent) {
     
 // 클릭 이벤트가 발생했을 때 원을 그리고 있는 상태가 아니면 중심좌표를 클릭한 지점으로 설정합니다
if (!drawingFlag) {    
     // 상태를 그리고있는 상태로 변경합니다
     drawingFlag = true; 
     
     // 원이 그려질 중심좌표를 클릭한 위치로 설정합니다 
     centerPosition = mouseEvent.latLng; 

     // 그려지고 있는 원의 반경을 표시할 선 객체를 생성합니다
     /* if (!drawingLine) {
         drawingLine = new kakao.maps.Polyline({
             strokeWeight: 3, // 선의 두께입니다
             strokeColor: '#00a0e9', // 선의 색깔입니다
             strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
             strokeStyle: 'solid' // 선의 스타일입니다
         });    
     } */
     
     // 그려지고 있는 원을 표시할 원 객체를 생성합니다
     if (!drawingCircle) {                    
         drawingCircle = new kakao.maps.Circle({ 
             strokeWeight: 1, // 선의 두께입니다
             strokeColor: '#00a0e9', // 선의 색깔입니다
             strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
             strokeStyle: 'solid', // 선의 스타일입니다
             fillColor: '#00a0e9', // 채우기 색깔입니다
             fillOpacity: 0.2 // 채우기 불투명도입니다 
         });     
     }
     
     // 그려지고 있는 원의 반경 정보를 표시할 커스텀오버레이를 생성합니다
     if (!drawingOverlay) {
         drawingOverlay = new kakao.maps.CustomOverlay({
             xAnchor: 0,
             yAnchor: 0,
             zIndex: 1
         });              
     }
 }
 });

//지도에 마우스무브 이벤트를 등록합니다
//원을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 원의 위치와 반경정보를 동적으로 보여주도록 합니다
kakao.maps.event.addListener(drawingMap, 'mousemove', function (mouseEvent) {
 // 마우스무브 이벤트가 발생했을 때 원을 그리고있는 상태이면
 if (drawingFlag && isCircleMode) {
     // 마우스 커서의 현재 위치를 얻어옵니다 
     var mousePosition = mouseEvent.latLng; 
     
     // 그려지고 있는 선을 표시할 좌표 배열입니다. 클릭한 중심좌표와 마우스커서의 위치로 설정합니다
     var linePath = [centerPosition, mousePosition];     
     
     // 그려지고 있는 선을 표시할 선 객체에 좌표 배열을 설정합니다
     //drawingLine.setPath(linePath);
     
     // 원의 반지름을 선 객체를 이용해서 얻어옵니다 
     //var length = drawingLine.getLength();
     
     if(length > 0) {
         // 그려지고 있는 원의 중심좌표와 반지름입니다
         var circleOptions = { 
             center : centerPosition, 
         radius: length,                 
         };
         
         // 그려지고 있는 원의 옵션을 설정합니다
         drawingCircle.setOptions(circleOptions); 
             
         // 반경 정보를 표시할 커스텀오버레이의 내용입니다
         var radius = Math.round(drawingCircle.getRadius()),   
         content = '<div class="info">반경 <span class="number">' + radius + '</span>m</div>';
         
         // 반경 정보를 표시할 커스텀 오버레이의 좌표를 마우스커서 위치로 설정합니다
         drawingOverlay.setPosition(mousePosition);
         
         // 반경 정보를 표시할 커스텀 오버레이의 표시할 내용을 설정합니다
         drawingOverlay.setContent(content);
         
         // 그려지고 있는 원을 지도에 표시합니다
         drawingCircle.setMap(drawingMap); 
         
         // 그려지고 있는 선을 지도에 표시합니다
         //drawingLine.setMap(drawingMap);  
         
         // 그려지고 있는 원의 반경정보 커스텀 오버레이를 지도에 표시합니다
         drawingOverlay.setMap(drawingMap);
         
     } else { 
         
         drawingCircle.setMap(null);
         //drawingLine.setMap(null);    
         drawingOverlay.setMap(null);
         
     }
 }     
});     

//지도에 마우스 오른쪽 클릭이벤트를 등록합니다
//원을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면
//마우스 오른쪽 클릭한 위치를 기준으로 원과 원의 반경정보를 표시하는 선과 커스텀 오버레이를 표시하고 그리기를 종료합니다
kakao.maps.event.addListener(drawingMap, 'rightclick', function (mouseEvent) {

 if (drawingFlag && isCircleMode) {

     // 마우스로 오른쪽 클릭한 위치입니다 
     var rClickPosition = mouseEvent.latLng; 

     // 원의 반경을 표시할 선 객체를 생성합니다
     var polyline = new kakao.maps.Polyline({
         path: [centerPosition, rClickPosition], // 선을 구성하는 좌표 배열입니다. 원의 중심좌표와 클릭한 위치로 설정합니다
         strokeWeight: 1, // 선의 두께 입니다
         strokeColor: '#00a0e9', // 선의 색깔입니다
         strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
         strokeStyle: 'solid' // 선의 스타일입니다
     });
     
     // 원 객체를 생성합니다
     var circle = new kakao.maps.Circle({ 
         center : centerPosition, // 원의 중심좌표입니다
         radius: polyline.getLength(), // 원의 반지름입니다 m 단위 이며 선 객체를 이용해서 얻어옵니다
         strokeWeight: 1, // 선의 두께입니다
         strokeColor: '#00a0e9', // 선의 색깔입니다
         strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
         strokeStyle: 'solid', // 선의 스타일입니다
         fillColor: '#00a0e9', // 채우기 색깔입니다
         fillOpacity: 0.2  // 채우기 불투명도입니다 
     });
     
     var radius = Math.round(circle.getRadius()), // 원의 반경 정보를 얻어옵니다
         content = getTimeHTML(radius); // 커스텀 오버레이에 표시할 반경 정보입니다

     
     // 반경정보를 표시할 커스텀 오버레이를 생성합니다
     var radiusOverlay = new kakao.maps.CustomOverlay({
         content: content, // 표시할 내용입니다
         position: rClickPosition, // 표시할 위치입니다. 클릭한 위치로 설정합니다
         xAnchor: 0,
         yAnchor: 0,
         zIndex: 1 
     });  

     // 원을 지도에 표시합니다
     circle.setMap(drawingMap); 
     
     // 선을 지도에 표시합니다
     //polyline.setMap(drawingMap);
     
     // 반경 정보 커스텀 오버레이를 지도에 표시합니다
     radiusOverlay.setMap(drawingMap);
     
     // 배열에 담을 객체입니다. 원, 선, 커스텀오버레이 객체를 가지고 있습니다
     var radiusObj = {
         'polyline' : polyline,
         'circle' : circle,
         'overlay' : radiusOverlay
     };
     kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {  
		var latlng = mouseEvent.latLng;
		alert(latlng.toString());
    });
     // 배열에 추가합니다
     // 이 배열을 이용해서 "모두 지우기" 버튼을 클릭했을 때 지도에 그려진 원, 선, 커스텀오버레이들을 지웁니다
     circles.push(radiusObj);   
 
     // 그리기 상태를 그리고 있지 않는 상태로 바꿉니다
     drawingFlag = true;
     isCircleMode = false;
     
     // 중심 좌표를 초기화 합니다  
     centerPosition = null;
     
     // 그려지고 있는 원, 선, 커스텀오버레이를 지도에서 제거합니다
     drawingCircle.setMap(null);
     //drawingLine.setMap(null);   
     drawingOverlay.setMap(null);
 }
});    
 
//지도에 표시되어 있는 모든 원과 반경정보를 표시하는 선, 커스텀 오버레이를 지도에서 제거합니다
function removeCircles() {         
 for (var i = 0; i < circles.length; i++) {
     circles[i].circle.setMap(null);    
     circles[i].polyline.setMap(null);
     circles[i].overlay.setMap(null);
 }         
 circles = [];
}

//마우스 우클릭 하여 원 그리기가 종료됐을 때 호출하여 
//그려진 원의 반경 정보와 반경에 대한 도보, 자전거 시간을 계산하여
//HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

 // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
 var walkkTime = distance / 67 | 0;
 var walkHour = '', walkMin = '';

 // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
 if (walkkTime > 60) {
     walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
 }
 walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

 // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
 var bycicleTime = distance / 227 | 0;
 var bycicleHour = '', bycicleMin = '';

 // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
 if (bycicleTime > 60) {
     bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
 }
 bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

 // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
 var content = '<ul class="info">';
 content += '    <li>';
 content += '        <span class="label2">총거리</span><span class="number">' + distance + '</span>m';
 content += '    </li>';
 content += '    <li>';
 content += '        <span class="label2">도보</span>' + walkHour + walkMin;
 content += '    </li>';
 content += '    <li>';
 content += '        <span class="label2">자전거</span>' + bycicleHour + bycicleMin;
 content += '    </li>';
 content += '</ul>'

 return content;
}
function circleMode() {
	if (isCircleMode && !(drawingFlag)) {
		isCircleMode = false;
		drawingFlag = true;
	} else {
		isCircleMode = true;
		drawingFlag = false;
	}
}
function rectangle_draggable() {
	drawingMap.setDraggable(false);
}
function rectangle_draggable2() {
	drawingMap.setDraggable(true);
}
kakao.maps.event.addListener(drawingMap, 'zoom_changed', function() {        
    for (var j = 0; j < rect_array.length; j++) {
		if (rect_array[j] != null && document.getElementById('daum-maps-shape-' + rect_array[j].id) != null) {
			var path = document.getElementById('daum-maps-shape-' + rect_array[j].id);
		    var tmpPath = new Array();
		    var width = 0;
		    var height = 0;
		    var width_small = 0;
		    var height_small = 0;
		    for (var i = 1; i < path.getAttribute('d').split(' ').length; i++) {
		    	var val = path.getAttribute('d').split(' ')[i];
		    	if (i == 1) {
					width_small = parseInt(val.substring(1));
		    	}
		    	if (i == 2) {
		    		height = parseInt(val);
		    		height_small = parseInt(val);
		    	}
		    	
		    	if (i > 0 && i < path.getAttribute('d').split(' ').length - 1) {
		    		if (i % 2 == 1) {		// x좌표
		    			if (i == 1 || i == 3) {
		    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
		    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
		    			} else {
		    				parseInt(val) > width ? width = parseInt(val) : width = width;
		    			}
		    		} else {		// y좌표
	    				parseInt(val) > height ? height = parseInt(val) : height = height;
	    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
		    		}
		    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
		    	}
		    }
		    $('#rectangle-text-' + rect_array[j].id).width((width - width_small));
		    $('#rectangle-text-' + rect_array[j].id).height((height - height_small));
		    
		    //console.log('width = ' + (width - width_small) + ' / height = ' + (height - height_small));
		    
			//var content = '<div id="rectangle-text-' + rect_array[j].id + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트</div>';
			
			
		}
    }
});
</script>
</head>
<body>

</body>
</html>