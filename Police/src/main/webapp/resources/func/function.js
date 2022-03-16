var mainUrl = 'https://' + window.location.hostname;
var jsonUrl = mainUrl + '/infra/rinfra_json_cmd.do';

var PAGE_TITLE = 'NETUS';
var DEFAULT_LANGUAGE = 'KR';
var SUB_LANGUAGE = 'EN';
var MAIN_LINK_URL = 'http://www.rifatron.com';
var MAIN_IMAGE_OEM = '';
var MAIN_IMAGE_KR = '';
var MAIN_IMAGE_EN = '';

var WEBVIEWER_PATH_VERSION = '/WebExeViewer.exe#version=1,0,0,472';
var RMS_INSTALLER_VERSION = '1.0.0.475';
var RMS_INSTALLER_PATH = '/rms_installer.exe';

var MANAGER_CONTROL_USER = true;
var MANAGER_CONTROL_P2P = false;
var ENABLE_USER_AUTHENTICATION = true;
var ENABLE_P2PUID_REGISTRATION = false;

switch(window.location.hostname)
{
case 'kt-kps.com':
	PAGE_TITLE = 'KT KPS';
	MAIN_LINK_URL = 'http://www.ktcctv.org';
	MAIN_IMAGE_OEM = "KPS";
	WEBVIEWER_PATH_VERSION = '/KPS/WebExeViewer.exe#version=1,0,0,474';
	RMS_INSTALLER_VERSION = '1.0.0.475';
	RMS_INSTALLER_PATH = '/KPS/rms_installer.exe';
	ENABLE_USER_AUTHENTICATION = false;
	break;
case 'cctvm.kr':
	PAGE_TITLE = 'KPS CCTV';
	MAIN_LINK_URL = 'http://www.ktcctv.org';
	MAIN_IMAGE_OEM = "KPS";
	break;
case 'aura.cloudvom.net':
case 'view.acatch.co.kr':
case 'acatch.cctvuser.net':
case 'ats.cctvuser.net':
case 'safeall.cctvuser.net':
case 'bluevision.cctvuser.net':
case 'bns.cctvuser.net':
	switch(window.location.hostname)
	{		
	case 'view.acatch.co.kr':
	case 'acatch.cctvuser.net':
		PAGE_TITLE = 'View Acatch';
		break;
	case 'ats.cctvuser.net':
		PAGE_TITLE = '�щ뙎酉캚Tview';
		break;
	case 'safeall.cctvuser.net':
		PAGE_TITLE = 'SafeAllPRO';
		break;
	case 'bluevision.cctvuser.net':
		PAGE_TITLE = 'BlueVision';
		break;
	case 'bns.cctvuser.net':
		PAGE_TITLE = 'BNS';
		break;
	default:
		PAGE_TITLE = 'Aura Cloud Vom';
		break;
	}
	MAIN_LINK_URL = 'http://www.auracctv.com';
	MAIN_IMAGE_OEM = "AURA";
	MANAGER_CONTROL_USER = false;
	ENABLE_USER_AUTHENTICATION = false;
	//ENABLE_P2PUID_REGISTRATION = true;
	break;
case 'husen.cctvuser.net':
	PAGE_TITLE = 'HUSEN';
	MAIN_LINK_URL = 'http://www.securitysystem.co.kr';
	MAIN_IMAGE_OEM = "HUSEN";
	break;
case 'netus.cctvuser.net':
	DEFAULT_LANGUAGE = 'EN';
	SUB_LANGUAGE = 'KR';
	//ENABLE_P2PUID_REGISTRATION = true;
	MAIN_IMAGE_KR ="_KR"
	break;
case 'netusdemo.cctvuser.net':
	PAGE_TITLE = 'NETUS DEMO';
	DEFAULT_LANGUAGE = 'EN';
	SUB_LANGUAGE = 'JP';
	MAIN_IMAGE_OEM = "DEMO";
	MAIN_LINK_URL = 'https://drive.google.com/open?id=1KOlywWz8qjUtxywlRvkiezZVhVAy9Oucx0CR4qIwSOk';
	//ENABLE_P2PUID_REGISTRATION = true;
	break;
case 'netusdev.cctvuser.net':
	PAGE_TITLE = 'NETUS DEV';
	MAIN_IMAGE_OEM = "DEV";
	//ENABLE_P2PUID_REGISTRATION = true;
	break;
default:
	location.href="/error_page.jsp";
	break;
}

