<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<header class="">
	<div class="css-1kmtcjv.e1ua6u350">
		<!-- 로고 -->
		<div class = "css">
			<a herf="" class = "logo">
				<img alt="로고" src="*.jpg">
			</a><!-- 로고 이미지 넣어야함. -->
		</div>
		
		<!-- 탭메뉴 -->
		<nav>
			<ul>
				<li>
					<span>
						<img alt="롤아이콘" src="*jpg">
						<span>리그오브레전드</span>
					</span>
				</li>
				<li>
					<span>
						<img alt="tft아이콘" src="*jpg">
						<span>전략적 팀 전투</span>
					</span>
				</li>
				<li>
					<span>
						<img alt="오버워치2아이콘" src="*jpg">
						<span>오버워치2</span>
					</span>
				</li>
			</ul>
		</nav>
		
		<!-- ...버튼 -->
		<div>
			<button class="">
				<img src ="*.jpg" alt="more">
			</button>
		</div>
	
		<!-- faq/피드백 버튼 -->
		<div>
			<button class="">
				<span class="hidden">Theme Button</span>
			</button>
		</div>
	
		<!-- 다크모드 버튼 -->
		<div>
			<button class="">
				<span class="hidden">Theme Button</span>
			</button>
		</div>
		
		<!-- 언어선택 -->
		<div class="">
			<img alt="" src="*.jpg">
			<div class="">
				<label class="hidden" for="ko_KR">ko_KR</label>
				<select id="ko_KR">
					<option value="en_US" selected>English</option>
					<option value="ko_KR" selected>한국어</option>
					<option value="ja_JP" selected>日本語</option>
				</select>
			</div>	
		</div>
		
		<!-- 로그인 -->
		<div class="">
			<a href="" class="">로그인</a>
		</div>
	</div>
	<div class="css-4llake emmetr10">
		<nav class="route-nav">
			<ul class="route-list">
				<li class="route-item">
					<a href="/">
						<div data-key="HOME" class="css-7rk75k emmetr11">홈</div>
					</a>
				</li>
				<li class="route-item">
					<a href="/champions">
						<div data-key="CHAMPION" class="css-q3uz41 emmetr11">챔피언 분석</div>
					</a>
				</li>
			</ul>
			<button class="">
				<span class="logo"></span>
				<span>13.18</span>
				"패치노트 보기"
			</button>
		</nav>
	</div>
</header>

<P>  The time on the server is ${serverTime}. </P>

<a href="${cp}/guest/getList?page=1">방명록</a>

<hr>
<a href="${cp}/member/login">로그인</a>
<a href="${cp}/member/logout">로그아웃</a>

<a href="${cp}/member/reg">회원가입</a>

id:${id} , pw:${pw}


</body>
</html>
