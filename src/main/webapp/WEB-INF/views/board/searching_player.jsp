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
	<div class="title_content">
		<div class="user_content">
			<div class="user-logo-box">

				<img class="user-logo" alt="로고" src="${profile_img}">
			</div>
			<div class="info">
				<div class="info-item-name">
					<h2>${summoner.name }</h2>
				</div>
				<div class="prev_rank">
					<!-- 대충 전시즌 랭크 나오는데 -->
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
						<c:choose>
							<c:when test="${liv.tier eq 'Unranked'}">
							<div class=rank-content>
						
						<div class="tier-info">
							<div class=tier>
								<h2>${liv.tier }</h2>
							</div>
						</div>
						<div class="lose-win-ratio">
							<div class="lose-win"></div>
							<div class="latio"></div>
						</div>
					</div>
							</c:when>
							<c:otherwise>
							<div class=rank-content>
						<div class="tier-picture">
							<img src="${cp }/resources/tier/${liv.tier }.png" alt="${liv.tier }">
						</div>
						<div class="tier-info">
							<div class=tier>
								<c:choose>
									<c:when test="${liv.rank eq ''}">
										<h2>${liv.tier }</h2>
									</c:when>
									<c:otherwise>
										<h2>${liv.tier }&nbsp;${liv.rank }</h2>
									</c:otherwise>
								</c:choose>
								
							</div>
							<div class=lp>${liv.leaguePoints} lp</div>
						</div>
						<div class="lose-win-ratio">
							<div class="lose-win"></div>
							<div class="latio"></div>
						</div>
					</div>
							</c:otherwise>
						</c:choose>
				</div>

				 <div class="rank">
					<div class="rank-header">전체 승률</div>
						<c:choose>
							<c:when test="${liv.wins+liv.losses == 0}">
								<div class=rank-content>
						<div class="lose-win-ratio">
							<div class="allgame">최근 게임을 찾을 수 없습니다</div>
							<div class="lose-win">
							</div>
							<div class="latio"></div>
						</div>
					</div>
							</c:when>
							<c:otherwise>
								<div class=rank-content>
						<div class="rank_winRate">${liv.win_per }%</div>
						<div class="lose-win-ratio">
							<div class="allgame">${liv.wins+liv.losses }전</div>
							<div class="lose-win">
								<span>${liv.wins }승</span> &nbsp;/&nbsp; <span class="d">${liv.losses }패</span>
							</div>
							<div class="latio"></div>
						</div>
					</div>
							</c:otherwise>
						</c:choose>
					
				</div> 

			</div>
		</div>

	</div>
	<div class="queue_content_box">
		<div class="queue_type_select">
			<ul>
				<li>
					<button class="queue_type_select_button selected" id="total" value="TOTAL">전체</button>
				</li>

				<li>
					<button class="queue_type_select_button" id="soloRank" value="SOLORANKED">솔로랭크</button>
				</li>

				<!-- <li>
					<button class="queue_type_select_button" value="FLEXRANKED">자유랭크</button>
				</li> -->

				<li>
					<button class="queue_type_select_button" id="normalGame" value="TOTAL">일반 게임</button>
				</li>
			</ul>
		</div>
		<div class="info-addition">
			<div class="stat">
				<div class="win-lose">
					<div class="k-d-a">
						${gameInfo.gg.chamGames }전 / ${gameInfo.gg.chamWins }승 / ${gameInfo.gg.chamLosses }패 
					</div>
				</div>
				<div class="kda">
					<div class="chart">
						<div class="circleGauge" style="background: conic-gradient(#7d2ae8 ${gameInfo.gg.winCircle}deg, #ededed 0deg);"> 
							<span>${gameInfo.gg.winRate }%</span>
						</div>					
						
						<%-- <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="160px" height="160px">
						         <defs>
						            <linearGradient id="GradientColor">
						               <stop offset="0%" stop-color="#e91e63" />
						               <stop offset="100%" stop-color="#673ab7" />
						            </linearGradient>
						         </defs>
						         <circle cx="80" cy="80" r="70" stroke-linecap="round" />
					   </svg> --%>
					</div>
					<div class="info">
						<div class="k-d-a">
							${gameInfo.gg.killGrade } / <span class="d">${gameInfo.gg.deathGrade }</span>
							/ ${gameInfo.gg.asiGrade }
						</div>
						<div class="ratio">${gameInfo.gg.gradestr }:1</div>
						<div class="kill_per">킬관여 ${gameInfo.gg.killRate }%</div>
					</div>
				</div>
			</div>

			<div class="champions">
				<div class="title">플레이한 챔피언</div>
					<ul>
						<c:forEach var="cg" items="${top3cham }" begin="0" step="1" end="2">
						<li>
							<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${cg.chamName }.png" alt="${cg.chamName }">
							<div class="win-lose">
								<div class style="position:relative;display: inline;">
									<c:choose>
										<c:when test="${cg.winRate eq '100' }">
											<span style="color:#D31A45;">${cg.winRate }%</span>
										</c:when>
										<c:otherwise>
										<span>${cg.winRate }%</span>
										</c:otherwise>
									</c:choose>
								</div>
								(${cg.chamWins }승 ${cg.chamLosses }패)
							</div>
							<div class="aver">
								<c:choose>
										<c:when test="${cg.grade == Infinity}">
											<span class="per">Perfect 평점</span>
										</c:when>
										<c:when test="${cg.grade >= 5.0}">
											<span class="per">${cg.grade } 평점</span>
										</c:when>
										<c:when test="${cg.grade >= 3.0}">
											<span class="gd">${cg.grade } 평점</span>
										</c:when>
										<c:otherwise>
										<span>${cg.grade } 평점</span>
										</c:otherwise>
								</c:choose>
								
							</div>
						</li>
						</c:forEach>
					</ul>
			</div>
			
			 <div class="positions">
				<div class="title">선호 포지션 (랭크)</div>
				<ul>
					<c:forEach var="pos" items="${positions }" begin="0" step="1" end="4" >
						<li>
							<div class="bar">
								<div class="gauge" style="height: ${pos.gauge}%;"></div>
							</div>
							<div class="positionLogo">
								<img src="${cp }/resources/position/${pos.position }.png" alt="${pos.position }" style="width:16px;">
							</div>
						</li>
					</c:forEach>
				</ul>
			</div> 
		</div>
		
		<div class="queue_content">
			<c:forEach var="pi" items="${L_Api}" begin="0" step="1" end="${gameInfo.en}"><%--  ${}로 부를때는 반드시 GameInfo클래스 맴버변수 이름으로 불러야한다 --%>
				<c:if test="true">
				<c:choose>
					<c:when test="${pi.mainUser.win==true}">
						<li>
							<div class="win_box">
								<div class="content_box">
									<div class="gameBox">
										<div class="game">
											<div class="gameType">${pi.gameMode }</div>
											<div class="bar"></div>
											<div class="result">승리</div>
											<div class="length">${pi.timemin }분 ${pi.timesec }초</div>
										</div>
										<%@include file="../board/detailInfo_Info(div)_parti(div).jsp"%>
									</div>
								</div>
								<div class="addBtnDiv">
									<button class="addInfoBtn" >
										<img src="${cp}/resources/wa.png" alt="화살표">
									</button>
								</div>
							</div>
							<div class="addInfo hidden">
								<table class="back_color blue">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>			
											<th class="userLose" colspan="3">
												<span class="result">승리</span>(레드팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win==player.mainUser.win}">
													 	<c:choose>
															<c:when test="${player.mainUser.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
									</tbody>
								</table>
								
								<div class="summary">
									
								</div>
								
								<table class="back_color red">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>
											<th class="userLose" colspan="3">
												<span class="result">패배</span>(블루팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win!=player.mainUser.win}">
														<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
														</tr>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
								
							</div>
						</li>
						
					
					</c:when>
					
					<c:when test="${pi.timemin < 3}">
						<li>
							<div class="re_box">
								<div class="content_box">
									<div class="gameBox">
										<div class="game">
											<div class="gameType">${pi.gameMode }</div>
											<div class="bar"></div>
											<div class="result">다시하기</div>
											<div class="length">${pi.timemin }분 ${pi.timesec }초</div>
										</div>
										<%@include file="../board/detailInfo_Info(div)_parti(div).jsp"%>
									</div>
								</div>
								<div class="addBtnDiv">
									<button class="addInfoBtn" >
										<img src="${cp}/resources/wa.png" alt="화살표">
									</button>
								</div>
							</div>
							<div class="addInfo hidden">
								<table class="back_color gray">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>			
											<th class="userLose" colspan="3">
												<span class="result">무승부</span>(레드팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="0" step="1" end="4">
													 
													 	<c:choose>
															<c:when test="${player.mainUser.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:otherwise>
														</c:choose>
													
										</c:forEach>
									</tbody>
								</table>
								
								<div class="summary">
									
								</div>
								
								<table class="back_color gray">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>
											<th class="userLose" colspan="3">
												<span class="result">무승부</span>(블루팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="5" step="1" end="9">
														<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
														</tr>
										</c:forEach>
										
									</tbody>
								</table>
								
							</div>
						</li>
					</c:when>


					<c:otherwise>
					<li>
							<div class="lose_box">
								<div class="content_box">
									<div class="gameBox">
										<div class="game">
											<div class="gameType">${pi.gameMode }</div>
											<div class="bar"></div>
											<div class="result">패배</div>
											<div class="length">${pi.timemin }분 ${pi.timesec }초</div>
										</div>
											<%@include file="../board/detailInfo_Info(div)_parti(div).jsp"%>
									</div>
								</div>
								<div class="addBtnDiv">
									<button class="addInfoBtn" >
										<img src="${cp}/resources/wa.png" alt="화살표">
									</button>
								</div>
									
							</div>
							<div class="addInfo hidden">
								<table class="back_color red">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>
											<th class="userLose" colspan="3">
												<span class="result">패배</span>(레드팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win==player.mainUser.win}">
													 	<c:choose>
															<c:when test="${player.mainUser.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
								
								<div class="summary">
									
								</div>
								
								<table class="back_color blue">
									<colgroup>
										<col width="44">
										<col width="36">
										<col >
										<col width="166">
										<col width="120">
										<col width="104">
										<col width="175">
									</colgroup>
									<thead>
										<tr>
											<th class="userWin" colspan="3">
												<span class="result">승리</span>(블루팀)
											</th>
											<th>KDA</th>
											<th>가한피해량/받은피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.perPlayers }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win!=player.mainUser.win}">
													 	
																<tr>
																	<%@include file="../board/detailInfo_td.jsp"%>
																</tr>
															
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
								
							</div>
							
						</li>

					</c:otherwise>
				</c:choose>
				</c:if>
			</c:forEach>
			
			</div>
			
			<div class="more_info">
				<button action="">더보기</button>
			</div>
			
		</div>

	</div>




</body>
</html>
