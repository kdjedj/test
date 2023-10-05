package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;


@Data
public class MateBoardVo {
	public final static String TABLE_NAME_MATE = "mate_board";
	private Long m_idx;
	private String m_title;
	private String m_writer;
	private String m_content;
	private Long writeIdx;
	
	private String m_date;

	public void setM_date(Date m_date) {
		this.m_date = TimeFormatter.calculateTime(m_date);
	}	
}