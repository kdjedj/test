package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;


@Data
public class BoardVO {
	private Long writeIdx;
	
//	FreeBoard
	public final static String TABLE_NAME_FREE = "free_board";
	private Long f_idx;
	private String f_title;
	private String f_id;
	private String f_user;
	private String f_content;
	private String f_date;

	public void setF_date(Date f_date) {
		this.f_date = TimeFormatter.calculateTime(f_date);
	}
	
//	TipBoard
	public final static String TABLE_NAME_TIP = "tip_board";
	private Long t_idx;
	private String t_title;
	private String t_id;
	private String t_user;
	private String t_content;
	private String t_date;

	public void setT_date(Date t_date) {
		this.t_date = TimeFormatter.calculateTime(t_date);
	}
	
//	CompBoard
	public final static String TABLE_NAME_COMP = "comp_board";
	private Long c_idx;
	private String c_title;
	private String c_id;
	private String c_user;
	private String c_content;
	private String c_date;

	public void setC_date(Date c_date) {
		this.c_date = TimeFormatter.calculateTime(c_date);
	}
}