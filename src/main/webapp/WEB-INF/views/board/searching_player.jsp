<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->


<c:set var="cp" value="${pageContext.request.contextPath}" />
<%@include file="../free_header.jsp"%>


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
								<h2>${liv.tier }</h2>
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
					<button class="queue_type_select_button" id="total" value="TOTAL">전체</button>
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
						${gameInfo.gg.winRate }%
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
										<div class="info">
											<div class="flexBox">
												<div class="champion">
													<div class="icon">
														<a href="#"> <img
															src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${pi.mainUser.championName }.png"
															alt="챔피언그림"><span class="chamlv">${pi.mainUser.champLevel }</span>
														</a>
													</div>
													 <div class="spells">
													 	<div class="spell1">
													 		<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${pi.spellId1 }.png" 
													 		 width="22px" height="22px">
													 	</div>
													 	<div class="spell2">
													 		<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${pi.spellId2 }.png"
													 		 width="22px" height="22px">
													 	</div>
													 	
													 </div>
											<div class="runes"></div>
												</div>
												<div class="kda">
													<div class="k-d-a">
														<span>${pi.mainUser.kills }</span> / <span class="d">${pi.mainUser.deaths }</span>
														/ <span>${pi.mainUser.assists }</span>
													</div>
													<div class="ratio">${pi.aver }:1 평점</div>
												</div>
												
												<div class="stats">
													<div class="p-kill">
														<span>킬관여${pi.killsRate }%</span>
													</div>
													<div class="cs">
														<span>Cs ${pi.cs }</span>
													</div>
												</div>

											</div>

											<div class="flexBox">
												<div class="items">
													<ul>
														<li><c:choose>
																<c:when test="${pi.mainUser.item0 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item0} --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item0}.png"
																			alt="#">
																	</div>
																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item1 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item1 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item1 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item2 eq '0'}">
																	<div class="item_box"></div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item2 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item3 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item3 } --%>

																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item3 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item4 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item4 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item5 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item5 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item5 }.png"
																			alt="#">
																	</div>
													</c:otherwise>
															</c:choose></li>

													</ul>
													<div class="ward">
														<c:choose>
															<c:when test="${pi.mainUser.item6 eq '0'}">
																<div class="item_box">
																	<%-- <div class="none_item"></div>
																	${pi.mainUser.item6} --%>
																</div>
															</c:when>
															<c:otherwise>
																<div class="item_box">
																	<img
																		src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item6 }.png"
																		alt="#">
																</div>
													</c:otherwise>
														</c:choose>
													</div>
												</div>
											</div>
										</div>
										<div class="participants">
											<ul>
												<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="4">
													<li class="player_list">
														<div class="icon">
															<a href="#"> <img
																src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
															</a>
														</div>
														<div class="name">
															<a
																href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
														</div>
													</li>
												</c:forEach>
											</ul>
											<ul>
												<c:forEach var="player" items="${pi.participants }"
													begin="5" step="1" end="9">
													<li class="player_list">
														<div class="icon">
															<a href="#"> <img
																src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
															</a>
														</div>
														<div class="name">
															<a
																href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
														</div>
													</li>
												</c:forEach>
											</ul>


										</div>
									</div>
								</div>
								<div class="addBtnDiv">
									<button class="addInfoBtn" >
										<img src="${cp}/resources/wa.png" alt="화살표">
									</button>
								</div>
							</div>
							<div class="addInfo hidden">
								<c:choose>
									<c:when test="${pi.mainUser.win==true }">
										<table class="back_color blue">
									</c:when>
									<c:otherwise>
										<table class="back_color red">
									</c:otherwise>
								</c:choose>
								
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
											<c:choose>
												<c:when test="${pi.mainUser.win ==true}">
													<th class="userWin" colspan="3">
													<span class="result">승리</span>(레드팀)
													</th>
												</c:when>
												<c:otherwise>
													<th class="userLose" colspan="3">
													<span class="result">패배</span>(레드팀)
													</th>
												</c:otherwise>
											</c:choose>
											<th>KDA</th>
											<th>피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win==player.win}">
													 	<c:choose>
															<c:when test="${player.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<div class="killRate">평점</div>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																	
																	</td>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<%-- <div class="killRate">
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
																		:1</div> --%>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
								<div class="summary">
									
								</div>
								
								<c:choose>
									<c:when test="${pi.mainUser.win!=true }">
										<table class="back_color blue">
									</c:when>
									<c:otherwise>
										<table class="back_color red">
									</c:otherwise>
								</c:choose>
								
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
											<c:choose>
												<c:when test="${pi.mainUser.win !=true}">
													<th class="userWin" colspan="3">
													<span class="result">승리</span>(블루팀)
													</th>
												</c:when>
												<c:otherwise>
													<th class="userLose" colspan="3">
													<span class="result">패배</span>(블루팀)
													</th>
												</c:otherwise>
											</c:choose>
											<th>KDA</th>
											<th>피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win!=player.win}">
													 	<c:choose>
															<c:when test="${player.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<div class="killRate">평점</div>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																	
																	</td>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<%-- <div class="killRate">
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
																		:1</div> --%>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
							</div>
						</li>

					</c:when>
					
					
					<c:when test="${pi.timemin < 3}">
					
					
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
										<div class="info">
											<div class="flexBox">
												<div class="champion">
													<div class="icon">
														<a href="#"> <img
															src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${pi.mainUser.championName }.png"
															alt="챔피언그림"><span class="chamlv">${pi.mainUser.champLevel }</span>
														</a>
													</div>
													 <div class="spells">
													 	<div class="spell1">
													 		<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${pi.spellId1 }.png" 
													 		 width="22px" height="22px">
													 	</div>
													 	<div class="spell2">
													 		<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${pi.spellId2 }.png"
													 		 width="22px" height="22px">
													 	</div>
													 	
													 </div>
											<div class="runes"></div>
												</div>
												<div class="kda">
													<div class="k-d-a">
														<span>${pi.mainUser.kills }</span> / <span class="d">${pi.mainUser.deaths }</span>
														/ <span>${pi.mainUser.assists }</span>
													</div>
													<div class="ratio">${pi.aver }:1 평점</div>
												</div>
												
												<div class="stats">
													<div class="p-kill">
														<span>킬관여${pi.killsRate }%</span>
													</div>
													<div class="cs">
														<span>Cs ${pi.cs }</span>
													</div>
												</div>

											</div>

											<div class="flexBox">
												<div class="items">
													<ul>
														<li><c:choose>
																<c:when test="${pi.mainUser.item0 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item0} --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item0}.png"
																			alt="#">
																	</div>
																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item1 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item1 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item1 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item2 eq '0'}">
																	<div class="item_box"></div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item2 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item3 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item3 } --%>

																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item3 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item4 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item4 }.png"
																			alt="#">
																	</div>

																</c:otherwise>
															</c:choose></li>

														<li><c:choose>
																<c:when test="${pi.mainUser.item5 eq '0'}">
																	<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item5 } --%>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="item_box">
																		<img
																			src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item5 }.png"
																			alt="#">
																	</div>
													</c:otherwise>
															</c:choose></li>

													</ul>
													<div class="ward">
														<c:choose>
															<c:when test="${pi.mainUser.item6 eq '0'}">
																<div class="item_box">
																	<%-- <div class="none_item"></div>
																	${pi.mainUser.item6} --%>
																</div>
															</c:when>
															<c:otherwise>
																<div class="item_box">
																	<img
																		src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${pi.mainUser.item6 }.png"
																		alt="#">
																</div>
													</c:otherwise>
														</c:choose>
													</div>
												</div>
											</div>
										</div>
										<div class="participants">
											<ul>
												<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="4">
													<li class="player_list">
														<div class="icon">
															<a href="#"> <img
																src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
															</a>
														</div>
														<div class="name">
															<a
																href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
														</div>
													</li>
												</c:forEach>
											</ul>
											<ul>
												<c:forEach var="player" items="${pi.participants }"
													begin="5" step="1" end="9">
													<li class="player_list">
														<div class="icon">
															<a href="#"> <img
																src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
															</a>
														</div>
														<div class="name">
															<a
																href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
														</div>
													</li>
												</c:forEach>
											</ul>

											</div>
										</div>
									</div>
									<div class="addBtnDiv">
									<button class="addInfoBtn" >
										<img src="${cp}/resources/wa.png" alt="화살표">
									</button>
									</div>
									
								</div>
								<div class="addInfo hidden">
								<c:choose>
									<c:when test="${pi.mainUser.win==true }">
										<table class="back_color blue">
									</c:when>
									<c:otherwise>
										<table class="back_color red">
									</c:otherwise>
								</c:choose>
								
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
											<c:choose>
												<c:when test="${pi.mainUser.win ==true}">
													<th class="userWin" colspan="3">
													<span class="result">승리</span>(레드팀)
													</th>
												</c:when>
												<c:otherwise>
													<th class="userLose" colspan="3">
													<span class="result">패배</span>(레드팀)
													</th>
												</c:otherwise>
											</c:choose>
											<th>KDA</th>
											<th>피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win==player.win}">
													 	<c:choose>
															<c:when test="${player.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<div class="killRate">평점</div>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																	
																	</td>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<%-- <div class="killRate">
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
																		:1</div> --%>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
								<div class="summary">
									
								</div>
								
								<c:choose>
									<c:when test="${pi.mainUser.win!=true }">
										<table class="back_color blue">
									</c:when>
									<c:otherwise>
										<table class="back_color red">
									</c:otherwise>
								</c:choose>
								
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
											<c:choose>
												<c:when test="${pi.mainUser.win !=true}">
													<th class="userWin" colspan="3">
													<span class="result">승리</span>(블루팀)
													</th>
												</c:when>
												<c:otherwise>
													<th class="userLose" colspan="3">
													<span class="result">패배</span>(블루팀)
													</th>
												</c:otherwise>
											</c:choose>
											<th>KDA</th>
											<th>피해량</th>
											<th>CS</th>
											<th>아이템</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="player" items="${pi.participants }"
													begin="0" step="1" end="9">
													 <c:if test="${pi.mainUser.win!=player.win}">
													 	<c:choose>
															<c:when test="${player.summonerName eq pi.mainUser.summonerName}"><!-- 색깔 진하게 구분 -->
																<tr class="mainPlayer">
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<div class="killRate">평점</div>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																	
																	</td>
																</tr>
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png">
																				<span>${player.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>스</div>
																		<div>펠</div>
																	</td>
																	<td class="name">
																		<a href="${cp}/board/searching_player?userName=${player.summonerName }">${player.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.kills }/${player.deaths }/${player.assists }(관여율)</div>
																		<%-- <div class="killRate">
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
																		:1</div> --%>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:10%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.totalMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:if> 
										</c:forEach>
										
									</tbody>
								</table>
							</div>
							
						</li>

					</c:otherwise>
				</c:choose>
			</c:forEach>
			<div class="more_info">
				<botton src="">더보기</botton>
			</div>
		</div>

	</div>



</div>

</body>
</html>
