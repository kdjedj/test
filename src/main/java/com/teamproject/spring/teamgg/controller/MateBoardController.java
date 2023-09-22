package com.teamproject.spring.teamgg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.service.MateBoardService;
import com.teamproject.spring.teamgg.vo.MateBoardVo;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/mate/*")
@AllArgsConstructor
@Controller
public class MateBoardController {
	private MateBoardService service;
	
	// 리스트
	@GetMapping("/mateList")
	public void list(Model model, @RequestParam(value="page", defaultValue="1")
				int page, MemberVO mv) {
		System.out.println("====== 유저찾기게시판 리스트");
		
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
	
	@GetMapping("/mateRead")
	public void read(@RequestParam("m_idx") Long m_idx, Model model) {
		System.out.println("====== 읽기, 수정 (" + m_idx + ")");
		model.addAttribute("mateRead",service.read(m_idx));
	}

	@GetMapping("/mateDel")
	public String del(@RequestParam("m_idx") Long m_idx, HttpSession session) {
		String m_writer = (String) session.getAttribute("m_id");
		if (m_writer == null) {
			return "redirect:/member/login";
		}
	        service.del(m_idx);
		return "redirect:/mate/mateList";
	}
	
	@GetMapping("/mateWrite") // view
	public String write(HttpSession session) {
		String m_writer = (String) session.getAttribute("m_id");
	    if (m_writer == null) {
	        return "redirect:/member/login";
	    }
	    return "/mate/mateWrite";
	}
	
	@PostMapping("/mateWrite")        // todo: 리스트 말고 작성한 글 읽기 화면으로 리다이렉트하기
	public String write(MateBoardVo mvo, HttpSession session) {
		String m_writer = (String) session.getAttribute("m_id");
	    if (m_writer == null) {
	        return "redirect:/member/login";
	    }
	    mvo.setM_writer(m_writer);
	    service.write(mvo);
	    return "redirect:/mate/mateList";
	}
	
	@GetMapping("/mateModify")
	public String modify(@RequestParam("m_idx") Long m_idx, Model model, HttpSession session) {
		String m_writer = (String) session.getAttribute("m_id");
		if (m_writer == null) {
			return "redirect:/member/login";
		}
		model.addAttribute("mateRead", service.read(m_idx));
		return "/mate/mateModify";
	}
	
	@PostMapping("/mateModify")           // todo: 리스트 말고 작성한 글 읽기 화면으로 리다이렉트하기
	public String modify(MateBoardVo mvo, HttpSession session) {
		String m_writer = (String) session.getAttribute("m_id");
	    if (m_writer == null) {
	        return "redirect:/member/login";
	    }
	    mvo.setM_writer(m_writer);
	    log.info("======modify mvo: "+mvo+", m_writer: " + m_writer);
	    service.modify(mvo);
	    return "redirect:/mate/mateList";
	}
}
