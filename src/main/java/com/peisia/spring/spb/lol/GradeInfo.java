package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class GradeInfo {
	
	public String chamName = "";
	public Integer chamWins =0;
	public Integer chamLosses =0;
	public Integer chamGames = 0;
	public Integer killsAndais = 0;
	public Integer deaths = 0;
	public double grade = 0.0;
	public String winRate="";
	
	
		public GradeInfo(String chamName, Integer chamWins, Integer chamLosses, Integer chamGames, Integer killsAndais, Integer deaths, double grade, String winRate) {
			this.chamName = chamName;
			this.chamWins = chamWins;
			this.chamLosses = chamLosses;
			this.chamGames = chamGames;
			this.killsAndais = killsAndais;
			this.deaths = deaths;
			this.grade = grade;
			this.winRate = winRate;
		}
}
