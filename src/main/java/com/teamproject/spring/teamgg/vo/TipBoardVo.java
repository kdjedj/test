package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;


@Data
public class TipBoardVo {
	public final static String TABLE_NAME_TIP = "tip_board";
	private Long t_idx;
	private String t_title;
	private String t_id;
	private String t_user;
	private String t_content;
	private Long writeIdx;
	
	private String t_date;

	public void setT_date(Date t_date) {
		this.t_date = TimeFormatter.calculateTime(t_date);
	}	
}