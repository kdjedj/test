<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link rel="stylesheet" href="${cp}/resources/Singup.css"/>
</head>
<body>
	<div class="container">
		<form action="${cp}/member/register" method="post">
			<div class="container">
				<h1>
					<a href="main.jsp" id="logo">로고 자리</a>
				</h1>
			</div>
			<div class="form-control">
				<input type="text" id="m_id" name="m_id" required> <label>ID</label>
			</div>
			<div class="form-control">
				<input type="password" id="m_pw" name="m_pw" required> <label>Password</label>
			</div>
			<div class="form-control">
				<input type="text" id="m_user" name="m_user" required> <label>Nickname</label>
			</div>
			<div class="form-control">
				<input type="text" id="m_email" name="m_email" required> <label>Email</label>
			</div>
			<input type="submit" class="btn" value="회원가입">
			<button class="btn" type="reset">리셋</button>
			<div style="text-align: center;">
				<span id="clock" style="color: gray; font-size: 60px;"></span> <span
					id="apm" style="color: gray; font-size: 30px;"></span>
			</div>
		</form>
	</div>
	<script src="${cp}/resources/popword.js"></script>
	<script src="${cp}/resources/time.js"></script>
</body>
</html>