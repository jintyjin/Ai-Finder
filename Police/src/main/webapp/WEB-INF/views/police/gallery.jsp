<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/viewer.css" />
<link rel="stylesheet" href="./resources/css/viewer.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-slider.css" />
<link rel="stylesheet" href="./resources/css/lity.css">
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script src="./resources/js/viewer.js"></script>
<script src="./resources/js/viewer.min.js"></script>
<script src="./resources/js/lity.js"></script>
<script src="./resources/js/bootstrap-slider.js"></script>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding-bottom:0;
	background-color:#252525;
	color:white;
}
canvas {
	padding:0;
	margin:0;
}
.small_menu {
	width:20%;
	margin:0;
	padding:0;
	float:left;
	color:white;
	font-size:14px;
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
}
.yellow {
	color:yellow;
	font-size:18px;
	font-weight:900;
	/* background-color:#252525; */
	/* width:22px; */
	/* height:21px; */
}
.yellow {
	color:yellow;
	font-size:18px;
	font-weight:900;
    text-shadow: -1px 0 gray, 0 1px gray, 1px 0 gray, 0 -1px gray;
	/* background-color:#252525; */
	/* width:22px; */
	/* height:21px; */
}
.gray {
	color:#696969;
	font-size:18px;
	font-sweight:900;
    text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
	/* background-color:#252525; */
	/* width:22px; */
	/* height:21px; */
}
.trash {
	color:#696969;
	font-size:18px;
	font-weight:900;
    text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
	/* background-color:#252525; */
	/* width:22px; */
	/* height:21px; */
}
.full {
	font-size:18px;
	font-weight:900;
	width:22px;
	height:21px;
	cursor:pointer;
}
a {
	color:#b3b3b3;
}
.icon a:hover {
	color:#b3b3b3;
}
hr {
	height:5px;
	margin:0;
	background-color:#b3b3b3;
	border:none;
}
img {
	margin:0;
	padding:0;
}
.lity-googlemaps .lity-container {
	width: 100%;
	max-width: 2000px;
}
#slider6 .slider-selection {
	background:#b3b3b3;
}
.slider-handle {
	background: #252525;
}
.selectImage {
	border:2px solid yellow;
}

