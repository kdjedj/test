package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.service.CommentService;
import com.teamproject.spring.teamgg.vo.CommentVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/comment/*")
@AllArgsConstructor
@Controller
public class CommentController {
	private CommentService service;
	
//	Free
	@GetMapping("/fcDel")
	public String fcDel(@RequestParam("fc_idx") Long fc_idx, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
		if (fc_id == null) {
			return "redirect:/member/login";
		}
		CommentVO writer = service.getFcData(fc_idx); 
	    if (!fc_id.equals(writer.getFc_id())) {
	    	log.info("fc_id: " + fc_id + ", writer: " + writer + ", fc_idx: " + fc_idx);
	        return "redirect:/errorPage";
	    }
        service.fcDel(fc_idx);
	    Long writeIdx = writer.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@PostMapping("fcWrite")
	public String fcWrite(CommentVO cvo, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
		String fc_user = (String) session.getAttribute("m_user");
	    if (fc_id == null) {
	        return "redirect:/member/login";
	    }
	    cvo.setFc_id(fc_id);
	    cvo.setFc_user(fc_user);
		service.fcWrite(cvo);
		return "redirect:/board/freeRead?f_idx=" + cvo.getF_idx();
	}
	
	@PostMapping("/fcModify")
	public String fcModify(CommentVO cvo, HttpSession session) {
		String fc_id = (String) session.getAttribute("m_id");
	    if (fc_id == null) {
	        return "redirect:/member/login";
	    }

	    CommentVO originComment = service.getFcData(cvo.getFc_idx()); 

	    if (!fc_id.equals(originComment.getFc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setFc_comment(cvo.getFc_comment());
	    service.fcModify(originComment);

	    Long writeIdx = originComment.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	
	
//	Tip
	@GetMapping("/tcDel")
	public String tcDel(@RequestParam("tc_idx") Long tc_idx, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
		if (tc_id == null) {
			return "redirect:/member/login";
		}
		CommentVO writer = service.getTcData(tc_idx); 
	    if (!tc_id.equals(writer.getTc_id())) {
	    	log.info("tc_id: " + tc_id + ", writer: " + writer + ", tc_idx: " + tc_idx);
	        return "redirect:/errorPage";
	    }
        service.tcDel(tc_idx);
	    Long writeIdx = writer.getT_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@PostMapping("tcWrite")
	public String tcWrite(CommentVO cvo, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
		String tc_user = (String) session.getAttribute("m_user");
	    if (tc_id == null) {
	        return "redirect:/member/login";
	    }
	    cvo.setTc_id(tc_id);
	    cvo.setTc_user(tc_user);
		service.tcWrite(cvo);
		return "redirect:/board/tipRead?t_idx=" + cvo.getT_idx();
	}
	
	@PostMapping("/tcModify")
	public String tcModify(CommentVO cvo, HttpSession session) {
		String tc_id = (String) session.getAttribute("m_id");
	    if (tc_id == null) {
	        return "redirect:/member/login";
	    }

	    CommentVO originComment = service.getTcData(cvo.getTc_idx()); 

	    if (!tc_id.equals(originComment.getTc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setTc_comment(cvo.getTc_comment());
	    service.tcModify(originComment);

	    Long writeIdx = originComment.getT_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	
	
//	Comp
	@GetMapping("/ccDel")
	public String ccDel(@RequestParam("cc_idx") Long cc_idx, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
		if (cc_id == null) {
			return "redirect:/member/login";
		}
		CommentVO writer = service.getCcData(cc_idx); 
	    if (!cc_id.equals(writer.getCc_id())) {
	    	log.info("cc_id: " + cc_id + ", writer: " + writer + ", cc_idx: " + cc_idx);
	        return "redirect:/errorPage";
	    }
        service.ccDel(cc_idx);
	    Long writeIdx = writer.getC_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@PostMapping("ccWrite")
	public String ccWrite(CommentVO cvo, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
		String cc_user = (String) session.getAttribute("m_user");
	    if (cc_id == null) {
	        return "redirect:/member/login";
	    }
	    cvo.setCc_id(cc_id);
	    cvo.setCc_user(cc_user);
		service.ccWrite(cvo);
		return "redirect:/board/compRead?c_idx=" + cvo.getC_idx();
	}
	
	@PostMapping("/ccModify")
	public String ccModify(CommentVO cvo, HttpSession session) {
		String cc_id = (String) session.getAttribute("m_id");
	    if (cc_id == null) {
	        return "redirect:/member/login";
	    }

	    CommentVO originComment = service.getCcData(cvo.getCc_idx()); 

	    if (!cc_id.equals(originComment.getCc_id())) {
	        return "redirect:/errorPage";
	    }

	    originComment.setCc_comment(cvo.getCc_comment());
	    service.ccModify(originComment);

	    Long writeIdx = originComment.getC_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
