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
						<div class="tier-picture"><img src="${cp }/resources/img/${liv.tier }" alt="${liv.tier }"></div>
						<div class="tier-info">
							<div class=tier><h2>${liv.tier }</h2></div>
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
				<div class="k-d-a">
						<span>${liv.wins }</span>
						&nbsp;/&nbsp;
						<span class="d">${liv.wins }</span>
						&nbsp;/&nbsp;
						<span>승률</span>
						</div>
				</div>
				<div class="kda">
					<div class="chart">차트 넣고</div>
					<div class="info"> 
					<div class="k-d-a">
						<span>평균킬</span>
						&nbsp;/&nbsp;
						<span class="d">평균 데스</span>
						&nbsp;/&nbsp;
						<span>평균 어시</span>
						</div>
				</div>
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
			 <c:forEach var="pi" items="${L_Api }" begin="0" step="1" end="1">
				<%--<c:choose></c:choose> 잊지말고 otherwise문 뒤에 붙이기
				<c:when test="${player_info.win==true }"> --%>
				<!-- <li> -->
					<div class="win_box">
						<div class="content_box">
							<div class="gameBox">
								<div class="game">
									<div class="gameType">${pi.gameMode }</div>
									<div class="bar"></div>
									<div class="result">승리</div>
								</div>
								<div class="info">
									<div class="flexBox">
										<div class="champion">
											<div class="icon">
												<a href="#">
												<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${pi.mainUser.championName }.png" alt="챔피언그림"><span></span>
												</a>
											</div>
											<!-- <div class="spells"></div>
											<div class="runes"></div> -->
										</div>
										<div class="kda">
											<div class="k-d-a">
											<span>${pi.mainUser.kills }</span>
											&nbsp; / &nbsp;
											<span class="d">${pi.mainUser.deaths }</span>
											&nbsp; / &nbsp;
											<span>${pi.mainUser.assists }</span>
											</div>
											<div class="ratio"></div>
										</div>
										<!-- 나중에 킬관여 등 정보 관리 -->
										
									</div>
									
									<div class="flexBox">
										<div class="items">
											<ul>
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item0 != '' || pi.mainUser.item0 !=null} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item0 }.png" alt="#">
														
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item">no</div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>												
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item0 != ''} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item0 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>
																								
												<li>
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item1 }.png" alt="#">
														${pi.mainUser.item1 }
														</div>
														<c:if test="${pi.mainUser.item1 == null}">
														
													<div class="item_box">
														<div class="none_item"></div>
														</div>
														</c:if>
												</li>
																								
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item2 == ''} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item2 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>												
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item3 != null} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item3 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>												
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item4 != null} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item4 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>												
												<li>
												<c:choose>
													<c:when test="${pi.mainUser.item5 != null} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item5 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
												</li>												
																								
											</ul>
											<div class="ward">
												<c:choose>
													<c:when test="${pi.mainUser.item6 != null} ">
														<div class="item_box">
															<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item6 }.png" alt="#">
														</div>
													</c:when>
													<c:otherwise>
													<div class="item_box">
														<div class="none_item"></div>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</div>
								<div class="participants">
									<ul>
										  <c:forEach var="player" items="${pi.participants }" begin="0" step="1" end="4">
											<li>
												<div class="icon"></div>
												<div class="name"><a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a></div>
											</li>
										</c:forEach> 
									</ul>
									<ul>
										  <c:forEach var="player" items="${pi.participants }" begin="5" step="1" end="9">
											<li>
												<div class="icon"></div>
												<div class="name"><a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a></div>
											</li>
										</c:forEach> 
									</ul>
									
								
								</div>
							</div>
						</div>
						<!-- 나중에 버튼 활성화 -->
					</div>
			<!--	</li>  -->
				
				<%-- </c:when>
				<c:otherwise>
				
				</c:otherwise>
				 --%>
			</c:forEach> 
		</div>
		
	</div>
	
	
	
</div>

</body>
</html>
