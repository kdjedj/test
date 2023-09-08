<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!-- x. 버전용 -->
<c:set var="ts" value="<%= System.currentTimeMillis() %>" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="${cp}/resources/testapi.js?ver=${ts}"></script>
<link rel="stylesheet" href="${cp}/resources/c.css">
</head>
<body>
ajax api 테스트
<hr>

<button id="cat1">삵</button>
<div id="cat1_area"></div>
<button id="cat2">칡</button>
<div id="cat2_area"></div>

<fieldset>
	<legend>jquery-애니</legend>
	<div id="cat">고양이</div>
</fieldset>


</body>
</html>