if (typeof(Storage) !== "undefined")
{
	function set(id, pw, level)
	{
		sessionStorage.setItem('userid', id);
		sessionStorage.setItem('userpw', pw);
		sessionStorage.setItem('userlevel', level);
	}

	function setOem(oemno)
	{
		sessionStorage.setItem('oemno', oemno);
	}

	function setUsers(subid)
	{
		sessionStorage.setItem('subid', subid);
	}

	function setProducts(mac, caller)
	{
		sessionStorage.setItem('macadd', mac);
		sessionStorage.setItem('caller', caller);
	}

	function setIssue(maxch, hwver, modelcode)
	{
		sessionStorage.setItem('maxch', maxch);
		sessionStorage.setItem('hwver', hwver);
		sessionStorage.setItem('modelcode', modelcode);
	}

	function setNotice(bodyurl, noticename, btnname, btnurl, noticeno, noticeoem)
	{
		sessionStorage.setItem('bodyurl', bodyurl);
		sessionStorage.setItem('noticename', noticename);
		sessionStorage.setItem('btnname', btnname);
		sessionStorage.setItem('btnurl', btnurl);
		sessionStorage.setItem('noticeno', noticeno);
		sessionStorage.setItem('noticeoem', noticeoem);
	}

	function setMonitoring(searchdate)
	{
		sessionStorage.setItem('searchdate', searchdate);
	}

	function setViewer(devip, devport, devpw, userpolicy)
	{
		sessionStorage.setItem('devip', devip);
		sessionStorage.setItem('devport', devport);
		sessionStorage.setItem('devid', 'admin');
		sessionStorage.setItem('devpw', devpw);
		sessionStorage.setItem('userpolicy', userpolicy);
	}

	function setAsviewer(serverurl, devmac, devpw)
	{
		sessionStorage.setItem('serverurl', serverurl);
		sessionStorage.setItem('devmac', devmac);
		sessionStorage.setItem('devid', 'admin');
		sessionStorage.setItem('devpw', devpw);
	}

	function get(key)
	{
		return sessionStorage.getItem(key);
	}

	function del()
	{
		sessionStorage.clear();
	}
}
else
{
	alert('Sorry! No Web Storage support..');
}

function openWindow(page, pageName, width, height)
{
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=yes, left=' + popupX + ', top=' + popupY);

	return popup_window;
}

function openViewer(viewerPage, viewerName)
{
	window.open('', viewerName, 'width=1308, height=776, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=yes, top=100');
	var form = document.createElement("form");
	form.setAttribute("method", "get");
	form.setAttribute("action", viewerPage);
	form.setAttribute("target", viewerName);
	document.body.appendChild(form);
	form.submit();
}

function getOemMaxP2pCount(oem_no)
{
	switch(oem_no)
	{
	case "55": // CMS VIEW - cmmaster
		return 10;
	default:
		return 0;
	}
}

function setCookie(cookieName, cookieValue)
{
	document.cookie = cookieName + "=" + escape(cookieValue) + "; path=/;";
}

function getCookie(cookieName)
{
	var search = cookieName + "=";
	var cookie = document.cookie;

	// �꾩옱 荑좏궎媛� 議댁옱�� 寃쎌슦
	if(cookie.length > 0)
	{
		// �대떦 荑좏궎紐낆씠 議댁옱�섎뒗吏� 寃��됲븳 �� 議댁옱�섎㈃ �꾩튂瑜� 由ы꽩.
		startIndex = cookie.indexOf(cookieName);

		// 留뚯빟 議댁옱�쒕떎硫�
		if(startIndex != -1)
		{
			// 媛믪쓣 �살뼱�닿린 �꾪빐 �쒖옉 �몃뜳�� 議곗젅
			startIndex += cookieName.length;

			// 媛믪쓣 �살뼱�닿린 �꾪빐 醫낅즺 �몃뜳�� 異붿텧
			endIndex = cookie.indexOf(";", startIndex);

			// 留뚯빟 醫낅즺 �몃뜳�ㅻ� 紐살갼寃� �섎㈃ 荑좏궎 �꾩껜湲몄씠濡� �ㅼ젙
			if(endIndex == -1) endIndex = cookie.length;

			// 荑좏궎媛믪쓣 異붿텧�섏뿬 由ы꽩
			return unescape(cookie.substring(startIndex + 1, endIndex));
		}
		else
		{
			// 荑좏궎 �댁뿉 �대떦 荑좏궎媛� 議댁옱�섏� �딆쓣 寃쎌슦
			switch(cookieName)
			{
			case 'lang':
				setCookie(cookieName, DEFAULT_LANGUAGE);
				return DEFAULT_LANGUAGE;
			default:
				return false;
			}
		}
	}
	else
	{
		// 荑좏궎 �먯껜媛� �놁쓣 寃쎌슦
		switch(cookieName)
		{
		case 'lang':
			setCookie(cookieName, DEFAULT_LANGUAGE);
			return DEFAULT_LANGUAGE;
		default:
			return false;
		}
	}
}

