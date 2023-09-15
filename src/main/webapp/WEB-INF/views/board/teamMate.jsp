<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    


<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@include file="../main_header.jsp" %>
    


<div class="container">
	
	<div class="top_part">
		<div class = "logo_box">
			<a><img id="logo" alt="로고" src="${cp}/resources/img/Logo.png"></a>
		</div> 
		<div class="search_box" alt="전적검색">
			<form action="/board/searcing_user" method="post">
			<input class="search_blank" name="search" placeholder="소환사 검색">
			
			</form>
		</div>
	</div>
	<div class="big_box">
	<%@include file="../user_left_menu.jsp"%>
	
	<div class="content">
		<div class="sub-header">
		
			<div class="sub-header-info">
			<h2 class="sub-headtitle">유저 찾기</h2>
			<div class="write_button">
				<a href="#">글쓰기</a>
			</div>
			</div>
			
			<div class="sub-menu">
				<ul class="sub-link_list">
					<li class="sub-link_item"><a href="#">인기</a></li>
					<li class="sub-link_item"><a href="#">최신</a></li>
					<li class="sub-link_item"><a href="#">TOP</a></li>
				</ul>
			</div>
		</div>
		<section class="post_content">
		<c:forEach var="guest" items="${mateList}">
						<article class="article-list-item">
							<div class="article-list-item__no"><span>${guest.m_idx }</span></div>
							<div class="article-list-item__content">
							<a href="${cp}/board/read?=${guest.m_idx }"><span>${guest.m_title }</span></a>
							<div class="article-list-item-meta">
								<div class="article-list-item-meta__item"><span>${guest.m_date }</span></div>
								<div class="article-list-item-meta__item"><span>${guest.m_writer }</span></div>
							</div>
							</div>

						</article>
						</c:forEach>
		</section>
	</div>
</div>
</div>

<%@include file="../main_back.jsp"%>