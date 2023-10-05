<%@page import="com.teamproject.spring.teamgg.vo.GuestVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>op.gg</title>
</head>
<body>
<%-- <%
	Object o = request.getAttribute("list");
	List<GuestVO> list = (List<GuestVO>)o; 
	for(int i=0;i<list.size();i++){
		Long bno = list.get(i).getBno();
		String btext = list.get(i).getBtext();
%>	 
		<%=bno %>	
		<a href="read?bno=<%=bno%>">
		<%=btext %>
		<br>
		</a>	
		<!-- <p>${list.get(i).getBno()}</p>
		<p>${list.get(i).getBtext()}</p> -->
		
		
<%		
	}

%>
--%>
<a href="${cp}/guest/write">새글 쓰기</a>

<!-- 페이징 리스트 뿌리기 -->
<!-- 반복문돌리기 -->
<hr>


<c:if test="${hasPrev == true}" >
	[<a href="${cp}/guest/getList?page=${prevPage}"><b>이전</b></a>]
</c:if>

<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
	[<a href="${cp}/guest/getList?page=${p}">${p}</a>]
</c:forEach>

<c:if test="${hasNext == true}" >
	[<a href="${cp}/guest/getList?page=${nextPage}"><b>다음</b></a>]
</c:if>

<fieldset>
	<legend>게시판 정보</legend>
	전체 글 수:${totalCount} <br>
	전체 페이지수:${totalPage} <br>
	전체 블럭 수:${totalBlock}<br>
<hr>
	현재 블럭 번호:${currentBlock}<br>
	현재 블럭 시작 번호:${blockStartNo}<br>
	현재 블럭 끝 번호:${blockEndNo}<br>
	이전 블럭 가기 가능 여부:${hasPrev}<br>
	다음 블럭 가기 가능 여부:${hasNext}<br>
	이전 블럭 이동 시 이동 될 페이지:${prevPage}<br>
	다음 블럭 이동 시 이동 될 페이지:${nextPage}<br>
</fieldset>

</body>
</html>