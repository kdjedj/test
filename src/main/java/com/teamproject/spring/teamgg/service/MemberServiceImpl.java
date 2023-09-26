package com.teamproject.spring.teamgg.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.mapper.MemberMapper;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public void register(MemberVO mvo) {
		log.info("회원가입");
		mapper.register(mvo);
	}

	@Override
	public int idchk(MemberVO mvo) {
		log.info("아이디체크");
		int chk = mapper.idchk(mvo);
		return chk;
	}

	@Override
	public int userchk(MemberVO mvo) {
		log.info("닉네임체크");
		int chk = mapper.userchk(mvo);
		return chk;
	}

	@Override
	public MemberVO login(MemberVO mvo) {
		log.info("로그인");
		mvo = mapper.login(mvo);
		return mvo;
	}

	@Override
	public void logout(HttpSession session) {
		log.info("로그아웃");
		session.invalidate();
	}
}
