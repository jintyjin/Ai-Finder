<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
// ��ư Ŭ�� �� ȣ��Ǵ� �ڵ鷯 �Դϴ�
function selectOverlay(type) {
    // �׸��� ���̸� �׸��⸦ ����մϴ�
	/* isCircleMode = false;
	drawingFlag = true; */
    manager.cancel();
    manager2.cancel();
    manager3.cancel();

    // Ŭ���� �׸��� ��� Ÿ���� �����մϴ�
    manager.select(kakao.maps.drawing.OverlayType[type]);
}

//��ư Ŭ�� �� ȣ��Ǵ� �ڵ鷯 �Դϴ�
function selectOverlay2(type) {
 // �׸��� ���̸� �׸��⸦ ����մϴ�
    manager.cancel();
    manager2.cancel();
    manager3.cancel();
 // Ŭ���� �׸��� ��� Ÿ���� �����մϴ�
 manager2.select(kakao.maps.drawing.OverlayType[type]);
}

//��ư Ŭ�� �� ȣ��Ǵ� �ڵ鷯 �Դϴ�
function selectOverlay3(type) {
// �׸��� ���̸� �׸��⸦ ����մϴ�
    manager.cancel();
    manager2.cancel();
    manager3.cancel();

// Ŭ���� �׸��� ��� Ÿ���� �����մϴ�
manager3.select(kakao.maps.drawing.OverlayType[type]);
}
function getDataFromDrawingMap(data1) {
    // Drawing Manager���� �׷��� ������ ������ �����ɴϴ� 
    //var data = manager.getData();

    // ������ ������ �����ͷ� �������� �׸��ϴ�
    //drawMarker(data[kakao.maps.drawing.OverlayType.MARKER]);
    //drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]);
    drawRectangle1(data1.rectangle);
    //drawCircle(data[kakao.maps.drawing.OverlayType.CIRCLE]);
    //drawPolygon(data[kakao.maps.drawing.OverlayType.POLYGON]);
}
// �������� ��ư�� Ŭ���ϸ� ȣ��Ǵ� �ڵ鷯 �Լ��Դϴ�
// Drawing Manager�� �׷��� ��ü �����͸� ������ �Ʒ� ������ ǥ���մϴ�
// �Ʒ� ������ �׷��� ������ �ִٸ� ��� ����ϴ�

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
    	// �� ���� ������ ���� �ȸ���(����)
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
	    		if (i % 2 == 1) {		// x��ǥ
	    			if (i == 1 || i == 3) {
	    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
	    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
	    			} else {
	    				parseInt(val) > width ? width = parseInt(val) : width = width;
	    			}
	    		} else {		// y��ǥ
    				parseInt(val) > height ? height = parseInt(val) : height = height;
    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
	    		}
	    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
	    	}
	    }
		var content = '<div id="rectangle-text-' + figure + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ</div>';
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
    
    // ������ ������ �����ͷ� �������� �׸��ϴ�
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
    	
        // �׷����� �ִ� ���� ǥ���� ��ǥ �迭�Դϴ�. Ŭ���� �߽���ǥ�� ���콺Ŀ���� ��ġ�� �����մϴ�
        var linePath = [center, mousePosition];    
        
        drawingLine = new kakao.maps.Polyline({
            strokeWeight: 1, // ���� �β��Դϴ�
            strokeColor: '#00a0e9', // ���� �����Դϴ�
            strokeOpacity: 1, // ���� �������Դϴ� 0���� 1 ���̰��̸� 0�� �������� �����մϴ�
            strokeStyle: 'solid' // ���� ��Ÿ���Դϴ�
        });    
        
        drawingLine.setPath(linePath);
        
        // ���� �������� �� ��ü�� �̿��ؼ� ���ɴϴ� 
        var length = drawingLine.getLength();
        
        if(length > 0) {
            // �ݰ� ������ ǥ���� Ŀ���ҿ��������� �����Դϴ�
			var circle_json = length_array.length - 1;
			
            var id = length_array[circle_json].id;
            
            //console.log('id = ' + id);
            
            var radius = Math.round(length),   
            content = '<div class="info" id="length' + id + '">�ݰ� <span class="number">' + radius + '</span>m</div>';
            
            radius_array[id] = radius;
            length_array[circle_json].radius = radius;
			//console.log(JSON.stringify(radius_array));
            
            // �ݰ� ������ ǥ���� Ŀ���� ���������� ��ǥ�� ���콺Ŀ�� ��ġ�� �����մϴ�
            //drawingOverlay.setPosition(mousePosition);
            drawingOverlay.setPosition(center);
            
            // �ݰ� ������ ǥ���� Ŀ���� ���������� ǥ���� ������ �����մϴ�
            drawingOverlay.setContent(content);

        	if (drawingOverlay != null) {
                //drawingOverlay.setMap(null);
        	}
            // �׷����� �ִ� ���� �ݰ����� Ŀ���� �������̸� ������ ǥ���մϴ�
            
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
            				var content = '<div class="info" id="length' + id + '">�ݰ� <span class="number">' + length_array[i].radius + '</span>m</div>';
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
				element.appendChild(document.createTextNode('�ؽ�Ʈ'));
				document.getElementById('daum-maps-shape-' + id).appendChild(element);
            	//$('#daum-maps-shape-' + id).text('�ؽ�Ʈ');
        	}
        });
    }
}); */

