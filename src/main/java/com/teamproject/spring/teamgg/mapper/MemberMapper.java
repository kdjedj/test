package com.teamproject.spring.teamgg.mapper;

import com.teamproject.spring.teamgg.vo.MemberVO;

public interface MemberMapper {
	public void register(MemberVO mvo);
	
	public int idchk(MemberVO mvo);
	
	public int userchk(MemberVO mvo);
}
