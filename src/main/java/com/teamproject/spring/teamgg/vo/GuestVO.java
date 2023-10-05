package com.teamproject.spring.teamgg.vo;

import lombok.Data;

@Data
public class GuestVO {
	public final static String TABLE_NAME_GUEST = "mate_board";
	private Long m_idx;
	private String m_title;
	private String m_writer;
	private String m_content;
	private String m_date;
	
}