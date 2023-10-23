package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.service.FreeCommentService;
import com.teamproject.spring.teamgg.vo.FreeCommentVo;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/comment/*")
@AllArgsConstructor
@Controller
public class FreeCommentController {
	private FreeCommentService service;
	
	@GetMapping("/fcDel")
	public String del(@RequestParam("fc_idx") Long fc_idx, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
		if (fc_id == null) {
			return "redirect:/member/login";
		}
		FreeCommentVo writer = service.getData(fc_idx); 
	    if (!fc_id.equals(writer.getFc_id())) {
	    	log.info("fc_id: " + fc_id + ", writer: " + writer + ", fc_idx: " + fc_idx);
	        return "redirect:/errorPage";
	    }
        service.del(fc_idx);
	    Long writeIdx = writer.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/free/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	//write
	@PostMapping("fcWrite")
	public String write(FreeCommentVo fcvo, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
		String fc_user = (String) session.getAttribute("m_user");
	    if (fc_id == null) {
	        return "redirect:/member/login";
	    }
	    fcvo.setFc_id(fc_id);
	    fcvo.setFc_user(fc_user);
		service.write(fcvo);
		return "redirect:/free/freeRead?f_idx=" + fcvo.getF_idx();
	}
	
	@PostMapping("/fcModify")
	public String modify(FreeCommentVo fcvo, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
	    if (fc_id == null) {
	        return "redirect:/member/login";
	    }

	    FreeCommentVo originComment = service.getData(fcvo.getFc_idx()); 

	    if (!fc_id.equals(originComment.getFc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setFc_comment(fcvo.getFc_comment());
	    service.modify(originComment);

	    Long writeIdx = originComment.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/free/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
