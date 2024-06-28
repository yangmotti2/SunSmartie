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
	</head>
	
	
	
	<body>
		
		<div class="city">${ city_name }</div>
	  	<div class="table-map-container">
	  	
	  	
	  		<!-- ↓ 데이터 값 테이블로 가져오는 radi_table.jsp ↓ -->
		  	<div class="radi-table">
		  		<jsp:include page="/WEB-INF/views/include/radi_table.jsp"></jsp:include>
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