function convertSB(str)
{
	var bytes = [];	
	for(var i=0; i< str.length-1; i+=2)
		bytes.push(parseInt(str.substr(i, 2), 16));
	var binData = String.fromCharCode.apply(String, bytes);
	return btoa(binData);
}

function SHA256(s)
{     
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

function get_me_str(d1, d2, d3, d4)
{
	var str = '';

	d3 = d3.toString();
	d4 = d4.replace(/:/gi, '').toLowerCase();
//	if(d2 != "") d2 = SHA256(d2);

	var d1_l = d1.length < 10?("0" + d1.length):d1.length;
	var d2_l = d2.length < 10?("0" + d2.length):d2.length;
	var d3_l = d3.length < 10?("0" + d3.length):d3.length;
	var d4_l = d4.length < 10?("0" + d4.length):d4.length;
	var str = '' + d1_l + d1 + d2_l + d2 + d3_l + d3 + d4_l + d4;

	return Base64.encode(str);
}

function idCheck(id)
{
	var spa = /[\{\}\[\]\/?.,;:|\)*~`!^\-+��<>@\#$%&\'\"\\\(\=]/gi;
	var cha = /[A-Z]/;
	var kor = /[��-��|��-��|媛�-��]/;

	if(spa.test(id) || cha.test(id) || kor.test(id) || id.length < 4)
		return false;

	return true;
}

function passwordCheck(password)
{
	var spa= /[\{\}\[\]\/?.,;:|\)*~`!^\-+��<>@\#$%&\'\"\\\(\=]/gi;  
	var cha = /[a-z]|[A-Z]/gi;
	var num = /[0-9]/gi;

	if(spa.test(password) && cha.test(password) && num.test(password) && password.length >= 8)
		return true;

	return false;
}

function spaceCheck(str)
{
	if(str.search(/\s/) == -1)
		return true;
	else
		return false;
}

function onlyNumber(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;

	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		return;
	else
		return false;
}

function onlyPlusNumber(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;

	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 16 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 107 || keyID == 187 )
		return;
	else
		return false;
}

function removeChar(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;

	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function removeCharExceptPlus(event)
{
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;

	if ( keyID == 8 || keyID == 16 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 107 || keyID == 187 )
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9\+]/g, "");
}

function expirationDateCheck(date)
{
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0
	var yyyy = today.getFullYear();
	if(dd<10) {dd='0'+dd;} 
	if(mm<10) {mm='0'+mm;}
	today = ''+yyyy+mm+dd;

	if(parseInt(today,10) >= parseInt(date.replace(/-/g,""),10))
		return true;
	else
		return false;
}

function asDateCheck(date)
{
	var today = new Date();
	var ss = today.getSeconds();
	var mi = today.getMinutes();
	var hh = today.getHours();
	var dd = today.getDate()-1;
	var mm = today.getMonth()+1; //January is 0
	var yyyy = today.getFullYear();
	if(ss<10) {ss='0'+ss;}
	if(mi<10) {mi='0'+mi;}
	if(hh<10) {hh='0'+hh;}
	if(dd<10) {dd='0'+dd;}
	if(mm<10) {mm='0'+mm;}
	var yesterday = ''+yyyy+mm+dd+hh+mi+ss;

	if(parseInt(yesterday,10) < parseInt(date.replace(/[-:]|\s/gi,""),10))
		return true;
	else
		return false;
}

function isInternetExplorer()
{
	var agent = navigator.userAgent.toLowerCase();
	if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1))
		return true;
	else
		return false;
}

