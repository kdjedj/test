package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.spring.teamgg.vo.CompCommentVo;

public interface CompCommentMapper {
	public List<CompCommentVo> ccList(Long c_idx);
	public CompCommentVo getData(Long cc_idx);
	public void ccDel(Long cc_idx);
	public void ccWrite(CompCommentVo ccvo);
	public void ccModify(CompCommentVo ccvo);
	
	Integer findLastGroupNum(Long c_idx);
    Integer findLastCcNum(@Param("c_idx") Long c_idx, @Param("cc_group") int cc_group);
    
    public String getWriterByCcIdx(Long cc_idx);
}
