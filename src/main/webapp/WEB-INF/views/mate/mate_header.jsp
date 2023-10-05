<%@page import="com.teamproject.spring.teamgg.vo.MateBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateList.css">
</head>
<body>

<c:set var="userName" value="${sessionScope.m_user}" />

<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/mate/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
					<div class="userName">
						<c:if test="${not empty userName}">
		      			<p>${userName}</p>
		    			</c:if>
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
							<a href="${cp}/free/freeList">자유게시판</a>
							<a href="${cp}/tip/tipList">정보게시판</a>
							<a href="${cp}/mate/mateList">유저찾기게시판</a>
					</div>
				</div>
		</div>
	</div>

</body>
</html>