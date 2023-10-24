package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.service.CompCommentService;
import com.teamproject.spring.teamgg.vo.CompCommentVo;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/comment/*")
@AllArgsConstructor
@Controller
public class CompCommentController {
	private CompCommentService service;
	
	@GetMapping("/ccDel")
	public String del(@RequestParam("cc_idx") Long cc_idx, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
		if (cc_id == null) {
			return "redirect:/member/login";
		}
		CompCommentVo writer = service.getData(cc_idx); 
	    if (!cc_id.equals(writer.getCc_id())) {
	    	log.info("cc_id: " + cc_id + ", writer: " + writer + ", cc_idx: " + cc_idx);
	        return "redirect:/errorPage";
	    }
        service.del(cc_idx);
	    Long writeIdx = writer.getC_idx();
	    if (writeIdx != null) {
	        return "redirect:/comp/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	//write
	@PostMapping("ccWrite")
	public String write(CompCommentVo ccvo, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
		String cc_user = (String) session.getAttribute("m_user");
	    if (cc_id == null) {
	        return "redirect:/member/login";
	    }
	    ccvo.setCc_id(cc_id);
	    ccvo.setCc_user(cc_user);
		service.write(ccvo);
		return "redirect:/comp/compRead?c_idx=" + ccvo.getC_idx();
	}
	
	@PostMapping("/ccModify")
	public String modify(CompCommentVo ccvo, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
	    if (cc_id == null) {
	        return "redirect:/member/login";
	    }

	    CompCommentVo originComment = service.getData(ccvo.getCc_idx()); 

	    if (!cc_id.equals(originComment.getCc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setCc_comment(ccvo.getCc_comment());
	    service.modify(originComment);

	    Long writeIdx = originComment.getC_idx();
	    if (writeIdx != null) {
	        return "redirect:/comp/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
