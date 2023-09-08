package com.teamproject.spring.teamgg.vo;

import lombok.Data;

@Data
public class GuestVO {
	public final static String TABLE_NAME_GUEST = "tbl_guest";
	private Long bno;
	private String btext;
}