// Drawing Manager���� ������ ������ �� ��Ŀ�� �Ʒ� ������ ǥ���ϴ� �Լ��Դϴ�
function drawMarker(markers) {
    var len = markers.length, i = 0;
    
    for (; i < len; i++) {
    	/* var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(markers[i].y, markers[i].x)
   		 });
    	
		clusterer.addMarker(marker, true); */
       //alert('���� = ' + markers[i].y + ', �浵 = ' + markers[i].x);
    }
}

// Drawing Manager���� ������ ������ �� ���� �Ʒ� ������ ǥ���ϴ� �Լ��Դϴ�
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

// Drawing Manager���� ������ ������ �� �簢���� �Ʒ� ������ ǥ���ϴ� �Լ��Դϴ�
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
			    		if (i % 2 == 1) {		// x��ǥ
			    			if (i == 1 || i == 3) {
			    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
			    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
			    			} else {
			    				parseInt(val) > width ? width = parseInt(val) : width = width;
			    			}
			    		} else {		// y��ǥ
		    				parseInt(val) > height ? height = parseInt(val) : height = height;
		    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
			    		}
			    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
			    	}
			    }
				var content = '<div id="rectangle-text-' + rect_array[j].id + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ</div>';
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

// Drawing Manager���� ������ ������ �� ���� �Ʒ� ������ ǥ���ϴ� �Լ��Դϴ�
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
var centerPosition; // ���� �߽���ǥ �Դϴ�
var drawingLine;
var drawingCircle;
var drawingOverlay; // �׷����� �ִ� ���� �ݰ��� ǥ���� Ŀ���ҿ������� �Դϴ�
var drawingDot; // �׷����� �ִ� ���� �߽����� ǥ���� Ŀ���ҿ������� �Դϴ�
var circles = [];
//������ Ŭ�� �̺�Ʈ�� ����մϴ�
kakao.maps.event.addListener(drawingMap, 'click', function(mouseEvent) {
     
 // Ŭ�� �̺�Ʈ�� �߻����� �� ���� �׸��� �ִ� ���°� �ƴϸ� �߽���ǥ�� Ŭ���� �������� �����մϴ�
if (!drawingFlag) {    
     // ���¸� �׸����ִ� ���·� �����մϴ�
     drawingFlag = true; 
     
     // ���� �׷��� �߽���ǥ�� Ŭ���� ��ġ�� �����մϴ� 
     centerPosition = mouseEvent.latLng; 

     // �׷����� �ִ� ���� �ݰ��� ǥ���� �� ��ü�� �����մϴ�
     /* if (!drawingLine) {
         drawingLine = new kakao.maps.Polyline({
             strokeWeight: 3, // ���� �β��Դϴ�
             strokeColor: '#00a0e9', // ���� �����Դϴ�
             strokeOpacity: 1, // ���� �������Դϴ� 0���� 1 ���̰��̸� 0�� �������� �����մϴ�
             strokeStyle: 'solid' // ���� ��Ÿ���Դϴ�
         });    
     } */
     
     // �׷����� �ִ� ���� ǥ���� �� ��ü�� �����մϴ�
     if (!drawingCircle) {                    
         drawingCircle = new kakao.maps.Circle({ 
             strokeWeight: 1, // ���� �β��Դϴ�
             strokeColor: '#00a0e9', // ���� �����Դϴ�
             strokeOpacity: 0.1, // ���� �������Դϴ� 0���� 1 ���̰��̸� 0�� �������� �����մϴ�
             strokeStyle: 'solid', // ���� ��Ÿ���Դϴ�
             fillColor: '#00a0e9', // ä��� �����Դϴ�
             fillOpacity: 0.2 // ä��� �������Դϴ� 
         });     
     }
     
     // �׷����� �ִ� ���� �ݰ� ������ ǥ���� Ŀ���ҿ������̸� �����մϴ�
     if (!drawingOverlay) {
         drawingOverlay = new kakao.maps.CustomOverlay({
             xAnchor: 0,
             yAnchor: 0,
             zIndex: 1
         });              
     }
 }
 });

