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
<%@include file="free_header.jsp" %>
<%
	FreeBoardVo read = (FreeBoardVo)request.getAttribute("freeRead");
	Long f_idx = read.getF_idx();
	String f_id = read.getF_id();
	String f_user = read.getF_user();
	String f_title = read.getF_title();	
	String f_content = read.getF_content();
	String f_date = read.getF_date();
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
<h1> <%=f_title %> </h1>
<%= f_date %> <%=f_user %>
			</div>
			<div class="content">
<%=f_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/free/freeList">리스트</a>
				<a href="${cp}/free/freeModify?f_idx=<%=f_idx%>">수정</a>
				<a href="${cp}/free/freeDel?f_idx=<%=f_idx%>">삭제</a>
			</div>
			
<!-- 			댓글 -->
			<div class="commentForm">
				<form action="${cp}/comment/fcWrite" method="post">
			    	<input type="hidden" name="f_idx" value="<%=f_idx%>">
			    	<textarea name="fc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentAction">
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
				        ${comment.fc_user} ${comment.fc_date}
				    </div>
				    <div class="c_content">
				        ${comment.fc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-fc-group="${comment.fc_group}">
				        	<button class="replyForm-modify" data-fc-idx="${comment.fc_idx}" data-fc-id="${comment.fc_id}">수정</button>
							<a href="${cp}/comment/fcDel?fc_idx=${comment.fc_idx}">삭제</a>
				            <button class="replyForm-btn">답글쓰기</button>
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
                                    <div class="c_top">
                                        ${reply.fc_user} ${reply.fc_date}
                                    </div>
                                    <div class="c_content">
                                        ${reply.fc_comment}
                                    </div>
                            <button class="replyForm-modify" data-fc-idx="${reply.fc_idx} "data-fc-id="${reply.fc_id}">수정</button>
							<a href="${cp}/comment/fcDel?fc_idx=${reply.fc_idx}">삭제</a>
                            </c:when>
                        </c:choose>
                    </c:forEach>
					        <div class="replyForm hidden">
							    <form action="${cp}/comment/fcWrite" method="post">
							        <input type="hidden" name="f_idx" value="<%=f_idx%>">
							        <input type="hidden" name="fc_class" value="1">
							        <textarea name="fc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="fc_group" value="${comment.fc_group}">
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
			        <form action="${cp}/comment/fcModify" method="post">
			            <input type="hidden" name="fc_idx">
			            <input type="hidden" name="f_idx" value="<%=f_idx%>">
			            <textarea name="fc_comment" rows="4" cols="50"></textarea>
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
                	// 버튼에서 fc_idx 값 꺼내옴
                    var editFcIdx = this.getAttribute('data-fc-idx');
                    var writerId = this.getAttribute('data-fc-id');
                    var modal = document.getElementById('commentModal');
                    var modalContent = modal.querySelector('.modal-content');
                    var fcIdxInput = modalContent.querySelector('input[name="fc_idx"]');

                    // 꺼내온 fc_idx 값 설정
                    fcIdxInput.value = editFcIdx;

            if (isLoggedIn && currentUserId === writerId) {
                // 로그인된 상태에서만 모달 열기
                modal.style.display = 'block';
                console.log('editFcIdx:', editFcIdx);
                console.log('fcIdxInput:', fcIdxInput);
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