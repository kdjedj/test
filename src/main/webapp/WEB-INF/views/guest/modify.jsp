<%@page import="com.teamproject.spring.teamgg.vo.GuestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	여기 진짜오나???
<%-- 	
<%
	GuestVO read = (GuestVO)request.getAttribute("read");
	long bno = read.getBno();
	String btext = read.getBtext();
%>	

글번호:<%=bno %><br>
글내용:	
	
	<form action="/guest/modify" method="post">
		<input type="hidden" name='bno' value='<%=bno %>' >
		<textarea name='btext'>
			<%=btext %> --%>
		</textarea>
		<input type="submit" value="수정하기">
	</form>
</body>
</html>