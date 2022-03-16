<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/canvasjs/1.7.0/canvasjs.min.js"></script> -->
<!-- <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script> -->
<!-- <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script> -->
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding-bottom:0;
	background-color:#252525;
}
#div_body {
	width:100%;
	height:97%;
	margin:0;
	padding:8px 8px 8px 8px;
}
.row {
	float:left;
	padding-left:8px;
	margin:0;
	width:25%;
	height:25%;
	background-color:#b3b3b3;
	border:1px solid white;
}
.small_title {
	width:98%;
	color:white;
	margin:8px 0px 8px 8px;
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
	font-size:14px;
}
h3 {
	margin:0;
	color:white;
}
.align-center {
	text-align:center;
}
/* .col-md-4 {
	width:30%;
	height:100%;
	margin:0;
	padding:0;
} */
#sales-doughnut-chart-us, #sales-doughnut-chart-nl {
	font-size:100px;
	height:200px;
	width:100%;
}
.long_row {
	float:left;
	width:49%;
	margin-left:8px;
	padding:8px 8px 0px 8px;
	height:25%;
	background-color:#b3b3b3;
	border:1px solid white;
}
.container {
	width:100%;
	margin:0;
	padding:0;
	background-color:#404040;
	color:white;
}
.navbar-left {
	color:white;
	margin:8px;
}
.navbar-right {
	color:white;
	margin:8px;
}
.row_text {
	float:left;
	width:40%;
	padding:8px 0px 0px 0px;
	margin:16px 8px 8px 8px;
	color:white;
	font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
}/* 
.progress {
	width:55%;
	margin:8px 8px 8px 8px;
	padding:0;
} */
table {
	width:100%;
	height:25%;
	padding:0;
	margin:0;
	color:white;
	font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
}
img {
	max-width: 100%; height: auto;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
function setTimeRemaining1(timeRemaining) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('timeRemaining1', timeRemaining);
}
function setTimeTaken1(timeTaken) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('timeTaken1', timeTaken);
}
function setPerTime1(perTime) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('perTime1', perTime);
}
function setWidth1(width) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('width1', width);
}
function setRemain(remain) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('remain', remain);
}
function setComplete(complete) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('complete', complete);
}
function setNormal(normal) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('normal', normal);
}
function setMissing(missing) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('missing', missing);
}
function setGraph(graph) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('graph', graph);
}
function setCount1(count) {		// 전체 이미지 갯수
	sessionStorage.setItem('count1', count);
}
function setTimer1(timer) {		// 전체 이미지 갯수
	sessionStorage.setItem('timer1', timer);
}
function setTimer2(timer) {		// 전체 이미지 갯수
	sessionStorage.setItem('timer2', timer);
}

var websocketUrl = '/police/websocket';

$(document).ready(function () {
	if (get('timeRemaining1') == null) {
		setTimeRemaining1('0시간 0분 0초');
	}

	if (get('timeTaken1') == null) {
		setTimeTaken1('0시간 0분 0초');
	}
	
	if (get('timeRemaining1') != null) {
		setTimeRemaining1('0시간 0분 0초');
	}

	if (get('timeTaken1') != null) {
		$('#timeTaken').text(get('timeTaken1'));
	}
	
	if (get('perTime1') == null) {
		setPerTime1('0');
	}

	if (get('perTime1') != null) {
		$('#perTime').text(get('perTime1') + '%');
	}
	
	if (get('width1') == null) {
		setWidth1('0');
	}

	if (get('width1') != null) {
		$('#perTime').width(get('width1') + '%');
	}
	
	if (get('remain') == null) {
		setRemain('0');
	}
	if (get('complete') == null) {
		setComplete('0');
	}
	
	if (get('remain') != null || get('normal') != null) {
		remainingWork(get('remain'), get('complete'));
	}
	
	if (get('normal') == null) {
		setNormal('1');
	}
	
	if (get('missing') == null) {
		setMissing('1');
	}
	
	if (get('normal') != null || get('missing') != null) {
		imageFrequency(parseInt(get('normal')),parseInt(get('missing')));
	}

	if (get('graph') == null) {
				
	}
	
	if (get('graph') != null) {
		detectGraph(JSON.parse(get('graph')));
	}

	
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	var array = new Array();
	var graph = new Array();
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/fileCount1', function (count) {
			setCount1(count.body);
			setRemain(count.body);
			setComplete('0');
			remainingWork(get('remain'), get('complete'));
			setNormal('0');
			setMissing('0');
			setTimeRemaining1('0시간 0분 0초');
			setTimeTaken1('0시간 0분 0초');
			timer(parseInt(count.body) * 5);
			timer2(parseInt(count.body) * 5);
			setPerTime1('0');
			setWidth1('0');
			$('#perTime').text(get('perTime1') + '%');
			$('#perTime').width(get('width1') + '%');
			graph = [];
			setGraph(JSON.stringify(graph));
			detectGraph(JSON.parse(get('graph')));
		});
		
		stompClient.subscribe('/endAnalyse1', function (response) {
			if (get('remain') == 0 && get('graph') == null) {
			} else {
				var json = JSON.parse(response.body);
				var roiCount = JSON.stringify(json.event_roi_list.length);
				/* alert(JSON.parse(response.body).event_roi_list);
				alert('2 = ' + typeof(JSON.parse(response.body))); */
				var remain = parseInt(get('remain'));
				var complete = parseInt(get('complete'));
				setRemain(remain - 1);
				setComplete(complete + 1);
				remainingWork(get('remain'), get('complete'));
				var missing = parseInt(get('missing'));
				var normal = parseInt(get('normal'));
				
				var perTime = get('perTime1');
				perTime = parseFloat(get('perTime1')) + (100 / parseFloat(get('count1'))) + '';
				setPerTime1(perTime + '');
				setWidth1(parseInt(perTime) + '');
				$('#perTime').text(parseInt(perTime) + '%');
				$('#perTime').width(perTime + '%');
				
				if (parseInt(roiCount) > 0) {
					setMissing(missing + 1);
				} else {
					setNormal(normal + 1);
				}
				imageFrequency(get('normal'),get('missing'));
	
				var jsonObj = new Object();
				jsonObj.x = parseInt(get('complete'));
				jsonObj.y = parseInt(roiCount);
				graph.push(jsonObj);
				setGraph(JSON.stringify(graph));
				
				detectGraph(JSON.parse(get('graph')));
			}
		});

		stompClient.subscribe('/endProcess1', function (count) {
			if (parseInt(get('remain')) == 0) {
				setPerTime1('100');
				setWidth1('100');
				var perTime = get('perTime1');
				$('#perTime').text(parseInt(perTime) + '%');
				$('#perTime').width(parseInt(perTime) + '%');
				clearInterval(get('timer1'));
				clearInterval(get('timer2'));
				$('#timeRemaining').text('0시간 0분 0초');	
			}
		});
	});

	$(window).resize(function() {
		/* alert($('#remainDiv').width());		// 464	331	211	213
		alert($('#remainDiv').height());		// 146
		alert($('#remain').width() + $('#icon').width() + $('#complete').width())	// 450.0625	321	204.640699999	206.5937
		alert($('#remain').height() + $('#icon').height() + $('#complete').height())	// 306.564 */
	});
});

