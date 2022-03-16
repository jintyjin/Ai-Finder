<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI-Finder</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.dark.css" type="text/css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxmenu.js"></script>
<!-- <script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.js"></script> -->
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid2.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxwindow.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdata.export.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.export.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxexport.js"></script> 
<script type="text/javascript" src="./resources/js/translate/translate.js"></script> 
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<!-- <script src="./resources/js/bootstrap.min.js"></script> -->
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	background-color:#404040;
}
.container-fluid {
	background-color:#404040;
	padding:0;
}
.nav-tabs {
	border:none;
}
.nav-tabs li {
	margin:0;
	height:100%;
}
.nav-item {
	height:100%;
}
.nav-item a {
	color:#ffffff;
}
.nav-item a:hover {
	color:black;
}
#iframe {
    position: relative;
    height: 100%;
    width: 100%; 
    border:none;
}
#logout span {
	cursor:pointer;
	
}
/* The Modal (background) */
.modal {
	display:block;
	/* visibility:visible; */
	opacity:0;
	position: fixed; /* Stay in place */
	z-index:-1; /* Sit on top */ 
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
.modal_hide {
	/* display: none; /* Hidden by default */ 
	/* visibility: hidden; */
}
/* Modal Content */
.modal-content {
  background-color: #252525;
  margin: auto;
  padding: 20px;
  border: none;
  width: 1300px;
  display:block;
  /* flex-direction:inherit; */
}
.closeDiv {
	width:1250px;
	padding-left:15px;
	/* padding-right:15px; */
	/* padding-top:20px; */
	/* padding-bottom:20px; */
	text-align-last:right;
}
.info_div {
	width:1250px;
	padding-left:15px;
	padding-right:15px;
	color:white;
	font-weight:bold;
	font-size:18px;
	height:25px;
	/* padding-top:20px; */
	/* padding-bottom:20px; */
}
#case_count {
	/* padding-left:15px; */
	float:left;
	color:#fff;
}
#deleteBtnDiv {
	float:right;
}
.btnDiv {
	width:1250px;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
#contentDiv {
	width:1250px;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.closeBtn {
	/* width:100px; */
	/* height:30px; */
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
}
.closeBtn:hover {
	color:#1c97ea;
}
.closeBtn:active {
	box-shadow: 0 #666;
}
.checkBtn {
	width:100px;
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
	margin-right:8px;
	display:none;
}
.checkBtn:hover {
	color:#1c97ea;
}
.checkBtn:active {
	box-shadow: 0 #666;
}
.downloadBtn {
	width:100px;
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
.downloadBtn:hover {
	color:#1c97ea;
}
.downloadBtn:active {
	box-shadow: 0 #666;
}
.deleteBtn {
	width:100px;
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
}
.deleteBtn:hover {
	color:#1c97ea;
}
.deleteBtn:active {
	box-shadow: 0 #666;
}
#title {
	width:100%;
	height:100%;
	text-align:right;
	color:white;
	line-height:3;
}
.jqxgrid-center-jin {
	margin-inline:auto;
	padding-top:7px;
	text-align:center;
}
/* The Modal (background) */
.modal3 {
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
.modal_hide3 {
	display: none; /* Hidden by default */
}
/* Modal Content */
.modal-content3 {
  background-color: #252525;
  margin: auto;
  /* padding: 20px; */
  border: none;
  width: 800px;
  display:block;
  /* flex-direction:inherit; */
}
.btnDiv3 {
	width:100%;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.closeDiv2 {
	width:100%;
	padding-left:15px;
	/* padding-right:15px; */
	/* padding-top:20px; */
	/* padding-bottom:20px; */
	text-align-last:right;
}
.closeBtn2 {
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
.closeBtn2:hover {
	color:#1c97ea;
}
.closeBtn2:active {
	box-shadow: 0 #666;
}
.titleDiv3 {
	width:100%;
	padding-left:15px;
	color:#fff;
}
.contentDiv3 {
	width:100%;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.checkBtn3 {
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
.checkBtn3:hover {
	color:#1c97ea;
}
.checkBtn3:active {
	box-shadow: 0 #666;
}
.closeBtn3 {
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
.closeBtn3:hover {
	color:#1c97ea;
}
.closeBtn3:active {
	box-shadow: 0 #666;
}
#caseTitle3 {
	color:black;
	width:100%;
}
/* The Modal (background) */
.modal4 {
	display:block;
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */ 
	padding-top:100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
.modal_hide4 {
	display: none; /* Hidden by default */
}
/* Modal Content */
.modal-content4 {
  background-color: #252525;
  margin: auto;
  padding: 20px;
  border: none;
  width: 600px;
  display:block;
  /* flex-direction:inherit; */
}
.btnDiv4 {
	width:100%;
	padding-left:15px;
	padding-right:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.contentDiv4 {
	width:100%;
	height:600px;
	color:white;
	/* padding-left:15px; */
	/* padding-right:15px; */
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:center;
	align-items:center;
}
.closeBtn4 {
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
.closeBtn4:hover {
	color:#1c97ea;
}
.closeBtn4:active {
	box-shadow: 0 #666;
}
#progress_div {
	width:1250px;
	padding:20px 15px 0px 15px;
}
#count_delete {
	width:1250px;
	padding:0px 15px;
}
#server_login {
	display:block;
	/* visibility:visible; */
	opacity:0;
	position: fixed; /* Stay in place */
	z-index:-1; /* Sit on top */ 
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
#login_box {
	width:auto;
	position: absolute;
	left: 50%; 
	top: 50%;
	transform: translate(-50%, -200%);
}
#server_table {
	border-spacing:12px;
	border-collapse:separate;
}
.server_user_info_text {
	padding-right:0px;
	margin:0;
	font-size:12px;
	text-align:right;
	font-weight:bold;
	color:white;
}
.sever_user_info {
	width:170px;
	height:30px;
	padding:2px;
	border:none;
	border-radius:3px;
	color:#404040;
}
#server_btn {
	margin:0px;
	padding:0px;
	width:77px;
	height:68px;
	font-size:15px;
	color:white;
	background-color:#1E90FF;
	border-radius:3px;
	border:none;
	cursor:pointer;
}
#server_btn:hover {
	color:#404040;
}
#join_text {
	pointer-events: none;
}
</style>
<script>
function SHA256(s) {     
	var chrsz   = 8;
	var hexcase = 0;
  
	function safe_add (x, y) {
		var lsw = (x & 0xFFFF) + (y & 0xFFFF);
		var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
		return (msw << 16) | (lsw & 0xFFFF);
	}
  
	function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
	function R (X, n) { return ( X >>> n ); }
	function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
	function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
	function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
	function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
	function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
	function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
  
	function core_sha256 (m, l) {
		 
		var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
			0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
			0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
			0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
			0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
			0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
			0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
			0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
			0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
			0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
			0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);

		var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

		var W = new Array(64);
		var a, b, c, d, e, f, g, h, i, j;
		var T1, T2;
  
		m[l >> 5] |= 0x80 << (24 - l % 32);
		m[((l + 64 >> 9) << 4) + 15] = l;
  
		for ( var i = 0; i<m.length; i+=16 ) {
			a = HASH[0];
			b = HASH[1];
			c = HASH[2];
			d = HASH[3];
			e = HASH[4];
			f = HASH[5];
			g = HASH[6];
			h = HASH[7];
  
			for ( var j = 0; j<64; j++) {
				if (j < 16) W[j] = m[j + i];
				else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
  
				T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
				T2 = safe_add(Sigma0256(a), Maj(a, b, c));
  
				h = g;
				g = f;
				f = e;
				e = safe_add(d, T1);
				d = c;
				c = b;
				b = a;
				a = safe_add(T1, T2);
			}
  
			HASH[0] = safe_add(a, HASH[0]);
			HASH[1] = safe_add(b, HASH[1]);
			HASH[2] = safe_add(c, HASH[2]);
			HASH[3] = safe_add(d, HASH[3]);
			HASH[4] = safe_add(e, HASH[4]);
			HASH[5] = safe_add(f, HASH[5]);
			HASH[6] = safe_add(g, HASH[6]);
			HASH[7] = safe_add(h, HASH[7]);
		}
		return HASH;
	}
  
	function str2binb (str) {
		var bin = Array();
		var mask = (1 << chrsz) - 1;
		for(var i = 0; i < str.length * chrsz; i += chrsz) {
			bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
		}
		return bin;
	}
  
	function Utf8Encode(string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
  
		for (var n = 0; n < string.length; n++) {
  
			var c = string.charCodeAt(n);
  
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
  
		}
  
		return utftext;
	}
  
	function binb2hex (binarray) {
		var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
		var str = "";
		for(var i = 0; i < binarray.length * 4; i++) {
			str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
			hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
		}
		return str;
	}
  
	s = Utf8Encode(s);
	return binb2hex(core_sha256(str2binb(s), s.length * chrsz));  
}

var Base64 = {

	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",

	// public method for encoding
	encode : function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		while (i < input.length) {

		  chr1 = input.charCodeAt(i++);
		  chr2 = input.charCodeAt(i++);
		  chr3 = input.charCodeAt(i++);

		  enc1 = chr1 >> 2;
		  enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		  enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		  enc4 = chr3 & 63;

		  if (isNaN(chr2)) {
			  enc3 = enc4 = 64;
		  } else if (isNaN(chr3)) {
			  enc4 = 64;
		  }

		  output = output +
			  this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			  this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

		}

		return output;
	},

	// public method for decoding
	decode : function (input)
	{
	    var output = "";
	    var chr1, chr2, chr3;
	    var enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = input.replace(/[^A-Za-z0-9+/=]/g, "");

	    while (i < input.length)
	    {
	        enc1 = this._keyStr.indexOf(input.charAt(i++));
	        enc2 = this._keyStr.indexOf(input.charAt(i++));
	        enc3 = this._keyStr.indexOf(input.charAt(i++));
	        enc4 = this._keyStr.indexOf(input.charAt(i++));

	        chr1 = (enc1 << 2) | (enc2 >> 4);
	        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
	        chr3 = ((enc3 & 3) << 6) | enc4;

	        output = output + String.fromCharCode(chr1);

	        if (enc3 != 64) {
	            output = output + String.fromCharCode(chr2);
	        }
	        if (enc4 != 64) {
	            output = output + String.fromCharCode(chr3);
	        }
	    }

	    return output;
	}
}
window.onbeforeunload = null;
function isEmpty(str) {
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		return true;
	else
		return false;
}
function get(key) {
	return sessionStorage.getItem(key);
}
function del() {
	sessionStorage.clear();
}
function removeInfo(key) {
	sessionStorage.removeItem(key);
}
function setPol_app(pol_app) {		// 파일 경로
	sessionStorage.setItem('pol_app', pol_app);
}
var case_idx;
var ascount;
$(document).ready(function () {
	if (get('pol_app') != null) {
		$('#join_text_li').show();
	}
	var src = './emap.htm';
	if ('${case_idx}' != null && '${case_idx}' != '') {
		$('#open_button').hide();
	}
	if (isEmpty(get('userdata'))) {
	} else {
		$('.display').css('display', '');
		$('.dropdown').css('display', '');
		if (get('pol_app') != null) {
			$("#join_server_li").hide();
		}
		if (window.name != '') {
			case_idx = '${case_idx}';
			var case_content = '${case_content}';
			src += '?case_idx=' + case_idx;
			$("#title").text(case_content);
		}
		$('#iframe').attr('src', src);
	}
	
	$('.closeBtn').click(function () {
	    $('.modal').animate({opacity:"0"}, 300);

		$('.modal').css('z-index', -1);
		
		//$('.modal').attr('class','modal_hide');
	});

	$('.closeBtn2').click(function () {
		$('.modal3').attr('class','modal_hide3');
	});
	$('.downloadBtn').click(function () {
        var rows = $("#grid").jqxGrid('getrows');
        var chk = false;
        var case_name = '';
        
		for (var i = 0; i < rows.length; i++) {
            //var boundindex = $("#grid").jqxGrid('getrowboundindex', i);
            var value = $('#grid').jqxGrid('getcellvalue', i, "available");
            var value2 = $('#grid').jqxGrid('getcellvalue', i, "case_num");
            if (value) {
            	chk = true;
	           // alert(value + " / " + value2 + " / " + i);
            	if (case_name.length == 0) {
            		case_name += value2;
            	} else {
            		case_name += ',' + value2;
            	}
            }
		}
		if (!chk) {
			alert(getTranslate('checkMoreThanOneMustBeChecked'));
		} else {
			//alert(case_name.split(',').length);
			//$('.info_div').text('다운로드 중...');

			$('#downloadBtn').text(getTranslate('downloading'));
			$('#downloadBtn').attr('disabled', true);
			$('#downloadBtn').css('opacity', '0.5');
				
			$('#perTime2').text('0%');
			$('#perTime2').width('0%');
			
			var perTotal = 0;
			var per = parseFloat(100 / case_name.split(',').length);
			
			perTotal += per;
    		var jsonUrl = "/police/imageDownload2";
    		
       		var obj = new Object();
       		obj.caseNum = case_name;
       		
       		var jsonData = obj.caseNum;
       		
       		$.ajax({
       			type : "POST",                        	 	     
       			url : jsonUrl,                      		
       			dataType : "text",                        	  
       			contentType : "application/json; charset=UTF-8",         
       			data : jsonData,          		   
       		    success: function(data) {
      		    	location.href = '/police/webserver/image/' + data + '.zip';
   					
   					/* $('#perTime2').text(parseInt(perTotal) + '%');
   					$('#perTime2').width(parseInt(perTotal) + '%'); */
       		    },
       			error: function(errorThrown) {
       				/* alert(errorThrown.statusText);
       				alert(jsonUrl); */
       			}
       		});
    			
			//$('.info_div').text('다운로드 완료');
		}
	});

	$('.deleteBtn').click(function () {
        var rows = $("#grid").jqxGrid('getrows');
        var chk = false;
        var case_name = '';
        var analyze_content = '';
        
		for (var i = 0; i < rows.length; i++) {
            //var boundindex = $("#grid").jqxGrid('getrowboundindex', i);
            var value = $('#grid').jqxGrid('getcellvalue', i, "available");
            var value2 = $('#grid').jqxGrid('getcellvalue', i, "case_num");
            var value3 = $('#grid').jqxGrid('getcellvalue', i, "analyze_content");
            if (value) {
            	chk = true;
	           // alert(value + " / " + value2 + " / " + i);
            	if (case_name.length == 0) {
            		case_name += value2;
            		analyze_content += value3
            	} else {
            		case_name += ',' + value2;
            		analyze_content += ',' + value3;
            	}
            }
		}
		if (!chk) {
			alert(getTranslate('checkMoreThanOneMustBeChecked'));
		} else {
			//alert("case_name = " + case_name);
			
			if (confirm(getTranslate('questionDelete'))) {
				//$('.info_div').text('삭제 중...');
				
				$('#perTime2').text('0%');
				$('#perTime2').width('0%');
				
	    		var jsonUrl = "/police/deleteCase";
	    		
	    		var obj = new Object();
	    		obj.case_num = case_name;
	    		obj.tagList = analyze_content;
	    		obj.login_id = JSON.parse(get('userdata')).login_id;
	    		obj.analyze_content = '${case_idx}';
	    		
	    		var jsonData = JSON.stringify(obj);
	    		
	    		$.ajax({
	    			type : "POST",                        	 	     
	    			url : jsonUrl,                      		
	    			dataType : "text",                        	  
	    			contentType : "application/json; charset=UTF-8",         
	    			data : jsonData,          		   
	    		    success: function(data) {
	    		    	data = JSON.parse(data);
	    		    	
	    				var source = {
	    					dataType : "json",
	    					localdata: data,
	    					//localdata: array,
	    					datafields: [
	    			        	{ name: 'case_num', type: 'string'},
	    			        	{ name: 'analyze_content', type: 'string'}
	    					]
	    				};
	    					
	    				var dataAdapter = new $.jqx.dataAdapter(source);
	    				
	    				$(".contentDiv4").jqxGrid( {
	    					width: '100%',
	    					//autoheight:true,
	    					height: '400px',
	    					source: dataAdapter,
	    					theme: 'metrodark',
	    					selectionmode: 'singlerow',
	    					//showfilterrow: true,
	    	                sortable: true,
	    	                filterable: true,
	    	                filtermode: 'excel',
	    	                columnsresize: true,
	    	                autoshowfiltericon: true,
	    					editable: true,
	    					columns: [
	    						{ text: getTranslate('idx'), datafield: 'row_num', width: '5%', cellsalign: 'center', editable: false, align: 'center', hidden:true },
	    						{ text: getTranslate('searchContent'), datafield: 'case_num', width: '50%', cellsalign: 'center', editable: false, align: 'center' },
	    						{ text: getTrnaslate('result'), datafield: 'analyze_content', width: '45%', cellsalign: 'center', editable: false, align: 'center' }
	    					]
	    				});
					    $('.modal').animate({opacity:"0"}, 300);

						$('.modal').css('z-index', -1);

	    				$('.modal_hide4').attr('class','modal4');
	    				
	    		    },
	    			error: function(errorThrown) {
	    				/* alert(errorThrown.statusText);
	    				alert(jsonUrl); */
	    			}
	    		});
			}
		}
	});
	 
	var websocketUrl = '/police/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/selectEndCase', function (count) {
		});
		stompClient.subscribe('/endDeleteOne', function (message) {
			if (JSON.parse(get('userdata')).login_id == JSON.parse(message.body).login_id && window.name == JSON.parse(message.body).browserName) {
				var totalLength = JSON.parse(message.body).totalLength;
				var count = JSON.parse(message.body).count;

				var per = parseInt(parseFloat(100 / totalLength) * count);
				
				$('#perTime2').text(per + '%');
				$('#perTime2').width(per + '%');
				if (totalLength == count) {
					//$('.info_div').text('삭제 완료');
				}
			}
		});
		stompClient.subscribe('/downloadOne', function (message) {
			var data = JSON.parse(message.body).caseNum;
			
    		var url = '/police/webserver/image/' + data + '.zip';
    		var a = document.createElement('a');
    		a.href = url;
    		a.click();
    		a.remove();
    		window.URL.revokeObjectURL(url);
		});
	}); 
	
	/* $('.nav-item').click(function () {
		$('.nav-item').find('.active').removeClass('active');
		$(this).addClass("active");
	}); */
	/* $('#logout span').on('click', function () {
		del();
		$(window.location).attr('href', '/police/main.htm');
		//location.reload();
	}); */
	$('.closeBtn3').click(function () {
		$('.modal3').attr('class','modal_hide3');
	});
	$('.closeBtn4').click(function () {
		$('.modal4').attr('class','modal_hide4');
		clickModal();
	});
	
	$('#join_server').click(function () {
		$('#server_userid').val('');
		$('#server_userpw').val('');
		$('#server_login').css('z-index', 100);
		$('#server_login').animate({opacity:"1"}, 300);
		$('#server_userid').focus();
	});
	$(window).click(function(event) {
		if (($(event.target).is('#server_login'))) {
			$('#server_login').css('z-index', -1);
			$('#server_login').animate({opacity:"0"}, 300);
		}
	});
	$('#server_btn').click(function () {
		var obj = new Object();
		obj.app_user_id = $('#server_userid').val();
		obj.app_user_pwd = SHA256($('#server_userpw').val());
		
		var jsonData = JSON.stringify(obj);
		var jsonUrl = "/police/server_login";
		 
		$.ajax({
			type : "POST",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			url : jsonUrl,
			data : jsonData,
			success : function(data) {
				if (data.json == null) {
					alert(getTranslate('wrongIDorPassword'));
					$("#userid").focus();
				} else if (data.json.return == "incorrect") {
					alert(getTranslate('notRegisteredMember'));
					$("#userid").focus();
				} else if (data.json.return == "null") {
					alert(getTranslate('specifyNewPassword'));
				} else if (data.json.return == "success") {
					var jsonObject2 = new Object();
					jsonObject2.app_user_idx = data.app_user_idx;
					jsonObject2.app_user_id = data.app_user_id;
					jsonObject2.app_user_pwd = data.app_user_pwd;
					jsonObject2.app_user_group = data.app_user_group;
					jsonObject2.app_create_time = data.app_create_time;
					jsonObject2.app_delete_time = data.app_delete_time;
					jsonObject2.app_ismain = data.app_ismain;
					//setCookie("pol_app", JSON.stringify(jsonObject2), 1);

					setPol_app(JSON.stringify(jsonObject2));

					$("#join_server_li").hide();
					$('#join_text_li').show();
					
					alert(getTranslate('connectedToTheServer'));
					
					$('#server_login').css('z-index', -1);
					$('#server_login').animate({opacity:"0"}, 300);
				}
			},
			error : function(request, status, error) {
				alert(getTranslate('error'));
			}
		});
	});
	$('.server_user_info').keydown(function(key) {
		if (key.keyCode == 13) {
			$('#server_btn').click();
		}
	});
});
function menuClick(flag) {
	$('#iframe').attr('src', flag);
}
function popupMenu(flag, case_idx) {
	if (flag == 'stitching') {
		if ('${case_idx}' != null && '${case_idx}' != '') {
			var img = new Image();
			var src = '/police/stitching?case_idx=' + '${case_idx}';
			img.onload = function() {
				window.open(src, src, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 0, left = 0, location = no');
			}
			img.onerror = function() {
				alert(getTranslate('needToUploadStitchingImage'));
			}
			img.src = "/police/webserver/image/case" + '${case_idx}' + "/stitching.jpg";
		} else {
			alert(getTranslate('theAnalysisMustProceed'));
		}
	} else if (flag == 'open_stitching') {
		var img = new Image();
		var src = "/police/webserver/image/case" + case_idx + "/stitching.jpg";
		img.onload = function() {
			window.open(src, src, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 0, left = 0, location = no');
		}
		img.onerror = function() {
			alert(getTranslate('needToUploadStitchingImage'));
		}
		img.src = src;
	} else if (flag == 'open_gallery') {
		var url = '/police/gallery.htm';
		if (case_idx != null && case_idx != '') {
			url += '?case_idx=' + case_idx;
		} else {
			case_idx = get('case_idx');
			url += '?case_idx=' + case_idx;
		}

		var window_name = "new";
		if ('${case_idx}' != null && '${case_idx}' != '') {
			window_name = 'gallery_' + case_idx;
		}
		
		window.open(url, window_name, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
	} else {
		window.open(flag, flag, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
	}
}
function loadIframe() {
}
function clickModal() {
	//setModalInfoArr(JSON.stringify(ModalInfoArr));
	//var url = "showImageInfo.htm?tag=" + tag;
	//var url = "/police/main.htm";
	
	//$('#grid').remove();
	//$("#contentDiv").append('<div id="grid"></div>');
	
	//$('.modal_hide').attr('class','modal');
	
   // document.getElementById("theModal").innerHTML='<object type="text/html" data="' + url + '" ></object>';
   
	if (get('userdata') != null) {
		$('#grid').remove();
		$("#contentDiv").append('<div id="grid"></div>');
		var jsonUrl = "/police/selectAllCase";
		
		ascount = 0;
		
		var obj = new Object();
		obj.login_id = JSON.parse(get('userdata')).login_id;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
		    	var SKEY_REQUEST = getTranslate('count');
		    	
		    	for (var i = 0; i < data.length; i++) {
		    		data[i].case_time2 = data[i].case_time.replaceAll("년 ", getTranslate('year'))
		    							.replaceAll("월 ", getTranslate('month'))
		    							.replaceAll("일 ", getTranslate('day'))
		    							.replaceAll("시 ", getTranslate('hour'))
		    							.replaceAll("분 ", getTranslate('minute'))
		    							.replaceAll("초", getTranslate('second'));
		    	}
		    	
				var source = {
					dataType : "json",
					localdata: data,
					datafields: [
			        	{ name: 'row_num', type: 'string'},
			        	{ name: 'case_time', type: 'string'},
			        	{ name: 'case_time2', type: 'string'},
			        	{ name: 'case_content', type: 'string'},
			        	{ name: 'tag_list', type: 'string'},
			        	{ name: 'case_idx', type: 'string'}
					]
				};
					
				var dataAdapter = new $.jqx.dataAdapter(source);
				
				$("#grid").jqxGrid( {
					width: '100%',
					source: dataAdapter,
					//autoheight:true,
					theme: 'metrodark',
					selectionmode: 'singlerow',
					//showfilterrow: true,
	                sortable: true,
	                filterable: true,
	                filtermode: 'excel',
	                columnsresize: true,
	                pageable: true,
	                autoshowfiltericon: true,
					editable: true,
					columns: [
						{
	                     text: '', menu: false, sortable: false,
	                     datafield: 'available', columntype: 'checkbox', width: '3%', align: 'center', 
	                     rendered: function (element) {
	                         $(element).jqxCheckBox({ width:"25px", animationShowDelay: 0, animationHideDelay: 0 });
	                         columnCheckBox = $(element);
	                         $(element).addClass('total');
	                         $(element).on('change', function (event) {
	                             var checked = event.args.checked;
	                           
	                             var rows = $("#grid").jqxGrid('getrows');
	                             
	                             // update cells values.
	                             for (var i = 0; i < rows.length; i++) {
	                                 var boundindex = $("#grid").jqxGrid('getrowboundindex', i);
	                                 $("#grid").jqxGrid('setcellvalue', boundindex, 'available', event.args.checked);
	                             }
	                         });
	                        
	                         return true;
	                     }
	                 },
						{ text: getTranslate('idx'), datafield: 'row_num', width: '5%', cellsalign: 'center', editable: false, align: 'center' },
						{ text: getTranslate('searchDate'), datafield: 'case_time', width: '23%', cellsalign: 'center', editable: false, align: 'center', hidden:true },
						{ text: getTranslate('searchDate'), datafield: 'case_time2', width: '23%', cellsalign: 'center', editable: false, align: 'center' },
						{ text: getTranslate('searchContent'), datafield: 'case_content', width: '22%', cellsalign: 'center', editable: true, align: 'center' },
						{ text: getTranslate('resultsOfAnalysis'), datafield: 'tag_list', width: '23%', editable: false, align: 'center' },
						{ datafield: 'case_idx', editable: false, hidden:true },
						{ text: getTranslate('droneRoute'), columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
							return getTranslate('display');
						},
						buttonclick: function (row) {
							var rowData = $('#grid').jqxGrid('getrowdata', row);
							
							var case_idx = rowData.case_idx;
							
							var open_url = '/police/drone?case_idx=' + case_idx;
							//popupMenu('open_drone', rowData.case_num);
							popupMenu(open_url);
						}},
						{ text: getTranslate('stitching'), columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
							return getTranslate('display');
						},
						buttonclick: function (row) {
							var rowData = $('#grid').jqxGrid('getrowdata', row);
							
							popupMenu('open_stitching', rowData.case_idx);
						}},
						{ text: getTranslate('open'), columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
							return getTranslate('display');
						},
						buttonclick: function (row) {
							var rowData = $('#grid').jqxGrid('getrowdata', row);
							
							var case_idx = rowData.case_idx;
							
							var case_content = rowData.case_content;
							
							var open_url = '/police/main.htm?case_idx=' + case_idx + '&case_content=' + case_content;

							window.open(open_url, case_idx, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
						}},
					]
				});

				$('#grid').on('celldoubleclick', function (event) {
					var args = event.args;
					
					var rowindex = args.rowindex;
					
					var datafield = args.datafield;
					
					if (datafield == 'analyze_content') {
						var value = $('#grid').jqxGrid('getcellvalue', rowindex, "analyze_content");
						$('#caseTitle3').val(value);
						$('.modal_hide3').attr('class','modal3');
						$('.checkBtn3').removeAttr('onclick');
						$('.checkBtn3').attr('onclick', 'updateAnalyze("' + rowindex + '", "' + value + '");');
					}
				});

	         	var ovar;
	            $("#grid").on('cellvaluechanged', function (event) {
		            // event arguments.
		            var args = event.args;
		            // column data field.
		            var datafield = event.args.datafield;
		            // row's bound index.
		            var rowBoundIndex = args.rowindex;
		            // old cell value.
		            var oldvalue = args.oldvalue;
				    var value = args.value;

		            if (ovar != oldvalue) {
		               if (confirm("sure?")) {
		            		var jsonUrl = "/police/updateCase_content";

		            		var obj = new Object();
		            		obj.case_idx = case_idx;
		            		obj.case_content = value;
		            		
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
		               } else {
		                  ovar = value;
		                  $('#grid').jqxGrid('refreshdata');
		                  $("#grid").jqxGrid('setcellvalue', rowBoundIndex, 'case_content', oldvalue);                  
		               }
		            }
	            });
				$('.modal').css('z-index', 100);

				$('.modal').animate({opacity:"1"}, 300);
		    },
			error: function(errorThrown) {
				/* alert(errorThrown.statusText);
				alert(jsonUrl); */
			}
		});
	}
}
function clickBtn() {
    var rowindex = $('#grid').jqxGrid('getselectedrowindex');
    if (rowindex > -1) {
    	var data = $('#grid').jqxGrid('getrowdata', rowindex);
        var url = '/police/main.htm?caseNum=' + data.case_num + '&analyze_content=' + data.analyze_content;
		window.open(url, '' + data.case_num, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
    } else {
    	alert(getTranslate('pleaseSelectARecordToViewAgain'));
    }
}
function updateAnalyze(index, oldValue) {
	var value = $('#caseTitle3').val();
	var data = $('#grid').jqxGrid('getrowdata', index);
	
	var caseNum = data.case_num;
	//alert(index + ' / ' + oldValue + ' / ' + value + " / " + caseNum);
	
	
	if ((value.length > 0) && (oldValue != value) && confirm(getTranslate('questionModification'))) {
		var dataField = 'analyze_content';
		var jsonUrl = "/police/updateAnalyzeContent";
		
		var obj = new Object();
		obj.case_num = caseNum;
		obj.analyze_content = value;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "text",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		   
		    success: function(data) {
				$('.modal3').attr('class','modal_hide3');
				
	    	   /*  $('.modal').animate({opacity:"0"}, 300);

	    		$('.modal').css('z-index', -1); */
	    		
		    		
				$("#grid").jqxGrid('setcellvalue', index, dataField, value);
		    },
			error: function(errorThrown) {
				//alert(errorThrown.statusText);
				//alert(jsonUrl);
			}
		});
	} else {
		$('.modal3').attr('class','modal_hide3');
	}
}
function setCookie(name, value, exp) {
    var date = new Date();
    // ms단위기에 1초로 변환->60초->60분->24시간->최종적으로 day
    date.setTime(date.getTime() + (1000 * 24 * 60 * 60 * exp));
    
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}
function getCookie (name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
}
function deleteCookie (name) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = name + '= ; expires=' + expireDate.toGMTString();
} 
</script>
</head>
<body>
<div class="container-fluid" id="top" style="padding-left:8px; height:5%;">
	<ul id="menu" class="nav nav-tabs" style="height:100%;">
		<li class="nav-item" style="margin-right:20px;">
			<img src="/police/resources/image/Police/Police.png" style="height:90%;" />
		</li>
		<li class="nav-item" style="margin-right:50px;"><div style="position:relative; top:30%; left:0; font-size:14px; color:white">AI-Finder</div></li>
		<!-- <li class="nav-item display active" style="display:none;"><a href="#" style="height:100%;">E-map</a></li> -->	<!--onclick="menuClick('/police/emap.htm')"  -->
		<!-- <li class="dropdown nav-item active" style="display:none;">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false" style="height:100%;">
			E-map
			</a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="clickModal();">Open</a></li>
			</ul>
		</li> -->
		<li class="dropdown nav-item active" style="display:none;">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false" style="height:100%; cursor:pointer;">
				<spring:message code="tab.menu" />
			</a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                <li role="presentation" id="open_button"><a role="menuitem" tabindex="-1" href="#" onclick="clickModal();"><spring:message code="common.open" /> </a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('open_gallery');"><spring:message code="tab.gallery" /></a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('stitching');" id="stitchingMenu"><spring:message code="tab.stitchingView" /></a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('situation_board');" id="situation_board"><spring:message code="tab.analysisSituationBoard" /> </a></li>
                <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('https://canvasjs.com/samples/dashboards/annual-sales/');">Analysis</a></li> -->
			</ul>
		</li>
		<li class="dropdown nav-item" style="display:none;" id="join_server_li">
			<a chref="#" role="button" aria-expanded="false" style="height:100%; cursor:pointer;" id="join_server">
				<spring:message code="tab.connectServer" />
			</a>
		</li>
		<li class="nav-item" style="display:none;" id="join_text_li">
			<a chref="#" role="button" aria-expanded="false" style="height:100%; cursor:pointer;" id="join_text">
				<spring:message  code="tab.serverConnectionComplete" />
			</a>
		</li>
		<li style="width:40%;">
			<div id ="title"></div>
		</li>
		<!-- <li class="nav-item">
			<div id ="logout" style="height:100%; width:100%;"><span style="font-size:30px; display:none; color:#b3b3b3;" class="glyphicon glyphicon-off"></span></div>
		</li> -->
	</ul>