/* 이미지 박스 */
.imageTr {
	padding:0; 
	margin:0;
}
.imageTd {
	background-color:#404040;
	margin:0;
	position:relative;
}
.imageA {
	position:absolute; 
	margin:0; 
	padding:0;
}
ul {
	padding-left:20px;
	list-style:none;
}
#allLi input[type=checkbox] {
	margin:0px 5px 0px 0px;
}
label {
	cursor:pointer;
}
a {
	color:white;
}
a:hover {
	text-decoration:none;
	color:white;
	cursor:pointer;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
function setObj2(obj) {		// 모든 데이터의 ROI 정보들
	sessionStorage.setItem('obj2', obj);
}
function setFile2(file) {		// 전체 이미지 갯수
	sessionStorage.setItem('file2', file);
}
function setCount2(count) {		// 전체 이미지 갯수
	sessionStorage.setItem('count2', count);
}
function setPage2(page) {		// 현재 페이지
	sessionStorage.setItem('page2', page);
}
function setTmpPage2(tmpPage) {		// 현재 페이지
	sessionStorage.setItem('tmpPage2', tmpPage);
}
function setStartPage2(startPage) {	// 총 시작 페이지
	sessionStorage.setItem('startPage2', startPage);
}
function setEndPage2(endPage) {	// 총 마지막 페이지
	sessionStorage.setItem('endPage2', endPage);
}
function setEndCount2(endCount) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('endCount2', endCount);
}
function setTotalImage(totalImage) {		// 전체 이미지에 대한 정보 들어갈 예정
	sessionStorage.setItem('totalImage', totalImage);
}
function setYellow(yellow) {		// 노란별 표시만 한 정보 들어갈 예정
	sessionStorage.setItem('yellow', yellow);
}
function setGray(gray) {			// 회색 별 한 정보 들어갈 예정
	sessionStorage.setItem('gray', gray);
}
function setTrash(trash) {		// 쓰레기통 표시만 한 정보 들어갈 예정
	sessionStorage.setItem('trash', trash);
}
function setCheckedConfidence(checked) { // 정확도순 체크 했는 지
	sessionStorage.setItem('checkedConfidence', checked);
}
function setCheckedYellow(checked) { // 노란별 체크 했는 지
	sessionStorage.setItem('checkedYellow', checked);
}
function setCheckedGray(checked) { // 회색별 체크 했는 지
	sessionStorage.setItem('checkedGray', checked);
}
function setCheckedTrash(checked) { // 노란별 체크 했는 지
	sessionStorage.setItem('checkedTrash', checked);
}
function setDataCount(dataCount) {
	sessionStorage.setItem('dataCount', dataCount);
}
function setTest(test) {
	sessionStorage.setItem('test', test);
}
function setIsShow2(isShow2) { // 총 마지막 페이지의 게시물 갯수
	sessionStorage.setItem('isShow2', isShow2);
}
function setTag(tag) {
	sessionStorage.setItem('tag', tag);
}
function setConfidenceValue(confidenceValue) {
	sessionStorage.setItem('confidenceValue', confidenceValue);
}
function setGallery_page_number(gallery_page_number) {
	sessionStorage.setItem('gallery_page_number', gallery_page_number);
}
var websocketUrl = '/police/websocket';
var obj2Array = new Array();
var case_idx;
var gallery_list;
$(document).ready(function () {
	// 각 태그별 이미지 갯수 정보
	function checkTag(array) {
		var objArray = new Array();
		var objArray2 = new Array();
		
		for (var n = 0; n < array.length; n++) {
			objArray.push(array[n].roi.class_name);
		}

		var result = {};
		objArray.sort();
		for(var value in objArray) {
		    var index = objArray[value];
		    result[index] = result[index] == undefined ? 1 : result[index] += 1;
		}
		
		for(var value in result) {
			var tagObj = new Object();
			tagObj.count = result[value];
			if (document.getElementById(value + '1') != null && !(document.getElementById(value + '1').checked)) {
				tagObj.checked = "N";
			}
			
			tagObj.checked = "Y";
			tagObj.class_name = value;
			var className = new Object();
			eval('className.' + value + ' = tagObj');
		    objArray2.push(className);
			setTag(JSON.stringify(objArray2));
		}
		
		return objArray2;
	}
	
	// 검출 민감도 검사
	function checkConfidence(jsonArray) {
		var confidence = parseInt($("#ex6SliderVal").text());
		var confidence2 = parseInt(jsonArray.roi.confidence);
		var isBig = true;
		
		if (confidence2 < confidence) {
			isBig = false;
		} 
	 	
		return isBig;
	}
	
	// 쓰레기통 버튼 및 별 버튼 검사
	function checkStar(array) {
		var arrYellow = new Array();
		var arrGray = new Array();
		var arrTrash = new Array();
		var arrObj2 = new Array();
		var objArr = new Array();
		
		for (var a = 0; a < array.length; a++) {
			if (array[a].favorites == 'Y') {
				arrYellow[a] = array[a];
			} else if (array[a].favorites == 'G') {
				arrGray[a] = array[a];
			} else if (array[a].favorites == 'T') {
				arrTrash[a] = array[a];
			}
		}
		
		// 별, 쓰레기통 필터링
		if (get('checkedYellow') == 'Y') {
			for (var j = 0; j < array.length; j++) {
				if (array[j].favorites == 'Y') {
					arrObj2[j] = array[j];
				}
			}
		}
		
		if (get('checkedGray') == 'Y') {
			for (var k = 0; k < array.length; k++) {
				if (array[k].favorites == 'G') {
					arrObj2[k] = array[k];
				}
			}
		}

		if (get('checkedTrash') == 'Y') {
			for (var t = 0; t < array.length; t++) {
				if (array[t].favorites == 'T') {
					arrObj2[t] = array[t];
				}
			}
		}

		if (get('checkedYellow') == 'N' && get('checkedGray') == 'N' && get('checkedTrash') == 'N') {
			for (var s = 0; s < array.length; s++) {
				if (array[s].favorites != 'T') {
					arrObj2[s] = array[s];
				}
			}
		}
		
		for (var o = 0; o < arrObj2.length; o++) {
			if (JSON.stringify(arrObj2[o]) != null && JSON.stringify(arrObj2[o]) != '') {
				objArr.push(arrObj2[o]);
			}
		}
		
		setYellow(JSON.stringify(arrYellow));
		setGray(JSON.stringify(arrGray));
		setTrash(JSON.stringify(arrTrash));
		setObj2(JSON.stringify(objArr));
		setCount2(objArr.length);
		
		return objArr;
	}
	
	// 정확도순 정렬 버튼 체크 검사
	function isConfidence(tmpArr) {
		var arrObj2 = new Array();
		
		if (get('checkedConfidence') == 'Y') {
			arrObj2 = tmpArr.sort(function(a, b) {
				var A = a.roi;
				var B = b.roi;
				var C = A.confidence;
				var D = B.confidence;
				return C > D ? -1 : C < D ? 1 : 0;
			});	
		} else {
			arrObj2 = tmpArr.sort(function(a, b) {
				var C = a.roiNum;
				var D = b.roiNum;
				return C < D ? -1 : C > D ? 1 : 0;
			});	
		}

		setObj2(JSON.stringify(arrObj2));
		setCount2(arrObj2.length);
		
		return arrObj2;
	}

	$('#heightUi').height($('#heightTd').height());

	if ('${case_idx}' != null && '${case_idx}' != '' && '${case_idx}' != 'null') {		// get('obj2') == null
		var jsonUrl = "/police/selectCase_gallery";
		
		var jsonObject = new Object();
		
		var page_number = get('gallery_page_number');
		if (page_number == null) {
			page_number = 1;
			setGallery_page_number(1);
		}
		
		var confidenceValue = parseInt(get('confidenceValue'));
		
		case_idx = '${case_idx}';
		
		jsonObject.case_idx = case_idx;
		jsonObject.page_number = page_number;
		jsonObject.confidenceValue = confidenceValue;
		
		var jsonData = JSON.stringify(jsonObject);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
            async: false,
			success: function (data) {
				gallery_list = data.gallery_list;
				var tag_list = data.tag_list;
				if (tag_list.length > 0) {
					var tagStr = "";
					var isAll = false;
					var tag_count = 0;
					for (var i = 0; i < tag_list.length; i++) {
						tag_count++;
						var class_name = tag_list[i].tag_class_name;
						console.log(class_name);
						var color_name = tag_list[i].tag_color;
						var count = tag_list[i].tag_count;
						var chk = tag_list[i].tag_color_checked;
						var tmpValue = "'" + class_name + "'";
						if (i == 0) {
							tagStr += '<label class="plus"><a>-</a></label>&nbsp;';
							tagStr += '<label id="all" class="' + gallery_list.length + '" onclick="chk_category(' + "'all'" + ');">All (' + gallery_list.length + ')</label>';
							tagStr += '<ul id="allUl">';
							tagStr += '<li>';
							tagStr += '<label class="plus"><a>+</a></label>&nbsp;<label class="0" id="' + class_name + '" onclick="chk_category(' + "'" + class_name + "'" + ');">' + class_name + ' (' + 0 + ')</label>';
							tagStr += '<ul class="hide">';
						}
						
						if (tag_list[i - 1] != null && tag_list[i - 1].tag_class_name != class_name) {
							tagStr += '</ul></li>';
							tagStr += '<li><label class="plus"><a>+</a></label>&nbsp;<label class="0" id="' + class_name + '" onclick="chk_category(' + "'" + class_name + "'" + ');">' + class_name + ' (0)</label><ul class="hide">';
						}
						
						var color_id = class_name + "_" + color_name.replace(' ', '_');
						
						if (chk == 'Y') {
							chk = 'checked';
						} else {
							chk = '';
						}
						tagStr += '<li><input type="checkbox" class="all ' + class_name + '" id="' + color_id + '" ' + chk + ' onclick="isChk(null, ' + "'change_" + color_id + "'" + ');" name="' + color_id + '" /><label id="' + count + '" class="' + color_id + '" for="' + color_id + '">' + color_name + ' (' + count + ')</label></li>';
						
					}
					tagStr += '</ul></li>';
					tagStr += '</ul>';
		  	    	$("#allLi").append(tagStr);
					$('#confidence').attr("onclick", "isChk()");
					$('.favorites').attr("onclick", "isChk()");
				}
				isChk(page_number, 'first');
				
				$('#previous').removeClass('disabled');
				
				$('#next').removeClass('disabled');
				$('#next').attr("onclick", "goEndPage()");

				$('#previous').attr("onclick", "goStartPage()");

				$('#next_one').attr("onclick", "goNextPage()");
				$('#previous_one').attr("onclick", "goPreviousPage()");
			
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	}

	if (get('confidenceValue') != null) {
		$("#ex6SliderVal").text(get('confidenceValue'));
	}
	
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/showImage1', function (message) {
			var gallery_data = JSON.parse(message.body);
			var login_id = gallery_data.login_id;
			if (JSON.parse(get('userdata')).login_id == login_id && window.name == 'new') {
				var roiNum = gallery_data.gallery_roiNum;
				var class_name = gallery_data.gallery_class_name;
				var colors = gallery_data.gallery_colors.substring(1, gallery_data.gallery_colors.indexOf('}')).split(', ');
				var confidence = gallery_data.gallery_confidence;
				var crop_name = gallery_data.gallery_crop_name;
				var idx = gallery_data.gallery_idx;
				if (roiNum == 0) {
					case_idx = gallery_data.case_idx;
					gallery_list = new Array();
					
					$('#previous').removeClass('disabled');
					
					$('#next').removeClass('disabled');
					$('#next').attr("onclick", "goEndPage()");

					$('#previous').attr("onclick", "goStartPage()");

					$('#next_one').attr("onclick", "goNextPage()");
					$('#previous_one').attr("onclick", "goPreviousPage()");

					$('.favorites').attr("onclick", "isChk()");

					$('#confidence').attr("onclick", "isChk()");

					var tagStr = '';
					tagStr += '<label class="plus" onclick="clickPlus(this);"><a>-</a></label>&nbsp;';
					tagStr += '<label id="all" class="1" onclick="chk_category(' + "'all'" + ');">All (1)</label>';
					tagStr += '<ul id="allUl"></ul>';
					
		  	    	$("#allLi").append(tagStr);
				} else {
					var count = $('#all').attr('class');
					$('#all').removeClass(count);
					count = parseInt(count) + 1; 
					$('#all').text('All (' + count + ')');
					$('#all').addClass('' + count);
				}
				
				if (document.getElementById(class_name) == null) {
					var tagStr = '';
					tagStr += '<li><label class="plus" onclick="clickPlus(this);"><a>+</a></label>&nbsp;';
					tagStr += '<label class="1" id="' + class_name + '" onclick="chk_category(' + "'" + class_name + "'" + ');">' + class_name + ' (1)</label><ul class="hide"></ul>';
		  	    	$("#allUl").append(tagStr);
				} else {
					var count = $('#' + class_name).attr('class');
					$('#' + class_name).removeClass(count);
					count = parseInt(count) + 1;
					$('#' + class_name).text(class_name + ' (' + count + ')');
					$('#' + class_name).addClass('' + count);
				}
 
				var chkColorTag = false;
				for (var i = 0; i < colors.length; i++) {
					var color_name = colors[i];				
					var color_id = class_name + "_" + color_name.replace(' ', '_');
					if (document.getElementById(color_id) == null) {
						var tagStr = '';
						tagStr += '<li><input type="checkbox" class="all ' + class_name + '" id="' + color_id + '" checked onclick="isChk(null, ' + "'change_" + color_id + "'" + ');" name="' + color_id + '" /><label id="1" class="' + color_id + '" for="' + color_id + '">' + color_name + ' (1)</label></li>';
			  	    	$("#" + class_name).next().append(tagStr);
					} else {
						var count = $('.' + color_id).attr('id');
						$('.' + color_id).removeAttr('id');
						count = parseInt(count) + 1;
						$('.' + color_id).text(color_name + ' (' + count + ')');
						$('.' + color_id).attr('id', count);
					}
					if (!chkColorTag && $('#' + color_id).prop('checked')) {
						chkColorTag = true;
					}
				}

				var chkFavorite = false;
				
				$('.favorites').each(function () {
					if ($(this).prop('checked')) {
						chkFavorite = true;
						return false;
					}
				});

				if (!($('#confidence').prop('checked')) && !chkFavorite) {
					if (chkColorTag) {
						if (confidence >= parseInt($('#ex6SliderVal').text())) {
							var isFull = true;
							var img_num = 0;
							var count = parseInt($('#fileCount').text());
							
							if ($('#fileCount').text() == '') {
								count = 0;
							}
							
							var total_page = parseInt((count - 1) / 28) + 1;
							if  (total_page < 1) {
								total_page = 1;
							}
							
							var page_number = parseInt(get('gallery_page_number'));
							if (get('gallery_page_number') == null) {
								page_number = 1;
							}
							
							if (total_page == page_number) {
								for (var i = 0; i < 28; i++) {
									if (document.getElementById('a' + i) == null) {
										isFull = false;
										img_num = i;
										break;
									}
								}

								if (isFull) {
									img_num = 0;
									
							    	for (var j = 0; j < 28; j++) {
										$('#a' + j).remove();
							    	}
							    	
							    	if (total_page % 10 == 0) {
								    	$('.page').remove();
							    	} else {
										$('#menu').find('.active').removeClass('active');
							    	}

									page_number = total_page + 1;
									$('<li class="page-item page active" id="page' + page_number + '"><a href="#" onclick="clickPage_num(' + page_number + ');">' + page_number + '</a></li>').insertBefore('#next_one');
								}
								
								setGallery_page_number(page_number);

								var w = $('#imageTd' + img_num).width();
								var h = $('#imageTd' + img_num).height();

								$('<a id="a' + img_num + '" href="/police/popup.htm?roiNum=' + roiNum + "&case_idx=" + case_idx + '" data-lity data-lity-desc=""><img id="image' + img_num + '" src="' + crop_name + '" width="' + w + '" height="' + h + '" class="imageA" /></a>').insertBefore('#T' + img_num);
								
								$('#trash' + img_num).attr("onclick", "updateFavorites('N', 'T', " + img_num + ", " + idx + ")");
								$('#gray' + img_num).attr("onclick", "updateFavorites('N', 'G', " + img_num + ", " + idx + ")");
								$('#yellow' + img_num).attr("onclick", "updateFavorites('N', 'Y', " + img_num + ", " + idx + ")");
							} else {
								if (count > 0 && count % 28 == 0) {
									total_page = total_page + 1;

									var total_opt = parseInt((total_page - 1) / 10) + 1;
									var page_opt = parseInt((page_number - 1) / 10) + 1;
									
									if (total_opt < 1) {
										total_opt = 1;
									}
									
									if (page_opt < 1) {
										page_opt = 1;
									}

									
									if (total_opt == page_opt) {
										$('<li class="page-item page" id="page' + total_page + '"><a href="#" onclick="clickPage_num(' + total_page + ');">' + total_page + '</a></li>').insertBefore('#next_one');
									}									
								}
							}

							count = count + 1;
							
							$('#fileCount').text(count);
						}
					}
				}
			}
		});
		stompClient.subscribe('/endProcess2', function (num) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(num.body).login_id && window.name == 'new') {
				/* if (parseInt(get('file2')) - 1 == parseInt(JSON.parse(num.body).num)) {
				} */
			}
		});
		stompClient.subscribe('/fileCount2', function (count) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(count.body).login_id && window.name == 'new') {
				$('#allLi').empty();
				
				$('#fileCount').text(0);
				
		    	for (var j = 0; j < 28; j++) {
					$('#a' + j).remove();
		    	}
		    	
		    	$('.page').remove();
		    	
				$('<li class="page-item page active" id="page1"><a href="#" onclick="clickPage_num(1);">1</a></li>').insertBefore('#next_one');
			}
		});
		stompClient.subscribe('/selectImage', function (num) {		// e-map에서 먼저 클릭했을 때
			if (JSON.parse(get('userdata')).login_id == JSON.parse(num.body).login_id) {
			}
		});

		stompClient.subscribe('/selectImage2', function (num) {		// gallery 페이지에서 먼저 눌렀을 때
			if (JSON.parse(get('userdata')).login_id == JSON.parse(num.body).login_id) {
			}
		});
	});

	$('#previous').removeClass('disabled');
	$('#next').removeClass('disabled');
	
	if (parseInt((parseInt(get('page2')) - 1) / 10) == 0) {
		//$('#previous').addClass('disabled');
	}

	if (parseInt((parseInt(get('page2')) - 1) / 10) == parseInt((parseInt(get('endPage2')) - 1) / 10)) {
		//$('#next').addClass('disabled');
	}
	
	if (parseInt(get('page2')) == 1 && (get('obj2') == null || JSON.parse(get('obj2')).length == 0)) {
		//$('<li class="nav-item active" id="page1"><a href="#">1</a>').insertBefore('#next');
	} else {
		if (get('endPage2') != null) {
			if (parseInt(get('endPage2')) < 10) {
				for (var i = 1; i < parseInt(get('endPage2')) + 1; i++) {
					if (i == parseInt(get('page2'))) {
						$('<li class="nav-item active" id="page' + i + '" onclick="showImage(' + i + ')"><a href="#">' + i + '</a></li>').insertBefore('#next');
					} else {
						$('<li class="nav-item" id="page' + i + '" onclick="showImage(' + i + ')"><a href="#">' + i + '</a></li>').insertBefore('#next');
					}
				}
			} else {
				var startNum = (parseInt((parseInt(get('page2')) - 1) / 10) * 10) + 1;
				setStartPage2(startNum + '');
				if (parseInt((parseInt(get('page2')) - 1) / 10) == parseInt((parseInt(get('endPage2')) - 1) / 10)) {		// 현재 페이지와 마지막 페이지 같은 블록일 때
					for (var j = startNum; j < parseInt(get('endPage2')) + 1; j++) {
						if (j == parseInt(get('page2'))) {
							$('<li class="nav-item active" id="page' + j + '" onclick="showImage(' + j + ')"><a href="#">' + j + '</a></li>').insertBefore('#next');
						} else {
							$('<li class="nav-item" id="page' + j + '" onclick="showImage(' + j + ')"><a href="#">' + j + '</a></li>').insertBefore('#next');
						}
					}
				} else {	// 현재 페이지와 마지막 페이지 다른 블록일 때
					for (var k = startNum; k < startNum + 10; k++) {
						if (k == parseInt(get('page2'))) {
							$('<li class="nav-item active" id="page' + k + '" onclick="showImage(' + k + ')"><a href="#">' + k + '</a></li>').insertBefore('#next');
						} else {
							$('<li class="nav-item" id="page' + k + '" onclick="showImage(' + k + ')"><a href="#">' + k + '</a></li>').insertBefore('#next');
						}	
					}
				}
			}
		}
	}
	
	$("#ex6").slider({
		id: 'slider6'
	});
	function slide_event_mouseup() {
		var confidenceValue = parseInt(get('confidenceValue'));
		
		$(window).off('mousemove');
		$(window).off('mouseup');
		
		isChk(1, null);
	}
	
	$(".slider-handle").mousedown(function() {      // 클릭
		$(window).mousemove(slide_event_mousemove);
		$(window).mouseup(slide_event_mouseup);
	});

	$(".slider-horizontal").mousedown(function() {      // 클릭
		$(window).mousemove(slide_event_mousemove);
		$(window).mouseup(slide_event_mouseup);
	});

	$(".slider-horizontal").click(function() {      // 클릭
		slide_event_mousemove();
		slide_event_mouseup();
	});
	
	function slide_event_mousemove() {
		if (($('.slider-selection').width() / $('.slider-track').width() * 100) - parseInt($('.slider-selection').width() / $('.slider-track').width() * 100) > 0.5) {
			confidenceValue = parseInt($('.slider-selection').width() / $('.slider-track').width() * 100) + 1;
		} else {
			confidenceValue = parseInt($('.slider-selection').width() / $('.slider-track').width() * 100);
		}
		setConfidenceValue(confidenceValue);
		$("#ex6SliderVal").text(confidenceValue);
	}
	
	$('.plus').click(function () {
  		var targetUl = $(this).parent().children('ul');
  		targetUl.toggleClass("hide");

  		if ($(this).children("a").text() == '+') {
  	  		$(this).children("a").text('-');
  		} else {
  	  		$(this).children("a").text('+');
  		}
	});
	
	function isChk(page_number, option) {
		var array = new Array();
		var favorites_array = new Array();
		$('.all').each(function () {
			if ($(this).prop('checked')) {
				array.push($(this).attr('id'));
			}
		});
		
		if (page_number == null) {
			page_number = 1;
		}
		
		var obj = new Object();
		$('.favorites').each(function () {
			if ($(this).prop('checked')) {
				favorites_array.push($(this).val());
			}
		});
		
		if ($('#confidence').prop('checked')) {
			obj.confidence = true;
		}
		
		obj.confidenceValue = parseInt($('#ex6SliderVal').text());

		if (option != null && option.split('_')[0] == 'change') {
			if ($('#' + option.split('_')[1] + '_' + option.split('_')[2] + '_' + option.split('_')[3]).prop('checked')) {
				obj.checked = 'Y';
			} else {
				obj.checked = 'N';
			}
			obj.tag_id = option.split('_')[1] + '_' + option.split('_')[2] + ' ' + option.split('_')[3];
		}
		
		obj.chk_tag = array;
		obj.favorites = favorites_array;
		obj.page_number = page_number;
		obj.case_idx = parseInt(case_idx);
		var jsonData = JSON.stringify(obj);
		var jsonUrl = "/police/selectChkImage";
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
			success: function (data) {	
				$('.chkIcon').hide();
		    	for (var j = 0; j < 28; j++) {
					$('#a' + j).remove();
		    	}
		    	
		    	if (data.length > 0) {
			    	var first_data = (page_number - 1) * 28;
			    	var end_data = first_data + 28;
			    	
					for (var i = first_data; i < end_data; i++) {
						if (data[i] != null) {
							var w = $('#imageTd' + (i % 28)).width();
							var h = $('#imageTd' + (i % 28)).height();
							
							$('<a id="a' + (i % 28) + '" href="/police/popup.htm?roiNum=' + data[i].gallery_roinum + "&case_idx=" + case_idx + '" data-lity data-lity-desc=""><img id="image' + (i % 28) + '" src="' + data[i].gallery_crop_name + '" width="' + w + '" height="' + h + '" class="imageA" /></a>').insertBefore('#T' + (i % 28));

							if (data[i].gallery_favorites != 'N' && data[i].gallery_favorites != 'T') {
								$('#' + data[i].gallery_favorites + (i % 28)).css('display', '');
							}
							
							$('#trash' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'T', " + (i % 28) + ", " + data[i].gallery_idx + ")");
							$('#gray' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'G', " + (i % 28) + ", " + data[i].gallery_idx + ")");
							$('#yellow' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'Y', " + (i % 28) + ", " + data[i].gallery_idx + ")");
						}
					}
					
					if (option == 'first') {
						for (var i = 0; i < data.length; i++) {
							var class_name = data[i].gallery_class_name;
							var count = parseInt($('#' + class_name).attr('class'));
							$('#' + class_name).removeClass(count + '');
							count = count + 1;
							$('#' + class_name).addClass(count + '');
							$('#' + class_name).text(class_name + '(' + count + ')');
						}
					}
		    	}
	    		
				var end_opt = parseInt((page_number - 1) / 10) ;
				var now_opt = parseInt((get('gallery_page_number') - 1) / 10);

				if (option != 'page') {
					$('.page').remove();

					var first = parseInt((page_number - 1) / 10) * 10 + 1;
					var end = first + 9;
					
					var total_count = data.length;
					var total_page = parseInt((total_count - 1) / 28) + 1;
					
					if (total_page < end) {
						end = total_page
					}
					
					console.log(total_count, total_page, first, end);
					
					for (var i = first; i < end + 1; i++) {
						var opt = '';
						if (i == page_number) {
							opt = 'active'
						}
						$('<li class="page-item page ' + opt + '" id="page' + i + 's"><a href="#" onclick="clickPage_num(' + i + ');">' + i + '</a></li>').insertBefore('#next_one');
					}
					setGallery_page_number(page_number);
				} else if (option == 'page') {
					$('#menu').find('.active').removeClass('active');
					$('#page' + page_number).addClass("active");
					setGallery_page_number(page_number);
				}


				$('#fileCount').text(data.length);
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		});
	}
});

