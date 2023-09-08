package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
@Controller
public class MemberController {
	@RequestMapping("/reg")
	public void reg() {
		System.out.println("==== 회원가입 페이지 진입");
	}
	@RequestMapping("/regProc")
	public void regProc(MemberVO m, Model model) {
		//todo
		log.info("====================");
		
		
		
		System.out.println("==== id:"+m.getId());
		System.out.println("==== pw:"+m.getPw());
	}
	@RequestMapping("/login")
	public void login() {
	}
	@RequestMapping("/loginProc")
	public String loginProc(HttpSession s,
			@RequestParam("id") String id, @RequestParam("pw") String pw) {
		log.info("==== id:"+id);
		log.info("==== pw:"+pw);
		s.setAttribute("id", id);
		s.setAttribute("pw", pw);
		return "redirect:/";
	}
	@RequestMapping("/logout")
	public String loginProc(HttpSession s) {
		s.invalidate();
		return "redirect:/";
	}
}