//������ ���콺���� �̺�Ʈ�� ����մϴ�
//���� �׸����ִ� ���¿��� ���콺���� �̺�Ʈ�� �߻��ϸ� �׷��� ���� ��ġ�� �ݰ������� �������� �����ֵ��� �մϴ�
kakao.maps.event.addListener(drawingMap, 'mousemove', function (mouseEvent) {
 // ���콺���� �̺�Ʈ�� �߻����� �� ���� �׸����ִ� �����̸�
 if (drawingFlag && isCircleMode) {
     // ���콺 Ŀ���� ���� ��ġ�� ���ɴϴ� 
     var mousePosition = mouseEvent.latLng; 
     
     // �׷����� �ִ� ���� ǥ���� ��ǥ �迭�Դϴ�. Ŭ���� �߽���ǥ�� ���콺Ŀ���� ��ġ�� �����մϴ�
     var linePath = [centerPosition, mousePosition];     
     
     // �׷����� �ִ� ���� ǥ���� �� ��ü�� ��ǥ �迭�� �����մϴ�
     //drawingLine.setPath(linePath);
     
     // ���� �������� �� ��ü�� �̿��ؼ� ���ɴϴ� 
     //var length = drawingLine.getLength();
     
     if(length > 0) {
         // �׷����� �ִ� ���� �߽���ǥ�� �������Դϴ�
         var circleOptions = { 
             center : centerPosition, 
         radius: length,                 
         };
         
         // �׷����� �ִ� ���� �ɼ��� �����մϴ�
         drawingCircle.setOptions(circleOptions); 
             
         // �ݰ� ������ ǥ���� Ŀ���ҿ��������� �����Դϴ�
         var radius = Math.round(drawingCircle.getRadius()),   
         content = '<div class="info">�ݰ� <span class="number">' + radius + '</span>m</div>';
         
         // �ݰ� ������ ǥ���� Ŀ���� ���������� ��ǥ�� ���콺Ŀ�� ��ġ�� �����մϴ�
         drawingOverlay.setPosition(mousePosition);
         
         // �ݰ� ������ ǥ���� Ŀ���� ���������� ǥ���� ������ �����մϴ�
         drawingOverlay.setContent(content);
         
         // �׷����� �ִ� ���� ������ ǥ���մϴ�
         drawingCircle.setMap(drawingMap); 
         
         // �׷����� �ִ� ���� ������ ǥ���մϴ�
         //drawingLine.setMap(drawingMap);  
         
         // �׷����� �ִ� ���� �ݰ����� Ŀ���� �������̸� ������ ǥ���մϴ�
         drawingOverlay.setMap(drawingMap);
         
     } else { 
         
         drawingCircle.setMap(null);
         //drawingLine.setMap(null);    
         drawingOverlay.setMap(null);
         
     }
 }     
});     

