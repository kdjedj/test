package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.spring.teamgg.vo.FreeCommentVo;

public interface FreeCommentMapper {
	public List<FreeCommentVo> fcList(Long f_idx);
	public FreeCommentVo getData(Long fc_idx);
	public void fcDel(Long fc_idx);
	public void fcWrite(FreeCommentVo fcvo);
	public void fcModify(FreeCommentVo fcvo);
	
	Integer findLastGroupNum(Long f_idx);
    Integer findLastFcNum(@Param("f_idx") Long f_idx, @Param("fc_group") int fc_group);
    
    public String getWriterByFcIdx(Long fc_idx);
}
