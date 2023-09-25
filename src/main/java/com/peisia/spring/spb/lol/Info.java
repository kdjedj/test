package com.peisia.spring.spb.lol;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Info {
	public String gameType;
	public ArrayList<Participants> participants;
}