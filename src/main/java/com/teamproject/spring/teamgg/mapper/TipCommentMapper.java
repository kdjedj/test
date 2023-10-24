package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.spring.teamgg.vo.TipCommentVo;

public interface TipCommentMapper {
	public List<TipCommentVo> tcList(Long t_idx);
	public TipCommentVo getData(Long tc_idx);
	public void tcDel(Long tc_idx);
	public void tcWrite(TipCommentVo tcvo);
	public void tcModify(TipCommentVo tcvo);
	
	Integer findLastGroupNum(Long t_idx);
    Integer findLastTcNum(@Param("t_idx") Long t_idx, @Param("tc_group") int tc_group);
    
    public String getWriterByTcIdx(Long tc_idx);
}
