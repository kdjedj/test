package com.teamproject.spring.teamgg.service;

import java.util.List;

import com.teamproject.spring.teamgg.vo.CompCommentVo;

public interface CompCommentService {
	public List<CompCommentVo> getCcList(Long c_idx);
	public CompCommentVo getData(long cc_idx);
	public void del(Long cc_idx);
	public void write(CompCommentVo ccvo);
	public void modify(CompCommentVo ccvo);
	
    int findGroupNum(Long c_idx);
    int findCcNum(Long c_idx, int cc_group);
    
    public String getWriterByCcIdx(Long cc_idx);
}
