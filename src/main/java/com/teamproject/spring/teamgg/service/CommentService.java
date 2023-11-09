package com.teamproject.spring.teamgg.service;

import java.util.List;

import com.teamproject.spring.teamgg.vo.CommentVO;

public interface CommentService {
	public List<CommentVO> getFcList(Long f_idx);
	public CommentVO getFcData(long fc_idx);
	public void fcDel(Long fc_idx);
	public void fcWrite(CommentVO cvo);
	public void fcModify(CommentVO cvo);
    int findFcGroupNum(Long f_idx);
    int findFcNum(Long f_idx, int fc_group);
    public String getWriterByFcIdx(Long fc_idx);
    
//    Tip
	public List<CommentVO> getTcList(Long t_idx);
	public CommentVO getTcData(long tc_idx);
	public void tcDel(Long tc_idx);
	public void tcWrite(CommentVO cvo);
	public void tcModify(CommentVO cvo);
    int findTcGroupNum(Long t_idx);
    int findTcNum(Long t_idx, int tc_group);
    public String getWriterByTcIdx(Long tc_idx);
    
//    Comp
	public List<CommentVO> getCcList(Long c_idx);
	public CommentVO getCcData(long cc_idx);
	public void ccDel(Long cc_idx);
	public void ccWrite(CommentVO cvo);
	public void ccModify(CommentVO cvo);
    int findCcGroupNum(Long c_idx);
    int findCcNum(Long c_idx, int cc_group);
    public String getWriterByCcIdx(Long cc_idx);
}
