package com.peisia.spring.spb.lol;

import java.util.List;

import lombok.Data;

@Data
public class GameInfo {

	public GradeInfo gg;//gradeInfo
	public Integer en;//endNum
	
	public GameInfo(GradeInfo gradeInfo, Integer endNum) {
		this.gg = gradeInfo;
		this.en = endNum;
	}
}
