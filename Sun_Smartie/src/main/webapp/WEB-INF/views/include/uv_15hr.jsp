<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	
	<script>
		// uv 타입 바꾸기
		function uv_change(uv_color) {
			let uvType = document.getElementById("uvType");
			uvType.value =  uv_color;
			alert( uv_color);
						
			let slide = document.getElementById("slide");
			let slide_back = document.getElementById("slide_back");
			slide.style.backgroundColor = uv_color;
			slide_back.style.backgroundColor = uv_color;
		}
	</script>
	
	<body>
		<div id="uv_box-container">
			<c:forEach var="vo" items="${radi_list}">
				<!-- calc() 함수는 CSS 스타일 시트에서 사용되어 스타일 속성의 값을 동적으로 계산하여 설정할 수 있는 기능을 제공 -->
				<div class="uv_box" onclick="uv_change('${vo.uv_color}');" 
					 style="width: calc(100% / ${radi_list.size()} - 2px); background-color: ${vo.uv_color}">
					 
					${vo.uv}
					
				</div>
			</c:forEach>
		</div>
	</body>
</html>