//������ ���콺 ������ Ŭ���̺�Ʈ�� ����մϴ�
//���� �׸����ִ� ���¿��� ���콺 ������ Ŭ�� �̺�Ʈ�� �߻��ϸ�
//���콺 ������ Ŭ���� ��ġ�� �������� ���� ���� �ݰ������� ǥ���ϴ� ���� Ŀ���� �������̸� ǥ���ϰ� �׸��⸦ �����մϴ�
kakao.maps.event.addListener(drawingMap, 'rightclick', function (mouseEvent) {

 if (drawingFlag && isCircleMode) {

     // ���콺�� ������ Ŭ���� ��ġ�Դϴ� 
     var rClickPosition = mouseEvent.latLng; 

     // ���� �ݰ��� ǥ���� �� ��ü�� �����մϴ�
     var polyline = new kakao.maps.Polyline({
         path: [centerPosition, rClickPosition], // ���� �����ϴ� ��ǥ �迭�Դϴ�. ���� �߽���ǥ�� Ŭ���� ��ġ�� �����մϴ�
         strokeWeight: 1, // ���� �β� �Դϴ�
         strokeColor: '#00a0e9', // ���� �����Դϴ�
         strokeOpacity: 1, // ���� �������Դϴ� 0���� 1 ���̰��̸� 0�� �������� �����մϴ�
         strokeStyle: 'solid' // ���� ��Ÿ���Դϴ�
     });
     
     // �� ��ü�� �����մϴ�
     var circle = new kakao.maps.Circle({ 
         center : centerPosition, // ���� �߽���ǥ�Դϴ�
         radius: polyline.getLength(), // ���� �������Դϴ� m ���� �̸� �� ��ü�� �̿��ؼ� ���ɴϴ�
         strokeWeight: 1, // ���� �β��Դϴ�
         strokeColor: '#00a0e9', // ���� �����Դϴ�
         strokeOpacity: 0.1, // ���� �������Դϴ� 0���� 1 ���̰��̸� 0�� �������� �����մϴ�
         strokeStyle: 'solid', // ���� ��Ÿ���Դϴ�
         fillColor: '#00a0e9', // ä��� �����Դϴ�
         fillOpacity: 0.2  // ä��� �������Դϴ� 
     });
     
     var radius = Math.round(circle.getRadius()), // ���� �ݰ� ������ ���ɴϴ�
         content = getTimeHTML(radius); // Ŀ���� �������̿� ǥ���� �ݰ� �����Դϴ�

     
     // �ݰ������� ǥ���� Ŀ���� �������̸� �����մϴ�
     var radiusOverlay = new kakao.maps.CustomOverlay({
         content: content, // ǥ���� �����Դϴ�
         position: rClickPosition, // ǥ���� ��ġ�Դϴ�. Ŭ���� ��ġ�� �����մϴ�
         xAnchor: 0,
         yAnchor: 0,
         zIndex: 1 
     });  

     // ���� ������ ǥ���մϴ�
     circle.setMap(drawingMap); 
     
     // ���� ������ ǥ���մϴ�
     //polyline.setMap(drawingMap);
     
     // �ݰ� ���� Ŀ���� �������̸� ������ ǥ���մϴ�
     radiusOverlay.setMap(drawingMap);
     
     // �迭�� ���� ��ü�Դϴ�. ��, ��, Ŀ���ҿ������� ��ü�� ������ �ֽ��ϴ�
     var radiusObj = {
         'polyline' : polyline,
         'circle' : circle,
         'overlay' : radiusOverlay
     };
     kakao.maps.event.addListener(circle, 'click', function(mouseEvent) {  
		var latlng = mouseEvent.latLng;
		alert(latlng.toString());
    });
     // �迭�� �߰��մϴ�
     // �� �迭�� �̿��ؼ� "��� �����" ��ư�� Ŭ������ �� ������ �׷��� ��, ��, Ŀ���ҿ������̵��� ����ϴ�
     circles.push(radiusObj);   
 
     // �׸��� ���¸� �׸��� ���� �ʴ� ���·� �ٲߴϴ�
     drawingFlag = true;
     isCircleMode = false;
     
     // �߽� ��ǥ�� �ʱ�ȭ �մϴ�  
     centerPosition = null;
     
     // �׷����� �ִ� ��, ��, Ŀ���ҿ������̸� �������� �����մϴ�
     drawingCircle.setMap(null);
     //drawingLine.setMap(null);   
     drawingOverlay.setMap(null);
 }
});    
 
