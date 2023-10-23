package com.teamproject.spring.teamgg.service;

import java.util.List;

import com.teamproject.spring.teamgg.vo.TipCommentVo;

public interface TipCommentService {
	public List<TipCommentVo> getTcList(Long t_idx);
	public TipCommentVo getData(long tc_idx);
	public void del(Long tc_idx);
	public void write(TipCommentVo tcvo);
	public void modify(TipCommentVo tcvo);
	
    int findGroupNum(Long t_idx);
    int findTcNum(Long t_idx, int tc_group);
    
    public String getWriterByTcIdx(Long tc_idx);
}
