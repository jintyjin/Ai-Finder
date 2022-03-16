<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>폴-파인더</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f03997c9ab3ebbb5b7ec9d5eab20e0e3&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="./resources/css/all.css" />
<link rel="stylesheet" href="./resources/css/timepicki.css" />
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script src="./resources/js/timepicki.js"></script>
<script type="text/javascript" src="./resources/func/exif.js"></script>
<style>
button:focus {
	outline:none;
}
input:focus {
	outline:none;
}
#pol_title {
	text-align:center; 
	font-size:100px; 
	font-weight:bold; 
	font-style:oblique; 
	text-shadow:0px 6px 0px darkblue;
	margin-bottom:50px;
}
#pol_logo {
	text-align:center;
    margin-bottom: 230px;
}
#pol_middle {
	text-align:right;
	font-size:45px;
}
#pol_room {
	position:fixed;
	bottom:140px;
}
#make_room {
	text-align:center;
}
button {
	height:100px;
	background-color:rgb(30, 144, 255);
	border:none;
	border-radius:5px;
	font-size:30px;
}
button:hover {
	color:#404040;
}
#make_button {
	width:100%;
}
#search_room {
	text-align:center;
}
#search_button {
	width:100%;
}
@media (max-width:1224px) {	/* and (orientation:Landscape) 세로 */
	.timepicker_wrap {
		position:fixed;
		top:30%;
		left:30%
	}
	html,body {
		width:100%;
		height:100%;
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		color:white;
		/* background-color:#404040; */
		/* padding-top:80px; */
	}
	
	#pol_main {
		display:none;
	}
	#pol_title {
		text-align:center;
		font-size:40px; 
		font-weight:bold; 
		font-style:oblique; 
		text-shadow:0px 6px 0px darkblue;
		margin-bottom:50px;
		padding-top:10px
	}
	#pol_logo {
		text-align:center;
	    margin-bottom: 30px;
	}
	#pol_logo img {
		height:120px;
	} 
	#pol_middle {
		text-align:right;
		font-size:30px;
	}
	#pol_room {
		position:fixed;
		bottom:20px;
		margin:0;
		margin-left:-1.5%;
	}
	#make_room {
		text-align:center;
	}
	button {
		height:auto;
		background-color:rgb(30, 144, 255);
		border:none;
		border-radius:5px;
		font-size:25px;
	}
	#make_button {
		width:100%;
		height:70px;
	}
	#search_room {
		text-align:center;
	}
	#search_button {
		width:100%;
		height:70px;
	}
	
	/* 방 만들기 클릭 시  */
	#room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:7%;
		font-size:25px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		color:black;
		padding-bottom:10px;
		overflow:auto;
	}
	#room_info_div {
		width:80%;
		height:100%;
	}
	#make-title {
		background-color:#404040;
		padding:0;
		color:white;
		width:100%;
	}
	#make-title .col-xs-11 {
		padding:4px 0 0 20px;
		font-size:25px;
		height:45px;
	}
	#closeBtn {
		background-color:transparent;
		width:100%;
		height:45px;
	}
	#closeBtn span {
		font-size:25px;
	}
	#closeBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#make-content {
		background-color:lightgray;
		padding:15px 0;
		text-align:right;
		width:100%;
		font-size:20px;
		bottom:0;
		overflow:auto;
	}
	input[type="text"], input[type="password"] {
		border-radius:5px;
		width:100%;
		/* height:50px; */
		border:1px solid black;
		padding-left:5px;
		font-size:25px;
	}
	.col-md-12 {
		margin-bottom:10px;
	}
	#room_open {
		margin-bottom:10px;
	}
	#room_open_button:hover {
		color:rgb(30, 144, 255);	
	}
	#room_open_button {
		height:50px;
		background-color:#404040;
		width:100%;
		color:white;
		font-size:25px;
		margin-bottom:0;
	}
	#make-content img {
		height:100px;
	}
	
	/* 방 검색 클릭 시  */
	#search_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:7%;
		font-size:25px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		color:black;
		padding-bottom:10px;
	}
	#search_room_info_div {
		width:80%;
		height:100%;
	}
	#search_title {
		background-color:#404040;
		padding:0;
		color:white;
		width:100%;
		/* height:45px; */
		font-size:25px;
	}
	#search_title .col-xs-11 {
		padding:0 0 0 20px;
		font-size:25px;
		height:auto;
	}
	#closeSearchBtn {
		background-color:transparent;
		height:35px;
	}
	#closeSearchBtn span{
		font-size:25px;
	}
	#closeSearchBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#search_content {
		background-color:lightgray;
		padding:0 0 10px 0;
		text-align:right;
		width:100%;
		font-size:45px;
		height:80%;
		overflow:auto;
	}
	#search_child_div {
		position:sticky;
		width:100%;	/* 783px; */ 
		z-index:2; 
		height:70px; 
		background-color:lightgray;
		top:0;
	}
	#search_name {
		width:100%;
		background:#ffffff;
		border-radius:8px;
		display:flex;
		flex:0 1 50vw;
		margin-top:10px;
	}
	#search_word {
		width:94%;
		background:none;
		border:none;
	}
	#svgDiv {
		width:6%;
		float:right;
		height:50px;
		text-align:center;
		-webkit-writing-mode:vertical-rl;
	}
	#index_div {
		float:left; 
		/* margin-top:70px; */
		width:100%;
	}
	.class_color {
		padding-top:5px; 
		padding-bottom:5px;
	}
	.class_index_div:hover {
		background-color:#f1f3f4;
	}
	.class_index_div {
		text-align:left;
		background-color:white;
		border-radius:8px;
		padding-bottom:10px;
		margin-bottom:0;
	}
	.index_h2 {
		float:left;
		font-size:25px;
		margin-top:25px;
	}
	.index_span {
		font-size:15px;
	}
	.room_user_name {
		font-size:15px;
		float:right;
		margin-top:10px;
	}
	.close_time {
		font-size:initial;
	}
	
	/* 입장하려는 방 클릭 시  */
	#join_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:10%;
		font-size:25px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		color:black;
		padding-bottom:10px;
		overflow:auto;
	}
	#join_room_info_div {
		width:80%;
		height:100%
	}
	#join_title {
		background-color:#404040;
		padding:15px 0 0 0;
		color:white;
		width:100%;
		height:100px;
		font-size:25px;
	}
	#join_title_text {
		margin-bottom:0;
	}
	#join_h1 {
		margin-top:0;
	}
	#join_title_div {
		font-size:large;
	}
	#join_content {
		background-color:lightgray;
		padding:15px;
		text-align:right;
		width:100%;
		font-size:25px;
	}
	.join_content_title {
		text-align-last:left;
		color:#606060;
	}
	.join_content_text {
		height:55px;
		margin-bottom:0;
		float:left;
		font-size:0;
	}
	.join_button {
		background-color:transparent;
		height:auto;
		font-size:20px;
	}
	.join_button:hover {
		/* color:#808080; */
		color:rgb(30, 144, 255);
	}
	#hidden_room_idx {
		display:none;
	}
}
/* @media not screen and (orientation:Portrait) {	
	html, body {
		width:100%;
		height:100%;
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		color:white;
		padding-top:20px;
	}
	#pol_main {
		display:none;
	}
	#pol_title {
		text-align:center; 
		font-size:30px; 
		font-weight:bold; 
		font-style:oblique; 
		text-shadow:0px 6px 0px darkblue;
		margin-bottom:20px;
	}
	#pol_logo {
		text-align:center;
	    margin-bottom:40px;
	}
	#pol_logo img {
		height:70px;
	}
	#pol_middle {
		font-size:15px;
		padding-right:180px;
	}
	#pol_room {
		position:relative;
		bottom:0px;
		width:50%;
		padding-top:40px;
		margin-left:25%;
	}
	button {
		height:50px;
		font-size:20px;
		background-color:rgb(30, 144, 255);
		border:none;
		border-radius:5px;
	}
	#make_button {
		width:100%;
	}
	#search_button {
		width:100%;
	}
	
	//방 만들기 클릭 시
	#room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:10%;
		font-size:30px;
		background-color: rgb(0,0,0); 
		background-color: rgba(0,0,0,0.4); 
		color:black;
	}
	#room_info_div {
		width:80%;
		height:90%;
	}
	#make-title {
		background-color:#404040;
		padding: 5px 0;
		color:white;
		width:100%;
		font-size:20px;
		height:35px;
	}
	#closeBtn {
		background-color:transparent;
		width:100%;
		height:20px;
	}
	#closeBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#make-content {
		background-color:lightgray;
		padding:10px 0;
		padding-bottom:5px;
		text-align:right;
		width:100%;
		font-size:20px;
		bottom:0;
	}
	input[type="text"], input[type="password"] {
		border-radius:5px;
		width:100%;
		height:25px;
		border:1px solid black;
		padding-left:5px;
		font-size:20px;
	}
	.col-md-12 {
		margin-bottom:10px;
	}
	#room_open {
		text-align:center;
	}
	#room_open_button:hover {
		color:rgb(30, 144, 255);	
	}
	#room_open_button {
		height:30px;
		background-color:#404040;
		width:15%;
		color:white;
		font-size:20px;
	}
	#make-content img {
		height:50px;
	}
	
	//방 검색 클릭 시
	#search_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:20px;
		font-size:30px;
		background-color: rgb(0,0,0); 
		background-color: rgba(0,0,0,0.4); 
		color:black;
	}
	#search_room_info_div {
		width:90%;
		height:90%;
	}
	#search_title {
		background-color:#404040;
		padding:5px 0 0 0;
		color:white;
		width:100%;
		height:40px;
		font-size:20px;
	}
	#closeSearchBtn {
		background-color:transparent;
		height:20px;
	}
	#closeSearchBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#search_content {
		background-color:lightgray;
		padding:0 0 10px 0;
		text-align:right;
		width:100%;
		font-size:20px;
		height:90%;
		overflow:auto;
	}
	#search_child_div {
		position:sticky;
		width:100%;	
		z-index:2; 
		background-color:lightgray;
		top:0;
		padding-bottom:10px;
	}
	#search_name {
		width:100%;
		background:#ffffff;
		border-radius:8px;
		display:flex;
		flex:0 1 20vw;
		margin-top:10px;
	}
	#search_word {
		width:94%;
		background:none;
		border:none;
		height:40px;
	}
	#svgDiv {
		width:6%;
		float:right;
		height:40px;
		text-align:center;
		-webkit-writing-mode:vertical-rl;
	}
	#index_div {
		float:left; 
		width:100%;
	}
	.class_color {
		padding-top:5px; 
		padding-bottom:5px;
	}
	.class_index_div:hover {
		background-color:#f1f3f4;
	}
	.class_index_div {
		text-align:left;
		background-color:white;
		border-radius:8px;
		padding-bottom:10px;
		margin-bottom:0;
	}
	.index_h2 {
		font-size:15px;
		float:left;
		padding-right:5px;
	}
	.index_span {
		font-size:10px;
	}
	.room_user_name {
		font-size:10px;
		float:right;
		margin-top:10px;
	}
	.close_time {
		float:none;
		font-size:10px;
	}
	
	//입장하려는 방 클릭 시
	#join_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:20px;
		font-size:30px;
		background-color: rgb(0,0,0);
		background-color: rgba(0,0,0,0.4); 
		color:black;
	}
	#join_room_info_div {
		width:60%;
		height:90%;
		padding-bottom:30px;
	}
	#join_title {
		background-color:#404040;
		padding:5px 0 5px 0;
		color:white;
		width:100%;
		height:auto;
		font-size:20px;
	}
	#join_title_text {
		margin-bottom:0;
	}
	#join_h1 {
		margin-top:0;
		font-size:20px;
	}
	#join_title_div {
		font-size:16px;
	}
	#join_content {
		background-color:lightgray;
		padding:5 10 5 10px;
		text-align:right;
		width:100%;
		font-size:45px;
		height:auto;
	}
	.join_content_title {
		text-align-last:left;
		color:#606060;
		font-size:20px;
	}
	.join_content_text {
		height:auto;
		margin-bottom:0;
		float:left;
		font-size:20px;
	}
	#join_text {
		padding:20px 2px 20px 5px;
	}
	#join_pwd {
		padding:20px 2px 20px 5px;
	}
	.join_button {
		background-color:transparent;
	}
	.join_button:hover {
		color:rgb(30, 144, 255);
	}
	#hidden_room_idx {
		display:none;
	}
} */
@media only screen and (min-width:1224px) {	/* min-width:992px  */
	.timepicker_wrap {
		top:60px;
		left:0px;
	}
	.arrow_top {
		background: url(./resources/images/top_arr.png) no-repeat;
	}
	html,body {
		width:100%;
		height:100%;
		font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
		font-size:14px;
		color:white;
		/* background-color:#404040; */
		padding-top:80px;
	}
	#pol_main {
		display:none;
	}
	.container-fluid {
		width:1200px;
	}
	#make-title {
		background-color:#404040;
		padding: 10px 0;
		color:white;
		width:100%;
		font-size:45px;
		height:84px;
	}
	#pol_title {
		text-align:center;
		font-size:40px; 
		font-weight:bold; 
		font-style:oblique; 
		text-shadow:0px 6px 0px darkblue;
		margin-bottom:50px;
		padding-top:10px
	}
	#pol_logo {
		text-align:center;
	    margin-bottom: 160px;
	}
	#pol_logo img {
		height:180px;
	}
	#pol_middle {
		font-size:30px;
		padding-right:100px;
	}
	#pol_room {
		position:relative;
		bottom:0px;
		padding-top:250px;
		width:100%;
		margin:0;
	}
	button {
		height:100px;
		background-color:rgb(30, 144, 255);
		border:none;
		border-radius:5px;
		font-size:30px;
	}
	#make_button {
		width:50%;
		padding-right: 14px;
		height:80px;
	}
	#search_button {
		width:50%;
		height:80px;
	}
	
	/* 방 만들기 클릭 시 */
	#room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:280px;
		font-size:30px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		color:black;
	}
	#room_info_div {
		width:600px;
	}
	#make-title {
		background-color:#404040;
		padding:10px 0;
		color:white;
		width:600px;
	}
	#closeBtn {
		background-color:transparent;
		height:35px;
	}
	#closeBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#make-content {
		background-color:lightgray;
		padding:15px 0;
		text-align:right;
		width:600px;
		font-size:45px;
	}
	input[type="text"], input[type="password"] {
		border-radius:5px;
		width:100%;
		height:50px;
		border:1px solid black;
		font-size:20px;
		padding-left:5px;
	}
	.col-md-12 {
		margin-bottom:10px;
	}
	#room_open {
		margin-bottom:30px;
	}
	#room_open_button:hover {
		color:rgb(30, 144, 255);	
	}
	#room_open_button {
		height:50px;
		background-color:#404040;
		width:100%;
		color:white;
		font-size:20px;
	}
	#make-content img {
		height:100px;
	}
	
	/* 방 검색 클릭 시  */
	#search_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:280px;
		font-size:30px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		color:black;
	}
	#search_room_info_div {
		width:1000px;
	}
	#search_title {
		background-color:#404040;
		padding:10px 0;
		color:white;
		width:800px;
		height:84px;
		font-size:45px;
	}
	#closeSearchBtn {
		background-color:transparent;
		height:35px;
	}
	#closeSearchBtn:hover {
		color:rgb(30, 144, 255);	
	}
	#search_content {
		background-color:lightgray;
		padding:0 0 10px 0;
		text-align:right;
		width:800px;
		font-size:45px;
		height:750px;
		overflow:auto;
	}
	#search_child_div {
		position:sticky;
		width:100%;	/* 783px; */ 
		z-index:2; 
		height:70px; 
		background-color:lightgray;
		top:0;
		padding-bottom:0px;
	}
	#search_name {
		width:100%;
		background:#ffffff;
		border-radius:8px;
		display:flex;
		flex:0 1 50vw;
		margin-top:10px;
	}
	#search_word {
		width:94%;
		background:none;
		border:none;
		height:auto;
	}
	#svgDiv {
		width:6%;
		float:right;
		height:50px;
		text-align:center;
		-webkit-writing-mode:vertical-rl;
	}
	#index_div {
		float:left; 
		/* margin-top:70px; */
		width:100%;
	}
	.class_color {
		padding-top:5px; 
		padding-bottom:5px;
	}
	.class_index_div:hover {
		background-color:#f1f3f4;
	}
	.class_index_div {
		text-align:left;
		background-color:white;
		border-radius:8px;
		padding-bottom:10px;
		margin-bottom:0;
	}
	.index_h2 {
		float:left;
		font-size:30px;
		padding:0;
	}
	.index_span {
		font-size:20px;
	}
	.room_user_name {
		font-size:20px;
		float:right;
		margin-top:10px;
	}
	.close_time {
		font-size:large;
	}
	
	/* 입장하려는 방 클릭 시  */
	#join_room_info {
		position:fixed;
		width:100%;
		height:100%;
		display:none;
		z-index:100;
		left: 0;
		top: 0;
		padding-top:280px;
		font-size:30px;
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.8); /* Black w/ opacity */
		color:black;
	}
	#join_room_info_div {
		width:600px;
		height:100%;
		padding:0;
	}
	#join_title {
		background-color:#404040;
		padding:15px 0 0 0;
		color:white;
		width:600px;
		height:100px;
		font-size:45px;
	}
	#join_title_text {
		margin-bottom:0;
	}
	#join_h1 {
		margin-top:0;
		font-size:36px;
	}
	#join_title_div {
		font-size:large;
	}
	#join_content {
		background-color:lightgray;
		padding:15px;
		text-align:right;
		width:600px;
		font-size:45px;
		height:auto;
	}
	.join_content_title {
		text-align-last:left;
		color:#606060;
		font-size:24px;
	}
	.join_content_text {
		height:55px;
		margin-bottom:0;
		float:left;
		font-size:0;
	}
	#join_text {
		padding:1px 2px 1px 5px;
	}
	#join_pwd {
		padding:1px 2px 1px 5px;
	}
	.join_button {
		background-color:transparent;
	}
	.join_button:hover {
		/* color:#808080; */
		color:rgb(30, 144, 255);
	}
	#hidden_room_idx {
		display:none;
	}
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
$(document).ready(function () {
	$('html').css('height', window.innerHiehgt);
	$('#make_button').click(function () {
		$('body').css("overflow", "hidden");
		$('#room_name').val('');
		$('#user_name').val('');
		$('#room_pwd').val('');
		$('#room_pwd2').val('');
		$('#room_close_date').val('');
		$('#room_info').toggle();
		$('#room_name').focus();
	});
	$('#closeBtn').click(function () {
		$('#room_info').toggle();
		$('body').css("overflow", "auto");
	});
	$('#search_button').click(function () {
		$('#search_word').val('');
		$('body').css("overflow", "hidden");
		$('#search_room_info').toggle();

		var jsonObject = new Object();
		jsonObject.app_user_group = JSON.parse(getCookie('pol_app')).app_user_group;
		
		var jsonData = JSON.stringify(jsonObject);
		
		var jsonUrl = "/police/pol_getRoom";

		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
	        async: false,
			success: function (data) {
			    $("#index_div").empty();
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var appendStr = '<div class="col-xs-12 col-md-12 class_color"><div class="col-xs-12 col-md-12 class_index_div"' 
						 + 'onclick="show_join(' + data[i].room_idx + ', ' + "'" + data[i].room_name + "'" + ', ' + "'" + data[i].room_user_name + "'" + ');">'
						 + '<h2 class="index_h2">' + data[i].room_name + '</h2><span class="index_span">&nbsp;&nbsp;' + data[i].room_count + '명</span>'
						 + '<div class="room_user_name">' + data[i].room_user_name + '</div><div class="close_time" id="close_time">폐쇄시간 ' + data[i].room_close_date + '</div></div></div>';
						$('#index_div').append(appendStr);
					}
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	});
	$('#closeSearchBtn').click(function () {
		$('body').css("overflow", "auto");
		$('#search_room_info').toggle();
	});
	$('#pol_title').click(function () {
		var jsonUrl = "/police/pol_post";

		var jsonObject = new Object();
		jsonObject.room_name = 'room1';
		jsonObject.room_user_name = '테스트1';
		jsonObject.room_pwd = '123456';
		jsonObject.La = '37.47793679991258'
		jsonObject.Ma = '126.88064820005795';
		jsonObject.duration = 10;
		jsonObject.limitedTime = 10;
		
		var jsonData = JSON.stringify(jsonObject);
		
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
	});
		
	$('#svgDiv').click(function () {
		var jsonUrl = "/police/pol_searchRoom";

		var jsonObject = new Object();

		jsonObject.keyword = $('#search_word').val();
		
		var jsonData = JSON.stringify(jsonObject);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",         
			data : jsonData,          		
	        async: false,
			success: function (data) {
				$('.class_color').remove();
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var appendStr = '<div class="col-xs-12 col-md-12 class_color"><div class="col-xs-12 col-md-12 class_index_div"' 
						 + 'onclick="show_join(' + data[i].room_idx + ', ' + "'" + data[i].room_name + "'" + ', ' + "'" + data[i].room_user_name + "'" + ');">'
						 + '<h2 class="index_h2">' + data[i].room_name + '</h2><span class="index_span">&nbsp;&nbsp;' + data[i].room_count + '명</span>'
						 + '<div class="room_user_name">' + data[i].room_user_name + '</div><div class="close_time">폐쇄시간 ' + data[i].room_close_date + '</div></div></div>';
						$('#index_div').append(appendStr);
					}
				} else {
					alert('조건에 맞는 방이 없습니다.');
				}
			}, error: function(errorThrown) {
				//alert(errorThrown.statusText);
			}
		}); 
	});
	$('input').keyup(function(e) {
		if (e.keyCode == 13) {
			if ($('#room_info').css('display') == 'none' &&  $('#join_room_info').css('display') == 'none' && $('#search_room_info').css('display') != 'none') {
				$('#svgDiv').click();
			} else if ($('#join_room_info').css('display') != 'none') { 
				$('#join_join').click();
			} else {
				$("#room_open_button").click();
			}
		}
	});
    $(".time_element").timepicki({
		show_meridian:false,
		min_hour_value:0,
		max_hour_value:23,
		overflow_minutes:true,
		increase_direction:'up'
    });
    //window.addEventListener("deviceorientation", handleOrientation, true);
});
//$("#room_limited_time").picktim();
function handleOrientation(event) {
	  var alpha = event.alpha;
	  alert(alpha);
}
function chk_info() {
	
	//alert('locPosition = ' + locPosition.Ma + "," + locPosition.La);
	
	var room_name = $('#room_name').val();		// 10글자
	var user_name = $('#user_name').val();		// 5글자
	var room_pwd = $('#room_pwd').val();		// 6자리
	var room_pwd2 = $('#room_pwd2').val();		// 6자리 및 확인
	var room_close_date = $('#room_close_date').val();
	
	var isTrue = true;
	
	if (room_name.length == 0) {
		alert('방 이름을 입력해야 합니다.');
		$('#room_name').focus();
		return false;
	}
	
	if (room_name.length > 20) {
		alert('방 이름이 20글자가 넘습니다.');
		$('#room_name').focus();
		return false;
	}
	
	if (user_name.length == 0) {
		alert('대화명을 입력해야 합니다.');
		$('#user_name').focus();
		return false;
	}
	
	var isFirstNumber = false;
	if (user_name[0] >= 0 && user_name[0] <= 9) {
		isFirstNumber = true;
	}
	
	if (isFirstNumber) {
		alert('대화명의 첫 글자는 숫자가 될 수 없습니다.');
		return false;
	}
	
	var isNumber = true;
	for (var i = 0; i < user_name.length; i++) {
		if (!(user_name[i] >= 0 && user_name[i] <= 9)) {
			isNumber = false;
			break;
		}
	}
	
	if (isNumber) {
		alert('대화명에 숫자만 들어갈 수 없습니다.');
		$('#user_name').focus();
		return false;
	}
	
	var isSpace = false;
	for (var i = 0; i < user_name.length; i++) {
		if (user_name[i] == ' ') {
			isSpace = true;
			break;
		}
	}
	
	if (isSpace) {
		alert('대화명에 띄어쓰기가 들어갈 수 없습니다.');
		$('#join_text').focus();
		return false;
	}
	
	var isUnderBar = false;
	for (var i = 0; i < user_name.length; i++) {
		if (user_name[i] == '_') {
			isUnderBar = true;
			break;
		}
	}
	
	if (isUnderBar) {
		alert('대화명에 언더바가 들어갈 수 없습니다.');
		$('#join_text').focus();
		return false;
	}
	
	if (user_name.length > 20) {
		alert('대화명이 20글자가 넘습니다.');
		$('#user_name').focus();
		return false;
	}
	
	if (room_pwd.length == 0) {
		alert('비밀번호를 입력해야 합니다.');
		$('#room_pwd').focus();
		return false;
	}
	
	if (room_pwd.length != 6) {
		alert('비밀번호는 6자리를 입력하여야합니다.');
		$('#room_pwd').focus();
		return false;
	}
	
	if (room_pwd != room_pwd2) {
		alert('비밀번호가 일치하지 않습니다.');
		$('#room_pwd2').focus();
		return false;
	}
	
	if (room_pwd.length != 6) {
		alert('비밀번호는 6자리를 입력하여야합니다.');
		$('#room_pwd').focus();
		return false;
	}
	
	if (room_close_date.length == 0) {
		alert('폐쇄시간을 지정해야 합니다.');
		return false;
	}
	
	var d = new Date()
	
	if (room_close_date.split(':')[0] < d.getHours()) {
		alert('폐쇄시간이 현재보다 빠를 수는 없습니다.');
		return false;
	} else if (room_close_date.split(':')[0] == d.getHours()) {
		if (room_close_date.split(':')[1] <= d.getMinutes()) {
			alert('폐쇄시간이 현재보다 빠를 수는 없습니다.');
			return false;
		}
	}
	
	var jsonUrl = "/police/pol_createRoom";
	var jsonObject = new Object();
	jsonObject.room_name = room_name;
	jsonObject.room_user_name = user_name;
	jsonObject.room_pwd = SHA256(room_pwd);
	jsonObject.room_close_date = room_close_date;
	
	if (!isTrue) {
		return false;
	}
	
	var jsonData = JSON.stringify(jsonObject);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
	       async: true,
		success: function (data) {
			if (data.count == -1) {
				alert('이미 만들어진 방 이름입니다.');
				$('#room_name').focus();
				isTrue = false;
			} else {
				jsonUrl = "/police/pol_insertRoomUser";
				var jsonObject2 = new Object();
				jsonObject2.room_user_name = user_name;
				jsonObject2.room_pwd = SHA256(room_pwd);
				jsonObject2.room_name = room_name;
				jsonObject2.room_isadmin = 'Y';
				
				jsonObject2.room_gps = '';
				jsonObject2.room_recent_gps = '';
				
				jsonObject2.room_user_idx = data.count;
				if (status == kakao.maps.services.Status.OK) {
					console.log(result[0].address.address_name);
					jsonObject2.room_address = result[0].address.address_name;
				}
	
				var jsonData = JSON.stringify(jsonObject2);
				
				$.ajax({
					type : "POST",                        	 	     
					url : jsonUrl,                      		
					dataType : "json",                        	  
					contentType : "application/json; charset=UTF-8",         
					data : jsonData,          		
			        async: true,
					success: function (data) {
						if (data.count == 0) {
							alert('존재하지 않는 방입니다.');
							isTrue = false;
						} else {
							jsonObject2.hidden_room_idx = jsonObject2.room_user_idx;
							jsonObject2.room_close_date = room_close_date;
							var room_create_date = new Date();
							var room_date = room_create_date.getFullYear() + ":" + (room_create_date.getMonth() + 1) + ":" + room_create_date.getDate()
							var room_time = room_create_date.getHours() + ":" + room_create_date.getMinutes() + ":" + room_create_date.getSeconds();
							jsonObject2.room_create_date = room_date + " " + room_time;
							
							//jsonObject2.room_close_date = data.room_close_date;
							setCookie("pol_room", JSON.stringify(jsonObject2), 1);
	
							location.replace('pol_map');
							//location.href = 'pol_map?room_name=' + jsonObject2.room_name + '&room_user_name=' + jsonObject2.room_user_name;
						}
					}, error: function(errorThrown) {
						//alert(errorThrown.statusText);
					}
				}); 
				
			}
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	}); 
	
	if (!isTrue) {
		return false;
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
function chkCookie() {
	if (getCookie('pol_app') == null) {
		location.replace('pol_login');
	} else if (getCookie('pol_room') != null) {
		location.replace('pol_map');
		//location.replace('pol_map?room_name=' + JSON.parse(getCookie('pol_room')).room_name + '&room_user_name=' + JSON.parse(getCookie('pol_room')).room_user_name);
	} else {
		$("body").css("background-color","#404040");
		$('#pol_main').show();
	}
}
function show_join(idx, room_name, user_name) {
	$('#hidden_room_idx').text(idx);
	$('#search_content').css("overflow", "hidden");
	$('#join_h1').text(room_name);
	$('#join_title_div').text(user_name);
	$('#join_room_info').toggle();
	$('#join_text').val('');
	$('#join_pwd').val('');
	$('#join_text').focus();
}
function hide_join() {
	$('#search_content').css("overflow", "auto");
	$('#join_room_info').toggle();
}
function chk_join() {
	//alert('locPosition = ' + locPosition.Ma + "," + locPosition.La);
	
	var user_name = $('#join_text').val();		// 5글자
	var room_pwd = $('#join_pwd').val();		// 6자리
	var room_name = $("#join_h1").text();
	
	var isTrue = true;
	
	if (user_name.length == 0) {
		alert('대화명을 입력해야 합니다.');
		$('#join_text').focus();
		return false;
	}
	
	var isFirstNumber = false;
	if (user_name[0] >= 0 && user_name[0] <= 9) {
		isFirstNumber = true;
	}
	
	if (isFirstNumber) {
		alert('대화명의 첫 글자는 숫자가 될 수 없습니다.');
		return false;
	}
	
	var isNumber = true;
	for (var i = 0; i < user_name.length; i++) {
		if (!(user_name[i] >= 0 && user_name[i] <= 9)) {
			isNumber = false;
			break;
		}
	}
	
	if (isNumber) {
		alert('대화명에 숫자만 들어갈 수 없습니다.');
		$('#join_text').focus();
		return false;
	}
	
	var isSpace = false;
	for (var i = 0; i < user_name.length; i++) {
		if (user_name[i] == ' ') {
			isSpace = true;
			break;
		}
	}
	
	if (isSpace) {
		alert('대화명에 띄어쓰기가 들어갈 수 없습니다.');
		$('#join_text').focus();
		return false;
	}
	
	var isUnderBar = false;
	for (var i = 0; i < user_name.length; i++) {
		if (user_name[i] == '_') {
			isUnderBar = true;
			break;
		}
	}
	
	if (isUnderBar) {
		alert('대화명에 언더바가 들어갈 수 없습니다.');
		$('#join_text').focus();
		return false;
	}
	
	if (user_name.length > 20) {
		alert('대화명이 20글자가 넘습니다.');
		$('#join_text').focus();
		return false;
	}
	
	if (room_pwd.length == 0) {
		alert('비밀번호를 입력해야 합니다.');
		$('#join_pwd').focus();
		return false;
	}
	
	if (room_pwd.length != 6) {
		alert('비밀번호는 6자리를 입력하여야합니다.');
		$('#join_pwd').focus();
		return false;
	}
	
	var jsonUrl = "/police/pol_chkLogin";
	var jsonObject2 = new Object();
	
	jsonObject2.room_user_name = user_name;
	jsonObject2.room_pwd = SHA256(room_pwd);
	jsonObject2.room_name = room_name;
	jsonObject2.room_isadmin = 'N';
	jsonObject2.room_gps = '';
	jsonObject2.room_recent_gps = '';
	jsonObject2.room_user_idx = $('#hidden_room_idx').text();
	
	var jsonData = JSON.stringify(jsonObject2);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		
	       async: false,
		success: function (data) {
			if (data.count == 0) {
				alert('존재하지 않는 방입니다.');
				hide_join();
				$('#closeSearchBtn').click
				isTrue = false;
			} else if (data.count == 1) {
				alert('비밀번호가 틀립니다.');
				$('#join_pwd').focus();
				isTrue = false;
			} else if (data.count == 'already') {
				alert('이미 접속중입니다. 다른 아이디를 만드세요.');
				isTrue = false;
			} else {
				jsonUrl = "/police/pol_insertRoomUser";
				jsonObject2 = new Object();
				
				jsonObject2.room_user_name = user_name;
				jsonObject2.room_pwd = SHA256(room_pwd);
				jsonObject2.room_name = room_name;
				jsonObject2.room_isadmin = 'N';
				jsonObject2.room_gps = '';
				jsonObject2.room_recent_gps = '';
				jsonObject2.room_user_idx = $('#hidden_room_idx').text();
				if (status == kakao.maps.services.Status.OK) {
					jsonObject2.room_address = result[0].address.address_name;
				}
				var jsonData = JSON.stringify(jsonObject2);
	
				$.ajax({
					type : "POST",                        	 	     
					url : jsonUrl,                      		
					dataType : "json",                        	  
					contentType : "application/json; charset=UTF-8",         
					data : jsonData,          		
			        async: false,
					success: function (data) {
						if (data.count == 0) {
							alert('존재하지 않는 방입니다.');
							hide_join();
							$('#closeSearchBtn').click
							isTrue = false;
						} else if (data.count == 1) {
							alert('비밀번호가 틀립니다.');
							$('#join_pwd').focus();
							isTrue = false;
						} else {
							jsonObject2.hidden_room_idx = jsonObject2.room_user_idx;
							jsonObject2.room_close_date = room_close_date;
							var room_create_date = new Date($('#close_time').text().split(' ')[0]);
							var room_date = room_create_date.getFullYear() + ":" + (room_create_date.getMonth() + 1) + ":" + room_create_date.getDate()
							var room_time = room_create_date.getHours() + ":" + room_create_date.getMinutes() + ":" + room_create_date.getSeconds();
							jsonObject2.room_create_date = room_date + " " + room_time;
							
							//jsonObject2.room_close_date = data.room_close_date;
							setCookie("pol_room", JSON.stringify(jsonObject2), 1);
	
							location.replace('pol_map');
							//location.href = 'pol_map?room_name=' + jsonObject2.room_name + '&room_user_name=' + jsonObject2.room_user_name;
						}
					}, error: function(errorThrown) {
						//alert(errorThrown.statusText);
					}
				}); 
			}
		}, error: function(errorThrown) {
			//alert(errorThrown.statusText);
		}
	}); 
	
	if (isTrue) {
		jsonObject2.hidden_room_idx = $('#hidden_room_idx').text();
		jsonObject2.room_close_date = $('#close_time').text().split(' ')[2].split(':')[0] + ":" + $('#close_time').text().split(' ')[2].split(':')[1];
		var room_create_date = new Date();
		var room_date = room_create_date.getFullYear() + "-" + (room_create_date.getMonth() + 1) + "-" + room_create_date.getDate()
		var room_time = room_create_date.getHours() + ":" + room_create_date.getMinutes() + ":" + room_create_date.getSeconds();
		jsonObject2.room_create_date = room_date + " " + room_time;
		setCookie("pol_room", JSON.stringify(jsonObject2), 1);
	
		location.replace('pol_map');
		//location.replace('pol_map?room_name=' + JSON.parse(getCookie('pol_room')).room_name + '&room_user_name=' + JSON.parse(getCookie('pol_room')).room_user_name);
	}
}
//setCookie("room1_poldrone", getCookie('room1_poldrone'), -1);
</script>
</head>
<body onload="chkCookie();">
	<div class="container-fluid" id="pol_main">
		<div class="col-xs-12 col-md-12" id="pol_title">폴 - 파 인 더</div>
		<div class="col-xs-12 col-md-12" id="pol_logo">
			<img src="/police/resources/image/Police/Police2.png" height="240px;" />
		</div>
		<div class="col-xs-12 col-md-12" id="pol_middle">
			팀원의 위치공유로<br>효율적인 업무수행
		</div>
		<div class="col-xs-12 col-md-12" id="pol_room">
			<div class="col-xs-6 col-md-6" id="make_room">
				<button id="make_button">방 만들기</button>
			</div>
			<div class="col-xs-6 col-md-6" id="search_room">
				<button id="search_button">방 검색</button>
			</div>
		</div>
	</div>
	<div id="room_info">
		<div id="room_info_div" class="container-fluid">
			<div id="make-title" class="container-fluid">
				<div class="col-xs-1 col-md-1">
					<button id="closeBtn">
						<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
					</button>
				</div>
				<div class="col-xs-11 col-md-11">방 만들기
				</div>
			</div>
			<div id="make-content" class="container-fluid">
				<div class="col-xs-12 col-md-12">
					<input type="text" id="room_name" placeholder="방이름(최대 20글자)" maxlength='20' />
				</div>
				<div class="col-xs-12 col-md-12">
					<input type="text" id="user_name" placeholder="대화명(최대 20글자)" maxlength='20' />
				</div>
				<div class="col-xs-12 col-md-12">
					<input type="password" id="room_pwd" placeholder="비밀번호(6자리)" maxlength='6'/>
				</div>
				<div class="col-xs-12 col-md-12">
					<input type="password" id="room_pwd2" placeholder="비밀번호 확인" />
				</div>
				<div class="col-xs-12 col-md-12" id="room_limited_time">
					<input type="text" placeholder="폐쇄시간" name="timepicker" class="time_element" id="room_close_date" />
				</div>
				<div class="col-xs-12 col-md-12" id="room_open">
					<button id="room_open_button" onclick="chk_info();">개설</button>
				</div>
				<!-- <div class="col-xs-12 col-md-12" id="room_logo">
					<img src="/police/resources/image/Police/Police2.png" />
				</div> -->
			</div>
		</div>
	</div>
	<div id="search_room_info">
		<div id="search_room_info_div" class="container-fluid">
			<div id="search_title" class="container-fluid">
				<div class="col-xs-1 col-md-1">
					<button id="closeSearchBtn">
						<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
					</button>
				</div>
				<div class="col-xs-11 col-md-11">방 검색
				</div>
			</div>
			<div id="search_content" class="container-fluid">
				<div class="col-xs-12 col-md-12" id="search_child_div">
					<div id="search_name">
						<input type="text" id="search_word" placeholder="방이름" maxlength='10' />
						<div id="svgDiv">
							<svg width="24px" height="24px">
								<path d="M20.49 19l-5.73-5.73C15.53 12.2 16 10.91 16 9.5A6.5 6.5 0 1 0 9.5 16c1.41 0 2.7-.47 3.77-1.24L19 20.49 20.49 19zM5 9.5C5 7.01 7.01 5 9.5 5S14 7.01 14 9.5 11.99 14 9.5 14 5 11.99 5 9.5z"></path>
							</svg>
						</div>
					</div>
				</div>
				<div id="index_div">
				</div>
			</div>
		</div>
	</div>
	<div id="join_room_info">
		<div id="join_room_info_div" class="container-fluid">
			<div id="join_title" class="container-fluid">
				<div class="col-xs-12 col-sm-12 col-md-12" id="join_title_text">
					<h1 id="join_h1"></h1>
					<div id="join_title_div"></div>
				</div>
			</div>
			<div id="join_content" class="container-fluid">
				<div class="col-xs-12 col-sm-12 col-md-12">
					<h3 class="join_content_title">대화명</h3>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 join_content_text">
					<input type="text" id="join_text" placeholder="대화명(최대 20글자)" maxlength='20' />
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12">
					<h3 class="join_content_title">비밀번호</h3>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 join_content_text">
					<input type="password" id="join_pwd" placeholder="비밀번호(6자리)" maxlength='6' />
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12">
					<div class="col-xs-8 col-sm-8 col-md-8">
						<button class="join_button" id="join_cancel" onclick="hide_join();">취소</button>
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4">
						<button class="join_button" id="join_join" onclick="chk_join();">확인</button>
					</div>
				</div>
				<div id="hidden_room_idx"></div>
			</div>
		</div>
	</div>
</body>
</html>