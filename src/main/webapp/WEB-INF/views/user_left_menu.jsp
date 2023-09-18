<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />  

<!-- 왼쪽 영역 -->
          <div id="user_left_menu">   
          		<c:choose>     
          			<c:when test="${login_on.m_id == 'null' || login_on.m_id == null || login_on.m_id == 'guest'}">  
          			<div id="login_box">
                    <a href="${cp}/board/login_admin?m_id=admin&m_pw=admin"><div class="login_button">로그인</div></a>
                    </div> 
                    </c:when>
                    <c:otherwise>
          			<div id="login_box">
          			임시 로그인 ${login_on.m_user }님 환영합니다
          			
          			</div>
                    
                    </c:otherwise>
                    </c:choose> 
                    <div class="sidebar-content">
                    	<div class="sidebar-menu">
                    		<div class="sidebar-menu__title">커뮤니티</div>
                    		<ul class="sidebar-menu__list">
								<li class="sidebar-menu__item">
								<a href="#">자유</a>
								</li>
								<li class="sidebar-menu__item">
								<a href="#">팁과 노하우</a>
								</li>
								<li class="sidebar-menu__item">
								<a href="#">유저 찾기</a>
								</li>
							</ul>
                    	</div>
                    </div>     
            </div> 



