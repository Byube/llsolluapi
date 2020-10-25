$(function() {
		$("#korea").click(function(){
			var eng = $("#usa").val();
			$.ajax({
				url: "/contensKorean",
				type: "GET",
				dataType: "json",
				data: { english: eng },
				success: function(v) {
					var korean = v.outputs[0];
					$("#kor").text(korean.output);
				}, error: function(e) {
					console.log(e);
				}
			});
		});
		$("#chinese").click(function(){
			var eng = $("#usa").val();
			$.ajax({
				url: "/contensChina",
				type: "GET",
				dataType: "json",
				data: { english: eng },
				success: function(v) {
					var chinese = v.outputs[0];
					$("#china").text(chinese.output);
				}, error: function(e) {
					console.log(e);
					alert(e);
				}
			});
		});
		$("#clean").click(function(){
			location.reload();
		});
	});