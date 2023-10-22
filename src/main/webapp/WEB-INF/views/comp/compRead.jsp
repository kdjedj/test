<%@page import="com.teamproject.spring.teamgg.vo.MateBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateRead.css">
</head>
<body>
<%@include file="mate_header.jsp" %>
<%
	MateBoardVo read = (MateBoardVo)request.getAttribute("mateRead");
	Long m_idx = read.getM_idx();
	String m_id = read.getM_id();
	String m_user = read.getM_user();
	String m_title = read.getM_title();	
	String m_content = read.getM_content();
	String m_date = read.getM_date();
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
<h1> <%=m_title %> </h1>
<%= m_date %> <%=m_user %>
			</div>
			<div class="content">
<%=m_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/mate/mateList">리스트</a>
				<a href="${cp}/mate/mateModify?m_idx=<%=m_idx%>">수정</a>
				<a href="${cp}/mate/mateDel?m_idx=<%=m_idx%>">삭제</a>
			</div>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>