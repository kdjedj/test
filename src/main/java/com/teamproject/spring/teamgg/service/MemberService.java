package com.teamproject.spring.teamgg.service;

import javax.servlet.http.HttpSession;

import com.teamproject.spring.teamgg.vo.MemberVO;

public interface MemberService {
	// 회원가입
	public void register(MemberVO mvo);

	// 아이디중복체크
	public int idchk(MemberVO mvo);

	// 닉네임중복체크
	public int userchk(MemberVO mvo);

	// 로그인
	public MemberVO login(MemberVO mvo);

	// 로그아웃
	public void logout(HttpSession session);
}