</div>
<div class="container-fluid" style="padding:0; height:92%;">
	<iframe id="iframe" src='/police/login.htm' onload="loadIframe();"></iframe>
</div>
<div class="container-fluid" id="bottom" style="padding:0px 8px 0px 8px; height:3%;">
	<nav class="navbar-right" style="margin:0; color:#b3b3b3; height:100%;">
		<!-- <div style="float:left; margin-right:5px; height:100%;">Powered by</div>
		<div style="float:left; height:100%; padding:0; margin:0;"><img src="/police/resources/image/Police/GY.png" style="padding:0; margin:0;"/></div> -->
	</nav>
</div>
<!-- The Modal -->
<!-- <div class="modal_hide"> -->
<div class="modal">
	<!-- Modal content -->
	<div class="modal-content">
		<div class="closeDiv">
			<button class="button_close closeBtn">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			</button> 
		</div>
		<div class="info_div">
		</div>
		<div id="progress_div" style='display:none;'>
			<div class="progress">
				<div id="perTime2" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" >
				</div>
			</div>
		</div>
		<div id="contentDiv">
			<div id="grid"></div>
		</div>
		<div id="count_delete">
			<div id="case_count"></div>
			<div id="deleteBtnDiv">
				<button class="button_delete deleteBtn">
					<spring:message code="common.delete" />
				</button>
			</div>
		</div>
		<div class="btnDiv">
			<button class="button_check checkBtn" onclick="clickBtn();">
					<spring:message code="common.open" />
			</button>
			<button class="button_download downloadBtn" style="display:none;">
					<spring:message code="common.download" />
			</button>
			<!-- <button class="button_delete deleteBtn">
				삭제
			</button> -->
		</div>
	</div>
