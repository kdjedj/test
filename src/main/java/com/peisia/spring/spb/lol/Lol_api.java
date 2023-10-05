package com.peisia.spring.spb.lol;

import java.util.List;

import lombok.Data;
@Data
public class Lol_api {
	List<Participants> participants;
	String gameMode;
	Participants mainUser;
	
	public Lol_api(List<Participants> participants, String gameMode, Participants mainUser) {
		this.participants = participants;
		this.gameMode = gameMode;
		this.mainUser = mainUser;
	}
	
	
	public Lol_api(List<Participants> participants, String gameMode) {
		this.participants = participants;
		this.gameMode = gameMode;
	}
	
}
