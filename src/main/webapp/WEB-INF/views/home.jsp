<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@include file="../views/main_header.jsp" %>
    
<%-- <link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css">
<link rel="stylesheet" type="text/css" href="${cp}/resources/main.css">
 --%>

<!-- <div class="container"> -->
	<!--  <P>  The time on the server is ${serverTime}. </P>-->
	<div class="">
		<div class = "logo">
			<a><img alt="로고" src="https://ifh.cc/g/o5TO4s.png"></a>
		</div>
		<!-- <div class="" alt="전적검색">
			소환사검색
		</div> -->
	</div>
	

</div>

<%@include file="../views/main_back.jsp"%>