</div>
<div id="download_div">
	<a id="download_div_a" download></a>
</div>
<!-- The Modal -->
<div class="modal_hide3">
	<!-- Modal content -->
	<div class="modal-content3">
		<div class="closeDiv2">
			<button class="button_close closeBtn2">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			</button> 
		</div>
		<div class="titleDiv3">
			수색 내용
		</div>
		<div class="contentDiv3">
			<input type="text" id="caseTitle3" />
		</div>
		<div class="btnDiv3">
			<button class="button_check3 checkBtn3">
				<spring:message code="common.modify" />
			</button>
			<button class="button_delete3 closeBtn3">
				<spring:message code="common.cancel" />
			</button>
		</div>
	</div>
</div>
<!-- The Modal -->
<div class="modal_hide4">
	<!-- Modal content -->
	<div class="modal-content4">
		<div class="contentDiv4">
		</div>
		<div class="btnDiv4">
			<button class="button_check4 closeBtn4">
				<spring:message code="common.close" />
			</button>
		</div>
	</div>
</div>
	<div class="container-fluid" id="server_login">
		<div class="container" id="login_box">
			<table id="server_table">
				<tr>
					<td class="server_user_info_text"><spring:message code="common.ID" /></td>
					<td><input type="text" id="server_userid" class="server_user_info"/></td>
					<td rowspan="2" id="td_btn"><input type="button" id="server_btn" value="Login" /></td>
				</tr>
				<tr>
					<td class="server_user_info_text"><spring:message code="common.password" /></td>
					<td><input type="password" id="server_userpw" class="server_user_info"/></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>