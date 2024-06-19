<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	// 위치를 성공적으로 가져왔을 때 호출되는 함수
	function sendLocation(position) {
		var latitude = position.coords.latitude;
		var longitude = position.coords.longitude;

		// URL 쿼리 파라미터로 위도와 경도 값을 설정하여 리다이렉트
		window.location.href = "location.do?latitude="+ latitude + "&longitude=" + longitude;
	}

	// Geolocation API를 사용하여 위치 가져오기
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(sendLocation);
	} else {
		console.warn("Geolocation is not supported by your browser");
	}
</script>

</head>
<body>
	
</body>
</html>