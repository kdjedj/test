package com.teamproject.spring.teamgg.vo;

import java.sql.Date;

import lombok.Data;


@Data
public class TipBoardVo {
	public final static String TABLE_NAME_TIP = "tip_board";
	private Long t_idx;
	private String t_title;
	private String t_writer;
	private String t_content;
	private Date t_date;
}
