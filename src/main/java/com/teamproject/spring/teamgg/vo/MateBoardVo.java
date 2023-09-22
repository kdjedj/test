package com.teamproject.spring.teamgg.vo;

import java.sql.Date;

import lombok.Data;


@Data
public class MateBoardVo {
	public final static String TABLE_NAME_MATE = "mate_board";
	private Long m_idx;
	private String m_title;
	private String m_writer;
	private String m_content;
	private Date m_date;
}
