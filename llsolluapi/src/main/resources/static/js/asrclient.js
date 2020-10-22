
var micImage = $(".img-fluid");
var isRecognition = false;

var recognizer = (function (window) {
	
	var recording = false;
	var asrSocket = undefined;
	var recordOpen = false;
	var state = 0;
	var recorder = undefined;
	var context = undefined;
	var audioInput = undefined;
	
	var stream  = undefined;
	function clearUIText(){
		
		document.getElementById("input-transcript-data-src").innerHTML = "";
	}
	
	
	function closeAudio() {
		
		if(!recording) return;
		
		recording = false;
		
		if(recorder){
			audioInput.disconnect(recorder)
			recorder.disconnect(context.destination);
		}
		
		console.log("closeAudio()");
	}
	
	
	
	return {
		startRecognition : function(){
			if(asrSocket && asrSocket.readyState == 1){
				return;
			}
			
			micImage.fadeOut(500, function(){
				micImage.attr('src', '/resources/image/microphone-red-54.png');
				micImage.fadeIn(1000);
			})
			
			
			
			// language 검출
			var srcLang = document.getElementsByClassName("dropp-src")[0].innerHTML;
						
			if(srcLang.indexOf("한국어") >= 0){
				srcLang = "kor";
			} else {
				srcLang = "kor";
			};
			
			
			isRecognition = true;
			state = 0;
			
			//해당 page의 도메인 명으로 주소 맵핑이 필요. 즉 asr 서버 IP  주소가 xxx.xxx.xxx.xxx 로 되어 있고 이 자바스크립트를 가지고 있는 웹 또는 WAS 서버의 
			//도메인 www.aaa.com 이면 yyy.aaa.com 도메인 명을 정해서 이것을 xxx.xxx.xxx.xxx로 맵핑 시켜주어야 함.
			//Recorder 및 websocket은 localhost만 제외하고는 반드시 https 상에서 동작하도록 되어 있음
			asrSocket = new WebSocket("wss://asrdemo.llsollu.com/asr/recognition/websocket/");
									
			asrSocket.onopen = function (event){
				
				clearUIText();
				
				if (!navigator.getUserMedia)
					navigator.getUserMedia = navigator.getUserMedia
							|| navigator.webkitGetUserMedia
							|| navigator.mozGetUserMedia || navigator.msGetUserMedia;

				if (navigator.getUserMedia) {
					if(!recordOpen){
						navigator.getUserMedia({
							audio : true
						}, success, function(e) {
							alert('Error capturing audio.');
						});
					} else {
						recording = true;
						processAudio();
					}
					
				} else {
					alert('getUserMedia not supported in this browser.');
				}
				
				function processAudio(){
					state = 1;
					
					clearUIText();

					context = new AudioContext();

					// the sample rate is in context.sampleRate
					audioInput = context.createMediaStreamSource(stream);

					var bufferSize = 4096;
					recorder = context.createScriptProcessor(bufferSize, 1, 1);

					recorder.onaudioprocess = function(stream) {
						if (!recording)
							return;
						
//						console.log('recording');
						var left = stream.inputBuffer.getChannelData(0);
						asrSocket.send(downsampleBuffer(left, ~~context.sampleRate, 8000));

					}
					
					var asrRequestOption = new Object();
					//product code 변경
					asrRequestOption.productcode = "PRODUCT_CODE";
					asrRequestOption.domain = "default";
					asrRequestOption.cmd = "START";
					asrRequestOption.transactionid = "0";
					asrRequestOption.language = srcLang;
					asrRequestOption.epd = true;
					asrRequestOption.frmt = "0";
					asrRequestOption.slu = false;
					asrRequestOption.partial = true;
					asrRequestOption.cfl = false;
					asrSocket.send(JSON.stringify(asrRequestOption));
					console.log("connected!")
				}
					
				
				function success(e) {
					recordOpen = true;
					stream = e;
					processAudio();					
				}
				
				function downsampleBuffer (buffer, sampleRate, outSampleRate) {

				    if (outSampleRate > sampleRate) {
				        throw "downsampling rate show be smaller than original sample rate";
				    }
				    var sampleRateRatio = sampleRate / outSampleRate;
				    var newLength = Math.round(buffer.length / sampleRateRatio);
				    var result = new Int16Array(newLength);
				    var offsetResult = 0;
				    var offsetBuffer = 0;
				    while (offsetResult < result.length) {
				        var nextOffsetBuffer = Math.round((offsetResult + 1) * sampleRateRatio);
				        var accum = 0, count = 0;
				        for (var i = offsetBuffer; i < nextOffsetBuffer && i < buffer.length; i++) {
				            accum += buffer[i];
				            count++;
				        }

				        result[offsetResult] = Math.min(1, accum / count)*0x7FFF;
				        offsetResult++;
				        offsetBuffer = nextOffsetBuffer;
				    }
				    
				    //Don't modify codes below;
				    var tmpEpd = new Int8Array(1);
				    var audio8KData = new Int8Array(result.buffer);
				    var sendData = new Int8Array(tmpEpd.length + audio8KData.length);
				    
				    sendData.set(tmpEpd);
				    sendData.set(audio8KData, tmpEpd.length);
				    
				    return sendData.buffer;
				};
			}
			
			asrSocket.onmessage = function (event) {
				  console.log("event.data:" + event.data);
				  if(event.data[0] != '{') return;
				  
				  var msg = JSON.parse(event.data);
				  
				  console.log("@@@@@@@@@@state:" + state);
				  
				  if(state == 1) {
					  if(msg.result == 1){
						audioInput.connect(recorder)
						recorder.connect(context.destination);
						recording = true;
						  state = 2;
					  } else {
						  stopRecording();
						  console.log("error :" + msg.result);
					  }
				  } else {
					  console.log("@@@@@@@@@@msg:" + msg.rcode);
					  
					  						  
					  if(msg.rcode > -1){
						  
						  
						  if(msg.rcode == 0){
							  //epd
							  closeAudio();
							  
						  } else if(msg.rcode == 1){
							  //////////////////////////////////////////////////////////////////////////////
							  ////  인식결과 - msg.result
							  //////////////////////////////////////////////////////////////////////////////
							  document.getElementById("input-transcript-data-src").innerHTML = msg.result;
							  stopRecording();
						  } else if(msg.rcode == 2){
							  //////////////////////////////////////////////////////////////////////////////
							  ////  Partial 인식결과 - msg.result
							  //////////////////////////////////////////////////////////////////////////////
							  document.getElementById("input-transcript-data-src").innerHTML = msg.result;
						  } else {
						 
						  }
					  } else{
						  stopRecording();
						  console.log("error : result code -" + msg.rcode);
					  }
				  }
				  
			};
			
			asrSocket.onclose = function (event) {
				  console.log("onclose");
				  closeAudio();
				  recording = false;
			};
			
			asrSocket.onerror = function (event) {
				console.log("onerror");
				stopRecognition();
				recording = false;
				isRecognition = false;
			};
		},
		stopRecognition : function(){
			isRecognition = false;
						
			closeAudio();

			micImage.fadeOut(500, function(){
				micImage.attr('src', '/resources/image/microphone-54.png');
				micImage.fadeIn(1000);
			})
			
			if(asrSocket){
				asrSocket.close();
			}
		},
	}
})(this);

this.startRecording = function() {
	
	
	
	if(isRecognition){
		recognizer.stopRecognition();	
		console.log("stopRecognition");
	} else {
		console.log("startRecognition");
		recognizer.startRecognition();		
	}
	
}

this.stopRecording = function() {
	recognizer.stopRecognition();	
}
