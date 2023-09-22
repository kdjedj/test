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
<title>로그인</title>
<link rel="stylesheet" href="${cp}/resources/css/Login.css" />
</head>
<body>
	<div class="container">
		<form action="${cp}/member/login" method="post">
			<div class="container">
				<a href="/teamgg" id="logo"><img
					src="${cp}/resources/img/Logo.png" id="logoimg"></a>
			</div>
			<h1>로그인</h1>
			<div class="form-control">
				<input type="text" name="m_id" id="m_id" required /> <label>ID</label>
			</div>
			<div class="form-control">
				<input type="password" name="m_pw" id="m_pw" required /> <label>Password</label>
			</div>
			<input type="submit" class="btn" value="로그인">
			<p class="text">
				계정이 없나요? <a href="${cp}/member/register">회원가입</a>
			</p>
		</form>
		<div style="text-align: center;">
			<span id="clock" style="color: rgb(222, 220, 238); font-size: 60px;"></span>
			<span id="apm" style="color: rgb(222, 220, 238); font-size: 30px;"></span>
		</div>
	</div>
	<script src="${cp}/resources/js/popword.js"></script>
	<script src="${cp}/resources/js/time.js"></script>
</body>
</html>