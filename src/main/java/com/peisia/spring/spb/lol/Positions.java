package com.peisia.spring.spb.lol;

import lombok.Data;

@Data
public class Positions {
	public String position;
	public Integer times;
	public String gauge;
	
	public Positions(String position, Integer times) {
		this.position = position;
		this.times = times;
	}

	
	public Positions(String position, String gauge) {
		this.position = position;
		this.gauge = gauge;
	}
	
	
	
}
