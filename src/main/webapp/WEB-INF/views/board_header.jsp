<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="com.teamproject.spring.teamgg.vo.TipBoardVo"%>
<%@page import="com.teamproject.spring.teamgg.vo.CompBoardVo"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />  
<c:set var="ts" value="<%= System.currentTimeMillis() %>" />

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
</head>
<body>

<c:set var="userName" value="${sessionScope.m_user}" />

<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/comp/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
					<div class="userName">
						<div id="userNameTop">
							<c:if test="${not empty userName}">
			      			<p>${userName}</p>
		    				</c:if>
						</div>
					</div>
					<div class="Proclogin">
						<% if (session.getAttribute("m_id") != null) { %>
		       				 <a href="${cp}/member/logout" class="">로그아웃</a>
					    <% } else { %>
					    	 <a href="${cp}/member/login" class="">로그인</a>
					    <% } %>
					</div>
				</div>
				<div class="headBot">
					<div class="boards_head">
						<div id="head_free">
							<a href="${cp}/free/freeList">자유게시판</a>
						</div>
						<div id="head_tip">
							<a href="${cp}/tip/tipList">정보게시판</a>
						</div>
						<div id="head_comp">
							<a href="${cp}/comp/compList">유저찾기게시판</a>
						</div>
					</div>
				</div>
		</div>
	</div>

<script type="text/javascript" src="${cp}/resources/free/freeBoard.js"></script>
</body>
</html>