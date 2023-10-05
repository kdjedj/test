package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.spring.teamgg.service.MemberService;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
@Controller
public class MemberController {

	private MemberService service;

	@PostMapping("/register")
	public ModelAndView register(MemberVO mvo) {
		log.info("회원가입 작동");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/Message");
		int idchk = service.idchk(mvo);
		int userchk = service.userchk(mvo);
		if (idchk == 1) {
			log.info("아이디중복됨!!");
			mv.addObject("message", "존재하는 아이디입니다");
			mv.addObject("href", "back");
			return mv;
		} else if (userchk == 1) {
			log.info("닉네임중복됨!!");
			mv.addObject("message", "존재하는 닉네임입니다");
			mv.addObject("href", "back");
			return mv;
		} else {
			service.register(mvo);
			log.info("회원가입 완료");
			mv.addObject("message", "회원가입완료!");
			mv.addObject("href", "/teamgg");
			return mv;
		}
	}

	@GetMapping("/register")
	public void register() {

	}

	// HttpSession
	@PostMapping("/login")
	public ModelAndView login(MemberVO mvo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/member/Message");
		MemberVO member = service.login(mvo);
		String oldurl = (String) session.getAttribute("oldurl");
		if (member != null) {
			log.info("로그인성공");
			session.setAttribute("m_id", member.getM_id());
			session.setAttribute("m_user", member.getM_user());
			session.setAttribute("m_email", member.getM_email());
			session.setAttribute("m_date", member.getM_date());
			session.setAttribute("m_role", member.getM_role());
			mv.addObject("message", member.getM_user() + " 님 환영합니다!");
			if (oldurl != null) {
				mv.addObject("href", oldurl);
			} else {
				mv.addObject("href", "/teamgg");
			}
			return mv;
		} else {
			log.info("로그인실패");
			mv.addObject("message", "아이디 또는 비밀번호가 올바르지 않습니다. 다시 확인해주세요");
			mv.addObject("href", "back");
			return mv;
		}
	}

	@GetMapping("/login")
	public void login(HttpSession session, HttpServletRequest request) {
		String oldurl = request.getHeader("referer");
		log.info(oldurl + " << 로그인 이전 페이지");
		session.setAttribute("oldurl", oldurl);
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, ModelAndView mv, HttpServletRequest request) {
		String oldurl = request.getHeader("referer");
		log.info(oldurl + " << 로그인 이전 페이지");
		service.logout(session);
		log.info("로그아웃 완료");
		mv.setViewName("/member/Message");
		mv.addObject("message", "로그아웃완료!");
		if (oldurl != null) {
			mv.addObject("href", oldurl);
		} else {
			mv.addObject("href", "/teamgg");
		}
		return mv;
	}
}