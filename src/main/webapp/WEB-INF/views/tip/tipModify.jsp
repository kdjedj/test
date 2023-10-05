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
	long t_idx = read.getT_idx();
	String t_content = read.getT_content();
%>	

<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off" type="text" placeholder="소환사 검색">
					</div>	
	</div>
	
	<div class="write_container">
		<div class="sideMenu">
			<div id="profileBox">
			</div>
			<div id="boards_container">
			</div>
		</div>
		<div class="write">

	<form action="${cp}/tip/tipModify" method="post">
		<input type="hidden" name='t_idx' value='<%=t_idx %>' >
		
			<div class="title">
			<input type="text" id="t_title" name="t_title" placeholder="제목" required><br>
			</div>
				
			<div class="content">
			<textarea rows="30" id="t_content" name="t_content" required></textarea><br>
			</div>
    
		<div class="write_actions">
			<div>
			    <input type="submit" id="cancel" value="취소">
			</div>
			<div>
			    <input type="submit" id="publish" value="글쓰기">
			</div>
		</div>
	</form>
		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>