package com.teamproject.spring.teamgg.mapper;

import java.util.List;

import com.teamproject.spring.teamgg.vo.CompBoardVo;

public interface CompBoardMapper {
	public List<CompBoardVo> compList(int page);
	public CompBoardVo compRead(long c_idx);
	public void compDel(long c_idx);
	public void compWrite(CompBoardVo cvo);
	public void compModify(CompBoardVo cvo);
	public int getTotalCount();
	public String getAuthorNickname(long c_idx);
}
