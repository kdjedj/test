package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.mapper.TipCommentMapper;
import com.teamproject.spring.teamgg.vo.TipCommentVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class TipCommentServiceImpl implements TipCommentService{
	
	@Setter(onMethod_ = @Autowired)
	private TipCommentMapper mapper;

	@Override
	public List<TipCommentVo> getTcList(Long t_idx) {
		return mapper.tcList(t_idx);
	}
	
	@Override
	public TipCommentVo getData(long tc_idx) {
		return mapper.getData(tc_idx);
	}

	@Override
	public void del(Long tc_idx) {
		mapper.tcDel(tc_idx);
	}

	@Override
	public void write(TipCommentVo tcvo) {
	    if (tcvo.getTc_class() == 0) { // 댓글
	        int groupNum = findGroupNum(tcvo.getT_idx());
	        tcvo.setTc_group(groupNum);
	        tcvo.setTc_class(0);
	        tcvo.setTc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (tcvo.getTc_class() == 1) { // 대댓글
	    	int tcNum = findTcNum(tcvo.getT_idx(), tcvo.getTc_group());
	        tcvo.setTc_class(1);
	        tcvo.setTc_num(tcNum);
	        log.info("TcNum : " + tcNum);
	    }
		mapper.tcWrite(tcvo);
	}

	@Override
	public void modify(TipCommentVo tcvo) {
		mapper.tcModify(tcvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findGroupNum(Long t_idx) {
        Integer lastGroupNum = mapper.findLastGroupNum(t_idx);
        log.info("LastGroupNum: " + lastGroupNum);
        return (lastGroupNum != null) ? lastGroupNum + 1 : 1;
    }
    
    // 대댓글 tc_num 설정
    @Override
    public int findTcNum(Long t_idx, int tc_group) {
        Integer lastTcNum = mapper.findLastTcNum(t_idx, tc_group);
        log.info("LastTcNum: " + lastTcNum + ", t_idx: " + t_idx + ", tc_group: " + tc_group);
        return (lastTcNum != null) ? lastTcNum + 1 : 1;
    }

    @Override
    public String getWriterByTcIdx(Long tc_idx) {
    	String writer = mapper.getWriterByTcIdx(tc_idx);
    	log.info("서비스 tc_id: " + writer);
    	return writer;
    }
}
