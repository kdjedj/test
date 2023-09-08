<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${cp}/resources/t.js"></script>
</head>
<body>
<%
	String aa = request.getParameter("a");
%>
표현태그로 출력:<%=aa%>
<hr>
el로 출력${param.a}

</body>
</html>