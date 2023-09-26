package com.teamproject.spring.teamgg.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String m_id;
	private String m_user;
	private String m_pw;
	private String m_email;
	private Date m_date;
	private String m_role;
}
