package com.teamproject.spring.teamgg.vo;

import java.sql.Date;

import lombok.Data;


//롬복 라이브러리가 게터함수, 세터함수를 자동으로 만들어줌. @Data 라고 붙이면.
@Data
public class FreeBoardVo {
	public final static String TABLE_NAME_FREE = "free_board";
	private Long f_idx;
	private String f_title;
	private String f_writer;
	private String f_content;
	private Date f_date;
	
	
	
	//게터, 게터함수, 게터메소드
//	public Long getNo() {
//		return no;
//	}
	
	//세터
//	public void setNo(Long no) {
//		this.no = no;
//	}
	
	//str_data 쪽 게터,세터도 ...

}
