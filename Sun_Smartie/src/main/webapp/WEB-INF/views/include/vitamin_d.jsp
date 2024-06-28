<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script>
		// 타이머 변수	
		let timer_count = 0;
		let past_time = 0;
		let now_time = 0;
		let intervalId;
	
		function timerstop() {
			clearInterval(intervalId); // 타이머 멈추기
						
			let slide = document.getElementById("slide");
			// slide.style.animation = "rotate 1s linear forwards"; // animation 속성을 빈 문자열로 설정하여 애니메이션 제거
		}
		
		// 게이지 상승 함수
		function gauge() {
			let uvType = document.getElementById("uvType");
			let skinType = document.getElementById("skinType");
						
			let uv_arr = ["#558B2F", "#F9A825", "#EF6C00", "#B71C1C", "#6A1B9A"];
			let shin_arr = ["#f7dac6", "#f2c9ac", "#d6aa8b", "#bd855e", "#8c5738", "#382012"];
						
			let uv_level;
			let shin_level;
						
			// uv 타입에 따른 index 번호 지정하기
			for(let i = 0; i < uv_arr.length; i++){
				if(uv_arr[i] == uvType.value){
					uv_level = i;
					break;
				}
			}
						
			// 피부 타입에 따른 index 번호 지정하기
			for(let i = 0; i < shin_arr.length; i++){
				if(shin_arr[i] == skinType.value){
					shin_level = i;
					break;
				}
			}
			console.log(uv_level + "/" + shin_level);
						
			let slide = document.getElementById("slide");
			slide.style.backgroundColor = uvType.value;
						
			let uv_min = [
			// low ......	
		    //  [20, 15, 10, 8, 5], //피부타입1
				[20, 15, 10, 8, 5], //피부타입1
				[30, 20, 15, 10, 8], //피부타입2
				[40, 30, 20, 15, 10], //피부타입3
				[60, 40, 30, 20, 15], //피부타입4
				[80, 60, 40, 30, 20], //피부타입5
				[0, 80, 60, 40, 30] //피부타입6
				];
						
			// 현 상황에 맞는 적정 시간 계산
			timer_count = uv_min[shin_level][uv_level];
						
			// 매 초마다 incrementCounter 함수를 호출
			intervalId = setInterval(uv_guage_count, 1000); // 1000ms = 1초
						
		}

		// 게이지 바 카운트 함수
		function uv_guage_count() {
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
	</script>
	
	</head>
	
	
	
	<body>
		<h2 align="center" style="color: #d3d3f2">Click this Point !</h2>
		<div id="slide"></div>
		<div id="slide_back"></div>
	</body>
</html>






