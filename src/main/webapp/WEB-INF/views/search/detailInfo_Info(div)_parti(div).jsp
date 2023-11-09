<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />  


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
													<c:choose>
														<c:when test="${player.summonerName eq pi.mainUser.summonerName }">
															<li class="player_list main">
																<div class="icon">
																	<a href="#"> 
																		<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png" style="border-radius:50%;"><span></span>
																	</a>
																</div>
																<div class="name">
																	<a href="${cp}/board/exist_user?userName=${player.summonerName }&region=${liv.region}" style="color: black;">${player.summonerName }</a>
																</div>
															</li>
														</c:when>
														<c:otherwise>
															<li class="player_list">
																<div class="icon">
																	<a href="#"> 
																		<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
																	</a>
																</div>
																<div class="name">
																	<a href="${cp}/board/exist_user?userName=${player.summonerName }&region=${liv.region}">${player.summonerName }</a>
																</div>
															</li>
														</c:otherwise>
													</c:choose>
													
												</c:forEach>
											</ul>
											<ul>
												<c:forEach var="player" items="${pi.participants }"
													begin="5" step="1" end="9">
													<c:choose>
														<c:when test="${player.summonerName eq pi.mainUser.summonerName }">
															<li class="player_list main">
																<div class="icon">
																	<a href="#"> 
																		<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png" style="border-radius:50%;"><span></span>
																	</a>
																</div>
																<div class="name">
																	<a href="${cp}/board/exist_user?userName=${player.summonerName }&region=${liv.region}" style="color: black;">${player.summonerName }</a>
																</div>
															</li>
														</c:when>
														<c:otherwise>
															<li class="player_list">
																<div class="icon">
																	<a href="#"> 
																		<img src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.championName }.png"><span></span>
																	</a>
																</div>
																<div class="name">
																	<a href="${cp}/board/exist_user?userName=${player.summonerName }&region=${liv.region}">${player.summonerName }</a>
																</div>
															</li>
														</c:otherwise>
													</c:choose>
													
												</c:forEach>
											</ul>


										</div>