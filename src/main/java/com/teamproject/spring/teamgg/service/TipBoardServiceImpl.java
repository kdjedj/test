package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.mapper.TipBoardMapper;
import com.teamproject.spring.teamgg.vo.TipBoardVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class TipBoardServiceImpl implements TipBoardService{

	@Setter(onMethod_ = @Autowired)
	private TipBoardMapper mapper;	
	
	@Override
	public List<TipBoardVo> getList(int page) {
		return mapper.tipList(page);
	}

	@Override
	public TipBoardVo read(long t_idx) {
		return mapper.tipRead(t_idx);
	}

	@Override
	public void del(long t_idx) {
		mapper.tipDel(t_idx);
	}

	@Override
	public void write(TipBoardVo tvo) {
		mapper.tipWrite(tvo);
	}

	@Override
    public void modify(TipBoardVo tvo) {
        mapper.tipModify(tvo);
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
	public String getAuthorNickname(long t_idx) {
        return mapper.getAuthorNickname(t_idx);
    }
}


