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
import com.teamproject.spring.teamgg.service.BoardService;
import com.teamproject.spring.teamgg.service.CompCommentService;
import com.teamproject.spring.teamgg.service.FreeCommentService;
import com.teamproject.spring.teamgg.service.TipCommentService;
import com.teamproject.spring.teamgg.vo.BoardVO;
import com.teamproject.spring.teamgg.vo.CompCommentVo;
import com.teamproject.spring.teamgg.vo.FreeCommentVo;
import com.teamproject.spring.teamgg.vo.MemberVO;
import com.teamproject.spring.teamgg.vo.TipCommentVo;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
@Controller
public class BoardController {
	private BoardService service;
	private FreeCommentService fcService;
	private TipCommentService tcService;
	private CompCommentService ccService;
	
	// FreeBoard
	@GetMapping("/freeList")
	public void freeList(Model model, @RequestParam(value="page", defaultValue="1")
				int page, MemberVO mv) {
		System.out.println("====== 자유게시판 리스트");
		
//		 ========= 페이징 =========
		// 시작 인덱스
		int index = service.getStartIndex(page);
		// 전체 글 수
		int totalCount = service.getTotalCountFree();
		// 전체 페이지 수
		int totalPage = service.getTotalPageFree();
		// 전체 블럭 수
		int totalBlock = service.getTotalBlockFree(totalPage);
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
		model.addAttribute("freeList",service.getFreeList(index));
		
	}
	
	@GetMapping("/freeRead")
	public void freeRead(@RequestParam("f_idx") Long f_idx, Model model) {
		System.out.println("====== 읽기, 수정 (" + f_idx + ")");
		model.addAttribute("freeRead",service.freeRead(f_idx));
		
		List<FreeCommentVo> fcList = fcService.getFcList(f_idx);
	    model.addAttribute("fcList", fcList);
	}

