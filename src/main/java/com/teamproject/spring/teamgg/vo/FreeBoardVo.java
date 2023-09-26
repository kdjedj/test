package com.teamproject.spring.teamgg.vo;

import java.sql.Date;

import lombok.Data;


@Data
public class FreeBoardVo {
	public final static String TABLE_NAME_FREE = "free_board";
	private Long f_idx;
	private String f_title;
	private String f_writer;
	private String f_content;
	private Date f_date;
}
