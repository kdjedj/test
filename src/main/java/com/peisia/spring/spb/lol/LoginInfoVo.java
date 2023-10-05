
package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class LoginInfoVo {

//public String leagueId;
public String queueType;
public String tier;
public String rank;
//public String summonerId;
//public String summonerName;
public Integer leaguePoints;
public Integer wins;
public Integer losses;
//public Boolean veteran;
//public Boolean inactive;
//public Boolean freshBlood;
//public Boolean hotStreak;

public Double win_per;

	public LoginInfoVo(String queueType, String tier, String rank, Integer leaguePoints, Integer wins, Integer losses, Double win_per) {
		this.queueType = queueType;
		this.tier = tier;
		this.rank = rank;
		this.leaguePoints = leaguePoints;
		this.wins = wins;
		this.losses = losses;
		this.win_per=win_per;
	}
	







}