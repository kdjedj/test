<%@page import="java.util.ArrayList"%>
<%@page import="com.teamproject.spring.teamgg.vo.MateBoardVo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateWrite.css">
</head>
<body>
<%@include file="mate_header.jsp" %>
<%
	MateBoardVo read = (MateBoardVo)request.getAttribute("mateRead");
	long m_idx = read.getM_idx();
	String m_content = read.getM_content();
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

	<form action="${cp}/mate/mateModify" method="post">
		<input type="hidden" name='m_idx' value='<%=m_idx %>' >
		
			<div class="title">
			<input type="text" id="m_title" name="m_title" placeholder="제목" required><br>
			</div>
				
			<div class="content">
			<textarea rows="30" id="m_content" name="m_content" required></textarea><br>
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