$('.slider-handle').ready(function() {
	$('.slider-selection').width(get('confidenceValue') + '%');
	$('.slider-track-high').width((100 - parseInt(get('confidenceValue'))) + '%');
	$(".slider-handle").css("left", get('confidenceValue') + '%');
});
$(window).resize(function() {
	var showImage = parseInt(parseInt(get('count2')) % 28);
	if (get('page2') < get('endPage2')) {
		showImage = 28;
	}
	if (showImage == 0) {
		showImage = 28;
	}
	
	for (var i = 0; i < showImage; i++) {
		$('#image' + i).width($('#imageTd' + i).width());
		$('#image' + i).height($('#imageTd' + i).height());
	}
	$('.slider-handle').ready(function() {
		if (get('confidenceValue') != null) {
			$('.slider-selection').width(get('confidenceValue') + '%');
			$('.slider-track-high').width((100 - parseInt(get('confidenceValue'))) + '%');
			$(".slider-handle").css("left", get('confidenceValue') + '%');
		}
	});
});
function showImage(pageNumber) {
	$('#menu').find('.active').removeClass('active');
	$('#page' + pageNumber).addClass("active");
	setPage2($('#page' + pageNumber).text());
	$('#previous').removeClass('disabled');
	$('#next').removeClass('disabled');
	var page = parseInt(get('page2'));
	var array = new Array();
	array = JSON.parse(get('obj2'));
	
	if (parseInt((parseInt(get('page2')) - 1) / 10) == 0) {
		//$('#previous').addClass('disabled');
	}
	
	if (parseInt((parseInt(get('page2')) - 1) / 10) == parseInt((parseInt(get('endPage2')) - 1) / 10)) {
		//$('#next').addClass('disabled');
	}

	for (var j = 0; j < 28; j++) {
		$('#a' + j).remove();
		$('#yellow' + j).css('display', 'none');
		$('#gray' + j).css('display', 'none');
		$('#trash' + j).css('display', 'none');
	}
	if (parseInt(get('page2')) < parseInt(get('endPage2'))) {
		// page2, endPage2 변하지 않음
		for (var k = 0; k < 28; k++) {
			var crop_name = array[(page - 1) * 28 + k].crop_name;
			var selectNum = crop_name.substring(crop_name.lastIndexOf('/') + 1, crop_name.lastIndexOf('_'));
			var w = $('#imageTd' + k).width();
			var h = $('#imageTd' + k).height();
			
			$('<a id="a' + k + '" onclick="selectImage(' + selectNum + ', ' + k + ');" href="/police/popup.htm?roiNum=' + ((page - 1) * 28 + k) + '" data-lity data-lity-desc=""><img id="image' + k + '" src="' + crop_name + '" width="' + w + '" height="' + h + '" class="imageA" /></a>').insertBefore('#trash' + k);
			if (array[(page - 1) * 28 + k].favorites == 'Y') {
				$('#yellow' + k).css('display', '');
			}
			if (array[(page - 1) * 28 + k].favorites == 'G') {
				$('#gray' + k).css('display', '');
			}
			if (array[(page - 1) * 28 + k].favorites == 'T') {
				$('#trash' + k).css('display', '');
			}
		}
	} else {
		var showImage = parseInt(parseInt(get('count2')) % 28);
		var tmpNum = parseInt(parseInt(get('endPage2')) - 1) * 28;
		if (showImage == 0) {
			showImage = 28;
		}
		//alert("count = " + get('count2') + ", showImage = " + showImage + ", tmpNum = " + tmpNum);
		for (var k = tmpNum; k < tmpNum + showImage; k++) {		// tmpNum, array
			var crop_name = array[k].crop_name;
			var selectNum = crop_name.substring(crop_name.lastIndexOf('/') + 1, crop_name.lastIndexOf('_'));
			var w = $('#imageTd' + (k % 28)).width();
			var h = $('#imageTd' + (k % 28)).height();
			
			$('<a id="a' + (k % 28) + '" onclick="selectImage(' + selectNum + ', ' + (k % 28) + ');" href="/police/popup.htm?roiNum=' + k + '" data-lity data-lity-desc=""><img id="image' + (k % 28) + '" src="' + crop_name + '" width="' + w + '" height="' + h + '" class="imageA" /></a>').insertBefore('#trash' + (k % 28));
			if (array[k].favorites == 'Y') {
				$('#yellow' + k % 28).css('display', '');
			}
			if (array[k].favorites == 'G') {
				$('#gray' + k % 28).css('display', '');
			}
			if (array[k].favorites == 'T') {
				$('#trash' + k % 28).css('display', '');
			}
		}
	}
}
function showFavorites(i) {
	$('#icon' + i).css('display', '');	
}
function hideFavorites(i) {
	$('#icon' + i).css('display', 'none');	
}
function fullScreenMode() {
	var docV = document.documentElement;
	
	// 전체화면 설정
	if (docV.requestFullscreen) {
		docV.requestFullscreen();
	} else if (docV.webkitRequestFullscreen) {
		docV.webkitRequestFullscreen();
	} else if (docV.mozRequestFullScreen) {
		docV.mozRequestFullScreen();
	} else if (docV.msRequestFullscreen) {
		docV.msRequestFullscreen();
	}
	
	// 전체화면 해제
	if (document.exitFullscreen) {
		document.exitFullscreen();
	} else if (document.webkitExitFullscreen) {
		document.webkitExitFullscreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.msExitFullscreen) {
		document.msExitFullscreen();
	}
}
function updateFavorites(before, after, i, idx) {
	if ($('#image' + i).attr("src") != null) {
		$('#T' + i).css('display', 'none');		
		$('#Y' + i).css('display', 'none');		
		$('#G' + i).css('display', 'none');
		
		var flag = after;

		var page_number = parseInt(get('gallery_page_number'));
		var total_page = parseInt(parseInt((parseInt($('#fileCount').text()) - 2) / 28) + 1);
		if (page_number > total_page) {
			page_number = total_page;
		}
		var ischecked = false;
		var isfunc = false;
		$('.favorites').each(function () {
			if ($(this).prop('checked')) {
				ischecked = true;
				return false;
			}
		});
		if (before != after) {
			if (ischecked) {
				isfunc = true;
			} else {
				if (after != 'T') {
					$('#' + after + i).css('display', '');
				} else {
					isfunc = true;
				}
			}
		} else {
			flag = 'N';
			if (ischecked) {
				isfunc = true;
			} else {
				if (before == 'T') {
					isfunc = true;
				}
			}
		}

		var obj = new Object();
		obj.gallery_idx = parseInt(idx);
		obj.gallery_favorites = flag;
		
		var jsonData = JSON.stringify(obj);
		var jsonUrl = "/police/updateFavorites";
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
			success: function (data) {
				if (isfunc = true) {
					isChk(page_number, null);
				} else {
					$('#trash' + i).removeAttr('onclick');
					$('#gray' + i).removeAttr('onclick');
					$('#yellow' + i).removeAttr('onclick');
					$('#trash' + i).attr("onclick", "updateFavorites('" + flag + "', 'T', " + i + ", " + idx + ")");
					$('#gray' + i).attr("onclick", "updateFavorites('" + flag + "', 'G', " + i + ", " + idx + ")");
					$('#yellow' + i).attr("onclick", "updateFavorites('" + flag + "', 'Y', " + i + ", " + idx + ")");
					$('#icon' + i).css('display', 'none');
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		});
	}
}
function clickPlus(obj) {
	console.log('clickPlus', obj);
	var targetUl = $(obj).parent().children('ul');
	targetUl.toggleClass("hide");

	if ($(obj).children("a").text() == '+') {
  		$(obj).children("a").text('-');
	} else {
  		$(obj).children("a").text('+');
	}
}
function selectImage(imgNum, imageNum) {
	var jsonUrl = "/police/selectGalImage";
	
	var selectObj = new Object();
	selectObj.login_id = JSON.parse(get('userdata')).login_id;
	selectObj.gallery_path = imgNum;
	selectObj.tags = '${case_idx}';
	
	var jsonData = JSON.stringify(selectObj);
	
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
	
	$('#image_list').find('.selectImage').removeClass('selectImage');
	$('#image' + imageNum).addClass("selectImage");
}
function goNextPage() {
	var total_page = parseInt(parseInt((parseInt($('#fileCount').text()) - 1) / 28) + 1);
	if ($(this).attr('class') != 'disabled' && get('gallery_page_number') != total_page) {
		var now_page = parseInt(get('gallery_page_number'));
		var page_number = parseInt((now_page - 1) / 10) + 1;
		
		page_number = page_number * 10 + 1;
		
		if (page_number > total_page) {
			page_number = total_page;
		}
		
		isChk(page_number, null);
	}
}
function goPreviousPage() {
	if ($(this).attr('class') != 'disabled' && parseInt(get('gallery_page_number')) != 1) {
		var now_page = parseInt(get('gallery_page_number'));
		var page_number = parseInt((now_page - 1) / 10) - 1;
		if (page_number < 0) {
			page_number = 1;
		} else {
			page_number = page_number * 10 + 10;
		}

		isChk(page_number, null);
	}
}
function goEndPage() {
	var page_number = parseInt(parseInt((parseInt($('#fileCount').text()) - 1) / 28) + 1);
	if ($(this).attr('class') != 'disabled' && parseInt(get('gallery_page_number')) != page_number) {
		console.log(page_number);
		isChk(page_number, null);
		
	}
}
function goStartPage() {
	var page_number = 1;	
	if ($(this).attr('class') != 'disabled' && parseInt(get('gallery_page_number')) != page_number) {
		isChk(page_number, null);
	}
}
function chk_category(opt) {
	var isClass = false;
	$('.' + opt).each(function () {
		if (!$(this).prop('checked')) {
			isClass = true;
			return false;
		}
	});
	$('.' + opt).prop('checked', isClass);
	isChk(null, null);
}
function clickPage_num(page_number) {
	isChk(page_number, 'page');
}
function isChk(page_number, option) {
	console.log(case_idx);	
	var array = new Array();
	var favorites_array = new Array();
	$('.all').each(function () {
		if ($(this).prop('checked')) {
			array.push($(this).attr('id'));
		}
	});
	
	if (page_number == null) {
		page_number = 1;
	}
	
	var obj = new Object();
	$('.favorites').each(function () {
		if ($(this).prop('checked')) {
			favorites_array.push($(this).val());
		}
	});
	
	if ($('#confidence').prop('checked')) {
		obj.confidence = true;
	}
	
	//obj.confidenceValue = parseInt(get('confidenceValue'));
	obj.confidenceValue = parseInt($('#ex6SliderVal').text());
	
	if (option != null && option.split('_')[0] == 'change') {
		if ($('#' + option.split('_')[1] + '_' + option.split('_')[2] + '_' + option.split('_')[3]).prop('checked')) {
			obj.checked = 'Y';
		} else {
			obj.checked = 'N';
		}
		obj.tag_id = option.split('_')[1] + '_' + option.split('_')[2] + ' ' + option.split('_')[3];
	}
	
	obj.chk_tag = array;
	obj.favorites = favorites_array;
	obj.page_number = page_number;
	obj.case_idx = parseInt(case_idx);
	
	var jsonData = JSON.stringify(obj);
	var jsonUrl = "/police/selectChkImage";
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
		success: function (data) {	
			$('.chkIcon').hide();
	    	for (var j = 0; j < 28; j++) {
				$('#a' + j).remove();
	    	}
	    	
	    	if (data.length > 0) {
		    	var first_data = (page_number - 1) * 28;
		    	var end_data = first_data + 28;
		    	
				for (var i = first_data; i < end_data; i++) {
					if (data[i] != null) {
						var w = $('#imageTd' + (i % 28)).width();
						var h = $('#imageTd' + (i % 28)).height();
						
						$('<a id="a' + (i % 28) + '" href="/police/popup.htm?roiNum=' + data[i].gallery_roinum + "&case_idx=" + case_idx + '" data-lity data-lity-desc=""><img id="image' + (i % 28) + '" src="' + data[i].gallery_crop_name + '" width="' + w + '" height="' + h + '" class="imageA" /></a>').insertBefore('#T' + (i % 28));

						if (data[i].gallery_favorites != 'N' && data[i].gallery_favorites != 'T') {
							$('#' + data[i].gallery_favorites + (i % 28)).css('display', '');
						}
						
						$('#trash' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'T', " + (i % 28) + ", " + data[i].gallery_idx + ")");
						$('#gray' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'G', " + (i % 28) + ", " + data[i].gallery_idx + ")");
						$('#yellow' + (i % 28)).attr("onclick", "updateFavorites('" + data[i].gallery_favorites + "', 'Y', " + (i % 28) + ", " + data[i].gallery_idx + ")");
					}
				}
	    	}
    		
			var end_opt = parseInt((page_number - 1) / 10) ;
			var now_opt = parseInt((get('gallery_page_number') - 1) / 10);

			if (option == null || option.split('_')[0] == 'change') {
				$('.page').remove();
				
				var first = parseInt((page_number - 1) / 10) * 10 + 1;
				var end = first + 9;

				var total_count = data.length;
				var total_page = parseInt((total_count - 1) / 28) + 1;
				
				if (total_page < end) {
					end = total_page
				}
				
				for (var i = first; i < end + 1; i++) {
					var opt = '';
					if (i == page_number) {
						opt = 'active'
					}
					$('<li class="page-item page ' + opt + '" id="page' + i + '"><a href="#" onclick="clickPage_num(' + i + ');">' + i + '</a></li>').insertBefore('#next_one');
				}
				setGallery_page_number(page_number);
			} else if (option == 'page') {
				$('#menu').find('.active').removeClass('active');
				$('#page' + page_number).addClass("active");
				setGallery_page_number(page_number);
			}


			$('#fileCount').text(data.length);
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	});
}
</script>
<body> 
<table class="viewer" style="width:100%; height:100%; margin:0; padding:0; border:none;">
	<tr height="5%" style="background-color:#404040">
		<td width="10%" style="padding-left:8px; background-color:#252525">카테고리</td>
		<td width="10%" style="padding-left:8px;">감지된 이미지</td>
		<td width="15%" id="fileCount"></td>
		<td width="*" align="right" style="padding:0px 30px 0px 8px;">검출 민감도
		</td>
		<td width="10%" style="padding-right:8px;">
			<input id="ex6" type="text" data-slider-handle="round" data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0"/>
		</td>
		<td id="ex6SliderVal" width="3%" align="center" style="padding-right:8px;">0
			<!-- <span id="ex6CurrentSliderValLabel"><span id="ex6SliderVal">0</span></span> -->
		</td>
		<td width="10%" align="right" style="padding-right:8px;">
			<label class="checkbox-inline"><input type="checkbox" id="confidence" value="C" style="display:inline">정확도순 정렬</label>
		</td>
		<td width="1%" style="padding-right:8px;">
			<label class="checkbox-inline">
				<input type="checkbox" id="trash" value="T" class="favorites">
				<span class="glyphicon glyphicon-trash trash" aria-hidden="true" style="padding-right:1.2px;"></span>
			</label>
		</td>
		<td width="1%" style="padding-right:8px;">
			<label class="checkbox-inline">
				<input type="checkbox" id="gray" value="G" class="favorites">
				<span class="glyphicon glyphicon-star gray" aria-hidden="true"></span>
			</label>
		</td>
		<td width="1%" style="padding-right:25px;">
			<label class="checkbox-inline">
				<input type="checkbox" id="yellow" value="Y" class="favorites">
				<span class="glyphicon glyphicon-star yellow" aria-hidden="true"></span>
			</label>
		</td>
		<td width="1%" style="padding-right:8px;">
			<span class="glyphicon glyphicon-resize-full full" aria-hidden="true" onclick="fullScreenMode();"></span>
		</td>
	</tr>
	<!-- <tr height="5px"><td colspan="7"><hr></td></tr> -->
	<tr height="95%">
		<td colspan="11">
			<table style="width:100%; height:100%; margin:0; padding:0; border:none;">
				<tr>
					<td width="10%" id="heightTd">
						<div style="height:100%;">
							<ul style="overflow-y:auto;" id="heightUi">
								<li id="allLi"></li>
							</ul>
						</div>
						<!-- <div style="overflow-x:hidden; overflow-y:auto;">
							<table id="tag_list" style="width:100%; padding:0; margin:0;">
								<tr height="0%" id="tmpTag" style="display:none;"></tr>
							</table>
						</div> -->
					</td>
					<td width="90%">
					<table id="image_list" class="table" style="width:100%; height:100%; padding:0; margin:0; border-collapse: separate; border-spacing:8px; background-color:#252525;">
					<% 
					int rowCount = 7;
					int colCount = 4;
					for (int i = 0; i < (rowCount * colCount); i++) { 
						if (i % rowCount == 0) {
					%>
						<tr class="imageTr">
					<%	} %>
						<td width="<%=100 / rowCount %>%" class="imageTd" style="padding:0; border:none;" id="imageTd<%=i%>" onmouseover='showFavorites(<%=i %>);' onmouseout='hideFavorites(<%=i%>);'>
							<div id="T<%=i %>" class="chkIcon" style="display:none; position:absolute; top:3%; left:90%;"><span class='glyphicon glyphicon-trash trash' aria-hidden='true' style="padding:1px 0px 0px 1px; margin:0;"></span></div>
							<div id="G<%=i %>" class="chkIcon" style="display:none; position:absolute; top:3%; left:90%;"><span class='glyphicon glyphicon-star gray' aria-hidden='true' style="padding:1px 0px 0px 2px; margin:0;"></span></div>
							<div id="Y<%=i %>" class="chkIcon" style="display:none; position:absolute; top:3%; left:90%;"><span class='glyphicon glyphicon-star yellow' aria-hidden='true' style="padding:1px 0px 0px 2px; margin:0;"></span></div>
							<div id="icon<%=i %>" class="icon" style="position:absolute; display:none; left:40%; top:87%">
								<a href="#" class="iconBtn" id="trash<%=i %>" onclick="updateFavorites('T', <%=i%>);"><span class='glyphicon glyphicon-trash trash' aria-hidden='true' style="padding:1px 0px 0px 0px; margin:0;"></span></a>
								<a href="#" class="iconBtn" id="gray<%=i %>" onclick="updateFavorites('G', <%=i%>);"><span class='glyphicon glyphicon-star gray' aria-hidden='true' style="padding:1px 0px 0px 2px; margin:0;"></span></a>
								<a href="#" class="iconBtn" id="yellow<%=i %>" onclick="updateFavorites('Y', <%=i%>);"><span class='glyphicon glyphicon-star yellow' aria-hidden='true' style="padding:1px 0px 0px 2px; margin:0;"></span></a>
							</div>
						</td>
					<% if (i % rowCount == (rowCount - 1)) { %>
						</tr>
						<%
						}
					} %>
					</table>
					</td>
				</tr>
				<tr height="5%">
					<td width="10%"></td>
					<td width="90%">
						<table style="width:100%; height:100%; margin:0; padding:0; border:none;">
						<tr>
							<td width="100%" align="center" style="border:none;">
							<ul id="menu" class="pagination" style="margin:0;">
								<li id="previous"> <!-- class="disabled" -->
									<a href="#" aria-label="Previous" style="maxheight:100%;">
							   			<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
								<li class="page-item" id="previous_one"><a class="page-link" href="#">이전</a></li>
								<li class="page-item page active" id="page1"><a href="#">1</a></li>
								<li class="page-item" id="next_one"><a class="page-link" href="#">다음</a></li>
								<li id="next">
									<a href="#" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</ul>
							</td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	<!-- <a href="/police/popup.htm?objNum=261" data-lity data-lity-desc="">Image</a> -->
</body>
</html>