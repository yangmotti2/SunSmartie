<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
		<c:forEach var="uv" items="${ uv_list }">
		 <tr>
		 	 <td>${ uv.idx }</td>
		 	 <td>${ uv.latitude }</td>
		 	 <td>${ uv.longitude }</td>
		 	 <td>${ uv.uv }</td>
		 	 <td>${ uv.uv_time }</td>
		 </tr>
		</c:forEach>
	</table>

</body>
</html>