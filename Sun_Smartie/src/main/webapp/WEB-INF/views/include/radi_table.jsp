<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>radi_table</title>
	
	</head>
	
	
	
	<body>
		<table border="1" align="center">
			<tr>
				<th>DATE</th>
				<th>UV INDEX</th>
				<th>LAT</th>
				<th>LON</th>
			</tr>
			<c:forEach var="vo" items="${radi_list}">
				<tr>
					<td>${vo.uv_time}</td>
					<td>${vo.uv}</td>
					<td>${vo.latitude}</td>
					<td>${vo.longitude}</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>






