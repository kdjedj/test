package com.teamproject.spring.teamgg.controller;

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
		if(idchk == 1) {
			log.info("아이디중복됨!!");
			mv.addObject("message", "존재하는 아이디입니다");
			mv.addObject("href", "back");
			return mv;
		} else if(userchk == 1) {
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
}
