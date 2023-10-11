package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class GradeInfo {
	
	public String chamName = "";
	public Double chamWins =0.0;
	public Double chamLosses =0.0;
	public Integer chamGames = 0;
	public Double grade;
	
		public GradeInfo(String chamName, Double chamWins, Double chamLosses, Integer chamGames, Double grade) {
			this.chamName = chamName;
			this.chamWins = chamWins;
			this.chamLosses = chamLosses;
			this.chamGames = chamGames;
			this.grade = grade;
		}
}
