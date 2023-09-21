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
	String f_writer = read.getF_writer();
	String f_title = read.getF_title();	
	String f_content = read.getF_content();
	Date f_date = read.getF_date();
	
	HttpSession sessionobj = request.getSession();
	String userId = (String) session.getAttribute("m_id");
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
<%= f_date %> <%=f_writer %>
			</div>
			<div class="content">
<%=f_content %>
<br>
<p>userId: <%= userId %></p>
<p>f_writer: <%=f_writer %></p>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/free/freeList">리스트</a>
				<c:if test="${userId eq f_writer}">
            <h2>유저 동일</h2> 
                    <a href="${cp}/free/freeModify?f_idx=${f_idx}">수정</a>
                    <a href="${cp}/free/freeDel?f_idx=${f_idx}">삭제</a>
            </c:if>
            <c:if test="${userId eq f_writer}"> 
               <h2>유저 불일치</h2> 
               </c:if>
<!-- 				if문 동작안함지금 -->
<%-- 				<c:if test="${sessionScope.m_id eq f_writer}"> --%>
<%-- 				        <a href="${cp}/free/freeModify?f_idx=${f_idx}">수정</a> --%>
<%-- 				        <a href="${cp}/free/freeDel?f_idx=${f_idx}">삭제</a> --%>
<%-- 				</c:if> --%>
			</div>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>