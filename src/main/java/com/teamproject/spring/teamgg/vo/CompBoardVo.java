package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;


@Data
public class CompBoardVo {
	public final static String TABLE_NAME_COMP = "comp_board";
	private Long c_idx;
	private String c_title;
	private String c_id;
	private String c_user;
	private String c_content;
	private Long writeIdx;
	
	private String c_date;

	public void setC_date(Date c_date) {
		this.c_date = TimeFormatter.calculateTime(c_date);
	}	
}