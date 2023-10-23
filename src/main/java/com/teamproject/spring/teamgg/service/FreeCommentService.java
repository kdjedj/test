package com.teamproject.spring.teamgg.service;

import java.util.List;

import com.teamproject.spring.teamgg.vo.FreeCommentVo;

public interface FreeCommentService {
	public List<FreeCommentVo> getFcList(Long f_idx);
	public FreeCommentVo getData(long fc_idx);
	public void del(Long fc_idx);
	public void write(FreeCommentVo fcvo);
	public void modify(FreeCommentVo fcvo);
	
    int findGroupNum(Long f_idx);
    int findFcNum(Long f_idx, int fc_group);
    
    public String getWriterByFcIdx(Long fc_idx);
}