//������ ǥ�õǾ� �ִ� ��� ���� �ݰ������� ǥ���ϴ� ��, Ŀ���� �������̸� �������� �����մϴ�
function removeCircles() {         
 for (var i = 0; i < circles.length; i++) {
     circles[i].circle.setMap(null);    
     circles[i].polyline.setMap(null);
     circles[i].overlay.setMap(null);
 }         
 circles = [];
}

//���콺 ��Ŭ�� �Ͽ� �� �׸��Ⱑ ������� �� ȣ���Ͽ� 
//�׷��� ���� �ݰ� ������ �ݰ濡 ���� ����, ������ �ð��� ����Ͽ�
//HTML Content�� ����� �����ϴ� �Լ��Դϴ�
function getTimeHTML(distance) {

 // ������ �ü��� ��� 4km/h �̰� ������ �м��� 67m/min�Դϴ�
 var walkkTime = distance / 67 | 0;
 var walkHour = '', walkMin = '';

 // ����� ���� �ð��� 60�� ���� ũ�� �ð����� ǥ���մϴ�
 if (walkkTime > 60) {
     walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>�ð� '
 }
 walkMin = '<span class="number">' + walkkTime % 60 + '</span>��'

 // �������� ��� �ü��� 16km/h �̰� �̰��� �������� �������� �м��� 267m/min�Դϴ�
 var bycicleTime = distance / 227 | 0;
 var bycicleHour = '', bycicleMin = '';

 // ����� ������ �ð��� 60�� ���� ũ�� �ð����� ǥ���մϴ�
 if (bycicleTime > 60) {
     bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>�ð� '
 }
 bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>��'

 // �Ÿ��� ���� �ð�, ������ �ð��� ������ HTML Content�� ����� �����մϴ�
 var content = '<ul class="info">';
 content += '    <li>';
 content += '        <span class="label2">�ѰŸ�</span><span class="number">' + distance + '</span>m';
 content += '    </li>';
 content += '    <li>';
 content += '        <span class="label2">����</span>' + walkHour + walkMin;
 content += '    </li>';
 content += '    <li>';
 content += '        <span class="label2">������</span>' + bycicleHour + bycicleMin;
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
		    		if (i % 2 == 1) {		// x��ǥ
		    			if (i == 1 || i == 3) {
		    				parseInt(val.substring(1)) > width ? width = parseInt(val.substring(1)) : width = width;
		    				parseInt(val.substring(1)) < width_small ? width_small = parseInt(val.substring(1)) : width_small = width_small;
		    			} else {
		    				parseInt(val) > width ? width = parseInt(val) : width = width;
		    			}
		    		} else {		// y��ǥ
	    				parseInt(val) > height ? height = parseInt(val) : height = height;
	    				parseInt(val) < height_small ? height_small = parseInt(val) : height_small = height_small;
		    		}
		    		tmpPath.push(path.getAttribute('d').split(' ')[i]);
		    	}
		    }
		    $('#rectangle-text-' + rect_array[j].id).width((width - width_small));
		    $('#rectangle-text-' + rect_array[j].id).height((height - height_small));
		    
		    //console.log('width = ' + (width - width_small) + ' / height = ' + (height - height_small));
		    
			//var content = '<div id="rectangle-text-' + rect_array[j].id + '" style="width:' + (width - width_small) + 'px; height:' + (height - height_small) + 'px;"><span class="number"></span>�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ�ؽ�Ʈ</div>';
			
			
		}
    }
});
</script>
</head>
<body>

</body>
</html>