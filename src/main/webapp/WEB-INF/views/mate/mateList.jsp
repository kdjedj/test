<%@page import="com.teamproject.spring.teamgg.vo.MateBoardVo"%>
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
<link rel="stylesheet" type="text/css" href="${cp}/resources/mate/mateList.css">
</head>
<body>

	<div class="head">
		<div class="logoBox">	
			<a href="${cp}/">
				<img class="logo" alt="로고" src="${cp}/resources/mate/img/LOGO_small_2.png">
			</a>
		</div>
		<div class="headTab">
				<div class="headTop">
				유저명
				<a href="${cp}/member/login">로그인</a>
				</div>
				<div class="boards_head">
						<a href="${cp}/free/freeList">자유게시판</a>
						<a href="${cp}/tip/tipList">정보게시판</a>
						<a href="${cp}/mate/mateList">유저찾기게시판</a>
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
				<h1> 유저찾기 </h1>
				<button type="button" id="write" title="글쓰기" onclick="location.href='mateWrite'">글쓰기</button>
			</div>
<%
	Object o = request.getAttribute("list");
	List<MateBoardVo> list = (List<MateBoardVo>) o; 
	for(int i=0;i<list.size();i++){
		Long m_idx = list.get(i).getM_idx();
		String m_title = list.get(i).getM_title();
		Date m_date = list.get(i).getM_date();
		String m_writer = list.get(i).getM_writer();
%>	
			<ul class="post">
            	<li class="posts w500"><%=m_idx%></li>
            	<li class="posts w2500"><a href="mateRead?m_idx=<%=m_idx%>"><%=m_title %></a></li>
            	<li class="posts"><%=m_date%></li>
            	<li class="posts"><%=m_writer%></li>
			</ul>
<%
	}
%>
			<div class="paging">
				<c:choose>
				    <c:when test="${hasPrev == true}">
				        [<a href="${cp}/mate/mateList?page=${prevPage}"><b>이전</b></a>]
				    </c:when>
				    <c:otherwise>
				        [이전]
				    </c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
					[<a href="${cp}/mate/mateList?page=${p}">${p}</a>]
				</c:forEach>
				
				<c:choose>
					<c:when test="${hasNext == true }">
						[<a href="${cp}/mate/mateList?page=${nextPage}"><b>다음</b></a>]
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