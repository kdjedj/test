package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.mapper.FreeBoardMapper;
import com.teamproject.spring.teamgg.vo.FreeBoardVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class FreeBoardServiceImpl implements FreeBoardService{

	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper mapper;	
	
	@Override
	public List<FreeBoardVo> getList(int page) {
		return mapper.freeList(page);
	}

	@Override
	public FreeBoardVo read(long f_idx) {
		return mapper.freeRead(f_idx);
	}

	@Override
	public void del(long f_idx) {
		mapper.freeDel(f_idx);
	}

	@Override
	public void write(FreeBoardVo fvo) {
		mapper.freeWrite(fvo);
	}

	@Override
    public void modify(FreeBoardVo fvo) {
        mapper.freeModify(fvo);
    }

	@Override
	public int getStartIndex(int page) {
		int index = (page-1)* ConfigBoard.AMOUNT_PER_PAGE;
		return index;
	}

	@Override
	public int getTotalCount() {
		
		return mapper.getTotalCount();
	}

	@Override
	public int getTotalPage() {
		//전체 페이지 수 = 전체 글 수 / [페이지당 글 수]
		int totalCount = getTotalCount();
		int totalPage=0;
		if(totalCount % ConfigBoard.AMOUNT_PER_PAGE == 0) {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE;
		}else {
			totalPage = totalCount / ConfigBoard.AMOUNT_PER_PAGE + 1;
		}
		return totalPage;
	}

	@Override
	public int getTotalBlock(int totalPage) {
		//전체 블럭 수 = 전체 페이지 수 / [블럭당 페이지 수]
		int totalBlock = 0;
		if(totalPage % ConfigBoard.PAGE_PER_BLOCK == 0) {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK;
		}else {
			totalBlock = totalPage / ConfigBoard.PAGE_PER_BLOCK + 1;
		}		
		return totalBlock;
	}
	
	@Override
	public String getAuthorId(long f_idx) {
        return mapper.getAuthorId(f_idx);
    }
}