$('#timeTaken').ready(function() {
	$('#timeTaken').text(get('timeTaken1'));
});
$('#timeRemaining').ready(function() {
	$('#timeRemaining').text(get('timeRemaining1'));
});
$('#perTime').ready(function() {
	$(this).text(get('perTime1'));
});

function remainingWork(remain, complete) {
	// CanvasJS doughnut chart to show annual sales percentage from United States(US)
	var salesDoughnutChartUS = new CanvasJS.Chart("sales-doughnut-chart-us", { 
		animationEnabled: true,
		backgroundColor: "transparent",
		title: {
			fontColor: "#ffffff",
			fontSize: 30,
			horizontalAlign: "center",
			text: remain,
			verticalAlign: "center"
		},
		toolTip: {
			backgroundColor: "#ffffff",
			borderThickness: 0,
			cornerRadius: 0,
			fontColor: "#424242"
		},
		data: [
			{
				explodeOnClick: false,
				innerRadius: "96%",
				radius: "90%",
				startAngle: 270,
				type: "doughnut",
				dataPoints: [
					{ y: 100, color: "#ffffff", toolTipContent: null }
				]
			}
		]
	});

	// CanvasJS doughnut chart to show annual sales percentage from Netherlands(NL)
	var salesDoughnutChartNL = new CanvasJS.Chart("sales-doughnut-chart-nl", { 
		animationEnabled: true,
		backgroundColor: "transparent",
		title: {
			fontColor: "#ffffff",
			fontSize: 30,
			horizontalAlign: "center",
			text: complete,
			verticalAlign: "center"
		},
		toolTip: {
			backgroundColor: "#ffffff",
			borderThickness: 0,
			cornerRadius: 0,
			fontColor: "#424242"
		},
		data: [
			{
				explodeOnClick: false,
				innerRadius: "96%",
				radius: "90%",
				startAngle: 270,
				type: "doughnut",
				dataPoints: [
					{ y: 100, color: "#ffffff", toolTipContent: null }
				]
			}
		]
	});
	
	salesDoughnutChartUS.render();
	salesDoughnutChartNL.render();

}
function imageFrequency(normal, missing) {
    CanvasJS.addColorSet("chartSet",
            [
            	"#ffffff",
            	"#5464EF"
            ]);
    
	var chart2 = new CanvasJS.Chart("chartContainer2", {
		animationEnabled: true,

		backgroundColor:"#404040",
		/* colorSet: "chartSet", */
		
		/* width:450,
		height:240, */
		
		title:{
			fontColor:"white"
		},
		legend:{
			markerMargin:10,
			fontSize:14,
			horizontalAlign:"middle",
			/* verticalAlign:"center", */
			fontColor:"white",
			fontFamily: "Helvetica Neue"
		},
		data: [{
			type: "pie",
			showInLegend:true,
			toolTipContent: "{name}: <strong>{y}</strong>",
			explodeOnClick:false,
			dataPoints: [
				{ y: normal, name: "일반 이미지", legendText: "일반 이미지 빈도"},
				{ y: missing, name: "실종자 이미지", legendText: "실종자 이미지 빈도"}
			]
		}]
	}); 
	chart2.render();
}
function detectGraph(dataSet) {
	var chart3 = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		theme: "light2",
		backgroundColor: "#404040",
		title:{
			text: "실종자 검색 그래프",
			fontColor: "white",
			fontSize:14,
			fontFamily:"Helvetica Neue",
	        margin: 8,
			horizontalAlign:"left"
		},
		axisY: {
			labelFontSize: 14
		},
		axisX: {
			labelFontSize: 14,
			interval: 1
		},
		data: [{        
			type: "column",  
			showInLegend: false, 
			dataPoints: dataSet
		}]
	});
	
	chart3.render();
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
		setTimeRemaining1(hour + '시간 ' + min + '분 ' + sec + '초');
		
		setTimer1(x);
		
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
		setTimeTaken1(hour + '시간 ' + min + '분 ' + sec + '초');

		setTimer2(x);
		
		time++;
		
		/* if (time == endTime) {
			clearInterval(x);
		} */
	}, 1000);
}
</script>
<body>
<div style="height:3%; margin:0; padding:0; border-bottom:5px solid #b3b3b3;"></div>
<div id="div_body">
	<table style="width:100%; height:100%; margin:0; padding:0;">
	<tr height="*">
	<td width="30%" style="padding-right:8px;">
	<table style="width:100%; height:100%; margin:0; padding:0; background-color:#404040;">		
		<tr height="19%">
		<td colspan="3" style="padding-left:8px;">남은 작업</td>
		</tr>
		<tr height="*">
		<td width="42%" align="center">잔여</td>
		<td width="16%"></td>
		<td width="42%" align="center">완료</td>
		</tr>
		<tr height="70%">
		<td width="42%">
			<div class="container" id="sales-doughnut-chart-us" style="height:100%;"></div>
		</td>
		<td width="16%">
			<img src="/police/resources/image/Police/pngguru.com.png" width="100%" height="50%" style="" />
		</td>
		<td width="42%">
			<div class="container" id="sales-doughnut-chart-nl" style="height:100%;"></div>
		</td>
		</tr>
	</table>
	</td>
	<td width="30%" style="padding-right:8px;">
		<table style="width:100%; height:100%; padding:0; margin:0; background-color:#404040;">
		<tr height="19%"><td style="padding-left:8px;">이미지 빈도</td></tr>
		<tr height="*">
		<td>
			<div id="chartContainer2" style="width:100%; height:100%;"></div>
		</td>
		</tr>
		</table>
	</td>
	<td width="*">
		<table style="width:100%; height:100%; padding:0; margin:0; background-color:#404040;">
		<tr height="*">
			<td colspan="2" style="padding-left:8px;">자원 사용량</td>
		</tr>
		<tr height="27%">
			<td align="right" style="padding-right:8px;">Storage 43GB / 256GB</td>
			<td width="55%">
				<div class="progress" style="margin:0; width:90%;">
					<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:60%;">
					<span class="sr-only">60% Complete</span>
				</div>
				</div>
			</td>
		</tr>
		<tr height="27%">
			<td align="right" style="padding-right:8px;">Memory 12GB / 36GB</td>
			<td>
				<div class="progress" style="margin:0; width:90%;">
					<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
		    		<span class="sr-only">20% Complete</span>
					</div>
				</div>
			</td>
		</tr>
		<tr height="27%">
			<td align="right" style="padding-right:8px;">Memory 12GB / 36GB</td>
			<td>
				<div class="progress" style="margin:0; width:90%;">
					<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
				    	<span class="sr-only">40% Complete</span>
					</div>
				</div>
			</td>
		</tr>
		</table>
	</td>
	</tr>
	<!-- 빈공간 -->
	<tr height=35%>
		<td colspan="3"></td>
	</tr>
	<!-- 그래프 -->
	<tr height="30%" style="background-color:#404040;">
		<td colspan="3">
			<div id="chartContainer" style="height:100%; width:100%;"></div>
		</td>
	</tr>
	<tr height="9%">
		<td colspan="3" style="padding-top:8px;">
			<table style="width:100%; height:100%; margin:0; padding:0; background-color:#404040;">
				<tr height="50%">
					<td style="padding-left:8px;" align="left" id="timeTaken"></td>
					<td style="padding-right:8px;" align="right" id="timeRemaining"></td>
				</tr>
				<tr height="*">
					<td colspan="2">
						<div class="progress" style="width:100%; margin:0;">
							<div id="perTime" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	<!-- <div class="container" style="height:9%">
		<div class="container" style="height:40%">
			<p class="navbar-text navbar-left" id="timeTaken"></p>
			<p class="navbar-text navbar-right" id="timeRemaining"></p>
		</div>
		<div class="progress" style="width:99%; margin-top:8px;">
			<div id="perTime" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100">
			</div>
		</div>
	</div> -->
</div>
</body>
</html>