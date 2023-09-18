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
		<form class="write_form" action="${cp}/board/mate_write?m_id=${idAndPw.m_id }&m_pw=${idAndPw.m_pw }" method="post">
		<div class="read_top">
			글제목 : <input name="m_title" placeholder="제목을 입력해주세요....">
			<input name="m_writer" type="hidden" value="${user }">
			
		</div>
		
		<div class="read_container">
			글 내용 : 
			<br>
			<br>
			<textarea class="write_text" name="m_content" rows="10" cols="110" ></textarea>
			<div class="viewer_bottom">
			<input type="submit" value="글쓰기">
			</div>
		</div>
		</form>
	</div>
	
</div>
</div>
<%@include file="../main_back.jsp"%>