function getOS()
{
	var userAgent = window.navigator.userAgent;
	var platform = window.navigator.platform;
	var macosPlatforms = ['Macintosh', 'MacIntel', 'MacPPC', 'Mac68K'];
	var windowsPlatforms = ['Win32', 'Win64', 'Windows', 'WinCE'];
	var iosPlatforms = ['iPhone', 'iPad', 'iPod'];
	var os = '';

	if(macosPlatforms.indexOf(platform) !== -1)
	{
		os = 'Mac OS';
	}
	else if(iosPlatforms.indexOf(platform) !== -1)
	{
		os = 'iOS';
	}
	else if(windowsPlatforms.indexOf(platform) !== -1)
	{
		os = 'Windows';
	}
	else if(/Android/.test(userAgent))
	{
		os = 'Android';
	}
	else if(!os && /Linux/.test(platform))
	{
		os = 'Linux';
	}
	else
	{
		os = 'Unknown';
	}

	return os;
}

function is64bitOS()
{
	if(navigator.userAgent.indexOf("WOW64") != -1 || navigator.userAgent.indexOf("Win64") != -1)
		return true;

	return false;
}

function humanReadable(seconds)
{
	var pad = function(x) { return (x < 10) ? "0"+x : x; }
	return pad(parseInt(seconds / (60 * 60))) + ":" +
		   pad(parseInt(seconds / 60 % 60)) + ":" +
		   pad(seconds % 60)
}

function left(str, n)
{
	if(n <= 0)
		return "";
	else if(n > String(str).length)
		return str;
	else
		return String(str).substring(0,n);
}

function right(str, n)
{
	if (n <= 0)
		return "";
    else if (n > String(str).length)
        return str;
    else {
        var iLen = String(str).length;

        return String(str).substring(iLen, iLen - n);
    }
}

function addComma(x)
{
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function menuClick(flag)
{
	$('#iframe').css({ 'margin-top': '80px' });
	$('.iframeContainer').height(783);

	switch (flag)
	{
		case "tab1":
			$('#iframe').attr('src', './user_product.htm');
			break;
		case "tab2":
			$('#iframe').attr('src', './master_main.htm');
			$('#iframe').css({ 'margin-top': '0px' });
			break;
		case "tab3":
			$('#iframe').attr('src', './manager_main.htm');
			break;
		case "tab4":
			$('#iframe').attr('src', './master_manager.htm');
			break;
		case "tab5":
			$('#iframe').attr('src', './manager_user.htm');
			break;
		case "tab6":
			$('#iframe').attr('src', './manager_product.htm');
			break;
		case "tab7":
			$('.iframeContainer').height(1030);
			$('#iframe').attr('src', './manager_notice.htm');
			break;
		case "tab8":
			$('#iframe').attr('src', './master_monitoring.htm');
			break;
		default:
			console.log("Something went wrong!");
	}
}

function isEmpty(str)
{
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		return true;
	else
		return false;
}

function ifEmpty(str, defaultStr)
{
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		str = defaultStr;

	return str;
}

function getNotificationPermission()
{
	if(!("Notification" in window))
		return false;

	Notification.requestPermission(function (result)
	{
		if(result == 'denied')
		{
			alert(SKEY_NOTIFY_DENIED);
			return false;
		}
	});
}

function notifyAS()
{
	if(!("Notification" in window))
		return false;

	var options = {
		body: SKEY_NOTIFY_AS
	}

	var notification = new Notification(PAGE_TITLE, options);

//	setTimeout(function()
//	{
//		notification.close();
//	}, 8000);
}

function getOemName(oem_num)
{
	switch(oem_num)
	{
		case 20:
			return "AURA";
		case 51:
			return "KT";
		case 54:
		case 61:
			return "NETUS";
		case 55:
			return "CM";
		case 56:
			return "ACATCH";
		case 57:
		case 58:
			return "NETUSDEMO";
		case 60:
			return "HUSEN";
		case 62:
			return "NETUSDEV";
		case 63:
			return "NOGUARD";
		case 65:
			return "ATS";
		case 66:
			return "SAFEALL";
		case 67:
			return "BLUEVISION";
		case 68:
			return "BNS";
		default:
			break;
	}
	return "";
}

function getOemString(oem_num)
{
	if(oem_num == 0)
		return SKEY_ALL;
	var oem_str = getOemName(oem_num);
	if(oem_str.length == 0)
		return oem_num + "";
	return oem_num + " - " + oem_str;
}

function getOemString2(oem_num)
{
	if(oem_num == 0)
		return SKEY_ALL;
	var oem_str = getOemName(oem_num);
	if(oem_str.length == 0)
		return oem_num + "";
	return oem_str;
}



String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};