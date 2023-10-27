<%@page import="com.teamproject.spring.teamgg.vo.CompBoardVo"%>
<%@page import="com.teamproject.spring.teamgg.vo.CompCommentVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/free/freeRead.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/board_header.jsp" %>
<c:set var="userId" value="${sessionScope.m_id}" />
<%
	CompBoardVo read = (CompBoardVo)request.getAttribute("compRead");
	Long c_idx = read.getC_idx();
	String c_id = read.getC_id();
	String c_user = read.getC_user();
	String c_title = read.getC_title();	
	String c_content = read.getC_content();
	String c_date = read.getC_date();
%>	

<script type="text/javascript">
var isLoggedIn = <%= session.getAttribute("m_id") != null %>;
var currentUserId = "<%= session.getAttribute("m_id") %>";
var cId = "<%= c_id %>";
var userId = "<c:out value='${userId}' />";
var userName = "<c:out value='${userName}' />";
</script>

<div class="board_wrap">
	<div class="middle">
		<div class="focusbox" alt="전적검색">
			<form action="${cp}/board/searching_player" class="region">
					<div class="kr">
						<select id="kr">
							<option value="na">NA</option>
							<option value="kr" selected>KR</option>
							<option value="jp">JP</option>
						</select>
					</div>
			</form>
			<div class="searchbox">
				<input id="searchHome" name="search" autocomplete="off" type="text" placeholder="소환사명, 소환사명, ...">
				<div class="under-bar">
					<div class="search-panel">
						<div class="panel-rap">
							<div class="recent-search">최근검색</div>
							<div class="bookmarks-list">즐겨찾기</div>
							<ul class="cookies">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<button id="searchButton" class="search-button">
				<img src="${cp}/resources/free/img/LOGO_search.png" width="43" height="23">
			</button>
		</div>
	</div>
	
	<div class="read_container">
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
					<button type="button" id="login" title="로그인" onclick="window.location.href='${cp}/member/login'">로그인</button>
				</div>
			</div>
			<div class="boards_side">
			<p style="color: grey; font-size: 12px;">커뮤니티</p>
				<button type="button" id="side_free" onclick="window.location.href='${cp}/free/freeList'">자유게시판</button>
				<button type="button" id="side_tip" onclick="window.location.href='${cp}/tip/tipList'">정보게시판</button>
				<button type="button" id="side_comp" onclick="window.location.href='${cp}/comp/compList'">유저찾기게시판</button>
			</div>
		</div>

		<div class="read">
			<div class="read_head">
				<h1> <%=c_title %> </h1>
				<%= c_date %> / <%=c_user %>
			</div>
			<div class="content">
				<%=c_content %>
			</div>
		
			<div class="read_actions">
				<div class="read_action">
					<button type="button" id="read_action" onclick="location.href='${cp}/comp/compModify?c_idx=<%=c_idx%>'">수정</button>
					<button type="button" id="read_action" onclick="location.href='${cp}/comp/compDel?c_idx=<%=c_idx%>'">삭제</button>
				</div>
			</div>
			
<!-- 			댓글 -->
			<div class="commentForm">
				<form id="form" action="${cp}/comment/ccWrite" method="post">
			    	<input type="hidden" name="c_idx" value="<%=c_idx%>">
			    	<textarea class="comment" name="cc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentSubmit">
			    	<button type="submit">작성</button>
			   		</div>
				</form>
			</div>

			<div class="comments">
<!-- 			댓글 -->
				<c:forEach var="comment" items="${ccList}">
				<c:choose>
           		<c:when test="${comment.cc_num == 0}">
				<c:set var="cc_user" value="${comment.cc_user}" />
				<c:set var="cc_id" value="${comment.cc_id}" />
				<c:set var="cc_comment" value="${comment.cc_comment}" />
				<c:set var="cc_date" value="${comment.cc_date}" />
				<c:set var="cc_idx" value="${comment.cc_idx}" />
				<c:set var="cc_group" value="${comment.cc_group}" />
				
				    <div class="c_top">
				        <span class="user">${comment.cc_user}</span> <span class="date"> ${comment.cc_date}</span>
				    </div>
				    <div class="c_content">
				        ${comment.cc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-cc-group="${comment.cc_group}">
				        	<div class="btnTrue">
				        	<button class="replyForm-modify" id="comment_modify" data-cc-idx="${comment.cc_idx}" data-cc-id="${comment.cc_id}">수정</button>
							<button class="replyForm-delete" id="comment_delete" onclick="location.href='${cp}/comment/ccDel?cc_idx=${comment.cc_idx}'">삭제</button>
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
				        	<div class="btnFalse">
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
                            <div class="replyList hidden">
				        <c:forEach var="reply" items="${ccList}">
				        <c:set var="cc_user" value="${reply.cc_user}" />
				        <c:set var="cc_id" value="${reply.cc_id}" />
						<c:set var="cc_comment" value="${reply.cc_comment}" />
						<c:set var="cc_date" value="${reply.cc_date}" />
						<c:set var="cc_idx" value="${reply.cc_idx}" />
						<c:set var="cc_group" value="${reply.cc_group}" />
                        <c:choose>
                            <c:when test="${reply.cc_num != 0 && reply.cc_group == comment.cc_group}">
                            <div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
                                    <div class="r_top">
                                        <span class="user">${reply.cc_user}</span> <span class="date"> ${reply.cc_date}</span>
                                    </div>
                                    <div class="r_content">
                                        ${reply.cc_comment}
                                    </div>
                            <div class="btnTrue">
                            <button class="replyForm-modify" id="reply_modify" data-cc-idx="${reply.cc_idx} "data-cc-id="${reply.cc_id}">수정</button>
							<button class="replyForm-delete" id="reply_delete" onclick="location.href='${cp}/comment/ccDel?cc_idx=${reply.cc_idx}'">삭제</button>
                            </div>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    	<div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
					        <div class="replyForm hidden">
							    <form id="form" action="${cp}/comment/ccWrite" method="post">
							        <input type="hidden" name="c_idx" value="<%=c_idx%>">
							        <input type="hidden" name="cc_class" value="1">
							        <textarea class="comment" name="cc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="cc_group" value="${comment.cc_group}">
								    <div class="commentSubmit">
								    	<button type="submit">작성</button>
								    </div>
							    </form>
					        </div>
				        </div>
				   	</div>
				 </c:when>
        		</c:choose>
				</c:forEach>
			
			</div>
			
			<div class="modal" id="commentModal">
			    <div class="modal-content">
			        <form id="form" action="${cp}/comment/ccModify" method="post">
			            <input type="hidden" name="cc_idx">
			            <input type="hidden" name="c_idx" value="<%=c_idx%>">
			            <textarea id="modalForm" name="cc_comment" rows="4" cols="50"></textarea>
			            <div class="replyAction">
			                <button class="modalBtn" type="submit">수정</button>
			                <button class="modalBtn" type="button" id="modifyForm-cancel">취소</button>
			            </div>
			        </form>
			    </div>
			<div class="modal-background"></div>
			</div>
		</div>
	</div>

	<div class=bottom>
	</div>
</div>

<script type="text/javascript" src="${cp}/resources/free/freeBoard.js"></script>
<script type="text/javascript" src="${cp}/resources/comp/compRead.js"></script>
<script type="text/javascript" src="${cp}/resources/t.js?ver=<%= System.currentTimeMillis() %>"></script>
</body>
</html>