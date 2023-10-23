package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;

@Data
public class CompCommentVo {
	public final static String TABLE_NAME_CC = "comp_comment";
	private Long cc_idx;
	private Long c_idx;
	private String cc_id;
	private String cc_user;
	private String cc_comment;
	private int cc_class;
	private int cc_group;
	private int cc_num;
	private String cc_date;

	public void setCc_date(Date cc_date) {
		this.cc_date = TimeFormatter.calculateTime(cc_date);
	}	
}
