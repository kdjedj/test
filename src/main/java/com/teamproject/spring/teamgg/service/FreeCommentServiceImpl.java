package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.mapper.FreeCommentMapper;
import com.teamproject.spring.teamgg.vo.FreeCommentVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class FreeCommentServiceImpl implements FreeCommentService{
	
	@Setter(onMethod_ = @Autowired)
	private FreeCommentMapper mapper;

	@Override
	public List<FreeCommentVo> getFcList(Long f_idx) {
		return mapper.fcList(f_idx);
	}
	
	@Override
	public FreeCommentVo getData(long fc_idx) {
		return mapper.getData(fc_idx);
	}

	@Override
	public void del(Long fc_idx) {
		mapper.fcDel(fc_idx);
	}

	@Override
	public void write(FreeCommentVo fcvo) {
	    if (fcvo.getFc_class() == 0) { // 댓글
	        int groupNum = findGroupNum(fcvo.getF_idx());
	        fcvo.setFc_group(groupNum);
	        fcvo.setFc_class(0);
	        fcvo.setFc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (fcvo.getFc_class() == 1) { // 대댓글
	    	int fcNum = findFcNum(fcvo.getF_idx(), fcvo.getFc_group());
	        fcvo.setFc_class(1);
	        fcvo.setFc_num(fcNum);
	        log.info("FcNum : " + fcNum);
	    }
		mapper.fcWrite(fcvo);
	}

	@Override
	public void modify(FreeCommentVo fcvo) {
		mapper.fcModify(fcvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findGroupNum(Long f_idx) {
        Integer lastGroupNum = mapper.findLastGroupNum(f_idx);
        log.info("LastGroupNum: " + lastGroupNum);
        return (lastGroupNum != null) ? lastGroupNum + 1 : 1;
    }
    
    // 대댓글 fc_num 설정
    @Override
    public int findFcNum(Long f_idx, int fc_group) {
        Integer lastFcNum = mapper.findLastFcNum(f_idx, fc_group);
        log.info("LastFcNum: " + lastFcNum + ", f_idx: " + f_idx + ", fc_group: " + fc_group);
        return (lastFcNum != null) ? lastFcNum + 1 : 1;
    }

    @Override
    public String getWriterByFcIdx(Long fc_idx) {
    	String writer = mapper.getWriterByFcIdx(fc_idx);
    	log.info("서비스 fc_id: " + writer);
    	return writer;
    }
}
