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
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- my css -->
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/searchingPage.css?ver=<%=System.currentTimeMillis()%>">

<link rel="stylesheet" type="text/css" href="${cp}/resources/freeList.css?ver=<%=System.currentTimeMillis()%>">
<script type="text/javascript" src="${cp}/resources/searchingPage.js?ver=<%= System.currentTimeMillis() %>"></script></head>
<body>

<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
				유저명/로그인
				</div>
				<div class="boards_head">
						<a href="${cp}/free/freeList?page=1">자유게시판
<!-- 							<div data-key="HOME" class="css-7rk75k emmetr11">자유게시판</div> -->
							<!-- data-key는 자바스크립트 사용자정의 데이터용. -->
						</a> 게시판 2 게시판 3
				</div>
		</div>
	</div>

