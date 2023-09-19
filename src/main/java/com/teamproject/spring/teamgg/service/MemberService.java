package com.teamproject.spring.teamgg.service;

import com.teamproject.spring.teamgg.vo.MemberVO;

public interface MemberService {
	public void register(MemberVO mvo);
	
	public int idchk(MemberVO mvo);
	
	public int userchk(MemberVO mvo);
}