	@GetMapping("/freeDel")
	public String freeDel(@RequestParam("f_idx") Long f_idx, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		if (f_id == null) {
			return "redirect:/member/login";
		}
	    BoardVO originPost = service.freeRead(f_idx);
	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }
	        service.freeDel(f_idx);
		return "redirect:/board/freeList";
	}
	
	@GetMapping("/freeWrite") // view
	public String freeWrite(HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    return "/board/freeWrite";
	}
	
	@PostMapping("/freeWrite")
	public String freeWrite(BoardVO vo, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		String f_user = (String) session.getAttribute("m_user");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    vo.setF_id(f_id);
	    vo.setF_user(f_user);
	    service.freeWrite(vo);
//	    작성 완료된 글번호로 이동
	    Long writeIdx = vo.getWriteIdx();
	    if (writeIdx != null) {
	        return "redirect:/board/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@GetMapping("/freeModify")
	public String freeModify(@RequestParam("f_idx") Long f_idx, Model model, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
		if (f_id == null) {
			return "redirect:/member/login";
		}
		
	    BoardVO originPost = service.freeRead(f_idx);
	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }
	    
		model.addAttribute("freeRead", service.freeRead(f_idx));
		return "/board/freeModify";
	}
	
	@PostMapping("/freeModify")
	public String freeModify(BoardVO vo, HttpSession session) {
		String f_id = (String) session.getAttribute("m_id");
	    if (f_id == null) {
	        return "redirect:/member/login";
	    }
	    
	    BoardVO originPost = service.freeRead(vo.getF_idx());

	    if (!f_id.equals(originPost.getF_id())) {
	        return "redirect:/errorPage";
	    }

	    originPost.setF_title(vo.getF_title());
	    originPost.setF_content(vo.getF_content());
	    service.freeModify(originPost);

	    // 작성 완료된 글번호로 이동
	    Long writeIdx = originPost.getF_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/freeRead?f_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	// TipBoard
	@GetMapping("/tipList")
	public void tipList(Model model, @RequestParam(value="page", defaultValue="1")
				int page, MemberVO mv) {
		System.out.println("====== 정보게시판 리스트");
		
//		 ========= 페이징 =========
		// 시작 인덱스
		int index = service.getStartIndex(page);
		// 전체 글 수
		int totalCount = service.getTotalCountTip();
		// 전체 페이지 수
		int totalPage = service.getTotalPageTip();
		// 전체 블럭 수
		int totalBlock = service.getTotalBlockTip(totalPage);
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
		model.addAttribute("tipList",service.getTipList(index));
		
	}
	
	@GetMapping("/tipRead")
	public void tipRead(@RequestParam("t_idx") Long t_idx, Model model) {
		System.out.println("====== 읽기, 수정 (" + t_idx + ")");
		model.addAttribute("tipRead",service.tipRead(t_idx));
		
		List<TipCommentVo> tcList = tcService.getTcList(t_idx);
		model.addAttribute("tcList", tcList);
	}
	
	@GetMapping("/tipDel")
	public String del(@RequestParam("t_idx") Long t_idx, HttpSession session) {
		String t_id = (String) session.getAttribute("m_id");
		if (t_id == null) {
			return "redirect:/member/login";
		}
	    BoardVO originPost = service.tipRead(t_idx);
	    if (!t_id.equals(originPost.getT_id())) {
	        return "redirect:/errorPage";
	    }
	        service.tipDel(t_idx);
		return "redirect:/board/tipList";
	}
	
	@GetMapping("/tipWrite") // view
	public String tipWrite(HttpSession session) {
		String t_id = (String) session.getAttribute("m_id");
	    if (t_id == null) {
	        return "redirect:/member/login";
	    }
	    return "/board/tipWrite";
	}
	
	@PostMapping("/tipWrite")
	public String tipWrite(BoardVO vo, HttpSession session) {
		String t_id = (String) session.getAttribute("m_id");
		String t_user = (String) session.getAttribute("m_user");
	    if (t_id == null) {
	        return "redirect:/member/login";
	    }
	    vo.setT_id(t_id);
	    vo.setT_user(t_user);
	    service.tipWrite(vo);
//	    작성 완료된 글번호로 이동
	    Long writeIdx = vo.getWriteIdx();
	    if (writeIdx != null) {
	        return "redirect:/board/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@GetMapping("/tipModify")
	public String tipModify(@RequestParam("t_idx") Long t_idx, Model model, HttpSession session) {
		String t_id = (String) session.getAttribute("m_id");
		if (t_id == null) {
			return "redirect:/member/login";
		}
		
	    BoardVO originPost = service.tipRead(t_idx);
	    if (!t_id.equals(originPost.getT_id())) {
	        return "redirect:/errorPage";
	    }
		
		model.addAttribute("tipRead", service.tipRead(t_idx));
		return "/board/tipModify";
	}
	
	@PostMapping("/tipModify")
	public String tipModify(BoardVO vo, HttpSession session) {
		String t_id = (String) session.getAttribute("m_id");
	    if (t_id == null) {
	        return "redirect:/member/login";
	    }

	    BoardVO originPost = service.tipRead(vo.getT_idx());

	    if (!t_id.equals(originPost.getT_id())) {
	        return "redirect:/errorPage";
	    }

	    originPost.setT_title(vo.getT_title());
	    originPost.setT_content(vo.getT_content());
	    service.tipModify(originPost);

//	    작성 완료된 글번호로 이동
	    Long writeIdx = originPost.getT_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/tipRead?t_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	
	// CompBoard
	@GetMapping("/compList")
	public void compList(Model model, @RequestParam(value="page", defaultValue="1")
				int page, MemberVO mv) {
		System.out.println("====== 유저찾기게시판 리스트");
		
//		 ========= 페이징 =========
		// 시작 인덱스
		int index = service.getStartIndex(page);
		// 전체 글 수
		int totalCount = service.getTotalCountComp();
		// 전체 페이지 수
		int totalPage = service.getTotalPageComp();
		// 전체 블럭 수
		int totalBlock = service.getTotalBlockComp(totalPage);
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
		model.addAttribute("compList",service.getCompList(index));
		
	}
	
	@GetMapping("/compRead")
	public void compRead(@RequestParam("c_idx") Long c_idx, Model model) {
		System.out.println("====== 읽기, 수정 (" + c_idx + ")");
		model.addAttribute("compRead",service.compRead(c_idx));
		
		List<CompCommentVo> ccList = ccService.getCcList(c_idx);
		model.addAttribute("ccList", ccList);
	}

	@GetMapping("/compDel")
	public String compDel(@RequestParam("c_idx") Long c_idx, HttpSession session) {
		String c_id = (String) session.getAttribute("m_id");
		if (c_id == null) {
			return "redirect:/member/login";
		}
	    BoardVO originPost = service.compRead(c_idx);
	    if (!c_id.equals(originPost.getC_id())) {
	        return "redirect:/errorPage";
	    }
	        service.compDel(c_idx);
		return "redirect:/board/compList";
	}
	
	@GetMapping("/compWrite") // view
	public String compWrite(HttpSession session) {
		String c_id = (String) session.getAttribute("m_id");
	    if (c_id == null) {
	        return "redirect:/member/login";
	    }
	    return "/board/compWrite";
	}
	
	@PostMapping("/compWrite")
	public String compWrite(BoardVO vo, HttpSession session) {
		String c_id = (String) session.getAttribute("m_id");
		String c_user = (String) session.getAttribute("m_user");
	    if (c_id == null) {
	        return "redirect:/member/login";
	    }
	    vo.setC_id(c_id);
	    vo.setC_user(c_user);
	    service.compWrite(vo);
//	    작성 완료된 글번호로 이동
	    Long writeIdx = vo.getWriteIdx();
	    if (writeIdx != null) {
	        return "redirect:/board/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
	
	@GetMapping("/compModify")
	public String compModify(@RequestParam("c_idx") Long c_idx, Model model, HttpSession session) {
		String c_id = (String) session.getAttribute("m_id");
		if (c_id == null) {
			return "redirect:/member/login";
		}
		
		BoardVO originPost = service.compRead(c_idx);
	    if (!c_id.equals(originPost.getC_id())) {
	        return "redirect:/errorPage";
	    }
	    
		model.addAttribute("compRead", service.compRead(c_idx));
		return "/board/compModify";
	}
	
	@PostMapping("/compModify")
	public String compModify(BoardVO vo, HttpSession session) {
		String c_id = (String) session.getAttribute("m_id");
	    if (c_id == null) {
	        return "redirect:/member/login";
	    }
	    
	    BoardVO originPost = service.compRead(vo.getC_idx());

	    if (!c_id.equals(originPost.getC_id())) {
	        return "redirect:/errorPage";
	    }

	    originPost.setC_title(vo.getC_title());
	    originPost.setC_content(vo.getC_content());
	    service.compModify(originPost);

//	    작성 완료된 글번호로 이동
	    Long writeIdx = originPost.getC_idx();
	    if (writeIdx != null) {
	        return "redirect:/board/compRead?c_idx=" + writeIdx;
	    } else {
	        return "redirect:/errorPage";
	    }
	}
}
