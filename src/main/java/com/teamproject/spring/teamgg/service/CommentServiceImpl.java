package com.teamproject.spring.teamgg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.spring.teamgg.mapper.CommentMapper;
import com.teamproject.spring.teamgg.vo.CommentVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class CommentServiceImpl implements CommentService{
	
	@Setter(onMethod_ = @Autowired)
	private CommentMapper mapper;

	
//	Free
	@Override
	public List<CommentVO> getFcList(Long f_idx) {
		return mapper.fcList(f_idx);
	}
	
	@Override
	public CommentVO getFcData(long fc_idx) {
		return mapper.getFcData(fc_idx);
	}

	@Override
	public void fcDel(Long fc_idx) {
		mapper.fcDel(fc_idx);
	}

	@Override
	public void fcWrite(CommentVO cvo) {
	    if (cvo.getFc_class() == 0) { // 댓글
	        int groupNum = findFcGroupNum(cvo.getF_idx());
	        cvo.setFc_group(groupNum);
	        cvo.setFc_class(0);
	        cvo.setFc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (cvo.getFc_class() == 1) { // 대댓글
	    	int fcNum = findFcNum(cvo.getF_idx(), cvo.getFc_group());
	        cvo.setFc_class(1);
	        cvo.setFc_num(fcNum);
	        log.info("FcNum : " + fcNum);
	    }
		mapper.fcWrite(cvo);
	}

	@Override
	public void fcModify(CommentVO cvo) {
		mapper.fcModify(cvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findFcGroupNum(Long f_idx) {
        Integer lastGroupNum = mapper.findLastFcGroupNum(f_idx);
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
    
    
//    Tip
	@Override
	public List<CommentVO> getTcList(Long t_idx) {
		return mapper.tcList(t_idx);
	}
	
	@Override
	public CommentVO getTcData(long tc_idx) {
		return mapper.getTcData(tc_idx);
	}

	@Override
	public void tcDel(Long tc_idx) {
		mapper.tcDel(tc_idx);
	}

	@Override
	public void tcWrite(CommentVO cvo) {
	    if (cvo.getTc_class() == 0) { // 댓글
	        int groupNum = findTcGroupNum(cvo.getT_idx());
	        cvo.setTc_group(groupNum);
	        cvo.setTc_class(0);
	        cvo.setTc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (cvo.getTc_class() == 1) { // 대댓글
	    	int tcNum = findTcNum(cvo.getT_idx(), cvo.getTc_group());
	        cvo.setTc_class(1);
	        cvo.setTc_num(tcNum);
	        log.info("TcNum : " + tcNum);
	    }
		mapper.tcWrite(cvo);
	}

	@Override
	public void tcModify(CommentVO cvo) {
		mapper.tcModify(cvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findTcGroupNum(Long t_idx) {
        Integer lastGroupNum = mapper.findLastTcGroupNum(t_idx);
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
    
    
//    Comp
	@Override
	public List<CommentVO> getCcList(Long c_idx) {
		return mapper.ccList(c_idx);
	}
	
	@Override
	public CommentVO getCcData(long cc_idx) {
		return mapper.getCcData(cc_idx);
	}

	@Override
	public void ccDel(Long cc_idx) {
		mapper.ccDel(cc_idx);
	}

	@Override
	public void ccWrite(CommentVO cvo) {
	    if (cvo.getCc_class() == 0) { // 댓글
	        int groupNum = findCcGroupNum(cvo.getC_idx());
	        cvo.setCc_group(groupNum);
	        cvo.setCc_class(0);
	        cvo.setCc_num(0);
	        log.info("groupNum : " + groupNum);
	    } else if (cvo.getCc_class() == 1) { // 대댓글
	    	int ccNum = findCcNum(cvo.getC_idx(), cvo.getCc_group());
	        cvo.setCc_class(1);
	        cvo.setCc_num(ccNum);
	        log.info("CcNum : " + ccNum);
	    }
		mapper.ccWrite(cvo);
	}

	@Override
	public void ccModify(CommentVO cvo) {
		mapper.ccModify(cvo);
	}
	
	// 댓글 작성 시 그룹 번호 설정
    @Override
    public int findCcGroupNum(Long c_idx) {
        Integer lastGroupNum = mapper.findLastCcGroupNum(c_idx);
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
