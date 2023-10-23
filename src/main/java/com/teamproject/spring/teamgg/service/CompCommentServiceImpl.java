package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.mapper.CompCommentMapper;
import com.teamproject.spring.teamgg.vo.CompCommentVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class CompCommentServiceImpl implements CompCommentService{
	
	@Setter(onMethod_ = @Autowired)
	private CompCommentMapper mapper;

	@Override
	public List<CompCommentVo> getCcList(Long c_idx) {
		return mapper.ccList(c_idx);
	}
	
	@Override
	public CompCommentVo getData(long cc_idx) {
		return mapper.getData(cc_idx);
	}

	@Override
	public void del(Long cc_idx) {
		mapper.ccDel(cc_idx);
	}

	@Override
	public void write(CompCommentVo ccvo) {
	    if (ccvo.getCc_class() == 0) { // 댓글
	        int groupNum = findGroupNum(ccvo.getC_idx());
	        ccvo.setCc_group(groupNum);
	        ccvo.setCc_class(0);
	        ccvo.setCc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (ccvo.getCc_class() == 1) { // 대댓글
	    	int ccNum = findCcNum(ccvo.getC_idx(), ccvo.getCc_group());
	        ccvo.setCc_class(1);
	        ccvo.setCc_num(ccNum);
	        log.info("CcNum : " + ccNum);
	    }
		mapper.ccWrite(ccvo);
	}

	@Override
	public void modify(CompCommentVo ccvo) {
		mapper.ccModify(ccvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findGroupNum(Long c_idx) {
        Integer lastGroupNum = mapper.findLastGroupNum(c_idx);
        log.info("LastGroupNum: " + lastGroupNum);
        return (lastGroupNum != null) ? lastGroupNum + 1 : 1;
    }
    
    // 대댓글 cc_num 설정
    @Override
    public int findCcNum(Long c_idx, int cc_group) {
        Integer lastCcNum = mapper.findLastCcNum(c_idx, cc_group);
        log.info("LastCcNum: " + lastCcNum + ", c_idx: " + c_idx + ", cc_group: " + cc_group);
        return (lastCcNum != null) ? lastCcNum + 1 : 1;
    }

    @Override
    public String getWriterByCcIdx(Long cc_idx) {
    	String writer = mapper.getWriterByCcIdx(cc_idx);
    	log.info("서비스 cc_id: " + writer);
    	return writer;
    }
}
