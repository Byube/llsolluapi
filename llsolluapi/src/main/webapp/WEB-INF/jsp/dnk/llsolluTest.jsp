<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache" />
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<title>엘솔루 API 테스트</title>
<link rel="stylesheet"
	href="resources/js/common/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<script src="resources/js/common/jquery-3.2.0.js"></script>
<script src="resources/js/common/bootstrap/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="resources/js/textapi.js"></script>

<style type="text/css">
#inner-bottom {
	display: none;
}

#language-select-div {
	display: none;
}

.main_txt {
	font-size: 30px;
}

.englishs {
	width: 150px;
	height: 150px;
	font-size: 24px;
	font-family: "휴먼매직체";
	vertical-align: bottom;
	margin-left: 50%;
	border: none;
	border-radius: 50%;
	background: #ffcd00 center;
	background-size: 60%;
}

body {
	background-color: #f0f5f6;
}

header {
	width: 1200px;
	margin: auto;
}

header h1 {
	text-align: center;
	color: #333;
}

.sub_title {
	text-align: center;
}

.inner-div {
	width: 100%;
	text-align: center;
	margin: 50px 0;
}

.overlay {
	width: 50%;
	margin: 50px auto;
}

.overlay img {
	
}

.flag-ko {
	text-align: center;
}

.wrap {
	width: 1200px;
	margin: 50px auto;
}

.wrap:after {
	content: '';
	display: block;
	clear: both;
}

.wrap>div {
	float: left;
	width: 30%;
	height: 350px;
	margin-right: 5%;
	border-radius: 10px;
	background-color: #f9faff;
	box-shadow: 14px 15px 32px -10px rgba(197, 207, 224, 1);
	overflow: hidden;
	overflow-y: auto;
}

.wrap div:last-child {
	margin-right: 0;
}

.wrap div p {
	width: 100%;
	height: 60px;
	display: block;
	margin: 0;
	padding: 10px 20px;
	box-sizing: border-box;
	font-weight: bold;
	color: #545454;
	background-color: #fff;
}

.wrap .trans_txt {
	width: 100%;
	padding: 20px;
	box-sizing: border-box;
	word-break: break-all;
}

.trans_txt input[type="text"], .trans_txt textarea {
	width: 100%;
	height: 265px;
	border: none;
	background-color: transparent;
	word-break: break-all;
}

.overlay .btn {
	width: 130px;
	height: 130px;
}

.overlay .btn_reset {
	width: 70px;
	height: 70px;
	vertical-align: bottom;
	margin-left: 30px;
	border: none;
	border-radius: 50%;
	background: #ffcd00 url(../resources/image/btn_refresh.png) no-repeat
		center;
	background-size: 60%
}

.trans_box input[type="button"] {
	border: none;
	text-align: left;
}

.trans_box:after {
	content: '';
	display: block;
	clear: both;
}

.trans_box .btn_transfer {
	float: right;
	padding: 5px 10px 5px 40px;
	background: #2acdcf url(../resources/image/btn_transfer.png) no-repeat
		10px center;
	background-size: 20%;
	color: #fff;
	border-radius: 50px;
	font-size: 0.5em;
}

.txt_is {
	font-size: 50px;
}

