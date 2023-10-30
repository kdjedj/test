<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/main.css?ver=<%= System.currentTimeMillis() %>">
<script type="text/javascript" src="${cp}/resources/home.js?ver=<%= System.currentTimeMillis() %>"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/main.css?ver=<%=System.currentTimeMillis()%>">

</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<div class="container">
	<!--  <P>  The time on the server is ${serverTime}. </P>-->
	<div class="middle">
	
		<div class = "logo">
			<a><img alt="로고" src="${cp}/resources/Logo.png"></a>
		</div>
		<div class="focusbox" alt="전적검색">
			<form action="${cp}/board/searching_player" class="region">
				<div>
					<small class="label">Region</small>
					<div class="">
						<label class="hidden" for="kr">kr</label>
						<select id="kr" name="region">
							<option value="na1">NA</option>
							<option value="kr" selected>KR</option>
							<option value="jp1">JP</option>
						</select>
					</div>
				</div>
			</form>
			<div class="searchbox">
				<label for="searchHome" class="label">Search</label>
				<input id="searchHome" name="search" autocomplete="off" type="text" placeholder="소환사명, 소환사명, ...">
				<div class="under-bar">
					<div class="search-panel">
						<div class="panel-rap">
							<div class="recent-search">최근검색</div>
							<div class="bookmarks-list">즐겨찾기</div>
							<ul class="cookies">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<button id="searchButton" class="search-button">검색</button>
		</div>
	</div>
</div>
	
<!-- <div class="footer">
	<div class="footer-rap">
	</div>
</div> -->
</body>
</html>