<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%= System.currentTimeMillis() %>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/header.css?ver=<%=System.currentTimeMillis()%>">
<script type="text/javascript" src="${cp}/resources/header.js?ver=<%= System.currentTimeMillis() %>"></script>

</head>
<body>
<header class="header">
	<div class="header-rap">
		<!-- 로고 -->
		<div class = "main-tab">
			<a href="${cp}/" class = "logo">
				<img alt="로고" src="${cp}/resources/Logo_white.png">
			</a>
		
			<!-- 게임탭메뉴 -->
			<nav>
				<ul>
					<li>
						<span>
							<img alt="lol" src="${cp}/resources/lol_client_logo.png">
							<span>리그오브레전드</span>
						</span>
					</li>
				</ul>
			</nav>	
			<!-- 로그인 -->
			<div class="Proclogin">
				<% if (session.getAttribute("m_id") != null) { %>
       				 <a href="${cp}/member/logout" class="">로그아웃</a>
			    <% } else { %>
			    	 <a href="${cp}/member/login" class="">로그인</a>
			    <% } %>
			</div>
		</div>
	
		<!-- 메인탭 아래 보조 탭 -->
		<div class="sub-tab">
			<nav class="board-nav">
				<ul class="boards">
					<li class="board1">
						<a href="${cp}/free/freeList">
							<div>자유게시판</div>
						</a>
					</li>
					<li class="board2">
						<a href="${cp}/tip/tipList">
							<div>정보게시판</div>
						</a>
					</li>
					<li class="board3">
						<a href="${cp}/comp/compList">
							<div>유저찾기게시판</div>
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
</body>
</html>