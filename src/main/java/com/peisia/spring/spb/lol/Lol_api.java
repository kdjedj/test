package com.peisia.spring.spb.lol;

import java.util.List;

import lombok.Data;
@Data
public class Lol_api {
	List<Participants> participants;
	String gameMode;
	Participants mainUser;
	String aver;
	String killsRate;
	Integer cs;
	String spellId1;
	String spellId2;
	
	
	public Lol_api(List<Participants> participants, String gameMode
			, Participants mainUser, String aver, String killsRate,
			Integer cs, String spellId1, String spellId2) {
		this.participants = participants;
		this.gameMode = gameMode;
		this.mainUser = mainUser;
		this.aver = aver;
		this.killsRate= killsRate;
		this.cs = cs;
		this.spellId1 = spellId1;
		this.spellId2 = spellId2;
		
	}
	
	
	public Lol_api(List<Participants> participants, String gameMode, Participants mainUser) {
		this.participants = participants;
		this.gameMode = gameMode;
		this.mainUser = mainUser;
	}
	
}
