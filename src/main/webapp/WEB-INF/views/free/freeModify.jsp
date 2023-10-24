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
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeWrite.css">
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<%
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	long f_idx = read.getF_idx();
	String f_content = read.getF_content();
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

	<form action="${cp}/free/freeModify" method="post">
		<input type="hidden" name='f_idx' value='<%=f_idx %>' >
		
			<div class="title">
			<input type="text" id="f_title" name="f_title" placeholder="제목" required><br>
			</div>
				
			<div class="content">
			<textarea rows="30" id="f_content" name="f_content" required></textarea><br>
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