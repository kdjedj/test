<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 0. 웹 애플리케이션의 루트 경로(컨텍스트 경로) 를 가져와서 링크에 다 연결해줘야 함     -->
<!-- 1. 0을 위한 준비. jstl core 태그 선언     -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 2. 0을 위한 준비. el 태그로 가져올 수 있는데 이걸 더 짧게 찍기위해 변수 대입함.     -->    
<c:set var="cp" value="${pageContext.request.contextPath}" />  

<!-- tr 아래 영역 -->
          <td class="champion">
																		<a href="#">
																			<div class style="position:relative;">
																				<img alt="${player.mainUser.championName }" src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/champion/${player.mainUser.championName }.png">
																				<span>${player.mainUser.champLevel}</span>
																			</div>
																		</a>
																	</td>
																	<td class="spells">
																		<div>
																			<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${player.spellId1 }.png" 
													 							 width="22px" height="22px">
																		</div>
																		
																		<div>
																			<img src="https://ddragon.leagueoflegends.com/cdn/13.18.1/img/spell/${player.spellId2 }.png" 
													 							 width="22px" height="22px">
																		</div>
																		
																	</td>
																	<td class="name">
																		<a href="${cp}/board/exist_user?userName=${player.mainUser.summonerName }&region=${liv.region}">${player.mainUser.summonerName }</a>
																		<!-- 각자의 랭크 -->
																	</td>
																	<td class="kda">
																		<div class="k-d-a">${player.mainUser.kills }/${player.mainUser.deaths }/${player.mainUser.assists }(관여율)</div>
																		<div class="killRate">
																			<div class="killRate">
																			<c:choose>
																					<c:when test="${player.averD == Infinity || player.averD eq 'Infinity'}">
																						<span class="per">Perfect</span>
																					</c:when>
																					<c:when test="${player.averD >= 5.0}">
																						<span class="per">${player.averD }:1</span>
																					</c:when>
																					<c:when test="${player.averD >= 3.0}">
																						<span class="gd">${player.averD }:1</span>
																					</c:when>
																					<c:otherwise>
																					<span>${player.averD }:1</span>
																					</c:otherwise>
																			</c:choose>
																		</div>
																		</div>
																	</td>
																	<td class="damage">
																		<div>
																			<div class style="position:relative;">
																				<div class="dealt">${player.mainUser.totalDamageDealtToChampions }</div>
																				<div class="progress">
																					<div class="fill" style="width:${player.dealtPer}%"></div>
																				</div>
																			</div>
																			<div class style="position:relative;">
																				<div class="taken">${player.mainUser.totalDamageTaken }</div>
																				<div class="progress_taken">
																					<div class="fill" style="width:${player.takenPer}%"></div>
																				</div>
																			</div>
																		</div>
																	</td>
																	<td class="cs"><div>${player.mainUser.totalMinionsKilled+player.mainUser.totalEnemyJungleMinionsKilled }</div></td>
																	<td class="items">
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item0 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item0 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item1 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item1 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item2 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item2 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item3 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item3 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item4 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item4 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item5 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item5 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																		<li><c:choose>
																		<c:when test="${player.mainUser.item6 eq '0'}">
																			<div class="item_box">
																		<%-- <div class="none_item"></div>
																		${pi.mainUser.item4 } --%>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<div class="item_box">
																			<img
																				src="https://ddragon.leagueoflegends.com/cdn/13.19.1/img/item/${player.mainUser.item6 }.png"
																				alt="#">
																			</div>
																		</c:otherwise>
																		</c:choose></li>
																	
																	
																	</td>



