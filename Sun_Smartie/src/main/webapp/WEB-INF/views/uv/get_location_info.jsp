<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
    window.onload = function() {
        if ("geolocation" in navigator) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    var latitude = position.coords.latitude;
                    var longitude = position.coords.longitude;
                    var accuracy = position.coords.accuracy;

                    document.getElementById("location-status").innerText = "Location found!";
                    document.getElementById("location-data").innerText = 
                        "Latitude: " + latitude + "\n" +
                        "Longitude: " + longitude + "\n" +
                        "Accuracy: " + accuracy + " meters";

                    // XHR을 이용해 서버로 위치 정보를 전송
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "${pageContext.request.contextPath}/location", true);
                    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                    
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            // 응답이 성공적으로 도착하면 페이지 리다이렉트
                            console.log("들어왔다");
                            var responseUrl = xhr.responseText;
                            console.log(responseUrl);
                            //window.location.href = responseUrl;
                            window.location.href = "test.do";
                        }
                    };
                    
                    xhr.send(JSON.stringify({
                        latitude: latitude,
                        longitude: longitude,
                        accuracy: accuracy
                    }));
                },
                function(error) {
                    document.getElementById("location-status").innerText = 
                        "Error Code = " + error.code + " - " + error.message;
                },
                {
                    enableHighAccuracy: true // 고정밀 위치 정보 사용
                }
            );
        } else {
            document.getElementById("location-status").innerText = "Geolocation is not supported by this browser.";
        }
    };
</script>

</head>
<body>

    <h1>Location Example</h1>
    <div id="location-status"></div>
    <div id="location-data"></div>

</body>
</html>