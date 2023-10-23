<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/main.css?ver=<%=System.currentTimeMillis()%>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic:wght@700;800&family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
</head>
<body>
<header id="mainHeader">
	<div class="header-rap">
		<!-- 로고 -->
		<div class = "main-tap">
			<a herf="" class = "logo">
				<img alt="로고" src="${cp}/resources/logo.jpg">
			</a><!-- 로고 이미지 넣어야함. -->
		
		
			<!-- 탭메뉴 -->
			<nav>
				<ul>
					<li>
						<span>
							<img alt="" src="*jpg">
							<span>리그오브레전드</span>
						</span>
					</li>
					<!-- 롤 제외 전부 주석
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
				</ul> -->
			</nav>
			
			<!--  ...버튼
			<div>
				<button class="">
					<img src ="*.jpg" alt="more">
				</button>
			</div>
		
			faq/피드백 버튼
			<div>
				<button class="">
					<span class="hidden">Theme Button</span>
				</button>
				
			</div> -->
		
			<!-- 다크모드 버튼
			<div>
				<button class="">
					<span class="hidden">Theme Button</span>
				</button>
			</div>
	 			-->		
			<!-- 언어선택
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
			</div> -->
			
			<!-- 로그인 -->
			<div class="Proclogin">
				<a href="${cp}/member/login" class="">로그인</a>
				<!-- 멤버.op.gg가서 로그인하고 다시 op.gg로 돌아옴. 참고 -->
			</div>
		</div>
	
		<!-- 메인탭 아래 보조 탭 -->
		<div class="sub-tap">
			<nav class="board-nav">
				<ul class="boards">
					<li class="board1">
						<a href="${cp}/board/teamMate?m_id=guest&m_pw=guest">
							<div data-key="HOME" class="css-7rk75k emmetr11">게시판1</div>
							<!-- data-key는 자바스크립트 사용자정의 데이터용. -->
						</a>
					</li>
					<li class="board2">
						<a href="${cp}/board/teamMate">
							<div data-key="CHAMPION" class="css-q3uz41 emmetr11">게시판2</div>
						</a>
					</li>
					<li class="board3">
						<a href="${cp}/board/teamMate">
							<div data-key="CHAMPION" class="css-q3uz41 emmetr11">게시판3</div>
						</a>
					</li>
				</ul>
				<!-- 마우스 오버시 색진해짐, 언더라인 누르면 링크이동 <a href="${cp}/guest/getList?page=1">방명록</a>-->
				<!--<button class="">
					<span class="logo"></span>
					<span>13.18</span>
					"패치노트 보기"
				</button>  -->
			</nav>
		</div>
	</div>
	</header>
	<div class="container">
	
	<div class="top_part">
		<div class = "logo_box">
			<a><img id="logo" alt="로고" src="${cp}/resources/img/Logo.png"></a>
		</div> 
			<form action="${cp}/board/searcing_player" method="post">
		<div class="search_box" alt="전적검색">
			<input class="search_blank" name="userName" placeholder="소환사 검색">
			<button type=submit>.GG</button>
		</div>
			</form>
		<a href="${cp}/board/searching_player?userName=hideonbush"><div class="function_button">페이커</div></a>
	</div>