@media only screen and (max-width: 1200px) {
	header {
		width: 100%;
	}
	.wrap {
		width: 100%;
	}
	.wrap>div {
		float: none;
		width: 100%;
		margin-top: 50px;
	}
	.main_txt {
		font-size: 35px;
	}
	.overlay {
		width: 100%;
	}
	.overlay .btn {
		width: 150px;
		height: 150px;
	}
	.overlay .btn_reset {
		width: 100px;
		height: 100px;
	}
	.trans_box .btn_transfer {
		float: right;
		padding: 5px 15px 5px 55px;
		background: #2acdcf url(../resources/image/btn_transfer.png) no-repeat
			10px center;
		background-size: 20%;
		color: #fff;
		border-radius: 50px;
		font-size: 0.7em;
	}
}
</style>
</head>
<body>
	<header>
		<h1>엘솔루 API 테스트 자동 번역</h1>
		<div id="layer-fixed">
			<p class="sub_title" id="title-paragraph">- 엘솔루 ASR demo -</p>
		</div>
		<div id="container">
			<div id="outer-div">
				<div id="contact-us"></div>

				<div class="inner-div" id="inner-div">
					<div id="language-select-div">
						<div class="dropdown dropdown-src">
							<p class="dropp dropp-src">Source</p>
							<div class="dropdown-content dropdown-content-src">
								<a href="#" class="flag-ko"><img
									src="/resources/image/southkorea.png" /> 한국어</a>
							</div>
						</div>
					</div>
					<div class="overlay ">
						<img src="/resources/image/microphone-54.png"
							class="btn img-fluid" onclick="startRecording()" /> <input
							type="button" class="btn btn_reset" id="clean">
						<!-- <input type="button" src="resources/image/microphone-54.png" class="btn img-fluid" onclick="asrProcess();"/> -->
					</div>
					<!-- <a href="#" class="flag-ko"><img src="/resources/image/southkorea.png" /> 한국어</a> -->
				</div>
				<div id="inner-bottom">
					<p>- Transcription -</p>
					<input type="hidden" id="input-translate-data-src" />
					<div id="input-transcript-data-src"></div>
				</div>
			</div>

			<div id="transcript-div"></div>
		</div>
	</header>

	<script>
		if (!navigator.mediaDevices || !navigator.mediaDevices.enumerateDevices) {
	  console.log("enumerateDevices() not supported.");
	  } else {
		// List cameras and microphones.
	
		  navigator.mediaDevices.enumerateDevices()
		  .then(function(devices) {
		    devices.forEach(function(device) {
		      console.log(device.kind + ": " + device.label +
		                  " id = " + device.deviceId);
		    });
		  })
		  .catch(function(err) {
		    console.log(err.name + ": " + err.message);
		  });
	  }
	
	
	</script>

	<script src="/resources/js/asrclient.js"></script>


	<div class="wrap">
		<div class="trans_box">
			<p class="main_txt">한국어</p>
			<div class="trans_txt">
				<textarea id="korean" name="korean" class="txt_is"></textarea>
			</div>
		</div>
		<div class="trans_box">
			<p class="main_txt">
				중국어 <input type="button" class="btn_transfer" id="chinese"
					value="번역하기">
			</p>
			<div class="trans_txt txt_is" id="china"></div>
		</div>
		<div class="trans_box">
			<p class="main_txt">
				영어 <input type="button" class="btn_transfer" id="english"
					value="번역하기">
			</p>
			<div class="trans_txt txt_is" id="usa"></div>
		</div>
	</div>

	<a href="/contensTest"><input type="button" class="englishs"
		id="goEnglish" value="영한번역"></a>


	<!-- 	<table border="1">
		<thead>
			<tr>
				<th>한국어</th>
				<th>중국어</th>
				<th>영어</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" id="korean" name="korean"></td>
				<td width="200" height="30" id="china"></td>
				<td width="200" height="30" id="usa"></td>
			</tr>
		</tbody>
	</table>
	<input type="button" id="chinese" value="중국어">
	<input type="button" id="english" value="영어">
	 -->


	<!-- 	<div id="footer">
		<hr />
		<span id="support-browser"
			class="visible-sm-block visible-md-block visible-lg-block"> <input
			type="image" src="/resources/image/chrome-resized.png"
			title="Chrome 21 or more" /> <input type="image"
			src="/resources/image/firefox-resized.png" title="Firefox 17 or more" />
			<input type="image" src="resources/image/edge-resized.png"
			title="Edge All versions supported" /> <input type="image"
			src="/resources/image/ie-resized.png" id="browser-ie"
			title="IE Not supported" />
		</span> <span id="footer-paragraph">Copyright ⓒ 엘솔루, All rights
			reserved</span>
	</div> -->
</body>
</html>