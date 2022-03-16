<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<style>
html, body {
	width:100%;
	height:100%;
	padding:10px;
	color:white;
}
table {
	width:100%;
	height:100%;
	border-collapse:separate;
	border-spacing:5px;
}
table tr {
	background-color:#252525;
}
ul {
	padding-left:20px;
	list-style:none;
}
input[type=checkbox] {
	margin:0px 5px 0px 0px;
}
div {
	margin:20px 0px 20px 0px;
	height:100%;
}
label {
	cursor:pointer;
}
ul li:before {
	/* content:"+ "; */
}
ul li.minus:before {
	/* content:"- "; */
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
<script>
$(document).ready(function () {
	$(".all").on('click', function() {
	});
	$('.plus').click(function () {        
  		var targetUl = $(this).parent().children('ul');
  		targetUl.toggleClass("hide");

  		if ($(this).children("a").text() == '+') {
  	  		$(this).children("a").text('-');
  		} else {
  	  		$(this).children("a").text('+');
  		}
	});
});
function chk_category(opt) {
	var count = 0;
	var isClass = false;
	$('.' + opt).each(function () {
		if (!$(this).prop('checked')) {
			isClass = true;
			count++;
			return false;
		}
	});
	$('.' + opt).prop('checked', isClass);
	isChk();
}
function isChk() {
	var array = new Array();
	$('.all').each(function () {
		if ($(this).prop('checked')) {
			array.push($(this).attr('id'));
		}
	});
	
	var obj = new Object();
	obj.chk_tag = array;
	obj.page_number = 1;
	var jsonData = JSON.stringify(obj);
	var jsonUrl = "/police/selectChkImage";
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
		success: function (data) {
			
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	});
}
</script>
</head>
<body>
<table>
	<tr>
		<td width="10%">
			<div>
				<ul>
					<li id="allLi">
						<label class="plus"><a>+</a></label>&nbsp;
						<label onclick="chk_category('all')">All (100)</label>
						<ul class="hide" id="allUl">
							<li>
								<label class="plus"><a>+</a></label>&nbsp;
								<label onclick="chk_category('car')">car (33)</label>
								<ul class="hide">
									<li><label><input type="checkbox" class="all car" id="car_amber color" onclick="isChk();" />red (16)</label></li>
									<li><label><input type="checkbox" class="all car" id="car_apple color" onclick="isChk();"/>blue (17)</label></li>
								</ul>
							</li>
							<li>
								<label class="plus"><a>+</a></label>&nbsp;
								<label onclick="chk_category('drone')">drone (33)</label>
								<ul class="hide">
									<li><label><input type="checkbox" class="all drone" id="motorbike_gold color" onclick="isChk();"/>white (17)</label></li>
									<li><label><input type="checkbox" class="all drone" id="motorbike_gray color" onclick="isChk();"/>black (16)</label></li>
								</ul>
							</li>
							<li>
								<label class="plus"><a>+</a></label>&nbsp;
								<label onclick="chk_category('person')">person (34)</label>
								<ul class="hide">
									<li><label><input type="checkbox" class="all person" id="person_amber color" onclick="isChk();"/>purple (17)</label></li>
									<li><label><input type="checkbox" class="all person" id="person_apple color" onclick="isChk();"/>yellow (17)</label></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</td>
		<td width="90%"></td>
	</tr>
</table>
</body>
</html>