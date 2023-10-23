<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    


<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@include file="../main_header.jsp" %>
    
<div class="container">
<div class="big_box">
	<%@include file="../user_left_menu.jsp"%>
	

 	<div class="read_box">
		<div class="read_top">
			<div class="read_title"><h2>${read.m_title}</h2></div>
			<div class="read_info">
				<div class="article-list-item-meta__item">${read.m_writer }</div>
				<div class="article-list-item-meta__item">${read.m_date }</div>
				
				<!-- 추천, 댓글 수(구현 한다면), 추천(구현한다면) -> read_info_right로 -->
			</div>
		</div>
		
		<div class="read_container">
			<div class="read_viewer">
				${read.m_content }
			</div>
			<div class="viewer_bottom">
				<a href="${cp}/board/del?m_idx=${read.m_idx}"><div class=function_button>삭제</div></a>
				<a href="${cp}/board/mate_modify?m_idx=${read.m_idx}&m_id=${idAndPw.m_id }&m_pw=${idAndPw.m_pw}"><div class=function_button>수정</div></a>
			</div>
		</div>
		
	</div> 
	
</div>
</div>
<%@include file="../main_back.jsp"%>