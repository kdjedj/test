<%@page import="com.teamproject.spring.teamgg.vo.TipBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipList.css">
<script src="${cp}/resources/tip/a.css?ver=${ts}"></script>
</head>
<body>

	<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/tip/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
				<a href="${cp}/member/login">유저명/로그인</a>
				</div>
				<div class="boards_head">
						<a href="${cp}/tip/tipList">자유게시판
<!-- 						<div data-key="HOME" class="css-7rk75k emmetr11">자유게시판</div> -->
							<!-- data-key는 자바스크립트 사용자정의 데이터용. -->
						</a> 게시판 2 게시판 3
				</div>
		</div>
	</div>
	
<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off"
						type="text" placeholder="소환사 검색">
					</div>	
	</div>
	
	<div class="container">
		<div class="sideMenu">
			<div id="profileBox">
			</div>
			<div id="boards_container">
			</div>
		</div>
		<div class="list">
			<div class="list_head">
				<h1> 자유 </h1>
				<button type="button" id="write" title="글쓰기" onclick="location.href='tipWrite'">글쓰기</button>
			</div>
<%
	Object o = request.getAttribute("list");
	List<TipBoardVo> list = (List<TipBoardVo>) o; 
	for(int i=0;i<list.size();i++){
		Long t_idx = list.get(i).getT_idx();
		String t_title = list.get(i).getT_title();
		Date t_date = list.get(i).getT_date();
		String t_writer = list.get(i).getT_writer();
%>	
			<ul class="post">
            	<li class="posts w500"><%=t_idx%></li>
            	<li class="posts w2500"><a href="tipRead?f_idx=<%=t_idx%>"><%=t_title %></a></li>
            	<li class="posts"><%=t_date%></li>
            	<li class="posts"><%=t_writer%></li>
			</ul>
<%
	}
%>
			<div class="paging">
				<c:choose>
				    <c:when test="${hasPrev == true}">
				        [<a href="${cp}/tip/tipList?page=${prevPage}"><b>이전</b></a>]
				    </c:when>
				    <c:otherwise>
				        [이전]
				    </c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
					[<a href="${cp}/tip/tipList?page=${p}">${p}</a>]
				</c:forEach>
				
				<c:choose>
					<c:when test="${hasNext == true }">
						[<a href="${cp}/tip/tipList?page=${nextPage}"><b>다음</b></a>]
						</c:when>
						<c:otherwise>
							[다음]
						</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>