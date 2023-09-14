<%@page import="java.util.ArrayList"%>
<%@page import="com.teamproject.spring.teamgg.vo.FreeBoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

자유게시판 리스트
<hr>

<%
	Object o = request.getAttribute("list");
	List<FreeBoardVo> list = (List<FreeBoardVo>)o; 
	for(int i=0;i<list.size();i++){
		Long f_idx = list.get(i).getF_idx();
		String f_title = list.get(i).getF_title();
%>		
		<%=f_idx %>	
		<a href="freeRead?f_idx=<%=f_idx%>">
		<%=f_title %>
		<hr>
		</a>	
		
		
<%		
	}

%>

<a href="${cp}/free/freeWrite">새글 쓰기</a>

<!-- <!-- 페이징 리스트 뿌리기 --> -->
<!-- <!-- 반복문돌리기 --> -->
<!-- <hr> -->

<%-- <c:if test="${hasPrev == true}" > --%>
<%-- 	[<a href="${cp}/free/freeList?page=${prevPage}"><b>이전</b></a>] --%>
<%-- </c:if> --%>

<c:choose>
    <c:when test="${hasPrev == true}">
        [<a href="${cp}/free/freeList?page=${prevPage}"><b>이전</b></a>]
    </c:when>
    <c:otherwise>
        [이전]
    </c:otherwise>
</c:choose>

<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
	[<a href="${cp}/free/freeList?page=${p}">${p}</a>]
</c:forEach>

<%-- <c:if test="${hasNext == true}" > --%>
<%-- 	[<a href="${cp}/free/freeList?page=${nextPage}"><b>다음</b></a>] --%>
<%-- </c:if> --%>

<c:choose>
	<c:when test="${hasNext == true }">
		[<a href="${cp}/free/freeList?page=${nextPage}"><b>다음</b></a>]
		</c:when>
		<c:otherwise>
			[다음]
		</c:otherwise>
</c:choose>


</body>
</html>