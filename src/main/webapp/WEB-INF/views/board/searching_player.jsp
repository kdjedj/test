<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    


<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@include file="../free_header.jsp" %>
  
    
<div class="container">
<div class="title_content">
	<div class="user_content">
		<div class="user-logo-box">
					
					<img class="user-logo" alt="로고" src="${profile_img}">
		</div>
		<div class="info">
			<div class="info-item-name"><h2>${summoner.name }</h2></div>
			<div class="prev_rank">
			대충 전시즌 랭크 나오는데
				<%-- <c:forEach var="r" items="${prev_ranks }" begin="0" step="1" end="3">
				<div class="priv_rank_div">${ }</div>
				<!-- 3개 이후는 반복문 걸어서 다르게 표기 -->
				</c:forEach> --%>
			</div>
		
		</div>
	</div>
	<div class="subBanner">
	<ul>
		<li></li>
	</ul>
	</div>
</div>

</div>

<div class="all_container">
	<div class="content-container">
		<div class="tier-and-prevplayer">
			<div class="tier-box">
				<div class="rank">
					<div class="rank-header">솔로랭크</div>
					<div class=rank-content>
						<div class="tier-picture"></div>
						<div class="tier-info">
							<div class=tier><h2>tier</h2></div>
							<div class=lp>lp</div>
						</div>
						<div class="lose-win-ratio">
							<div class="lose-win"></div>
							<div class="latio"></div>
						</div>
					</div>
				</div>
				
				<div class="rank">
					<div class="rank-header">자유랭크</div>
					<div class=rank-content>
						<div class="tier-picture"></div>
						<div class="tier-info">
							<div class=tier><h2>tier</h2></div>
							<div class=lp>lp</div>
						</div>
						<div class="lose-win-ratio">
							<div class="lose-win"></div>
							<div class="latio"></div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	
	</div>
	<div class="queue_content">
		<div class="queue_type_select">
			<ul>
				<li>
				<button class="queue_type_select_button" value="TOTAL">전체</button>
				</li>
				
				<li>
				<button class="queue_type_select_button" value="SOLORANKED">솔로랭크</button>
				</li>
				
				<li>
				<button class="queue_type_select_button" value="FLEXRANKED">자유랭크</button>
				</li>
				
				<li>
				<button class="queue_type_select_button" value="TOTAL">큐타입</button>
				</li>
			</ul>
		</div>
		<div class="info-addition">
			<div class="stat">
				<div class="win-lose">
				몇전 몇숭 몇패
				</div>
				<div class="kda">
					<div class="chart">차트 넣고</div>
					<div class="info"> kda </div>
				</div>
			</div>
			
			<div class="champions">
				<div class="title-cham">
				<ul>
					<li>
						<div class="">해당 챔피언 게임 정보</div>
					</li>
					<li></li>
					<li></li>
				</ul>
				</div>
			</div>
		</div>
		<div class="queue_content">
			<c:forEach var="queInfo" items="${queInfo }" begin="0" step="1" end="20">
				<div class="queue">${queInfo }</div>
				
			</c:forEach> 
		</div>
		
	</div>
	
	
	
</div>

</body>
</html>
