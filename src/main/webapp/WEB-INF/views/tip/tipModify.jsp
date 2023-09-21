<%@page import="java.util.ArrayList"%>
<%@page import="com.teamproject.spring.teamgg.vo.TipBoardVo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipWrite.css">
</head>
<body>
<%@include file="tip_header.jsp" %>
<%
	TipBoardVo read = (TipBoardVo)request.getAttribute("tipRead");
	long f_idx = read.getT_idx();
	String f_content = read.getT_content();
%>	

<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off" type="text" placeholder="소환사 검색">
					</div>	
	</div>
	
	<div class="container">
		<div class="sideMenu">
			<div id="profileBox">
			</div>
			<div id="boards_container">
			</div>
		</div>
		<div class="modify">

글번호:<%=f_idx %><br>
글내용:	

	<form action="${cp}/tip/tipModify" method="post">
		<input type="hidden" name='t_idx' value='<%=f_idx %>' >
		
		<label for="t_title">제목: </label>
	    <input type="text" name="t_title" required><br>
	
	    <label for="t_content">내용: </label>
	    <textarea rows="3" name="t_content" required></textarea><br>
    
		<input type="submit" value="수정하기">
	</form>
		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>