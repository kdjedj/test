<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
<script src="${cp}/resources/free/a.css?ver=${ts}"></script>
</head>
<body>

	<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/free/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
				유저명/로그인
				</div>
				<div class="boards_head">
						<a href="${cp}/free/freeList?page=1">자유게시판
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
				<button type="button" id="write" title="글쓰기" onclick="location.href='freeWrite'">글쓰기</button>
			</div>
<%
	Object o = request.getAttribute("list");
	List<FreeBoardVo> list = (List<FreeBoardVo>) o; 
	for(int i=0;i<list.size();i++){
		Long f_idx = list.get(i).getF_idx();
		String f_title = list.get(i).getF_title();
		Date f_date = list.get(i).getF_date();
		String f_writer = list.get(i).getF_writer();
%>	
			<ul class="post">
            	<li class="posts w500"><%=f_idx%></li>
            	<li class="posts w2500"><a href="freeRead?f_idx=<%=f_idx%>"><%=f_title %></a></li>
            	<li class="posts"><%=f_date%></li>
            	<li class="posts"><%=f_writer%></li>
			</ul>
<%
	}
%>
			<div class="paging">
				<c:choose>
				    <c:when test="${hasPrev == true}">
				        [<a href="${cp}/free/freeList?page=${prevPage}"><b>이전</b></a>]
				    </c:when>
				    <c:otherwise>
				        [이전]
				    </c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
					[<a href="${cp}/free/freeList?page=${p}">${p}</a>]
				</c:forEach>
				
				<c:choose>
					<c:when test="${hasNext == true }">
						[<a href="${cp}/free/freeList?page=${nextPage}"><b>다음</b></a>]
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