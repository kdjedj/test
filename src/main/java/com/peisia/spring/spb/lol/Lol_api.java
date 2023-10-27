package com.peisia.spring.spb.lol;

import java.util.List;

import lombok.Data;
@Data
public class Lol_api {
	public List<Participants> participants;
	public String gameMode;
	public Integer timemin;
	public Integer timesec;
	public Participants mainUser;
	public String aver;
	public double averD;
	public String killsRate;
	public Integer cs;
	public String spellId1;
	public String spellId2;
	public double dealtPer;
	public double takenPer;
	public List<Lol_api> perPlayers;
	
	
	public Lol_api(List<Participants> participants, String gameMode
			, Integer timemin, Integer timesec, Participants mainUser, String aver, String killsRate,
			Integer cs, String spellId1, String spellId2, List<Lol_api> perPlayer) {
		this.participants = participants;
		this.gameMode = gameMode;
		this.timemin = timemin; 
		this.timesec = timesec; 
		this.mainUser = mainUser;
		this.aver = aver;
		this.killsRate= killsRate;
		this.cs = cs;
		this.spellId1 = spellId1;
		this.spellId2 = spellId2;
		this.perPlayers = perPlayer;
	}
	
	
	public Lol_api(Participants perPlayer, double averD,
			String spellId1, String spellId2, double dealtPer, double takenPer) {
		this.mainUser = perPlayer;
		this.averD = averD;
		this.spellId1 = spellId1;
		this.spellId2 = spellId2;
		this.dealtPer = dealtPer;
		this.takenPer = takenPer;
	}
	
}
