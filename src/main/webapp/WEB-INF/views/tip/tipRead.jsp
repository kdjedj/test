<%@page import="com.teamproject.spring.teamgg.vo.TipBoardVo"%>
<%@page import="com.teamproject.spring.teamgg.vo.TipCommentVo"%>
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
	TipBoardVo read = (TipBoardVo)request.getAttribute("tipRead");
	Long t_idx = read.getT_idx();
	String t_id = read.getT_id();
	String t_user = read.getT_user();
	String t_title = read.getT_title();	
	String t_content = read.getT_content();
	String t_date = read.getT_date();
%>	

<script type="text/javascript">
var isLoggedIn = <%= session.getAttribute("m_id") != null %>;
var currentUserId = "<%= session.getAttribute("m_id") %>";
var tId = "<%= t_id %>";
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
					<button type="button" id="write" title="글쓰기" onclick="location.href='tipWrite'">글쓰기</button>
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
				<h1> <%=t_title %> </h1>
				<%= t_date %> / <%=t_user %>
			</div>
			<div class="content">
				<%=t_content %>
			</div>
		
			<div class="read_actions">
				<div class="read_action">
					<button type="button" id="read_action" onclick="location.href='${cp}/tip/tipModify?t_idx=<%=t_idx%>'">수정</button>
					<button type="button" id="read_action" onclick="location.href='${cp}/tip/tipDel?t_idx=<%=t_idx%>'">삭제</button>
				</div>
			</div>
			
<!-- 			댓글 -->
			<div class="commentForm">
				<form id="form" action="${cp}/comment/tcWrite" method="post">
			    	<input type="hidden" name="t_idx" value="<%=t_idx%>">
			    	<textarea class="comment" name="tc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentSubmit">
			    	<button type="submit">작성</button>
			   		</div>
				</form>
			</div>

			<div class="comments">
<!-- 			댓글 -->
				<c:forEach var="comment" items="${tcList}">
				<c:choose>
           		<c:when test="${comment.tc_num == 0}">
				<c:set var="tc_user" value="${comment.tc_user}" />
				<c:set var="tc_id" value="${comment.tc_id}" />
				<c:set var="tc_comment" value="${comment.tc_comment}" />
				<c:set var="tc_date" value="${comment.tc_date}" />
				<c:set var="tc_idx" value="${comment.tc_idx}" />
				<c:set var="tc_group" value="${comment.tc_group}" />
				
				    <div class="c_top">
				        <span class="user">${comment.tc_user}</span> <span class="date"> ${comment.tc_date}</span>
				    </div>
				    <div class="c_content">
				        ${comment.tc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-tc-group="${comment.tc_group}">
				        	<div class="btnTrue">
				        	<button class="replyForm-modify" id="comment_modify" data-tc-idx="${comment.tc_idx}" data-tc-id="${comment.tc_id}">수정</button>
							<button class="replyForm-delete" id="comment_delete" onclick="location.href='${cp}/comment/tcDel?tc_idx=${comment.tc_idx}'">삭제</button>
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
				        	<div class="btnFalse">
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
                            <div class="replyList hidden">
				        <c:forEach var="reply" items="${tcList}">
				        <c:set var="tc_user" value="${reply.tc_user}" />
				        <c:set var="tc_id" value="${reply.tc_id}" />
						<c:set var="tc_comment" value="${reply.tc_comment}" />
						<c:set var="tc_date" value="${reply.tc_date}" />
						<c:set var="tc_idx" value="${reply.tc_idx}" />
						<c:set var="tc_group" value="${reply.tc_group}" />
                        <c:choose>
                            <c:when test="${reply.tc_num != 0 && reply.tc_group == comment.tc_group}">
                            <div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
                                    <div class="r_top">
                                        <span class="user">${reply.tc_user}</span> <span class="date"> ${reply.tc_date}</span>
                                    </div>
                                    <div class="r_content">
                                        ${reply.tc_comment}
                                    </div>
                            <div class="btnTrue">
                            <button class="replyForm-modify" id="reply_modify" data-tc-idx="${reply.tc_idx} "data-tc-id="${reply.tc_id}">수정</button>
							<button class="replyForm-delete" id="reply_delete" onclick="location.href='${cp}/comment/tcDel?tc_idx=${reply.tc_idx}'">삭제</button>
                            </div>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    	<div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
					        <div class="replyForm hidden">
							    <form id="form" action="${cp}/comment/tcWrite" method="post">
							        <input type="hidden" name="t_idx" value="<%=t_idx%>">
							        <input type="hidden" name="tc_class" value="1">
							        <textarea class="comment" name="tc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="tc_group" value="${comment.tc_group}">
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
			        <form id="form" action="${cp}/comment/tcModify" method="post">
			            <input type="hidden" name="tc_idx">
			            <input type="hidden" name="t_idx" value="<%=t_idx%>">
			            <textarea id="modalForm" name="tc_comment" rows="4" cols="50"></textarea>
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
<script type="text/javascript" src="${cp}/resources/tip/tipRead.js"></script>
<script type="text/javascript" src="${cp}/resources/t.js?ver=<%= System.currentTimeMillis() %>"></script>
</body>
</html>