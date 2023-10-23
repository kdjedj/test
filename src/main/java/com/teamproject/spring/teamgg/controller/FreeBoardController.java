package com.teamproject.spring.teamgg.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.service.FreeCommentService;
import com.teamproject.spring.teamgg.service.FreeBoardService;
import com.teamproject.spring.teamgg.vo.FreeBoardVo;
import com.teamproject.spring.teamgg.vo.FreeCommentVo;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/free/*")
@AllArgsConstructor
@Controller
public class FreeBoardController {
	private FreeBoardService service;
	private FreeCommentService commentService;
	
	// 리스트
	@GetMapping("/freeList")
	public void list(Model model, @RequestParam(value="page", defaultValue="1")
				int page, MemberVO mv) {
		System.out.println("====== 자유게시판 리스트");
		
//		 ========= 페이징 =========
		// 시작 인덱스
		int index = service.getStartIndex(page);
		// 전체 글 수
		int totalCount = service.getTotalCount();
		// 전체 페이지 수
		int totalPage = service.getTotalPage();
		// 전체 블럭 수
		int totalBlock = service.getTotalBlock(totalPage);
		// 현재 블럭 번호
		int currentBlock = (int)Math.ceil((double)page/ConfigBoard.PAGE_PER_BLOCK);
		
		
		// 블럭 시작 페이지 번호 = (현재 블럭 번호 - 1) * 블럭 당 페이지 수 + 1
		int blockStartNo = (currentBlock - 1) * ConfigBoard.PAGE_PER_BLOCK + 1;
		// 블럭 페이지 끝 번호 = 현재 블럭 번호 * 블럭 당 페이지 수		
		int blockEndNo = currentBlock * ConfigBoard.PAGE_PER_BLOCK;
		
		// 이전, 다음 블럭 가기 가능 여부 처리
		boolean hasPrev = true;	//이전 블럭 가기 가능 여부 저장값 초기화.
		boolean hasNext = true;	//다음 블럭 가기 가능 여부 저장값 초기화.
		int prevPage = 0;
		int nextPage = 0;	
		
		if(currentBlock == 1){
			hasPrev = false;
		} else {
			hasPrev = true;
			// 이전 블럭으로 이동 시 위치할 페이지를 해당 블럭의 마지막 페이지로 지정
			// 값 = (현재 블럭 번호 - 1) * 블럭 당 페이지 수
			prevPage = (currentBlock - 1 ) * ConfigBoard.PAGE_PER_BLOCK;
		}
		
		
		if(currentBlock < totalBlock ){
			hasNext = true;
			// 다음 블럭으로 이동 시 위치할 페이지를 해당 블럭의 첫 페이지로 지정
			// 값 = 현재 블럭 번호 * 블럭 당 페이지 수 + 1
			nextPage = currentBlock * ConfigBoard.PAGE_PER_BLOCK + 1;		
		} else {
			hasNext = false;
		}
//		 ========= 페이징 =========
		
		// 모델에 데이터 추가
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("totalPage",totalPage);
		model.addAttribute("totalBlock",totalBlock);
		model.addAttribute("currentBlock",currentBlock);
		model.addAttribute("blockStartNo",blockStartNo);
		model.addAttribute("blockEndNo",blockEndNo);
		model.addAttribute("hasPrev",hasPrev);
		model.addAttribute("hasNext",hasNext);
		model.addAttribute("prevPage",prevPage);
		model.addAttribute("nextPage",nextPage);
		model.addAttribute("list",service.getList(index));
		
	}
	
	@GetMapping("/freeRead")
	public void read(@RequestParam("f_idx") Long f_idx, Model model) {
		System.out.println("====== 읽기, 수정 (" + f_idx + ")");
		model.addAttribute("freeRead",service.read(f_idx));
		
		List<FreeCommentVo> fcList = commentService.getFcList(f_idx);
	    model.addAttribute("fcList", fcList);
	}

	@GetMapping("/freeDel")
	public String del(@RequestParam("f_idx") Long f_idx, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		if (f_id == null) {
			return "redirect:/member/login";
		}
	    FreeBoardVo originPost = service.read(f_idx);
	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }
	        service.del(f_idx);
		return "redirect:/free/freeList";
	}
	
	@GetMapping("/freeWrite") // view
	public String write(HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    return "/free/freeWrite";
	}
	
	@PostMapping("/freeWrite")
	public String write(FreeBoardVo fvo, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		String f_user = (String) session.getAttribute("m_user");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    fvo.setF_id(f_id);
	    fvo.setF_user(f_user);
	    service.write(fvo);
//	    작성 완료된 글번호로 이동
	    Long writeIdx = fvo.getWriteIdx();
	    if (writeIdx != null) {
	        return "redirect:/free/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@GetMapping("/freeModify")
	public String modify(@RequestParam("f_idx") Long f_idx, Model model, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		if (f_id == null) {
			return "redirect:/member/login";
		}
		
	    FreeBoardVo originPost = service.read(f_idx);
	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }
	    
		model.addAttribute("freeRead", service.read(f_idx));
		return "/free/freeModify";
	}
	
	@PostMapping("/freeModify")
	public String modify(FreeBoardVo fvo, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    
	    FreeBoardVo originPost = service.read(fvo.getF_idx());

	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }

	    originPost.setF_title(fvo.getF_title());
	    originPost.setF_content(fvo.getF_content());
	    service.modify(originPost);

	    // 작성 완료된 글번호로 이동
	    Long writeIdx = originPost.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/free/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
