<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="com.teamproject.spring.teamgg.vo.FreeCommentVo"%>
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
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	Long f_idx = read.getF_idx();
	String f_id = read.getF_id();
	String f_user = read.getF_user();
	String f_title = read.getF_title();	
	String f_content = read.getF_content();
	String f_date = read.getF_date();
%>	

<script type="text/javascript">
var isLoggedIn = <%= session.getAttribute("m_id") != null %>;
var currentUserId = "<%= session.getAttribute("m_id") %>";
var fId = "<%= f_id %>";
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
					<button type="button" id="write" title="글쓰기" onclick="location.href='freeWrite'">글쓰기</button>
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
				<h1> <%=f_title %> </h1>
				<%= f_date %> / <%=f_user %>
			</div>
			<div class="content">
				<%=f_content %>
			</div>
		
			<div class="read_actions">
				<div class="read_action">
					<button type="button" id="read_action" onclick="location.href='${cp}/free/freeModify?f_idx=<%=f_idx%>'">수정</button>
					<button type="button" id="read_action" onclick="location.href='${cp}/free/freeDel?f_idx=<%=f_idx%>'">삭제</button>
				</div>
			</div>
			
<!-- 			댓글 -->
			<div class="commentForm">
				<form id="form" action="${cp}/comment/fcWrite" method="post">
			    	<input type="hidden" name="f_idx" value="<%=f_idx%>">
			    	<textarea class="comment" name="fc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentSubmit">
			    	<button type="submit">작성</button>
			   		</div>
				</form>
			</div>

			<div class="comments">
<!-- 			댓글 -->
				<c:forEach var="comment" items="${fcList}">
				<c:choose>
           		<c:when test="${comment.fc_num == 0}">
				<c:set var="fc_user" value="${comment.fc_user}" />
				<c:set var="fc_id" value="${comment.fc_id}" />
				<c:set var="fc_comment" value="${comment.fc_comment}" />
				<c:set var="fc_date" value="${comment.fc_date}" />
				<c:set var="fc_idx" value="${comment.fc_idx}" />
				<c:set var="fc_group" value="${comment.fc_group}" />
				
				    <div class="c_top">
				        <span class="user">${comment.fc_user}</span> <span class="date"> ${comment.fc_date}</span>
				    </div>
				    <div class="c_content">
				        ${comment.fc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-fc-group="${comment.fc_group}">
				        	<div class="btnTrue">
				        	<button class="replyForm-modify" id="comment_modify" data-fc-idx="${comment.fc_idx}" data-fc-id="${comment.fc_id}">수정</button>
							<button class="replyForm-delete" id="comment_delete" onclick="location.href='${cp}/comment/fcDel?fc_idx=${comment.fc_idx}'">삭제</button>
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
				        	<div class="btnFalse">
				            <button class="replyForm-btn" id="comment_reply">답글</button>
				        	</div>
                            <div class="replyList hidden">
				        <c:forEach var="reply" items="${fcList}">
				        <c:set var="fc_user" value="${reply.fc_user}" />
				        <c:set var="fc_id" value="${reply.fc_id}" />
						<c:set var="fc_comment" value="${reply.fc_comment}" />
						<c:set var="fc_date" value="${reply.fc_date}" />
						<c:set var="fc_idx" value="${reply.fc_idx}" />
						<c:set var="fc_group" value="${reply.fc_group}" />
                        <c:choose>
                            <c:when test="${reply.fc_num != 0 && reply.fc_group == comment.fc_group}">
                            <div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
                                    <div class="r_top">
                                        <span class="user">${reply.fc_user}</span> <span class="date"> ${reply.fc_date}</span>
                                    </div>
                                    <div class="r_content">
                                        ${reply.fc_comment}
                                    </div>
                            <div class="btnTrue">
                            <button class="replyForm-modify" id="reply_modify" data-fc-idx="${reply.fc_idx} "data-fc-id="${reply.fc_id}">수정</button>
							<button class="replyForm-delete" id="reply_delete" onclick="location.href='${cp}/comment/fcDel?fc_idx=${reply.fc_idx}'">삭제</button>
                            </div>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                    	<div class="reply_mark" style="font-size: 22px; color: lightgrey;">┗</div>
					        <div class="replyForm hidden">
							    <form id="form" action="${cp}/comment/fcWrite" method="post">
							        <input type="hidden" name="f_idx" value="<%=f_idx%>">
							        <input type="hidden" name="fc_class" value="1">
							        <textarea class="comment" name="fc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="fc_group" value="${comment.fc_group}">
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
			        <form id="form" action="${cp}/comment/fcModify" method="post">
			            <input type="hidden" name="fc_idx">
			            <input type="hidden" name="f_idx" value="<%=f_idx%>">
			            <textarea id="modalForm" name="fc_comment" rows="4" cols="50"></textarea>
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

<script type="text/javReadipt" src="${cp}/resources/free/freeBoard.js"></script>
<script type="text/javascript" src="${cp}/resources/free/freeRead.js"></script>
<script type="text/javascript" src="${cp}/resources/t.js?ver=<%= System.currentTimeMillis() %>"></script>
</body>
</html>