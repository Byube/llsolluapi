$(function() {
		$("#chinese").click(function(){
			var ko = $("#korean").val();
			$.ajax({
				url:"/contensChina",
				type:"GET",
				dataType:"json",
				data:{korean:ko},
				success:function(v){
					var chinese = v.outputs[0];
					$("#china").text(chinese.output);
					console.log(v);
				},error:function(e){
					console.log(e);
					alert(e);
				}
			});
		});
		$("#english").click(function(){
			var ko = $("#korean").val();
			$.ajax({
				url:"/contensEnglish",
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