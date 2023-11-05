<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />  
<c:set var="ts" value="<%= System.currentTimeMillis() %>" />

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- my css -->
<link rel="stylesheet" type="text/css" href="${cp}/resources/reset.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet" type="text/css" href="${cp}/resources/searchingPage.css?ver=<%=System.currentTimeMillis()%>">

<link rel="stylesheet" type="text/css" href="${cp}/resources/freeList.css?ver=<%=System.currentTimeMillis()%>">
<script type="text/javascript" src="${cp}/resources/searchingPage.js?ver=<%= System.currentTimeMillis() %>"></script></head>
<body>

<%@include file="/WEB-INF/views/header.jsp" %>


<div class="container">
	

</div>

<div class="all_container">
		<div class="no_search">
			<span>해당 유저에 대한 정보가 없습니다</span>
			<div class="no_search_mark">ⓧ</div>
		</div>
		
	</div>





</body>
</html>
