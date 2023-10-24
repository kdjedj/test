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
<link rel="stylesheet" type="text/css" href="${cp}/resources/comp/compList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/comp/compRead.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp" %>
<%
CompBoardVo read = (CompBoardVo)request.getAttribute("compRead");
	Long c_idx = read.getC_idx();
	String c_id = read.getC_id();
	String c_user = read.getC_user();
	String c_title = read.getC_title();	
	String c_content = read.getC_content();
	String c_date = read.getC_date();
%>	

<div class="board_wrap">
	<div class="middle">
					<div>
						<input id="search" name="search" autocomplete="off" type="text" placeholder="소환사 검색">
					</div>	
	</div>
	
	<div class="read_container">
		<div class="sideMenu">
			<div id="profileBox">
			</div>
			<div id="boards_container">
			</div>
		</div>
		<div class="read">
			<div class="read_head">
<h1> <%=c_title %> </h1>
<%= c_date %> <%=c_user %>
			</div>
			<div class="content">
<%=c_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/comp/compList">리스트</a>
				<a href="${cp}/comp/compModify?c_idx=<%=c_idx%>">수정</a>
				<a href="${cp}/comp/compDel?c_idx=<%=c_idx%>">삭제</a>
			</div>

<!-- 			댓글 -->
			<div class="commentForm">
				<form action="${cp}/comment/ccWrite" method="post">
			    	<input type="hidden" name="c_idx" value="<%=c_idx%>">
			    	<textarea name="cc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentAction">
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
				        ${comment.cc_user} ${comment.cc_date}
				    </div>
				    <div class="c_content">
				        ${comment.cc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-cc-group="${comment.cc_group}">
				        	<button class="replyForm-modify" data-cc-idx="${comment.cc_idx}" data-cc-id="${comment.cc_id}">수정</button>
							<a href="${cp}/comment/ccDel?cc_idx=${comment.cc_idx}">삭제</a>
				            <button class="replyForm-btn">답글쓰기</button>
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
                                    <div class="c_top">
                                        ${reply.cc_user} ${reply.cc_date}
                                    </div>
                                    <div class="c_content">
                                        ${reply.cc_comment}
                                    </div>
                            <button class="replyForm-modify" data-cc-idx="${reply.cc_idx} "data-cc-id="${reply.cc_id}">수정</button>
							<a href="${cp}/comment/ccDel?cc_idx=${reply.cc_idx}">삭제</a>
                            </c:when>
                        </c:choose>
                    </c:forEach>
					        <div class="replyForm hidden">
							    <form action="${cp}/comment/ccWrite" method="post">
							        <input type="hidden" name="c_idx" value="<%=c_idx%>">
							        <input type="hidden" name="cc_class" value="1">
							        <textarea name="cc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="cc_group" value="${comment.cc_group}">
								    <div class="replyAction">
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
			        <form action="${cp}/comment/ccModify" method="post">
			            <input type="hidden" name="cc_idx">
			            <input type="hidden" name="c_idx" value="<%=c_idx%>">
			            <textarea name="cc_comment" rows="4" cols="50"></textarea>
			            <div class="replyAction">
			                <button type="submit">수정</button>
			                <button type="button" class="modifyForm-cancel">취소</button>
			            </div>
			        </form>
			    </div>
			<div class="modal-background"></div>
			</div>
			
			<script>
			
			var replyButtons = document.querySelectorAll('.replyForm-btn');
			replyButtons.forEach(function (button) {
			    button.addEventListener('click', function () {
			        var replyContainer = this.parentElement;
			        var replyForm = replyContainer.querySelector('.replyForm');
			        var replyList = replyContainer.querySelector('.replyList');
			        replyForm.classList.toggle('hidden');
			        replyList.classList.toggle('hidden');

			        // 열려있던 폼 닫기
			        var allReplyForms = document.querySelectorAll('.replyForm');
			        allReplyForms.forEach(function (form) {
			            if (form !== replyForm) {
			                form.classList.add('hidden');
			                var list = form.querySelector('.replyList');
			                if (list) {
			                    list.classList.add('hidden');
			                }
			            }
			        });
			    });
			});
			
			var isLoggedIn = <%= session.getAttribute("m_id") != null %>;
			var currentUserId = "<%= session.getAttribute("m_id") %>";
			
            // 수정 버튼 클릭 시 모달 열기
            var modifyButtons = document.querySelectorAll('.replyForm-modify');
            modifyButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                	// 버튼에서 cc_idx 값 꺼내옴
                    var editCcIdx = this.getAttribute('data-cc-idx');
                    var writerId = this.getAttribute('data-cc-id');
                    var modal = document.getElementById('commentModal');
                    var modalContent = modal.querySelector('.modal-content');
                    var ccIdxInput = modalContent.querySelector('input[name="cc_idx"]');

                    // 꺼내온 cc_idx 값 설정
                    ccIdxInput.value = editCcIdx;

            if (isLoggedIn && currentUserId === writerId) {
                // 로그인된 상태에서만 모달 열기
                modal.style.display = 'block';
                console.log('editCcIdx:', editCcIdx);
                console.log('ccIdxInput:', ccIdxInput);
                console.log('writerId:', writerId);
            } else {
                // 비로그인 상태에서는 페이지 이동
                window.location.href = '/teamgg/member/login';
            }
                });
            });
            
            // 취소버튼으로 모달 닫기
            var cancelEditButton = document.querySelector('.modifyForm-cancel');
            cancelEditButton.addEventListener('click', function () {
                var modal = document.getElementById('commentModal');
                modal.style.display = 'none';
            });
			</script>

		</div>
	</div>

	<div class=bottom>
	바텀
	</div>
</div>

</body>
</html>