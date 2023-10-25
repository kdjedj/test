<%@page import="com.teamproject.spring.teamgg.vo.CompBoardVo"%>
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
</head>
<body>
<c:set var="userName" value="${sessionScope.m_user}" />
<script type="text/javascript">
var userName = "<c:out value='${userName}' />";
</script>
<%@include file="/WEB-INF/views/header.jsp" %>
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
				<div class="userName side">
					<c:choose>
					    <c:when test="${not empty userName}">
					        <p>${userName}</p>
					    </c:when>
					    <c:otherwise>
					        <p>로그인이 필요합니다.</p>
					    </c:otherwise>
					</c:choose>
				</div>
				<div class="side_btn">
					<button type="button" id="write" title="글쓰기" onclick="location.href='compWrite'">글쓰기</button>
				</div>
				<div class="side_btn">
					<button type="button" id="login" title="로그인" onclick="location.href='${cp}/member/login'">로그인</button>
				</div>
			</div>
			<div class="boards_side">
			<p style="color: grey; font-size: 12px;">커뮤니티</p>
				<button type="button" id="side_free" onclick="window.location.href='${cp}/free/freeList'">자유게시판</button>
				<button type="button" id="side_tip" onclick="window.location.href='${cp}/tip/tipList'">정보게시판</button>
				<button type="button" id="side_comp" onclick="window.location.href='${cp}/comp/compList'">유저찾기게시판</button>
			</div>
		</div>
		<div class="list">
			<div class="list_head">
				<h1 style="color: rgb(106,96,169)"> 유저찾기 </h1>
			</div>
			<div id="postBox">
<c:forEach var="item" items="${list}">
    <c:set var="c_idx" value="${item.c_idx}" />
    <c:set var="c_title" value="${item.c_title}" />
    <c:set var="c_date" value="${item.c_date}" />
    <c:set var="c_id" value="${item.c_id}" />
    <c:set var="c_user" value="${item.c_user}" />
    	<div class="postBox">
			<ul class="post">
            	<li class="posts idx">${item.c_idx}</li>
            	<li class="posts title"><a href="compRead?c_idx=${item.c_idx}">${item.c_title}</a></li>
            	<li class="posts date">${item.c_date}</li>
            	<li class="posts user">${item.c_user}</li>
			</ul>
    	</div>
</c:forEach>
			</div>

			<div class="paging">
				<c:choose>
				    <c:when test="${hasPrev == true}">
				        [<a href="${cp}/comp/compList?page=${prevPage}"><b>이전</b></a>]
				    </c:when>
				    <c:otherwise>
				        [이전]
				    </c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
					[<a href="${cp}/comp/compList?page=${p}">${p}</a>]
				</c:forEach>
				
				<c:choose>
					<c:when test="${hasNext == true }">
						[<a href="${cp}/comp/compList?page=${nextPage}"><b>다음</b></a>]
						</c:when>
						<c:otherwise>
							[다음]
						</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<div class=bottom>
	</div>
</div>

<script type="text/javascript" src="${cp}/resources/free/freeBoard.js"></script>
</body>
</html>