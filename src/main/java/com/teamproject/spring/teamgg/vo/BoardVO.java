package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;


@Data
public class FreeBoardVo {
	public final static String TABLE_NAME_FREE = "free_board";
	private Long f_idx;
	private String f_title;
	private String f_id;
	private String f_user;
	private String f_content;
	private Long writeIdx;
	
	private String f_date;

	public void setF_date(Date f_date) {
		this.f_date = TimeFormatter.calculateTime(f_date);
	}	
}