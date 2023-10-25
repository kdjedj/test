<%@page import="java.util.ArrayList"%>
<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeWrite.css">
</head>
<body>
<%@include file="free_header.jsp" %>
<%
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	long f_idx = read.getF_idx();
	String f_content = read.getF_content();
%>
<script type="text/javascript">
var userName = "<c:out value='${userName}' />";
</script>

<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off" type="text" placeholder="소환사 검색">
					</div>	
	</div>
	<div class="write_container">
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
					<button type="button" id="write" title="글쓰기" onclick="location.href='freeWrite'">글쓰기</button>
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
		<div class="write">
			<div class="writeForm">
			<form id="form" action="${cp}/free/freeModify" method="post" accept-charset="utf-8">
			<input type="hidden" name='f_idx' value='<%=f_idx %>' >
				<div class="title">
			    <input type="text" id="title" name="f_title" placeholder="제목" required><br>
				</div>
				
				<div class="content">
			    <textarea rows="40" id="content" name="f_content" required></textarea><br>
				</div>
			
		<div class="write_actions">
			<div>
			    <input type="button" id="cancel" value="취소" onclick="goBack()">
			</div>
			<div>
			    <input type="button" id="publish" value="작성" onclick="submitForm()">
			</div>
		</div>
			</form>
			</div>
		</div>
		
	</div>
	<div class=bottom>
	</div>
</div>

<script type="text/javascript" src="${cp}/resources/free/freeBoard.js"></script>
<script type="text/javascript" src="${cp}/resources/free/freeWrite.js"></script>
</body>
</html>