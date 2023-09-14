<%@page import="java.util.ArrayList"%>
<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	long f_idx = read.getF_idx();
	String f_content = read.getF_content();
%>	

글번호:<%=f_idx %><br>
글내용:	
	
	<form action="${cp}/free/freeModify" method="post">
		<input type="hidden" name='f_idx' value='<%=f_idx %>' >
		<textarea name='f_content'>
			<%=f_content %>
		</textarea>
		<input type="submit" value="수정하기">
	</form>

</body>
</html>