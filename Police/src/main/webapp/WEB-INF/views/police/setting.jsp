<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 세팅페이지</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
</head>
<script>
$(document).ready(function () {
	var jsonUrl = "/police/settingInfo";
	
	var obj = new Object();
	obj.version_name = 'finder';
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		   
	    success: function(data) {
	    	if (data != null) {
	    		const client_code = data.client_code;
	    		//const select_box = document.fm.select.options;
	    		const isExist = false;
	    		const value = "";
	    		const num = 0;
	    		
	    		var exists = false; 
	    		$('#selbox option').each(function() { 
	    			if (this.value == client_code) { 
	    				exists = true; 
	    				return false;
	    			} 
	    		});
	    		
	    		if (exists) {
	    			$('#selbox').val(client_code).attr('selected', 'selected');
	    		} else {
	    			$('#selbox').val('direct').attr('selected', 'selected');
	    			$("#selboxDirect").val(client_code);
	    			$("#selboxDirect").show();
	    		}
	    	}
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
	$("#selbox").change(function() {
		if($("#selbox").val() == "direct") {
			$("#selboxDirect").val('');
			$("#selboxDirect").show();
		} else {
			$("#selboxDirect").hide();
		}
	}) 
});
function save_code() {
	var code = $("#selboxDirect").val();
	var value = $("#selbox").val();
	
	if (value == 'direct') {
		value = code;
	}
	
	var versionObj = new Object();
	versionObj.version_name = 'finder';
	versionObj.client_code = value;
	
	var jsonUrl = "/police/updateCode";
	var jsonData = JSON.stringify(versionObj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
		success: function (data) {
			alert('저장을 성공하였습니다.');
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
			alert('오류가 발생하였습니다.');
		}
	});
}
</script>
<body>
	<div id="body_div">
		<div id="code_div">
			<select name="code_box" id="selbox">
				<option value="poldrone">poldrone</option>
				<option value="korea_forest_service">korea_forest_service</option>
				<option value="direct">직접입력</option>
			</select>
			<input type="text" placeholder="poldrone" id="selboxDirect" style="display:none;" />
		</div>
		<div id="btn_div">
			<button id="btn" onclick="save_code();">저장</button>
		</div>
	</div>
</body>
</html>