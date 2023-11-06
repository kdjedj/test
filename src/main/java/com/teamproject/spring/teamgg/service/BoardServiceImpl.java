package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.mapper.BoardMapper;
import com.teamproject.spring.teamgg.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;	
	
	@Override
	public int getStartIndex(int page) {
		int index = (page-1)* ConfigBoard.AMOUNT_PER_PAGE;
		return index;
	}

	@Override
	public List<BoardVO> getList(int page) {
		return mapper.freeList(page);
	}
	
	
//	FreeBoard
	@Override
	public BoardVO freeRead(long f_idx) {
		return mapper.freeRead(f_idx);
	}

	@Override
	public void freeDel(long f_idx) {
		mapper.freeDel(f_idx);
	}

	@Override
	public void freeWrite(BoardVO vo) {
		mapper.freeWrite(vo);
	}

	@Override
    public void freeModify(BoardVO vo) {
        mapper.freeModify(vo);
    }
	
	@Override
	public int getTotalCountFree() {
		
		return mapper.getTotalCountFree();
	}

	@Override
	public int getTotalPageFree() {
		//전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
		int totalCount = getTotalCountFree();
		int totalPage=0;
		if(totalCount % ConfigBoard.AMOUNT_PER_PAGE == 0) {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE;
		}else {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE + 1;
		}
		return totalPage;
	}

	@Override
	public int getTotalBlockFree(int totalPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalBlock = 0;
		if(totalPage % ConfigBoard.PAGE_PER_BLOCK == 0) {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK;
		}else {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK + 1;
		}		
		return totalBlock;
	}

	
//	TipBoard
	@Override
	public BoardVO tipRead(long t_idx) {
		return mapper.tipRead(t_idx);
	}
	
	@Override
	public void tipDel(long t_idx) {
		mapper.tipDel(t_idx);
	}
	
	@Override
	public void tipWrite(BoardVO vo) {
		mapper.tipWrite(vo);
	}
	
	@Override
	public void tipModify(BoardVO vo) {
		mapper.tipModify(vo);
	}
	
	@Override
	public int getTotalCountTip() {
		
		return mapper.getTotalCountTip();
	}

	@Override
	public int getTotalPageTip() {
		//전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
		int totalCount = getTotalCountTip();
		int totalPage=0;
		if(totalCount % ConfigBoard.AMOUNT_PER_PAGE == 0) {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE;
		}else {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE + 1;
		}
		return totalPage;
	}

	@Override
	public int getTotalBlockTip(int totalPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalBlock = 0;
		if(totalPage % ConfigBoard.PAGE_PER_BLOCK == 0) {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK;
		}else {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK + 1;
		}		
		return totalBlock;
	}
	
	
//	FreeBoard
	@Override
	public BoardVO compRead(long c_idx) {
		return mapper.compRead(c_idx);
	}
	
	@Override
	public void compDel(long c_idx) {
		mapper.compDel(c_idx);
	}
	
	@Override
	public void compWrite(BoardVO vo) {
		mapper.compWrite(vo);
	}
	
	@Override
	public void compModify(BoardVO vo) {
		mapper.compModify(vo);
	}
	
	@Override
	public int getTotalCountComp() {
		
		return mapper.getTotalCountComp();
	}

	@Override
	public int getTotalPageComp() {
		//전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
		int totalCount = getTotalCountComp();
		int totalPage=0;
		if(totalCount % ConfigBoard.AMOUNT_PER_PAGE == 0) {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE;
		}else {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE + 1;
		}
		return totalPage;
	}

	@Override
	public int getTotalBlockComp(int totalPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalBlock = 0;
		if(totalPage % ConfigBoard.PAGE_PER_BLOCK == 0) {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK;
		}else {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK + 1;
		}		
		return totalBlock;
	}
}


