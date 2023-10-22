<%@page import="com.teamproject.spring.teamgg.vo.CompBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/comp/compList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/comp/compRead.css">
</head>
<body>
<%@include file="comp_header.jsp" %>
<%
CompBoardVo read = (CompBoardVo)request.getAttribute("compRead");
	Long c_idx = read.getC_idx();
	String c_id = read.getC_id();
	String c_user = read.getC_user();
	String c_title = read.getC_title();	
	String c_content = read.getC_content();
	String c_date = read.getC_date();
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
<h1> <%=c_title %> </h1>
<%= c_date %> <%=c_user %>
			</div>
			<div class="content">
<%=c_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/comp/compList">리스트</a>
				<a href="${cp}/comp/compModify?c_idx=<%=c_idx%>">수정</a>
				<a href="${cp}/comp/compDel?c_idx=<%=c_idx%>">삭제</a>
			</div>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>