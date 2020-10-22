$(function() {

		$("#close").click(function(){
		alert("test");
		});

		$("#chinese").click(function(){
			var ko = $("#korean").val();
			$.ajax({
				url:"/llsolluChina",
				type:"GET",
				dataType:"json",
				data:{korean:ko},
				success:function(v){
					var chinese = v.outputs[0];
					$("#china").text(chinese.output);
				},error:function(e){
					console.log(e);
					alert(e);
				}
			});
		});
		$("#english").click(function(){
			var ko = $("#korean").val();
			$.ajax({
				url:"/llsolluEnglish",
				type:"GET",
				dataType:"json",
				data:{korean:ko},
				success:function(v){
					var english = v.outputs[0];
					$("#usa").text(english.output);
				},error:function(e){
					console.log(e);
				}
			});
		});
		$("#clean").click(function(){
			location.reload();
		});
	});