package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;

@Data
public class CommentVO {
//	Free
	public final static String TABLE_NAME_FC = "free_comment";
	private Long fc_idx;
	private Long f_idx;
	private String fc_id;
	private String fc_user;
	private String fc_comment;
	private int fc_class;
	private int fc_group;
	private int fc_num;
	private String fc_date;
	public void setFc_date(Date fc_date) {
		this.fc_date = TimeFormatter.calculateTime(fc_date);
	}
	
//	Tip
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
	
//	Comp
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
