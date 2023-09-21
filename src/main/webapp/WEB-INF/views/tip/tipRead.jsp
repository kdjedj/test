<%@page import="com.teamproject.spring.teamgg.vo.TipBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipRead.css">
</head>
<body>
<%@include file="tip_header.jsp" %>
<%
	TipBoardVo read = (TipBoardVo)request.getAttribute("tipRead");
	Long t_idx = read.getT_idx();
	String t_writer = read.getT_writer();
	String t_title = read.getT_title();	
	String t_content = read.getT_content();
	Date t_date = read.getT_date();
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
		<h1> <%=t_title %> </h1>
			<%= t_date %> <%=t_writer %>
			</div>
			<div class="content">
			<%=t_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/tip/tipList?page=1">리스트</a>
				<a href="${cp}/tip/tipModify?t_idx=<%=t_idx%>">수정</a>
				<a href="${cp}/tip/tipDel?t_idx=<%=t_idx%>">삭제</a>
			</div>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>