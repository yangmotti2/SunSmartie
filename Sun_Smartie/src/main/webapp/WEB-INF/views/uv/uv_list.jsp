<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- Ajax 사용을 위한 httpRequest.js 처리 -->
		<script src="/sunny/resources/js/httpRequest.js"></script>
		
		<style>
			#skin_container{padding:2px;
							width: 165px;
							height: 135px;
							border: 1px solid;
							overflow: hidden;
							}
			.skin_box{
					margin: 2px;
					width: 50px;
					height: 50px;
					float: left;
					display: block;
					cursor: pointer;
					border-radius: 20px;
					}
					
			#day_container{width: 800px;
						   height: 60px;
						   overflow: hidden;
						   }
			
			.uv_box{width: 40px;
					height: 50px;
					border: 1px solid;
					float: left;
					}
					
			#slide_container{ width: 800px;
							  height: 60px;
							  border: 6px groove #5a5a73;
		 					  cursor: pointer;
		 					  border-radius: 30px;
		 					  background-color: #2d2d36;
		 					  position: relative;
		 				
		 					  overflow: hidden; 
						
							  animation: linechange 0.5s linear infinite;
						}	

			#slide_container h2{position:absolute;
								z-index: 1;
								left: 35%}
								
			#slide{width: 200px;
					height: 200px;
					z-index: 2;
					position: absolute;
					border-radius: 50px;
					margin-top:-40px;
					left: -100px;
					border: 1px solid blue;
					}

			#slide_back{width: 200px;
					height: 200px;
					z-index: 2;
					position: absolute;
					margin-top:-5px;
					border-radius: 20px;
					top: 0;
					left: 0px;
					}

			#skin_type{width: 30px;
					   height: 30px;
					   border-radius: 20px;
					   border: 1px solid;
						}	
						
			   @keyframes linechange {
			        0% {
			             border: 6px solid #5a5a73;
			        }100% {
			          	 border: 6px solid #88b3a8;;
			        }
		    	}
		    #map {
			    height: 500px;
			    width: 400px;
			    margin: 0 auto;
			    max-width: 400px;
			    border: 2px solid #000;
			}

		</style>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mapdata.js"></script>		
		<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/js/countrymap.js"></script>
		
		<script>
			// 타이머 변수	
			let timer_count = 0;
			let past_time = 0;
			let now_time = 0;
			let intervalId;
			
			// 게이지 바 카운트 함수
			function uv_guage_count(uv_color_list, uv_time_list) {
				let skinType = document.getElementById("skinType");
				let shin_arr = ["#f7dac6", "#f2c9ac", "#d6aa8b", "#bd855e", "#8c5738", "#382012"];

				let shin_level;
				// 피부 타입에 따른 index 번호 지정하기
				for(let i = 0; i < shin_arr.length; i++){
					if(shin_arr[i] == skinType.value){
						shin_level = i;
						break;
					}
				}
				
				let now = new Date();
				console.log(now.getHours());
				console.log(uv_time_list[0]);
				
				
/* 				for(let i = 0; i < shin_arr.length; i++){
					if(shin_arr[i] == skinType.value){
						shin_level = i;
						break;
					}
				} */

				
				let slide = document.getElementById("slide");
				slide.style.backgroundColor = uvType.value;
				
				let uv_min = [
				// low ......	
//				    [20, 15, 10, 8, 5], //피부타입1
				    [20, 15, 10, 8, 5], //피부타입1
				    [30, 20, 15, 10, 8], //피부타입2
				    [40, 30, 20, 15, 10], //피부타입3
				    [60, 40, 30, 20, 15], //피부타입4
				    [80, 60, 40, 30, 20], //피부타입5
				    [0, 80, 60, 40, 30] //피부타입6
				];
				
				// 현 상황에 맞는 적정 시간 계산
				timer_count = uv_min[shin_level][uv_level];

				
				now_time++;
				let oldstyle = document.getElementById("oldstyle");
				if(oldstyle){
					oldstyle.remove();
					console.log("지워짐");
					console.log(now_time + " / " + past_time);
					console.log(now_time/timer_count);
				}
				
				let slide_back = document.getElementById("slide_back");
			    // 동적으로 <style> 요소 생성
		        let styleSheet = document.createElement("style");
		        styleSheet.type = "text/css"; // JavaScript를 사용하여 동적으로 생성된 <style> 요소의 타입을 설정하는 코드
											// CSS 파일이 아닌 HTML 문서 내에서 스타일을 정의할 때는 대부분 text/css를 사용
		        styleSheet.id = "oldstyle"
				// 동적으로 키프레임 애니메이션 정의
 				let keyframes_rotate = "@keyframes rotate { 0% { transform: rotate(0deg); left: "+ (past_time/timer_count * 100) +"%; } 100% { transform: rotate(360deg); left:"+ (now_time/timer_count*100) +"%; } } #slide { animation: rotate 1s linear infinite; }";
		        let keyframes_back = "@keyframes back { 0% { width:"+(past_time/timer_count * 100 + 5)+"%; } 100% { width:" +(now_time/timer_count * 100 + 5) +"% }} #slide_back { animation: back 0.8s linear forwards; }";
		        // <style> 요소에 키프레임 애니메이션 추가
		        styleSheet.innerHTML = keyframes_rotate + "\n" + keyframes_back;
		        
		        document.head.appendChild(styleSheet);
		        
		        past_time = now_time;
				
			}
		
		
			// 피부 타입 바꾸기
			function change_color(color) {
				let skin_type = document.getElementById("skin_type");
				skin_type.style.backgroundColor = color;
				
				let skinType = document.getElementById("skinType");
				skinType.value = color;
			}
		
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
			
			let uv_color_list = [];
			let uv_time_list = [];
			
			// 게이지 상승 함수
			function gauge(radiMapJson) {
				console.log("하이");
	            let radi_map = JSON.parse(radiMapJson); // json 객체로 변환
	            let radi_list = radi_map.radi_list;
				console.log("radi : "+radi_map);
				console.log("radi : "+radi_map.radi_list);
				
				
				radi_list.forEach(vo => {
					uv_color_list.push(vo.uv_color);
					uv_time_list.push(vo.uv_time);
				});
				
				
		        // 매 초마다 incrementCounter 함수를 호출
		       intervalId = setInterval(function() {
		           uv_guage_count(uv_color_list, uv_time_list);
		       		}, 1000); // 1000ms = 1초
				
			}
			
			function timerstop() {
				clearInterval(intervalId); // 타이머 멈추기
				
				let slide = document.getElementById("slide");
				// slide.style.animation = "rotate 1s linear forwards"; // animation 속성을 빈 문자열로 설정하여 애니메이션 제거
			}
			
		</script>
	</head>
	<body>
		<table border="1" align="center">
			<c:forEach var="vo" items="${radi_list}">
				<tr>
					<td>${vo.uv_time}</td>
					<td>${vo.uv}</td>
					<td>${vo.latitude}</td>
					<td>${vo.longitude}</td>
				</tr>
			</c:forEach>
		</table>
		
		<hr>
		<br>

		<!-- 선택한 값들 input 태그에 넣어두고 필요할 때 불러오기 -->
		<input type="hidden" id="skinType">
		<input type="hidden" id="uvType">
		
		<div id="day_container">
			<c:forEach var="vo" items="${radi_list}">
				<!-- calc() 함수는 CSS 스타일 시트에서 사용되어 스타일 속성의 값을 동적으로 계산하여 설정할 수 있는 기능을 제공 -->
				<div class="uv_box" onclick="uv_change('${vo.uv_color}');" style="width: calc(100% / ${radi_list.size()} - 2px); background-color: ${vo.uv_color}">
					${vo.uv}			
				</div>
			</c:forEach>
		</div>
		<br>
		
		<div id="slide_container" onclick="gauge('${radiMapJson}');" align="center"> <!-- onclick 부분이 json 문자열로 안보내져요  -->
			<h2 align="center" style="color: #d3d3f2">Click this Point !</h2>
			<div id="slide"></div>
			<div id="slide_back"></div>
		</div>
		<input type="button" value="멈추기" onclick="timerstop();">
		
		
		<br>
		your skin type<div id="skin_type"></div>
		<br>
		
		<div id="skin_container">
		 Check your skin
		<br>
			<div class="skin_box" style="background-color: #f7dac6" onclick="change_color('#f7dac6');"></div>
			<div class="skin_box" style="background-color: #f2c9ac" onclick="change_color('#f2c9ac');"></div>
			<div class="skin_box" style="background-color: #d6aa8b" onclick="change_color('#d6aa8b');"></div>
			<div class="skin_box" style="background-color: #bd855e" onclick="change_color('#bd855e');"></div>
			<div class="skin_box" style="background-color: #8c5738" onclick="change_color('#8c5738');"></div>
			<div class="skin_box" style="background-color: #382012" onclick="change_color('#382012');"></div>
		</div>

	<div id="test">야야</div>
	<div id="map"></div>
	<script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function() {
	        simplemaps_countrymap.load();
	    });
	</script>

</body>
</html>