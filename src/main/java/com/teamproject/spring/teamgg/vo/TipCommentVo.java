package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;

@Data
public class TipCommentVo {
	public final static String TABLE_NAME_TC = "tip_comment";
	private Long tc_idx;
	private Long t_idx;
	private String tc_id;
	private String tc_user;
	private String tc_comment;
	private int tc_class;
	private int tc_group;
	private int tc_num;
	private String tc_date;

	public void setTc_date(Date tc_date) {
		this.tc_date = TimeFormatter.calculateTime(tc_date);
	}	
}
