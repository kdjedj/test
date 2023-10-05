package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.board.ConfigBoard;
import com.teamproject.spring.teamgg.mapper.GuestMapper;
import com.teamproject.spring.teamgg.vo.GuestVO;
import com.teamproject.spring.teamgg.vo.MbinfoVO;
import com.teamproject.spring.teamgg.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class GuestServiceImpl implements GuestService{

	@Setter(onMethod_ = @Autowired)
	private GuestMapper mapper;	
	
	@Override
	public List<GuestVO> getList(int IndexNumber) {
		log.info("비지니스 계층===========");
		return mapper.getList(IndexNumber);
	}

	@Override
	public GuestVO read(long m_idx) {
		log.info("읽기 컨트롤러에서 넘어온 값==========="+m_idx);
		return mapper.read(m_idx);
	}

	@Override
	public void del(long m_idx) {
		mapper.del(m_idx);
	}

	@Override
	public void write(GuestVO gvo) {
		mapper.write(gvo);
	}

	@Override
	public void modify(GuestVO gvo) {
		mapper.modify(gvo);
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
	public int login_count(MemberVO mv) {
		int loginNumber = mapper.login_count(mv);
		
		log.info("로그인 카운트==========="+loginNumber);
		return loginNumber;
	}
	
	
	
	@Override
	public MbinfoVO login_string(MemberVO mv) {
		log.info("게스트 서비스 함수 실행됨===========");
		return mapper.login_string(mv);
	}
//		@Override
//		public MbinfoVO login_string(MemberVO mv) {
//			
//			int loginOk=login_count(mv);
//			if(loginOk==0) {
//				return "no id";
//			} else {
//				return mapper.login_string(mv);
//			}
//			
//			
		
	
	
	
	
	
}


