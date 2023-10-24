package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.service.TipCommentService;
import com.teamproject.spring.teamgg.vo.TipCommentVo;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/comment/*")
@AllArgsConstructor
@Controller
public class TipCommentController {
	private TipCommentService service;
	
	@GetMapping("/tcDel")
	public String del(@RequestParam("tc_idx") Long tc_idx, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
		if (tc_id == null) {
			return "redirect:/member/login";
		}
		TipCommentVo writer = service.getData(tc_idx); 
	    if (!tc_id.equals(writer.getTc_id())) {
	    	log.info("tc_id: " + tc_id + ", writer: " + writer + ", tc_idx: " + tc_idx);
	        return "redirect:/errorPage";
	    }
        service.del(tc_idx);
	    Long writeIdx = writer.getT_idx();
	    if (writeIdx != null) {
	        return "redirect:/tip/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	//write
	@PostMapping("tcWrite")
	public String write(TipCommentVo tcvo, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
		String tc_user = (String) session.getAttribute("m_user");
	    if (tc_id == null) {
	        return "redirect:/member/login";
	    }
	    tcvo.setTc_id(tc_id);
	    tcvo.setTc_user(tc_user);
		service.write(tcvo);
		return "redirect:/tip/tipRead?t_idx=" + tcvo.getT_idx();
	}
	
	@PostMapping("/tcModify")
	public String modify(TipCommentVo tcvo, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
	    if (tc_id == null) {
	        return "redirect:/member/login";
	    }

	    TipCommentVo originComment = service.getData(tcvo.getTc_idx()); 

	    if (!tc_id.equals(originComment.getTc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setTc_comment(tcvo.getTc_comment());
	    service.modify(originComment);

	    Long writeIdx = originComment.getT_idx();
	    if (writeIdx != null) {
	        return "redirect:/tip/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
