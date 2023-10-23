package com.peisia.spring.spb.lol;

import java.util.List;

import lombok.Data;

@Data
public class GameInfo {

	public GradeInfo gg;//gradeInfo
	public Integer en;//endNum
	
	public GameInfo(GradeInfo gg, Integer en) {
		this.gg = gg;
		this.en = en;
	}
}
