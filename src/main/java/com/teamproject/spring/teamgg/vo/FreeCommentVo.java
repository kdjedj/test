package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import com.teamproject.spring.teamgg.board.TimeFormatter;

import lombok.Data;

@Data
public class FreeCommentVo {
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
}
