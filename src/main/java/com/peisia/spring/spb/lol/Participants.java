package com.peisia.spring.spb.lol;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Participants {
	public String championName;
	public String summonerName;
	public boolean win;
	public Integer kills;
	public Integer death;
	public Integer assists;
	public Integer champLevel;
	public Integer profileIcon;
	public Integer spell1Casts;
    public Integer spell2Casts;
    public Integer spell3Casts;
    public Integer spell4Casts;
    public String item0;
    public String item1;
    public String item2;
    public String item3;
    public String item4;
    public String item5;
    public String item6;
    }
    
    