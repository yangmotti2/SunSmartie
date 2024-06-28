<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script>
		let skin = document.getElementById("skin_type").value;
		
		// 피부 타입 바꾸기
		function change_color(color) {
			let skin_type = document.getElementById("skin_type");
			skin_type.style.backgroundColor = color;
						
			let skinType = document.getElementById("skinType");
			skinType.value = color;
						
		 	let url = "skinSession.do";
			let param = "color=" + color;
			sendRequest(url, param, resultFn, "post"); 
		}
					
		function resultFn(){
			if(xhr.readyState == 4 && xhr.status == 200){
				alert("skinSession등록 성공");
				return;
			}
		} 
	</script>
	
	</head>
	
	
	
	<body>
		 Check your skin
		<br>
		<div class="skin_box" style="background-color: #f7dac6" onclick="change_color('#f7dac6');"></div>
		<div class="skin_box" style="background-color: #f2c9ac" onclick="change_color('#f2c9ac');"></div>
		<div class="skin_box" style="background-color: #d6aa8b" onclick="change_color('#d6aa8b');"></div>
		<div class="skin_box" style="background-color: #bd855e" onclick="change_color('#bd855e');"></div>
		<div class="skin_box" style="background-color: #8c5738" onclick="change_color('#8c5738');"></div>
		<div class="skin_box" style="background-color: #382012" onclick="change_color('#382012');"></div>		
	</body>
</html>






