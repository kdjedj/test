<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="java.util.ArrayList"%>
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

글본문
글번호:<%=f_idx %>
글내용:<%=f_content %>
<hr>
<!-- [ ] 글삭제로 이동. 글번호를 넘겨야함. -->
<a href="${cp}/free/freeDel?f_idx=<%=f_idx%>">글 삭제</a>
<!-- [ ] 글 수정으로 이동. 글번호를 넘겨야함. -->
<a href="${cp}/free/freeModify?f_idx=<%=f_idx%>">글 수정</a>
<!-- [ ] 글 리스트로 이동. -->
<a href="${cp}/free/freeList?page=<%=f_idx%>">글 리스트</a>
</body>
</html>