<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>메인페이지</title>
		<link rel="stylesheet" href="resources/css/uv_list_style.css">
		<script src="resources/js/httpRequest.js"></script>
		<script src="resources/js/change_radi_list.js"></script>
		<script src="resources/js/change_map_color.js"></script>
		<!-- chart.js 라이브러리 -->
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	
	
	<script>
		// 전역 변수로 myChart 정의
		let myChart;  
	
		document.addEventListener("DOMContentLoaded", function() {
			fetch("list_select.do")
				.then(response => {
					console.log(response);
					if(!response.ok){
						throw new Error('Network response was not ok');
					}
					return response.json();
				})
				.then(data => {
					console.log(data);
					
					let city_name = [];
					let uv_list = [];
					let uv_time_list = [];
					
					// let flattenedData = data[0].flat(); // 다차원 배열을 1차원 배열로 변환
					
					data.forEach(data_list => {
						let uv = [];
						let uv_time = [];
	                    console.log('city_name :', data_list.city_name);
	                    console.log('radi_list :', data_list.radi_list);
	               
	                   
	                    city_name.push(data_list.city_name);
	                    
	                    
	                    data_list.radi_list.forEach(radiVO => {
		                    console.log('uv:', radiVO.uv);
		                    console.log('uv_time:', radiVO.uv_time);
		               
		                   
		                    uv.push(radiVO.uv);
		                    uv_time.push(radiVO.uv_time);
		                });
	                    
	                    uv_list.push(uv);
	                    uv_time_list.push(uv_time);
	                });
					 
					show_chart(city_name[0], uv_list[0], uv_time_list[0]);
					updataChartData(city_name, uv_list, uv_time_list);
				})
				.catch(error => {
		                console.error('There was a problem with the fetch operation:', error);
		         });
		 }); 
		
		function show_chart(city_name, uv, uv_time) {
			
			console.log("uv : "+ uv);
			
		    // 캔버스 요소 가져오기
		    var ctx = document.getElementById('myChart').getContext('2d');
			console.log("------------------");
			  // ttb 배열의 데이터를 숫자로 변환하는 과정
	//	    let ttb_numeric = ttb.map(value => parseFloat(value.replace(',', ''))); // ',' 제거 후 숫자로 변환
			
		    // 차트 생성
		    if (!myChart) {
		    myChart = new Chart(ctx, {
		        type: 'line', // 차트 유형 (bar, line, pie, 등)
		        data: {
		            labels: uv_time,
		            datasets: [{
		                label: 'uv',
		                data: uv,
		                borderColor:'rgba(30, 215, 232, 1)',
		                borderWidth: 1,
		                fill: true // 이 옵션을 통해 라인 아래를 채웁니다.
		            }
		            ]
		        },
		        options: {
		        	responsive: true, // 차트 크기가 자동으로 조절되도록 설정
		    		maintainAspectRatio: true, // 차트의 가로 세로 비율을 유지하지 않음
		            // 차트 애니메이션 효과를 설정
		            animation: {
		                duration: 500, // 애니메이션 지속 시간을 설정
		                easing: 'easeOutQuad' // 애니메이션의 변화 속도 설정
		            },
		            scales: {
		                y: {
		                    beginAtZero: true
/* 		                    min: min,  // y축 최소값 설정
		                    max: max  // y축 최대값 설정 */
		                }
		            },
		            plugins: {
		                title: {
		                    display: true,
		                    text: city_name
		                } 
		            }
		        }
		    });
		
			}else {// 차트 객체가 있는 경우, 데이터 업데이트
		        myChart.data.labels = uv_time;
		        myChart.data.datasets[0].data = uv;
		        myChart.options.plugins.title.text = city_name;
		        myChart.update();
			}
		}
		
		let intervaled;
		let city_index = 1;
		
		function updataChartData(city_name, uv_list, uv_time_list) {
			intervaled = setInterval(function() {
				if( city_index == city_name.length){
					city_index = 0;
				}
				console.log("이건 : "+city_index);
				console.log("이건 2 : "+city_name.length );
				
		       show_chart(city_name[city_index], uv_list[city_index], uv_time_list[city_index]);
		       city_index++;
			}, 4000);
		}  
	 
		function send(accountnumber, user_id) {
			location.href = "account_info.do?account_number="+accountnumber + "&user_id="+user_id;
		}
		
		window.onload = function () {
			let account_box = document.getElementById("account_box");
			
			let user_id = "${user_id}"; 
			if(user_id == 'null' || user_id ==''){
				account_box.style.display ="none";
			}else{
				account_box.style.display ="block";
			}
		}
	
		
	</script>
	
	</head>
	
	
	
	<body>
		
		<div class="city" id="cityName">${ city_name }</div>
	  	<div class="table-map-container">
	  	
	  	
	  		<!-- ↓ 데이터 값 테이블로 가져오는 radi_table.jsp ↓ -->
		  	<div class="radi-table">
		  	<%-- 	<jsp:include page="/WEB-INF/views/include/radi_table.jsp"></jsp:include> --%>
					<canvas id="myChart" width="600" height="400"></canvas>
			</div>
			<!-- ↑ 데이터 값 테이블로 가져오는 radi_table.jsp ↑ -->
			
			<!-- ↓ 지도 보여주는 map.jsp ↓ -->
			<div class="map-box">
				<jsp:include page="/WEB-INF/views/include/map.jsp"/>
			</div>
			<!-- ↑ 지도 보여주는 map.jsp ↑ -->
			
			
		</div>
		
		<hr>
		<br>

		<!-- 선택한 값들 input 태그에 넣어두고 필요할 때 불러오기 -->
		<input type="hidden" id="skinType">
		<input type="hidden" id="uvType">
		
		
		<!-- ↓ 15시간을 시간별, 색깔별로 나타내는 uv_15hr.jsp ↓ -->
		<div id="day_container">
			<jsp:include page="/WEB-INF/views/include/uv_15hr.jsp"></jsp:include>
		</div>
		<!-- ↑ 15시간을 시간별, 색깔별로 나타내는 uv_15hr.jsp ↑ -->
		
		
		<br>
		
		
		<!-- ↓ 비타민D 게이지바 보여주는 vitamin_d.jsp ↓ -->
		<div id="slide_container" onclick="gauge();" align="center">
			<jsp:include page="/WEB-INF/views/include/vitamin_d.jsp"></jsp:include>
		</div>
		<!-- ↑ 비타민D 게이지바 보여주는 vitamin_d.jsp ↑ -->
		
		
		<input type="button" value="멈추기" onclick="timerstop();">
		<br> your skin type<div id="skin_type"></div> <br>
		
		
		<!-- ↓ 피부색깔 선택을 도와주는 skin_type.jsp ↓ -->
		<div id="skin_container">
			<jsp:include page="/WEB-INF/views/include/skin_type.jsp"></jsp:include>
		</div>
		<!-- ↑ 피부색깔 선택을 도와주는 skin_type.jsp ↑ -->
		
		
	</body>
</html>









