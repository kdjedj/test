package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class GradeInfo {
	
	public String chamName = "";
	public Integer chamWins =0;
	public Integer chamLosses =0;
	public Integer chamGames = 0;
	public Integer killsAndais = 0;
	public String killGrade = "";
	public String asiGrade = "";
	public Integer deaths = 0;
	public String deathGrade = "";
	public double grade = 0.0;
	public String gradestr = "";
	public String winRate="";
	public String killRate = "";
	public double winCircle =0.0;
	
	
		public GradeInfo(String chamName, Integer chamWins, Integer chamLosses, Integer chamGames,
				Integer killsAndais, Integer deaths, double grade, String winRate) {
			this.chamName = chamName;
			this.chamWins = chamWins;
			this.chamLosses = chamLosses;
			this.chamGames = chamGames;
			this.killsAndais = killsAndais;
			this.deaths = deaths;
			this.grade = grade;
			this.winRate = winRate;
		}
		public GradeInfo(Integer chamWins, Integer chamLosses, Integer chamGames,
				String killGrade, String asiGrade, String deathGrade, String gradestr,
				String winRate, String killRate, double winCircle) {
			this.chamWins = chamWins;
			this.chamLosses = chamLosses;
			this.chamGames = chamGames;
			this.killGrade = killGrade;
			this.asiGrade = asiGrade;
			this.deathGrade = deathGrade;
			this.gradestr = gradestr;
			this.winRate = winRate;
			this.killRate = killRate;
			this.winCircle = winCircle;
		}
}
