package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.mapper.CompBoardMapper;
import com.teamproject.spring.teamgg.vo.CompBoardVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class CompBoardServiceImpl implements CompBoardService{

	@Setter(onMethod_ = @Autowired)
	private CompBoardMapper mapper;	
	
	@Override
	public List<CompBoardVo> getList(int page) {
		return mapper.compList(page);
	}

	@Override
	public CompBoardVo read(long c_idx) {
		return mapper.compRead(c_idx);
	}

	@Override
	public void del(long c_idx) {
		mapper.compDel(c_idx);
	}

	@Override
	public void write(CompBoardVo cvo) {
		mapper.compWrite(cvo);
	}

	@Override
    public void modify(CompBoardVo cvo) {
        mapper.compModify(cvo);
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
	public String getAuthorNickname(long c_idx) {
        return mapper.getAuthorNickname(c_idx);
    }
}


