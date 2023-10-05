<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeRead.css">
</head>
<body>
<%@include file="free_header.jsp" %>
<%
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	Long f_idx = read.getF_idx();
	String f_id = read.getF_id();
	String f_user = read.getF_user();
	String f_title = read.getF_title();	
	String f_content = read.getF_content();
	String f_date = read.getF_date();
%>	

<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off" type="text" placeholder="소환사 검색">
					</div>	
	</div>
	
	<div class="read_container">
		<div class="sideMenu">
			<div id="profileBox">
			</div>
			<div id="boards_container">
			</div>
		</div>
		<div class="read">
			<div class="read_head">
<h1> <%=f_title %> </h1>
<%= f_date %> <%=f_user %>
			</div>
			<div class="content">
<%=f_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/free/freeList">리스트</a>
				<a href="${cp}/free/freeModify?f_idx=<%=f_idx%>">수정</a>
				<a href="${cp}/free/freeDel?f_idx=<%=f_idx%>">삭제</a>
			</div>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>