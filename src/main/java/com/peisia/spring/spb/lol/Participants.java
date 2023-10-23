package com.peisia.spring.spb.lol;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Participants {
	public String championName;
	public Integer championId;
	public String summonerName;
	public boolean win;
	public Integer kills;
	public Integer deaths;
	public Integer assists;
	public Integer champLevel;
	public Integer profileIcon;
	public String summoner1Id;
	public String summoner2Id;
    public String item0;
    public String item1;
    public String item2;
    public String item3;
    public String item4;
    public String item5;
    public String item6;
    public String puuid;
    public Integer totalEnemyJungleMinionsKilled;
    public Integer totalMinionsKilled;
    public String individualPosition;
    public Integer totalDamageDealtToChampions;
    public Integer totalDamageTaken;
    }
    
    