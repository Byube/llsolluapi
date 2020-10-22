<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache" />
<title>엘솔루 API 테스트2</title>
<link rel="stylesheet"
	href="/resources/js/common/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<script src="/resources/js/common/jquery-3.2.0.js"></script>
<script src="/resources/js/common/bootstrap/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/textapi2.js"></script>
</head>
<body>
	<h1>엘솔루 API 테스트</h1>
	<div id="layer-fixed">
		<p id="title-paragraph">엘솔루 ASR demo</p>
	</div>
	<div id="container">
		<div id="outer-div">
			<div id="contact-us"></div>

			<div id="inner-div">
				<div id="language-select-div">
					<div class="dropdown dropdown-src">
						<p class="dropp dropp-src">Source</p>
						<div class="dropdown-content dropdown-content-src">
							<a href="#" class="flag-ko"><img
								src="/resources/image/southkorea.png" /> 한국어</a>
						</div>
					</div>
				</div>

				<br /> <br /> <br />
				<div class="overlay ">
					<img src="/resources/image/microphone-54.png" class="btn img-fluid"
						onclick="startRecording()" />
					<!-- <input type="button" src="resources/image/microphone-54.png" class="btn img-fluid" onclick="asrProcess();"/> -->
				</div>
			</div>
			<div id="inner-bottom">
				<p>- Transcription -</p>
				<!-- <input type="text" id="input-translate-data-src" /> -->
				
				
				<div id="input-transcript-data-src"></div>
			</div>
		</div>

		<div id="transcript-div"></div>
	</div>
	<div id="footer">
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
	</div>
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

	<table border="1">
			<thead>
				<tr>
					<th>한국어</th>
					<th>중국어</th>
					<th>영어</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><textarea rows="20" cols="50" id="korean" name="korean"></textarea></td>
					<td><textarea rows="20" cols="50"  id="china" disabled="disabled" ></textarea></td>
					<td><textarea rows="20" cols="50" id="usa" disabled="disabled" ></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="button" id="chinese" value="중국어">
		<input type="button" id="english" value="영어">
		<input type="button" id="clean" value="리셋"><br>
		<a href="/llsollu">테스트1로 돌아가기</a>
	
</body>
</html>