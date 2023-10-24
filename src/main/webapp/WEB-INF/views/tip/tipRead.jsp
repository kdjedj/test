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
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipList.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/tip/tipRead.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="tip_header.jsp" %>
<%
	TipBoardVo read = (TipBoardVo)request.getAttribute("tipRead");
	Long t_idx = read.getT_idx();
	String t_id = read.getT_id();
	String t_user = read.getT_user();
	String t_title = read.getT_title();	
	String t_content = read.getT_content();
	String t_date = read.getT_date();
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
<h1> <%=t_title %> </h1>
<%= t_date %> <%=t_user %>
			</div>
			<div class="content">
<%=t_content %>
			</div>
		
			<div class="read_actions">
				<a href="${cp}/tip/tipList">리스트</a>
				<a href="${cp}/tip/tipModify?t_idx=<%=t_idx%>">수정</a>
				<a href="${cp}/tip/tipDel?t_idx=<%=t_idx%>">삭제</a>
			</div>

<!-- 			댓글 -->
			<div class="commentForm">
				<form action="${cp}/comment/tcWrite" method="post">
			    	<input type="hidden" name="t_idx" value="<%=t_idx%>">
			    	<textarea name="tc_comment" rows="4" cols="50"></textarea>
			    	<div class="commentAction">
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
				        ${comment.tc_user} ${comment.tc_date}
				    </div>
				    <div class="c_content">
				        ${comment.tc_comment}
				    </div>
				    
<!-- 				    대댓글 -->
				        <div class="c_reply" data-tc-group="${comment.tc_group}">
				        	<button class="replyForm-modify" data-tc-idx="${comment.tc_idx}" data-tc-id="${comment.tc_id}">수정</button>
							<a href="${cp}/comment/tcDel?tc_idx=${comment.tc_idx}">삭제</a>
				            <button class="replyForm-btn">답글쓰기</button>
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
                                    <div class="c_top">
                                        ${reply.tc_user} ${reply.tc_date}
                                    </div>
                                    <div class="c_content">
                                        ${reply.tc_comment}
                                    </div>
                            <button class="replyForm-modify" data-tc-idx="${reply.tc_idx} "data-tc-id="${reply.tc_id}">수정</button>
							<a href="${cp}/comment/tcDel?tc_idx=${reply.tc_idx}">삭제</a>
                            </c:when>
                        </c:choose>
                    </c:forEach>
					        <div class="replyForm hidden">
							    <form action="${cp}/comment/tcWrite" method="post">
							        <input type="hidden" name="t_idx" value="<%=t_idx%>">
							        <input type="hidden" name="tc_class" value="1">
							        <textarea name="tc_comment" rows="4" cols="50"></textarea>
        							<input type="hidden" name="tc_group" value="${comment.tc_group}">
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
			        <form action="${cp}/comment/tcModify" method="post">
			            <input type="hidden" name="tc_idx">
			            <input type="hidden" name="t_idx" value="<%=t_idx%>">
			            <textarea name="tc_comment" rows="4" cols="50"></textarea>
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
                	// 버튼에서 tc_idx 값 꺼내옴
                    var editTcIdx = this.getAttribute('data-tc-idx');
                    var writerId = this.getAttribute('data-tc-id');
                    var modal = document.getElementById('commentModal');
                    var modalContent = modal.querySelector('.modal-content');
                    var tcIdxInput = modalContent.querySelector('input[name="tc_idx"]');

                    // 꺼내온 tc_idx 값 설정
                    tcIdxInput.value = editTcIdx;

            if (isLoggedIn && currentUserId === writerId) {
                // 로그인된 상태에서만 모달 열기
                modal.style.display = 'block';
                console.log('editTcIdx:', editTcIdx);
                console.log('tcIdxInput:', tcIdxInput);
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